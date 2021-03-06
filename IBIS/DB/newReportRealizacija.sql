EXEC [dbo].[DropPRCorUDF] @ObjectName = 'newReportRealizacija'
GO


CREATE PROCEDURE [dbo].[newReportRealizacija]
    (
      @veljaOd DATETIME,
      @veljaDo DATETIME,
      @stanje DATETIME,
      @osebaId INT,
      @operater INT,
      @kaj INT
    )
AS 
    BEGIN

        IF ( @kaj = 0 ) 
            BEGIN 
                IF OBJECT_ID('tempdb..#tmpT') IS NOT NULL 
                    DROP TABLE #tmpT

                SELECT DISTINCT
                        vm.interval
                INTO    #tmpT
                FROM    view_Meritve vm
                WHERE   ( vm.Interval >= @VeljaOd )
                        AND ( vm.Interval < DATEADD(d, 1, @VeljaDo) )
                        AND ( vm.DatumVnosa <= @stanje )
                        AND ( ISNULL(vm.DatumSpremembe,
                                     DATEADD(yy, 50, GETDATE())) >= @stanje )
                 

                SELECT  dbo.mk24ur(Interval) AS [Datum]
                FROM    #tmpT 
				--ORDER BY Interval ASC 
				ORDER BY 
					DATEPART(month,interval) asc,
					DATEPART(day,interval) asc,
					(CASE WHEN DATEPART(HH,interval) = 0 THEN 24 ELSE DATEPART(HH,interval) end) asc 
                RETURN
            END

        IF ( @kaj = 2 ) 
            BEGIN 
                SELECT  naziv
                FROM    Oseba
                WHERE   OsebaID = @operater   
                RETURN
            END




        IF OBJECT_ID('tempdb..#tmpPPM') IS NOT NULL 
            DROP TABLE #tmpPPM 

        SELECT  PPMID AS x,
                CASE LEN(NazivPorocila)
                  WHEN 0 THEN Naziv
                  ELSE NazivPorocila
                END AS np,
                *
        INTO    #tmpPPM
        FROM    PPM
        WHERE   dobavitelj1 = @osebaId
                AND SistemskiOperater1 = @operater
                AND @veljaOd BETWEEN VeljaOd AND dbo.infinite(veljaDo)
                AND ( DatumVnosa <= @stanje )
                AND ( ISNULL(DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje ) 


        IF OBJECT_ID('tempdb..#tmp') IS NOT NULL 
            DROP TABLE #tmp

        CREATE TABLE #tmp
            (
              ppmId INT,
              naziv NVARCHAR(200),
              interval DATETIME,
              value DECIMAL(24, 8),
			  VrstniRed INT NULL,
            )

        INSERT  INTO #tmp
                SELECT  vm.ppmid,
                        tp.np AS naziv,
                        vm.Interval AS Interval,
                        vm.kolicina AS VALUE,
						tp.VrstniRed                       
                FROM    view_meritve vm
                        INNER JOIN #tmpPPM tp ON tp.x = vm.ppmid
                WHERE   ( vm.Interval >= @VeljaOd )
                        AND ( vm.Interval < DATEADD(d, 1, @VeljaDo) )
                        AND ( vm.DatumVnosa <= @stanje )
                        AND ( ISNULL(vm.DatumSpremembe,
                                     DATEADD(yy, 50, GETDATE())) >= @stanje )
               



        IF OBJECT_ID('tempdb..#t2') IS NOT NULL 
            DROP TABLE #t2 
        SELECT DISTINCT
                naziv,
                ppmid,
				VrstniRed
        INTO    #t2
        FROM    #tmp
        --ORDER BY ppmId ASC --naziv asc  

        DECLARE @query NVARCHAR(4000)
        DECLARE @ids NVARCHAR(2000)
 
        SELECT  @ids = '[' + STUFF(( SELECT '[' + naziv + '],'
                                     FROM   #t2
									 ORDER BY VrstniRed ASC,ppmId asc
                                   FOR
                                     XML PATH('')
                                   ), 1, 1, '') 
        SET @ids = LEFT(@ids, LEN(@ids) - 1)


        SET @query = 'SELECT interval as Datum, ' + @ids
            + ' FROM
(SELECT Interval, Naziv, round(value,3) as pData
    FROM #tmp 
  ) 
AS pivTemp
PIVOT
(   SUM(pData)
    FOR naziv  in (' + @ids + ')
) AS pivTable 
ORDER BY 
					DATEPART(month,pivtable.interval) asc,
					DATEPART(day,pivtable.interval) asc,
					(CASE WHEN DATEPART(HH,pivtable.interval) = 0 THEN 24 ELSE DATEPART(HH,pivtable.interval) end) asc '
 
 
        PRINT @query 
        EXECUTE ( @query
               )

        RETURN 

    END

GO


