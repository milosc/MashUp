EXEC [dbo].[DropPRCorUDF] @ObjectName = 'sp_PPMceObstajaPPMzaOsebo' 
GO

CREATE PROCEDURE [dbo].[sp_PPMceObstajaPPMzaOsebo]
    @OsebaID INT,
    @stanje DATETIME
AS 
    BEGIN
        DECLARE @st INT
        DECLARE @ret INT
        SET @ret = 0 


--pogledamo ce izbrana oseba vsebuje ppm-je
        SELECT  @st = COUNT(PPMID)
        FROM    PPM
        WHERE   ( Dobavitelj1 = @OsebaID
                  OR SistemskiOperater1 = @OsebaID
                )
                AND DatumVnosa <= @stanje
                AND ISNULL(DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje
 

        IF ( @st > 0 ) 
            BEGIN
		--ppm ji obstajao vrnemo 1
                SET @ret = 1
                RETURN @ret
            END
        ELSE 
            BEGIN
		--ni nobenega ppmja za osebo
                SET @ret = 0
                RETURN @ret
            END


    END
GO
