DECLARE @BP    INT = 1
DECLARE @DatumStanjaBaze DATETIME = GETDATE()
DECLARE @DatumVeljavnostiPodatkov DATETIME = GETDATE()
DECLARE @DatumIntervalaOD DATETIME = '2012-01-01 00:00:00'  
DECLARE @DatumIntervalaDO DATETIME = '2012-01-31 00:00:00'  

SELECT  *
--INTO #OsebeZaSaldoObdobja
FROM    [dbo].[Pogodba] P  JOIN [dbo].[Oseba] O ON P.[Partner2] = O.[OsebaID]
WHERE P.[PogodbaTipID]=@BP    
	  and ( @DatumVeljavnostiPodatkov between p.VeljaOd and dbo.infinite(p.VeljaDo) ) 
      AND ( @DatumStanjaBaze between P.[DatumVnosa] and dbo.infinite(P.DatumSpremembe) )
        and ( @DatumVeljavnostiPodatkov BETWEEN o.VeljaOd and dbo.infinite(o.VeljaDo) ) 
      AND ( @DatumStanjaBaze between o.[DatumVnosa] and dbo.infinite(o.DatumSpremembe) )
        
        
        
SELECT SUM(CASE WHEN R.[Odstopanje] > 0 THEN R.[Odstopanje] * C.Cplus ELSE R.[Odstopanje] * C.Cminus end) FROM [#OsebeZaSaldoObdobja] S 
JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.Partner2 = R.[OsebaID]
JOIN #tmpCena C ON R.[Interval] = C.Inteval
WHERE R.[ObracunID] = @NewObracunID
R.[Interval] > @DatumIntervalaOD
                      AND R.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)        
                      
DROP TABLE #OsebeZaSaldoObdobja