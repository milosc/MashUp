

EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_Kontrola_ND'
GO 

CREATE PROCEDURE [dbo].[BilancniObracun_Kontrola_ND]
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


        SET @SelectStatement = '
        SELECT
interval,Kolicina, O.Naziv
FROM ' + [dbo].[ResolveTableName](@DatumIntervalaDO, @DatumIntervalaOD)
            + ' M JOIN [dbo].[PPM] P ON M.[PPMID] = P.[PPMID]
JOIN [dbo].[PPMTip] T ON P.[PPMTipID] = T.[PPMTipID] AND T.[Naziv] IN (''(SODO) ND_EL_CE'',''(SODO) ND_EL_GO'',''(SODO) ND_EL_LJ'',''(SODO) ND_EL_MB'',''(SODO) ND_EL_PR'')
JOIN [dbo].[Oseba] O ON P.SistemskiOperater1 = O.OsebaId
WHERE ''' + @DareString
            + ''' BETWEEN P.[DatumVnosa] AND dbo.[infinite](P.[DatumSpremembe])
AND ''' + @DareString
            + ''' BETWEEN O.[DatumVnosa] AND dbo.[infinite](O.[DatumSpremembe])
AND ''' + @DareString + ''' BETWEEN O.VeljaOd AND dbo.[infinite](O.VeljaDo)
and M.DatumSpremembe is NULL '
	
	
        EXEC [dbo].[CrossTab] @SelectStatement, 'Naziv',
            'sum(Kolicina)[]', 'interval', NULL,
            ' ORDER BY 
            DATEPART(month,[Interval]) asc,
DATEPART(day,[Interval]) asc,
(CASE WHEN DATEPART(HH,[Interval]) = 0 THEN 24 ELSE DATEPART(HH,[Interval]) end) asc '


    END

GO