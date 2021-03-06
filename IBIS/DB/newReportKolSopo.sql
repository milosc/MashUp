EXEC [dbo].[DropPRCorUDF] @ObjectName = 'newReportKolSopo' 
GO


CREATE PROCEDURE [dbo].[newReportKolSopo]
    (
      @obracunId INT,
      @osebaID INT
    )
AS 
    BEGIN 

        IF OBJECT_ID('tempdb..#tmp') IS NOT NULL 
            DROP TABLE #tmp 
        CREATE TABLE #tmp
            (
              naziv NVARCHAR(200),
              interval DATETIME,
              Realizacija DECIMAL(18, 3)
            )

        DECLARE @StanjeNaDan DATETIME
        DECLARE @dtOd DATETIME
        DECLARE @dtDo DATETIME

        SELECT  @StanjeNaDan = datumvnosa
        FROM    obracun
        WHERE   obracunid = @obracunID -- getdate()
        SELECT  @dtOd = MIN(interval)
        FROM    PodatkiObracuna
        WHERE   ObracunID = @obracunID
        SELECT  @dtDo = MAX(interval)
        FROM    PodatkiObracuna
        WHERE   ObracunID = @obracunID

   
        INSERT  INTO #tmp
                EXEC repObracunKolIzpisSopo @obracunId, @osebaID, @StanjeNaDan,
                @dtOd, @dtDo
 

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

        SET @query = 'SELECT interval, ' + @ids
            + ' FROM
				(SELECT  Interval, Naziv, cast(Realizacija as decimal (18,3)) as pData
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

    END


GO