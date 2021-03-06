EXEC [dbo].[DropPRCorUDF] @ObjectName = 'newReportTrzniPlan'
GO

CREATE PROCEDURE [dbo].[newReportTrzniPlan]
    (
      @veljaOd DATETIME ,
      @veljaDo DATETIME ,
      @stanje DATETIME ,
      @filter NVARCHAR(200)
    )
AS 
    BEGIN 
  

        DECLARE @cmd0 NVARCHAR(300)
        IF OBJECT_ID('tempdb..#tmpOs') IS NOT NULL 
            DROP TABLE #tmpOs 
        CREATE TABLE #tmpOs ( osebaId INT )
        SET @cmd0 = 'insert into #tmpOs select distinct osebaid from Oseba where OsebaID in ('
            + @filter + ')'
        EXEC(@cmd0)


        IF OBJECT_ID('tempdb..#tmp') IS NOT NULL 
            DROP TABLE #tmp
        CREATE TABLE #tmp
            (
              osebaId INT ,
              naziv NVARCHAR(200) ,
              interval DATETIME ,
              Kolicina DECIMAL(24, 8)
            )


        INSERT  INTO #tmp
                SELECT  TrzniPlan.OsebaID ,
                        Oseba.Naziv AS OsebaNaziv ,
                        TrzniPlan.Interval AS Interval ,
                        TrzniPlan.Kolicina AS Kolicina
                FROM    TrzniPlan
                        INNER JOIN Oseba ON Oseba.OsebaID = TrzniPlan.OsebaID
                                            AND Oseba.DatumVnosa <= @stanje
                                            AND Oseba.OsebaID IN ( SELECT
                                                              OsebaID
                                                              FROM
                                                              #tmpOs )
                                            AND ISNULL(Oseba.DatumSpremembe,
                                                       DATEADD(yy, 50,
                                                              GETDATE())) >= @stanje
                WHERE   ( TrzniPlan.Interval >= @VeljaOd )
                        AND ( TrzniPlan.Interval < DATEADD(d, 1, @VeljaDo) )
                        AND @veljaOd BETWEEN oseba.VeljaOd
                                     AND     dbo.infinite(oseba.veljaDo)
                        AND ( TrzniPlan.DatumVnosa <= @stanje )
                        AND ( ISNULL(TrzniPlan.DatumSpremembe,
                                     DATEADD(yy, 50, GETDATE())) >= @stanje )
                ORDER BY Interval

        IF OBJECT_ID('tempdb..#t2') IS NOT NULL 
            DROP TABLE #t2 

        SELECT DISTINCT
                naziv
        INTO    #t2
        FROM    #tmp
        ORDER BY naziv ASC  

		
        DECLARE @query NVARCHAR(4000)
        DECLARE @ids NVARCHAR(2000)
 
        SELECT  @ids = '[' + STUFF(( SELECT '[' + naziv + '],'
                                     FROM   #t2
                                   FOR
                                     XML PATH('')
                                   ), 1, 1, '') 
        SET @ids = LEFT(@ids, LEN(@ids) - 1)

        SET @query = 'SELECT dbo.mk24ur(interval) as Datum, ' + @ids + ' 
		FROM
(SELECT  Interval, Naziv, round(Kolicina ,3) as pData
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


        EXECUTE (@query)

		
    END
