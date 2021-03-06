EXEC [dbo].[DropPRCorUDF]	@ObjectName = 'usp_SelectPPMOstali' 
GO

CREATE PROCEDURE [dbo].[usp_SelectPPMOstali]
    @osebaID INT,
    @obdobjeOd DATETIME,
    @obdobjeDo DATETIME
AS 
    BEGIN
---- dobi ostale ppmje za sodo -> (kvalificirani proizvajalci-2x,nekvalific. proiz 2x,nregulirana dobava 2x,
-- skupaj, UDO merjeni in nemerjeni in izgube, diagram skupen prevezem, prevzem brez izgub
        SELECT  p.PPMID,
                p.Naziv,
                p.PPMTipID
        FROM    PPM p
                LEFT OUTER JOIN PPMTip pt ON pt.PPMTipID = p.PPMTipID
        WHERE   p.SistemskiOperater1 = @osebaID
                AND p.PPMTipID IN ( 9, 10, 24, 25, 26, 27, 28, 19, 20,13,14 )
                AND dbo.intersects(@obdobjeOd, @obdobjeDo, p.VeljaOd,
                                  p.VeljaDo) = 1
                AND DatumSpremembe IS NULL
        ORDER BY pt.VrstniRedExcelUvoz

    END


GO