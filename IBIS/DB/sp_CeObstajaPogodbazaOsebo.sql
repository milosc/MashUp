/****** Object:  StoredProcedure [dbo].[sp_CeObstajaPogodbazaOsebo]    Script Date: 03/11/2012 21:58:16 ******/
IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'[dbo].[sp_CeObstajaPogodbazaOsebo]')
                    AND type IN ( N'P', N'PC' ) ) 
    DROP PROCEDURE [dbo].[sp_CeObstajaPogodbazaOsebo]
GO
SET ANSI_NULLS ON

EXEC [dbo].[DropPRCorUDF] @ObjectName = 'sp_CeObstajaPogodbazaOsebo'
 --  varchar(max)
go

CREATE PROCEDURE [dbo].[sp_CeObstajaPogodbazaOsebo]
    @OsebaID INT,
    @stanje DATETIME
AS 
    BEGIN
        DECLARE @st INT
        DECLARE @ret INT
        SET @ret = 0 

--pogledamo ce izbrana oseba vsebuje pogodbe
        SELECT  @st = COUNT(PogodbaID)
        FROM    Pogodba
        WHERE   ( Partner1 = @OsebaID
                  OR Partner2 = @OsebaID
                )
                AND DatumVnosa <= @stanje
                AND ISNULL(DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje

        IF ( @st > 0 ) 
            BEGIN
		--pogodba  obstaja vrnemo 1
                SET @ret = 1
                RETURN @ret
            END
        ELSE 
            BEGIN
		--ni nobene pogodbe za osebo
                SET @ret = 0
                RETURN @ret
            END


    END
GO
