EXEC [dbo].[DropPRCorUDF] @ObjectName = 'usp_SelectPogodbasAll'
 --  varchar(max)
GO

CREATE PROCEDURE [dbo].[usp_SelectPogodbasAll] @stanje DATETIME
AS 
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED

    SELECTDISTINCT    p.[ID],
            p.[PogodbaID],
            p.[PogodbaTipID],
            p.[Partner1],
            p.[Partner2],
            p.[VeljaOd],
            p.[VeljaDo],
            p.[IzvrsilniDan],
            p.[Opis],
            p.[Opombe],
            p.[Avtor],
            p.[DatumVnosa],
             p.[DatumSpremembe],
            tp.[Naziv] AS TipPogodbeNaziv,
            o1.[Naziv] AS Partner1Naziv,
            o2.[Naziv] AS Partner2Naziv
    FROM    [Pogodba] p
            INNER JOIN [PogodbaTip] tp ON p.[PogodbaTipID] = tp.[PogodbaTipID]
            INNER JOIN Oseba o1 ON p.Partner1 = o1.OsebaID
            INNER JOIN Oseba o2 ON p.Partner2 = o2.OsebaID
    WHERE   
   -- p.id = ( SELECT MAX(id)
   --                  FROM   Pogodba p1
   --                  WHERE  p1.PogodbaID = p.PogodbaID
   --                   AND CAST(@stanje AS DATE) BETWEEN CAST(P1.VeljaOd AS DATE) AND CAST(ISNULL(P1.VeljaDo, DATEADD(year, 100, GETDATE())) AS DATE)
			--		  AND CAST(@stanje AS DATE) BETWEEN CAST(p1.DatumVnosa AS DATE) AND CAST(ISNULL(p1.DatumSpremembe, DATEADD(year, 100, GETDATE())) AS DATE)
                            
   --                )
   --AND 
   
    ( ( @stanje BETWEEN P.DatumVnosa AND     dbo.infinite(P.DatumSpremembe) )
   AND ( @stanje BETWEEN p.VeljaOd  AND     dbo.infinite(p.VeljaDo) )
   )
   
   AND  ( ( @stanje BETWEEN o1.DatumVnosa AND     dbo.infinite(o1.DatumSpremembe) )
   AND ( @stanje BETWEEN o1.VeljaOd  AND     dbo.infinite(o1.VeljaDo) )
   )
   
    AND  ( ( @stanje BETWEEN o2.DatumVnosa AND     dbo.infinite(o2.DatumSpremembe) )
   AND ( @stanje BETWEEN o2.VeljaOd  AND     dbo.infinite(o2.VeljaDo) )
   )
      
                                            

    ORDER BY p.PogodbaID ASC,p.VeljaOd DESC,O1.[Naziv] asc


GO


