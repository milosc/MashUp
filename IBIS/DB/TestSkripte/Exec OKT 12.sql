
DECLARE @p8 INT
SET @p8 = 211
DECLARE @p9 XML
SET @p9 = NULL
DECLARE @p10 XML
SET @p10 = NULL


DECLARE @obrID INT

EXEC BilnacniObracun @ObracunskoObdobjeID = 70,
    @DatumVeljavnostiPodatkov = '2012-12-15 00:00:00',
    @DatumStanjaBaze = '2012-12-15 02:40:04.507', @Avtor = 2,
    @Naziv = 'Oktober test 2', 
    @ObracunID = @obrID OUTPUT,
    @BS = DEFAULT,
    @ValidationErrorsXML = @p9 OUTPUT,
    @ValidationErrorsDetailXML = @p10 OUTPUT

/*REGION REALIZACIJA CHECK*/
--SELECT  'RealizacijaPoDobaviteljih',R.*,O1.[Naziv] AS Oseba,O2.[Naziv] AS Nadrejena, O3.[Naziv] AS SistemskiOperater
--FROM    dbo.RealizacijaPoDobaviteljih R JOIN [dbo].[Oseba] O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--JOIN [dbo].[Oseba] O2 ON R.[NadrejenaOsebaID] = O2.[OsebaID] AND O2.[DatumSpremembe] IS NULL AND O2.[VeljaDo] IS NULL 
--JOIN [dbo].[Oseba] O3 ON R.[SistemskiOperaterID] = O3.[OsebaID] AND O3.[DatumSpremembe] IS NULL AND O3.[VeljaDo] IS NULL 
--WHERE   R.ObracunID =  @obrID
--		AND [NadrejenaOsebaID] IN (3,34)
--        AND R.Interval = '2012-02-01 01:00:00.000'
--ORDER BY R.OsebaID ASC

--SELECT  'RealizacijaPoBPS',R.*,O1.[Naziv]
--FROM    dbo.RealizacijaPoBPS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.Interval = '2012-02-01 01:00:00.000'
--ORDER BY R.OsebaID ASC

--SELECT  'RealizacijaPoBS',R.*,O1.[Naziv]
--FROM    dbo.RealizacijaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.Interval = '2012-02-01 01:00:00.000'
--ORDER BY R.OsebaID ASC


--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.[KolicinskaOdstopanjaPoBS] R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 3
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc
--ORDER BY R.[Interval] ASC

--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 9
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 10
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 39
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc


--SELECT 'KolicinskaOdstopanjaPoBS', R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 45
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 46
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 11
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc



--SELECT 'KolicinskaOdstopanjaPoBS', R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 48
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 49
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc


--SELECT 'KolicinskaOdstopanjaPoBS', R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 50
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc


--SELECT 'KolicinskaOdstopanjaPoBS', R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 51
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc



--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 57
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc


--SELECT 'KolicinskaOdstopanjaPoBS', R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 58
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc


--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 59
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc


--SELECT 'KolicinskaOdstopanjaPoBS', R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 60
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 61
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 62
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc


--SELECT 'KolicinskaOdstopanjaPoBS', R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 63
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--SELECT 'KolicinskaOdstopanjaPoBS', R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 66
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc


--SELECT 'KolicinskaOdstopanjaPoBS', R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 32
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc


--SELECT 'KolicinskaOdstopanjaPoBS', R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 68
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) ASC

--SELECT 'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 69
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 70
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--SELECT  'KolicinskaOdstopanjaPoBS',R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 47
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--SELECT 'KolicinskaOdstopanjaPoBS', R.*,O1.[Naziv]
--FROM    dbo.KolicinskaOdstopanjaPoBS R JOIN [dbo].[Oseba]  O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @obrID
--        AND R.[OsebaID] = 33
--ORDER BY 
--DATEPART(day,R.[Interval]) asc,
--DATEPART(month,R.[Interval]) asc,
--(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

--/*REGION REALIZACIJA CHECK - END*/



--ROLLBACK TRAN

