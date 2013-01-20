USE [IBIS2]
GO

EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_Kontrola_PrevzemaELES'
GO 

CREATE PROCEDURE [dbo].[BilancniObracun_Kontrola_PrevzemaELES]
    (
      @DatumStanjaBaze AS DATETIME,
      @ObracunID AS INT
    )
AS 
    BEGIN
    
    
        DECLARE @DareString VARCHAR(40)
  
        
  
        DECLARE @SelectStatement VARCHAR(8000)
    
        DECLARE @DatumIntervalaDO DATETIME
        DECLARE @DatumIntervalaOD DATETIME
        DECLARE @ObdobjeId INT
     
          
        SELECT  @ObdobjeId = ObracunskoObdobjeID,
				@DatumStanjaBaze = DatumVnosa
        FROM    Obracun
        WHERE   ObracunID = @ObracunID

		SET @DareString = CONVERT(VARCHAR(30), @DatumStanjaBaze, 120)

        SELECT  @DatumIntervalaDO = VeljaDo,
                @DatumIntervalaOD = VeljaOd
        FROM    ObracunskoObdobje
        WHERE   ObracunskoObdobjeID = @ObdobjeId 


        SET @SelectStatement = 'SELECT
interval,((CASE WHEN T.[PPMTipID] = 23 then kolicina ELSE 0 end)) AS [SODO PREVZEM], O.Naziv
FROM ' + [dbo].[ResolveTableName](@DatumIntervalaDO, @DatumIntervalaOD)
            + ' M JOIN [dbo].[PPM] P ON M.[PPMID] = P.[PPMID]
JOIN [dbo].[PPMTip] T ON P.[PPMTipID] = T.[PPMTipID] AND T.[PPMTipID] IN (23,7)
JOIN [dbo].[Oseba] O ON P.[Dobavitelj1] = O.OsebaId
WHERE ''' + @DareString
            + ''' BETWEEN P.[DatumVnosa] AND dbo.[infinite](P.[DatumSpremembe])
AND ''' + @DareString
            + ''' BETWEEN O.[DatumVnosa] AND dbo.[infinite](O.[DatumSpremembe])
AND ''' + @DareString + ''' BETWEEN O.VeljaOd AND dbo.[infinite](O.VeljaDo)
and M.DatumSpremembe is NULL '
	
	
        EXEC [dbo].[CrossTab] @SelectStatement, 'Naziv',
            'sum([SODO PREVZEM])[]', 'interval', NULL,
            ' ORDER BY 
            DATEPART(month,[Interval]) asc,
DATEPART(day,[Interval]) asc,
(CASE WHEN DATEPART(HH,[Interval]) = 0 THEN 24 ELSE DATEPART(HH,[Interval]) end) asc '


        SET @SelectStatement = 'SELECT
interval,((CASE WHEN T.[PPMTipID] = 7 then kolicina ELSE 0 end)) AS [ELES ODJEM], O.Naziv
FROM ' + [dbo].[ResolveTableName](@DatumIntervalaDO, @DatumIntervalaOD)
            + ' M JOIN [dbo].[PPM] P ON M.[PPMID] = P.[PPMID]
JOIN [dbo].[PPMTip] T ON P.[PPMTipID] = T.[PPMTipID] AND T.[PPMTipID] IN (23,7)
JOIN [dbo].[Oseba] O ON P.[Dobavitelj1] = O.OsebaId
WHERE ''' + @DareString
            + ''' BETWEEN P.[DatumVnosa] AND dbo.[infinite](P.[DatumSpremembe])
AND ''' + @DareString
            + ''' BETWEEN O.[DatumVnosa] AND dbo.[infinite](O.[DatumSpremembe])
AND ''' + @DareString + ''' BETWEEN O.VeljaOd AND dbo.[infinite](O.VeljaDo)
and M.DatumSpremembe is NULL '
	 	
	
        EXEC [dbo].[CrossTab] @SelectStatement, 'Naziv', 'sum([ELES ODJEM])[]',
            'interval', NULL,
            ' ORDER BY 
            DATEPART(month,[Interval]) asc,
DATEPART(day,[Interval]) asc,
(CASE WHEN DATEPART(HH,[Interval]) = 0 THEN 24 ELSE DATEPART(HH,[Interval]) end) asc '

        SET @SelectStatement = 'SELECT
interval,((CASE WHEN T.[PPMTipID] = 23 then -1*ABS(kolicina) ELSE ABS([Kolicina]) end)) AS Razlika , O.Naziv
FROM ' + [dbo].[ResolveTableName](@DatumIntervalaDO, @DatumIntervalaOD)
            + ' M JOIN [dbo].[PPM] P ON M.[PPMID] = P.[PPMID]
JOIN [dbo].[PPMTip] T ON P.[PPMTipID] = T.[PPMTipID] AND T.[PPMTipID] IN (23,7)
JOIN [dbo].[Oseba] O ON P.[Dobavitelj1] = O.OsebaId
WHERE ''' + @DareString
            + ''' BETWEEN P.[DatumVnosa] AND dbo.[infinite](P.[DatumSpremembe])
AND ''' + @DareString
            + ''' BETWEEN O.[DatumVnosa] AND dbo.[infinite](O.[DatumSpremembe])
AND ''' + @DareString + ''' BETWEEN O.VeljaOd AND dbo.[infinite](O.VeljaDo)
and M.DatumSpremembe is NULL '
	
	
	

        EXEC [dbo].[CrossTab] @SelectStatement, 'Naziv', 'sum(Razlika)[]',
            'interval', NULL,
            ' ORDER BY 
            DATEPART(month,[Interval]) asc,
DATEPART(day,[Interval]) asc,
(CASE WHEN DATEPART(HH,[Interval]) = 0 THEN 24 ELSE DATEPART(HH,[Interval]) end) asc '



    END