EXEC dbo.DropPRCorUDF @ObjectName = '[usp_InsertPogodba]' 
GO

CREATE PROCEDURE [dbo].[usp_InsertPogodba]
    @PogodbaID INT ,
    @PogodbaTipID INT ,
    @Partner1 INT ,
    @Partner2 INT ,
    @VeljaOd DATETIME ,
    @VeljaDo DATETIME ,
    @Opis VARCHAR(500) ,
    @Opombe VARCHAR(500) ,
    @Avtor INT ,
    @ident INT = 0 ,
    @ID INT OUTPUT
AS 
    SET NOCOUNT ON

    DECLARE @txt VARCHAR(250) 

    SET @txt = 'xx:' + CAST(@pogodbaId AS VARCHAR) + ' '
        + CAST(@PogodbaTipID AS VARCHAR) + ',' + CAST(@Partner1 AS VARCHAR)
        + ',' + CAST(@Partner2 AS VARCHAR) + ',' + CAST(@VeljaOd AS VARCHAR)
        + ',' + CAST(ISNULL(@VeljaDo, 0) AS VARCHAR) + ','
        + CAST(@ident AS VARCHAR) + ',' 


--reg preverjanje OT
    DECLARE @oid INT --oid je organizator trga.
    SELECT  @oid = osebaid
    FROM    OsebaTip
    WHERE   OsebaTipID = 6
            AND GETDATE() BETWEEN DatumVnosa
                          AND     dbo.infinite(DatumSpremembe)

    IF ( @PogodbaTipID = 4 ) 
        BEGIN  -- pogodba org. trga
            IF ( @Partner1 <> @oid
                 OR @Partner2 <> @oid
               ) 
                RETURN 11
        END
--endreg preverjanje OT

    IF ( ( @Partner1 = @Partner2 )
         AND ( @PogodbaTipID <> 4 )
       ) 
        BEGIN
            RETURN 6 -- Oba sta enaka
        END

-- Dolocim nivo pogodbe
    DECLARE @Nivo1 INT 
    SET @Nivo1 = 1000
    SELECT  @Nivo1 = ISNULL(MIN(Nivo), 1000)
    FROM    Pogodba
    WHERE   Partner2 = @Partner1
            AND DatumSpremembe IS NULL

    DECLARE @Nivo2 INT 
    SET @Nivo2 = 1000
    SELECT  @Nivo2 = ISNULL(MIN(Nivo), 1000)
    FROM    Pogodba
    WHERE   Partner2 = @Partner2
            AND DatumSpremembe IS NULL

    DECLARE @Nivo INT
    DECLARE @Temp INT

    IF ( @Nivo1 < @Nivo2 ) 
        SET @Nivo = @Nivo1 

    IF ( @Nivo1 = @Nivo2 ) 
        BEGIN
            IF ( @Partner1 = @Partner2 ) 
                BEGIN
                    IF ( @Nivo1 = 1000 ) 
                        BEGIN
                            SET @Nivo = @Nivo1 - 1000
                        END
                    ELSE 
                        BEGIN
                            SET @Nivo = @Nivo1
                        END
                END
            ELSE 
                BEGIN
	--original:	return 7 -- napaka kombinacije partnerjev
	--MTX
                    IF ( @PogodbaTipID = 2 ) 
                        SET @Nivo = @Nivo1  -- MT PI je lahko tudi med dvema dobaviteljema (?)
                    ELSE 
                        RETURN 7
	--MTXend
                END
        END

    IF ( @Nivo1 > @Nivo2 ) 
        BEGIN 
            SET @Nivo = @Nivo2
	--zamenjamo partnerja, partner1 je vedno na visjem nivoju!
            SET @Temp = @Partner1
            SET @Partner1 = @Partner2
            SET @Partner2 = @Temp
            SET @Nivo2 = @Nivo1
            SET @Nivo1 = @Nivo
        END

    SET @Nivo = @Nivo + 1

    DECLARE @NadrejenaOseba INT
    SET @NadrejenaOseba = @Partner1

-- preverim, da ima lahko samo borzen bilancno pogodbo
    IF ( @PogodbaTipID = 1 ) 
        BEGIN

            DECLARE @Borzen INT 
            SELECT DISTINCT
                    @Borzen = partner1
            FROM    Pogodba
            WHERE   nivo = 1;

            IF ( @Borzen <> @Partner1 ) 
                BEGIN
                    RETURN 1 -- napaka kar ni pogodba z borzenom
                END

            SET @NadrejenaOseba = @Partner2

        END

-- izravnalna pogodba mora bit z nekom ki ze ima pogodbo o izravnavi ali bilancno pogodbo
    IF ( @PogodbaTipID = 2 ) 
        BEGIN

            DECLARE @Borzen1 INT 
            SELECT DISTINCT
                    @Borzen1 = partner1
            FROM    Pogodba
            WHERE   nivo = 1;

            IF ( @Borzen1 <> @Partner1 ) -- ne sme bit pogodba z borzenom
                BEGIN
		
                    IF ( @Nivo1 > 1 ) 
                        BEGIN 
                            DECLARE @ImaIzrav1 INT
                            SELECT  @ImaIzrav1 = COUNT(PogodbaID)
                            FROM    Pogodba
                            WHERE   Partner2 = @Partner1
                                    AND PogodbaTipID = 2
                                    AND DatumSpremembe IS NULL
                            IF ( @ImaIzrav1 = 0 ) 
                                BEGIN
                                    RETURN 2 -- partner1 ni uvrscen na bilancno shemo z izravnalno pogodbo
                                END

                        END

		
                END
            ELSE 
                BEGIN
                    RETURN 3 -- napaka ker JE pogodba z borzenom
                END


        END

-- pogodba o dobavi
    IF ( @PogodbaTipID = 5 ) 
        BEGIN

            DECLARE @Borzen2 INT 
            SELECT DISTINCT
                    @Borzen2 = partner1
            FROM    Pogodba
            WHERE   nivo = 1;

            IF ( @Borzen2 <> @Partner1 ) -- ne sme bit pogodba z borzenom
                BEGIN
		
                    IF ( @Nivo1 > 1 ) 
                        BEGIN 
                            DECLARE @ImaIzrav INT
                            SELECT  @ImaIzrav = COUNT(PogodbaID)
                            FROM    Pogodba
                            WHERE   Partner2 = @Partner1
                                    AND ( PogodbaTipID = 2
                                          OR PogodbaTipID = 1
                                        )
                                    AND DatumSpremembe IS NULL
                            IF ( @ImaIzrav = 0 ) 
                                BEGIN
                                    RETURN 5 -- partner1 ni uvrscen na bilancno shemo z izravnalno pogodbo ali bilancno pogodbo
                                END

                        END

		
                END
            ELSE 
                BEGIN
                    RETURN 4 -- napaka kar JE pogodba z borzenom
                END


        END



-- preverjam, da ne bi naredil druge povezave navzgor
    DECLARE @ImaPogodbo INT
    IF ( @ident = 0 ) 
        BEGIN
            SELECT  @ImaPogodbo = COUNT(PogodbaID)
            FROM    Pogodba
            WHERE   Partner2 = @Partner2
                    AND DatumSpremembe IS NULL
                    AND @VeljaOd BETWEEN VeljaOd
                                 AND     ISNULL(VeljaDo,
                                                DATEADD(yy, 50, GETDATE()))
                    AND ISNULL(@VeljaDo, DATEADD(yy, 40, GETDATE())) BETWEEN VeljaOd
                                                              AND
                                                              ISNULL(VeljaDo,
                                                              DATEADD(yy, 50,
                                                              GETDATE()));
        END
    ELSE 
        BEGIN
            SELECT  @ImaPogodbo = COUNT(PogodbaID)
            FROM    Pogodba
            WHERE   Partner2 = @Partner2
                    AND DatumSpremembe IS NULL
                    AND ID <> @ident
                    AND @VeljaOd BETWEEN VeljaOd
                                 AND     ISNULL(VeljaDo,
                                                DATEADD(yy, 50, GETDATE()))
                    AND ISNULL(@VeljaDo, DATEADD(yy, 40, GETDATE())) BETWEEN VeljaOd
                                                              AND
                                                              ISNULL(VeljaDo,
                                                              DATEADD(yy, 50,
                                                              GETDATE()));

        END

    IF ( @ImaPogodbo > 0 ) 
        BEGIN
            RETURN 6 -- napaka, ker imammo ze vsaj eno pogodbo navzgor v tem intervalu
        END

-- definiram ClanBSID
    DECLARE @ClanBSID INT
    IF ( @PogodbaTipID = 1 ) 
        BEGIN
            SET @ClanBSID = @Partner2
        END
    ELSE 
        BEGIN
            SELECT  @ClanBSID = ClanBSID
            FROM    Pogodba
            WHERE   Partner2 = @Partner1;
        END

----posatvimostolpec AKTIVNO=0 pred novim insertom
    IF EXISTS ( SELECT  ID
                FROM    Pogodba
                WHERE   Partner1 = @Partner1
                        AND Partner2 = @Partner2
                        AND NadrejenaOsebaID = @NadrejenaOseba
                        AND ClanBSID = @ClanBSID
                        AND VeljaOd = @VeljaOd
                        AND ( VeljaDo = @VeljaDo
                              OR VeljaDo IS NULL
                            )
                        AND DatumSpremembe IS NULL ) 
        BEGIN
            DECLARE @tmpID INT
            SELECT  @tmpID = ID
            FROM    Pogodba
            WHERE   Partner1 = @Partner1
                    AND Partner2 = @Partner2
                    AND NadrejenaOsebaID = @NadrejenaOseba
                    AND ClanBSID = @ClanBSID
                    AND VeljaOd = @VeljaOd
                    AND ( VeljaDo = @VeljaDo
                          OR VeljaDo IS NULL
                        )
                    AND DatumSpremembe IS NULL
						
            UPDATE  Pogodba
            SET     Aktivno = 0
            WHERE   ID = @tmpID
        END
----konec postavimo AKTIVNO=0

-- insert
    INSERT  INTO [dbo].[Pogodba]
            ( [PogodbaID] ,
              [PogodbaTipID] ,
              [Partner1] ,
              [Partner2] ,
              [NadrejenaOsebaID] ,
              [ClanBSID] ,
              [VeljaOd] ,
              [VeljaDo] ,
              [Nivo] ,
              [Opis] ,
              [Opombe] ,
              [Avtor]
	
            )
    VALUES  ( @PogodbaID ,
              @PogodbaTipID ,
              @Partner1 ,
              @Partner2 ,
              @NadrejenaOseba ,
              @ClanBSID ,
              @VeljaOd ,
              @VeljaDo ,
              @Nivo ,
              @Opis ,
              @Opombe ,
              @Avtor
            )
 -- zacetek postavitve AKTIVNO stolpca ----
 ----- updatemo aktivna po insertu, @@indetity vrne pravkar insertan id (vedno vrne v to sprenljivko ce je identity=true za izbrani stolpec)
    UPDATE  Pogodba
    SET     Aktivno = 1
    WHERE   ID = @@IDENTITY 		
 ------ konec postavitve AKtivno stolpca 
 


    SET @ID = SCOPE_IDENTITY()

--endregion
GO