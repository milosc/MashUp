EXEC [dbo].[DropPRCorUDF] @ObjectName = 'usp_SelectPPMTipID' 
GO

CREATE PROCEDURE [dbo].[usp_SelectPPMTipID]
AS 
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED

    SELECT  t.[PPMTipID],
            t.[Naziv],
            CAST(( CASE WHEN SUM(p.PPMID) IS NULL THEN 1
                        ELSE 0
                   END ) AS BIT) AS CanDelete
    FROM    [dbo].[PPMTip] t
            LEFT JOIN dbo.PPM p ON t.PPMTipID = p.PPMTipID
                                   AND GETDATE() BETWEEN DatumVnosa
                                                 AND   ISNULL([DatumSpremembe],DATEADD(YEAR,100,GETDATE()))
    GROUP BY t.PPMTipID,
            t.Naziv

GO

