EXEC dbo.DropPRCorUDF @ObjectName = 'BO_ObracunUpdate'
GO

CREATE PROCEDURE [dbo].[BO_ObracunUpdate]
    (
      @ObracunID INT,
      @stanje INT, --staro: @ObracunStatusID INT,
      @Komentar VARCHAR(100),
      @Avtor INT,
      @Naziv VARCHAR(50),
      @Admin INT,
      @tPoint DATETIME = GETDATE,
      @objavljen BIT
    )
AS 
    BEGIN
        SET nocount ON

--declare @dtxt varchar(250)
--set @dtxt = ''objava=''+CAST(@objavljen as varchar)


        DECLARE @OldNaziv VARCHAR(50)
        DECLARE @Obdobje INT
        DECLARE @OldStatus INT
        DECLARE @Tip INT
        DECLARE @oldObjavljen INT
        DECLARE @OldKomentar VARCHAR(100)

        DECLARE @currState INT
        DECLARE @currObdobje INT
        SELECT  @currState = ObracunStatusId,
                @currObdobje = ObracunskoObdobjeID
        FROM    Obracun
        WHERE   ObracunID = @ObracunID 

        DECLARE @obstaja INT

-- stanja: 1-delovni, 2-informativni, 3- koncni, 4-info neveljaven, 5-koncni neveljaven.
-- nedovoljeni prehodi. stanje sam vase dovolimo!
        IF ( @currState = 1
             AND @stanje NOT IN ( 1, 2 )
           )
            OR ( @currState = 2
                 AND @stanje NOT IN ( 2, 3, 4 )
               )
            OR ( @currState = 3
                 AND @stanje NOT IN ( 3, 5 )
               )
            OR ( @currState = 4
                 AND @stanje NOT IN ( 2, 4 )
               )
            OR ( @currState = 5
                 AND @stanje NOT IN ( 3, 5 )
               ) 
            BEGIN
                RETURN -1
            END

-- ne dovolimo, ce informativni obstaja
        IF @stanje = 2 
            BEGIN -- informativni.
                SELECT  @obstaja = COUNT(*)
                FROM    Obracun
                WHERE   ObracunskoObdobjeID = @currObdobje
                        AND ObracunStatusID = @stanje
                        AND ObracunID <> @ObracunID
                IF @obstaja > 0 
                    RETURN -2
            END
-- ne dovolimo, ce koncni obstaja
        IF @stanje = 3 
            BEGIN -- koncni. 
                SELECT  @obstaja = COUNT(*)
                FROM    Obracun
                WHERE   ObracunskoObdobjeID = @currObdobje
                        AND ObracunStatusID = @stanje
                        AND ObracunID <> @ObracunID
                IF @obstaja > 0 
                    RETURN -3
            END

-- MTXout!!!
        UPDATE  Obracun
        SET     objavljen = @objavljen
        WHERE   ObracunID = @ObracunID


-- MTX todo: tu je treba preverit se kaksne pogoje, da se to lahko naredi.
--     poleg tega je treba tudi updatat cslopn s podatkom o tem, da je veljaven cslopn
--     s tem obracunom

        IF @stanje IN ( 1, 5 ) 
            SET @objavljen = 0    
        UPDATE  Obracun
        SET     ObracunStatusId = @stanje,
                komentar = @Komentar,
                Naziv = @Naziv,
                objavljen = @objavljen
        WHERE   ObracunID = @ObracunID

-- update se CSLOPN 
        UPDATE  CSLOPN
        SET     potrjen = CASE WHEN @stanje = 3 THEN 1
                               ELSE 0
                          END
        WHERE   ObracunId = @ObracunID

        RETURN 0

--- staro se od prej!!!!

        DECLARE @ObracunStatusID INT 
        SET @ObracunStatusID = @stanje 

        SELECT  @Tip = ObracunTipID,
                @OldNaziv = [o].[Naziv],
                @Obdobje = [o].[ObracunskoObdobjeID],
                @OldStatus = [o].[ObracunStatusID],
                @ObracunID = [o].[ObracunID],
                @OldKomentar = ISNULL([o].[Komentar], ''''),
                @oldObjavljen = ISNULL(o.objavljen, 0)
        FROM    Obracun o
        WHERE   o.ObracunID = @ObracunID
                AND o.DatumVnosa <= @stanje
                AND ISNULL(o.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje ;
 

--declare @txt nvarchar(250)
        IF ( @OldStatus <> @ObracunStatusID )
            OR ( @OldKomentar <> @Komentar )
            OR ( @OldNaziv <> @Naziv )
            OR ( @oldObjavljen <> @objavljen ) 
            BEGIN
-- Vstavim nov vnos
                IF ( @ObracunStatusID = 2 ) 
                    BEGIN
	
                        DECLARE @ImaKon INT
	-- preverim da se koncni status ne prekriva s kakim drugim v istem intevalu
                        SELECT  @ImaKon = COUNT(ObracunID)
                        FROM    Obracun
                        WHERE   ObracunskoObdobjeID = @Obdobje
                                AND ObracunStatusID = 2

                        IF ( @ImaKon > 0 ) 
                            BEGIN
                                IF ( @Admin = 0 ) 
                                    BEGIN
                                        RETURN 1 -- napaka, ker imammo ze nek koncni obracun za obdobje
                                    END
                                ELSE 
                                    BEGIN
			   -- [WARN:] vse ostale obracune v tem obdobju damo na koncno neveljavno stanje!!!!
			   --set @txt=''update s statusom 3!, obdobje=''
			   
			   -- vse moramo nastavit na 3, kar jih je na 2. za to obdobje. 
                                        UPDATE  Obracun
                                        SET     ObracunStatusID = 3 --,DatumSpremembe = GETDATE() 
                                        WHERE   ObracunskoObdobjeID = @Obdobje
                                                AND ObracunStatusID = 2
			   -- sedaj updatamo se zadnjega s tem id.
                                        DECLARE @maxid INT
                                        SELECT  @maxid = MAX(id)
                                        FROM    Obracun
                                        WHERE   ObracunID = @ObracunID --zadnji.
			   --set @txt=''update s statusom 3!, maxid=''+CAST(@maxid as varchar)
			   
                                        UPDATE  Obracun
                                        SET     ObracunStatusID = 3,
                                                DatumSpremembe = GETDATE()
                                        WHERE   ID = @maxid
                                        INSERT  INTO Obracun
                                                (
                                                  ObracunID,
                                                  ObracunStatusID,
                                                  ObracunskoObdobjeID,
                                                  Avtor,
                                                  Naziv,
                                                  DatumVnosa,
                                                  Komentar,
                                                  ObracunTipID
                                                )
                                        VALUES  (
                                                  @ObracunID,
                                                  @ObracunStatusID,
                                                  @Obdobje,
                                                  @Avtor,
                                                  @Naziv,
                                                  GETDATE(),
                                                  @Komentar,
                                                  @Tip 
                                                ) ;
                                        RETURN 0   
                                    END			  
                            END
                        ELSE 
                            BEGIN
		--set @txt=''!kon, ''
		
                                UPDATE  Obracun
                                SET     DatumSpremembe = GETDATE()
                                WHERE   ObracunID = @ObracunID
                                        AND DatumVnosa <= @stanje
                                        AND ISNULL(DatumSpremembe,
                                                   DATEADD(yy, 50, GETDATE())) >= @stanje ;
                                INSERT  INTO Obracun
                                        (
                                          ObracunID,
                                          ObracunStatusID,
                                          ObracunskoObdobjeID,
                                          Avtor,
                                          Naziv,
                                          DatumVnosa,
                                          Komentar,
                                          ObracunTipID
                                        )
                                VALUES  (
                                          @ObracunID,
                                          @ObracunStatusID,
                                          @Obdobje,
                                          @Avtor,
                                          @Naziv,
                                          GETDATE(),
                                          @Komentar,
                                          @Tip 
                                        ) ;
                                RETURN 0 ;
                            END

                    END
                ELSE 
                    BEGIN
                        IF ( @ObracunStatusID >= @OldStatus
                             OR @Admin = 1
                           ) 
                            BEGIN
                                UPDATE  Obracun
                                SET     DatumSpremembe = GETDATE()
                                WHERE   ObracunID = @ObracunID
                                        AND DatumVnosa <= @stanje
                                        AND ISNULL(DatumSpremembe,
                                                   DATEADD(yy, 50, GETDATE())) >= @stanje ;
                                INSERT  INTO Obracun
                                        (
                                          ObracunID,
                                          ObracunStatusID,
                                          ObracunskoObdobjeID,
                                          Avtor,
                                          Naziv,
                                          DatumVnosa,
                                          Komentar,
                                          ObracunTipID
                                        )
                                VALUES  (
                                          @ObracunID,
                                          @ObracunStatusID,
                                          @Obdobje,
                                          @Avtor,
                                          @Naziv,
                                          GETDATE(),
                                          @Komentar,
                                          @Tip 
                                        ) ;
                            END
                        ELSE 
                            BEGIN
                                RETURN 2 ;
                            END
                        RETURN 0 ;
                    END

            END

    END

GO
