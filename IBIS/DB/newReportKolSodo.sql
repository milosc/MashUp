EXEC [dbo].[DropPRCorUDF] @ObjectName = 'newReportKolSodo'
GO


CREATE PROCEDURE [dbo].[newReportKolSodo]
    (
      @obracunId INT,
      @osebaID INT
    )
AS 
    BEGIN 
        SET NOCOUNT ON
       
        DECLARE @StanjeNaDan DATETIME
        DECLARE @dtOd DATETIME
        DECLARE @dtDo DATETIME
        DECLARE @query NVARCHAR(4000)
        DECLARE @ids NVARCHAR(2000)
        DECLARE @tVelja DATETIME

        SELECT  @StanjeNaDan = datumvnosa
        FROM    obracun
        WHERE   obracunid = @obracunID
        
        SELECT  @dtOd = MIN(INTERVAL)
        FROM    PodatkiObracuna
        WHERE   ObracunID = @obracunID
        
        SELECT  @dtDo = MAX(INTERVAL)
        FROM    PodatkiObracuna
        WHERE   ObracunID = @obracunID
        
        
        DECLARE @DatumVeljavnostiPodatkov DATETIME
        DECLARE @DatumIntervalaDO DATETIME
        DECLARE @DatumIntervalaOD DATETIME
        DECLARE @ObdobjeId INT
     
          
        SELECT  @ObdobjeId = ObracunskoObdobjeID,
                @DatumVeljavnostiPodatkov = DatumVnosa
        FROM    Obracun
        WHERE   ObracunID = @ObracunID
      
        SELECT  @DatumIntervalaDO = VeljaDo,
                @DatumIntervalaOD = VeljaOd
        FROM    ObracunskoObdobje
        WHERE   ObracunskoObdobjeID = @ObdobjeId 
        
        
        SET @tVelja = @dtOd 

        IF OBJECT_ID('tempdb..#tmp') IS NOT NULL 
            DROP TABLE #tmp 

		

        SELECT  o1.Naziv AS Naziv,
                o1.OsebaID,
                tp.Interval,
                tp.Kolicina AS Realizacija,
                tp.sistemskioperaterid
        INTO    #tmp
        FROM    RealizacijaPoDobaviteljih AS tp
                INNER JOIN Oseba AS o1 ON tp.sistemskioperaterid = o1.OsebaID
        WHERE   ( @StanjeNaDan BETWEEN o1.DatumVnosa
                               AND     dbo.infinite(o1.DatumSpremembe) )
                AND ( @tVelja BETWEEN o1.VeljaOd
                              AND     dbo.infinite(o1.VeljaDo) )
                AND ( tp.Interval >= @dtOd )
                AND ( tp.Interval <= DATEADD(d, 1, @dtDo) )
                AND tp.SistemskiOperaterID <> 2
                AND ( tp.OsebaID IN (
										  			SELECT    P.Partner2
										  FROM      dbo.Pogodba P
													JOIN dbo.Oseba O ON P.Partner2 = O.OsebaID
										  WHERE     P.NadrejenaOsebaID = @osebaId
													AND @StanjeNaDan BETWEEN P.DatumVnosa
																	 AND     dbo.infinite(P.DatumSpremembe)
													AND @tVelja BETWEEN P.VeljaOd
																AND     dbo.infinite(P.VeljaDo)
													AND @StanjeNaDan BETWEEN O.DatumVnosa
																	 AND     dbo.infinite(O.DatumSpremembe)
													AND @tVelja BETWEEN O.VeljaOd
																AND     dbo.infinite(O.VeljaDo) 
											UNION ALL
										   SELECT    P2.Partner2
										  FROM      dbo.Pogodba P
													JOIN dbo.Oseba O ON P.Partner2 = O.OsebaID
													JOIN Pogodba P2 ON P.Partner2 = P2.NadrejenaOsebaID and P2.Nivo=3
													JOIN dbo.Oseba O1 ON O1.OsebaID = P2.Partner2
										  WHERE     P2.NadrejenaOsebaID = P.Partner2
													AND @StanjeNaDan BETWEEN P.DatumVnosa
																	 AND     dbo.infinite(P.DatumSpremembe)
													AND @tVelja BETWEEN P.VeljaOd
																AND     dbo.infinite(P.VeljaDo)
													AND @StanjeNaDan BETWEEN O.DatumVnosa
																	 AND     dbo.infinite(O.DatumSpremembe)
													AND @tVelja BETWEEN O.VeljaOd
																AND     dbo.infinite(O.VeljaDo) 

																AND @StanjeNaDan BETWEEN P2.DatumVnosa
																	 AND     dbo.infinite(P2.DatumSpremembe)
													AND @tVelja BETWEEN P2.VeljaOd
																AND     dbo.infinite(P2.VeljaDo)
													AND @StanjeNaDan BETWEEN O1.DatumVnosa
																	 AND     dbo.infinite(O1.DatumSpremembe)
													AND @tVelja BETWEEN O1.VeljaOd
																AND     dbo.infinite(O1.VeljaDo) 
																) 
					)
                AND ( tp.ObracunID = @ObracunID )
        ORDER BY o1.OsebaID DESC
                
        --SELECT  *
        --FROM    #tmp
        --WHERE Interval = '2012-01-01 01:00:00'

        IF OBJECT_ID('tempdb..#t2') IS NOT NULL 
            DROP TABLE #t2 
            
--  v prvem intervalu naj bi bili ze vsi nazivi!
        SELECT  naziv,
                osebaid
        INTO    #t2
        FROM    #tmp
        WHERE   INTERVAL = @dtOd
        ORDER BY OsebaID DESC
                

        SELECT  @ids = '[' + STUFF(( SELECT DISTINCT '[' + naziv + '],'
                                     FROM   #t2
                                   FOR
                                     XML PATH('')
                                   ), 1, 1, '') 
       
        SET @ids = LEFT(@ids, LEN(@ids) - 1)

--SELECT @ids

        SET @query = 'SELECT Interval, ' + @ids
            + ' FROM
			(SELECT Interval, Naziv, cast(Realizacija as decimal (18,3)) as pData
				 FROM #tmp 
			) 
			AS pTmp
			PIVOT
			(   SUM(pData)
				FOR naziv in (' + @ids
            + ')
			) AS pTable ORDER BY 
		DATEPART(month,pTable.interval) asc,
		DATEPART(day,pTable.interval) asc,
		(CASE WHEN DATEPART(HH,pTable.interval) = 0 THEN 24 ELSE DATEPART(HH,pTable.interval) end) asc '

        PRINT @query 
        EXECUTE ( @query
               )

    END

GO
