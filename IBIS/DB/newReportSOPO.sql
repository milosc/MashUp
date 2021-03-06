EXEC [dbo].[DropPRCorUDF] @ObjectName = 'newReportSOPO' 
GO

CREATE PROCEDURE [dbo].[newReportSOPO]
    (
      @obracunID INT,
      @tip INT  -- 0:vrne datum, 1: odstopanje BS, 2: Tol pas BS, 3. odstopanje GJS/MEJA
    )
AS 
    BEGIN
        SET nocount ON 

        IF ( @tip = 0 ) 
            BEGIN
                EXEC newReportDt @obracunId
                RETURN
            END
            
        IF ( @tip = 4 ) 
            BEGIN
                SELECT  ( CASE WHEN DATEPART(hour, interval) = 0
                               THEN CONVERT (VARCHAR(20), DATEADD(day, -1, interval), 104)
                                    + ' 24'
                               WHEN DATEPART(hour, interval) < 10
                               THEN CONVERT (VARCHAR(10), interval, 104)
                                    + ' 0'
                                    + CAST(DATEPART(hour, interval) AS VARCHAR(5))
                               ELSE CONVERT (VARCHAR(10), interval, 104) + ' '
                                    + CAST(DATEPART(hour, interval) AS VARCHAR(5))
                          END ) AS Datum,
                        [C+] AS [C+],
                        [C-] AS [C-],
                        [C+'] AS [C+'],
                        [C-'] AS [C-']
                FROM    [dbo].[PodatkiObracuna_Skupni]
                WHERE   ObracunId = @obracunid
                ORDER BY Datum ASC
                RETURN           
            END

        DECLARE @imeStolpca NVARCHAR(100)
        
        IF ( @tip = 1
             OR @tip = 3
           ) 
            SET @imeStolpca = 'Odstopanje'
        ELSE 
            SET @imeStolpca = 'KoregiranTP'

        DECLARE @tipList TABLE ( id INT ) 
-- insert into @tipi (id) select 1,2,3


        IF ( @tip = 1
             OR @tip = 2
           ) 
            BEGIN -- grupa BS
                INSERT  INTO @tipList
                        SELECT  osebazid
                        FROM    osebazid
                        WHERE   OsebaZId IN ( 1, 2, 4 )
            END
        ELSE 
            BEGIN
                INSERT  INTO @tipList
                        SELECT  osebazid
                        FROM    osebazid
                        WHERE   OsebaZId IN ( 3, 5 )  
            END
  

        DECLARE @dtOd DATETIME
        DECLARE @dtDo DATETIME

        DECLARE @obdobjeId INT 

        DECLARE @dt DATETIME
        SELECT  @dt = DatumVnosa,
                @obdobjeId = ObracunskoObdobjeID
        FROM    Obracun
        WHERE   obracunId = @obracunID 
        
        SELECT  @dtOd = DATEADD(hour, 1, veljaod),
                @dtDo = DATEADD(day, 1, veljaDo)
        FROM    ObracunskoObdobje
        WHERE   ObracunskoObdobjeID = @obdobjeId


        SELECT  @dtOd = MIN(interval)
        FROM    PodatkiObracuna
        WHERE   ObracunID = @obracunID

        SELECT  @dtDo = MAX(interval)
        FROM    PodatkiObracuna
        WHERE   ObracunID = @obracunID


        IF OBJECT_ID('tempdb..#tmp') IS NOT NULL 
            DROP TABLE #tmp  
                      
        SELECT  OsebaID,
                kratica
        INTO    #tmp
        FROM    Oseba
        WHERE   OsebaID IN (
                SELECT  partner2
                FROM    Pogodba p
                WHERE   p.PogodbaTipID IN ( 1, 2 ) -- bp/PI     
                        AND @dtOd BETWEEN p.veljaod AND dbo.infinite(p.VeljaDo)
                        AND @dt BETWEEN p.DatumVnosa
                                AND     dbo.infinite(p.DatumSpremembe)
                        AND P.Nivo > 1 )
                AND @dt BETWEEN datumVnosa
                        AND     dbo.infinite(DatumSpremembe)
                AND @dtOd BETWEEN VeljaOd AND dbo.infinite(veljaDo)
                AND OsebaID IN (
                SELECT  osebaid
                FROM    osebazcalc
                WHERE   @dt BETWEEN DatumVnosa
                            AND     dbo.infinite(datumSpremembe)
                        AND OsebaZId IN ( SELECT    ID
                                          FROM      @tipList ) )
        ORDER BY OsebaID ASC


        DECLARE @query NVARCHAR(4000)
        DECLARE @ids VARCHAR(2000)
        DECLARE @names NVARCHAR(3000)

        SELECT  @ids = '[' + STUFF(( SELECT '[' + LTRIM(STR(OsebaID)) + '],'
                                     FROM   #tmp
                                   FOR
                                     XML PATH('')
                                   ), 1, 1, '') 
        SET @ids = LEFT(@ids, LEN(@ids) - 1)
        SELECT  @names = '['
                + STUFF(( SELECT    '[' + LTRIM(STR(OsebaID)) + '] as '
                                    + QUOTENAME(kratica) + ','
                          FROM      #tmp
                        FOR
                          XML PATH('')
                        ), 1, 1, '') 
        SET @names = LEFT(@names, LEN(@names) - 1)



       SET @query = 'SELECT interval, ' + @names + ' FROM
(SELECT  ( CASE WHEN DATEPART(hour, interval) = 0
                                               THEN CONVERT (varchar(20), DATEADD(day, -1, interval), 104)
                                                    + '' 24''
                                               WHEN DATEPART(hour, interval) < 10
                                               THEN CONVERT (varchar(10), interval, 104)
                                                    + '' 0''
                                                    + CAST(DATEPART(hour, interval) AS varchar(5))
                                               ELSE CONVERT (varchar(10), interval, 104)
                                                    + '' ''
                                                    + CAST(DATEPART(hour, interval) AS varchar(5))
                                          END ) as Interval, ' + @imeStolpca + ' as '
            + @imeStolpca + ',OsebaID
    FROM KolicinskaOdstopanjaPoBPS where  ObracunID=' + CAST(@obracunID AS VARCHAR) + '
  ) 
AS pivTemp
PIVOT
(   SUM(' + @imeStolpca + ')
    FOR osebaid IN (' + @ids + ')
) AS pivTable 
ORDER BY interval asc '

 
        EXECUTE ( @query)

    END

GO