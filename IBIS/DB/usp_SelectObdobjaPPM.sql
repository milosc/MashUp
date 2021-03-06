IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectObdobjaPPM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectObdobjaPPM]
GO

CREATE PROCEDURE [dbo].[usp_SelectObdobjaPPM]
    @PPMID INT,
    @stanje DATETIME,
    @ShowAll INT = 0
AS 
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED
    BEGIN

        IF ( @ShowAll = 0 ) 
            SELECT  *
            FROM    PPM
            WHERE   PPMID = @PPMID
                    AND DatumVnosa <= @stanje
                    AND dbo.infinite(DatumSpremembe) >= @stanje
            ORDER BY VeljaOd DESC
        ELSE 
            SELECT  *
            FROM    PPM
            WHERE   PPMID = @PPMID
            ORDER BY VeljaOd DESC


    END



GO