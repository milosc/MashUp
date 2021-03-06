
EXEC [dbo].[DropPRCorUDF] @ObjectName = 'Podatki_IzberiOsebeSistemskiOperaterji'
 --  varchar(max)
GO

CREATE PROCEDURE [dbo].[Podatki_IzberiOsebeSistemskiOperaterji] @stanje DATETIME
AS 
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED

    SELECT 
DISTINCT    OSS.OsebaID,
            OSS.Naziv + ' (' + OSTI.Naziv + ')' AS Naziv
    FROM    Oseba OSS
            INNER JOIN OsebaTip OST ON OST.OsebaID = OSS.OsebaID
                                       AND OST.DatumVnosa <= @stanje
                                       AND ISNULL(OST.DatumSpremembe,
                                                  DATEADD(yy, 50, GETDATE())) >= @stanje
            INNER JOIN OsebaTipID OSTI ON OSTI.OsebaTipID = OST.OsebaTipID
    WHERE   ( OST.OsebaTipID = 1
              OR OST.OsebaTipID = 2
            )
            AND OSS.DatumVnosa <= @stanje
            AND ISNULL(OSS.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje
    ORDER BY Naziv ASC








GO
