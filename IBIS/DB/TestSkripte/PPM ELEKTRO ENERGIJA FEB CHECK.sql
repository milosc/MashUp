--SELECT * FROM [dbo].[Oseba]

/*ODJEMI*/
SELECT M.[Kolicina],M.[PPMID],T.[Naziv],O1.[Naziv] AS Dobavitelj,O2.Naziv AS SODO
FROM
Meritve_FEB_12 M JOIN [dbo].[PPM] P ON M.[PPMID] = P.[PPMID] AND P.[DatumSpremembe] IS NULL AND P.[Dobavitelj1]=7 
JOIN [dbo].[PPMTip] T ON P.[PPMTipID] = T.[PPMTipID] AND T.[Naziv] LIKE '%ODJEM%'
JOIN [dbo].[Oseba] O1 ON P.[Dobavitelj1] = O1.[OsebaID]
JOIN [dbo].[Oseba] O2 ON P.[SistemskiOperater1] = O2.[OsebaID]
WHERE M.[Interval] = '2012-02-01 01:00:00'
AND ( GETDATE() BETWEEN O1.VeljaOd
                                                AND     dbo.infinite(O1.VeljaDo) )
AND ( GETDATE() BETWEEN O1.[DatumVnosa]
                                       AND     dbo.infinite(O1.DatumSpremembe) )
AND ( GETDATE() BETWEEN O2.VeljaOd
                                                AND     dbo.infinite(O2.VeljaDo) )
AND ( GETDATE() BETWEEN O2.[DatumVnosa]
                                       AND     dbo.infinite(O2.DatumSpremembe) )
ORDER BY SODo ASC

--/*ODDAJE*/
--SELECT M.[Kolicina],M.[PPMID],T.[Naziv],O1.[Naziv] AS Dobavitelj,O2.Naziv AS SODO
--FROM
--Meritve_FEB_12 M JOIN [dbo].[PPM] P ON M.[PPMID] = P.[PPMID] AND P.[DatumSpremembe] IS NULL AND P.[Dobavitelj1]=7 AND P.[PPMJeOddaja] = 1
--JOIN [dbo].[PPMTip] T ON P.[PPMTipID] = T.[PPMTipID]
--JOIN [dbo].[Oseba] O1 ON P.[Dobavitelj1] = O1.[OsebaID]
--JOIN [dbo].[Oseba] O2 ON P.[SistemskiOperater1] = O2.[OsebaID]
--WHERE M.[Interval] = '2012-02-01 01:00:00'
--AND ( GETDATE() BETWEEN O1.VeljaOd
--                                                AND     dbo.infinite(O1.VeljaDo) )
--AND ( GETDATE() BETWEEN O1.[DatumVnosa]
--                                       AND     dbo.infinite(O1.DatumSpremembe) )
--AND ( GETDATE() BETWEEN O2.VeljaOd
--                                                AND     dbo.infinite(O2.VeljaDo) )
--AND ( GETDATE() BETWEEN O2.[DatumVnosa]
--                                       AND     dbo.infinite(O2.DatumSpremembe) )
--ORDER BY M.[Kolicina] asc