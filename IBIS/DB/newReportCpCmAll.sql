EXEC [dbo].[DropPRCorUDF] @ObjectName = 'newReportCpCmAll'
GO

CREATE PROCEDURE [dbo].[newReportCpCmAll]
    (
      @obracunId INT,
      @kaj INT
    )
AS 
    BEGIN 

        SET nocount ON

        IF ( @kaj = 0 ) 
            BEGIN
                EXEC newReportDt @obracunId
                RETURN
            END

-- poiscemo osebo meja in od nje dobimo vrednost V+/ V-
-- to je sicer ze korigirana vrednost!!
        DECLARE @osebaMeja INT
        DECLARE @osebaPen INT 
        DECLARE @dt DATETIME
        SELECT  @dt = datumvnosa
        FROM    Obracun
        WHERE   ObracunID = @ObracunID

        DECLARE @tOsebe TABLE ( id INT ) 
        INSERT  INTO @tOsebe ( id )
                SELECT DISTINCT
                        osebaid
                FROM    PodatkiObracuna
                WHERE   obracunId = @obracunId

  
        SELECT  @osebaMeja = OsebaID
        FROM    OsebaZCalc
        WHERE   OsebaZId = 5  -- meja = 5
                AND @dt BETWEEN DatumVnosa
                        AND     dbo.infinite(datumSpremembe)
                AND OsebaID IN ( SELECT id
                                 FROM   @tOsebe ) 
           
        SELECT  @osebaPen = OsebaID
        FROM    OsebaZCalc
        WHERE   OsebaZId = 1 -- penaliziran.
                AND @dt BETWEEN DatumVnosa
                        AND     dbo.infinite(datumSpremembe)
                AND OsebaID IN ( SELECT id
                                 FROM   @tOsebe ) 



        SELECT  ( CASE WHEN DATEPART(hour, p.interval) = 0
                       THEN CONVERT (VARCHAR(20), DATEADD(day, -1, p.interval), 104)
                            + ' 24'
                       WHEN DATEPART(hour, p.interval) < 10
                       THEN CONVERT (VARCHAR(10), p.interval, 104) + ' 0'
                            + CAST(DATEPART(hour, p.interval) AS VARCHAR(5))
                       ELSE CONVERT (VARCHAR(10), p.interval, 104) + ' '
                            + CAST(DATEPART(hour, p.interval) AS VARCHAR(5))
                  END ) AS Interval,
                P.SIPXUrni,
                P.[C+],
                P.[C-],
                P.[C+'],
                P.[C-'],
                P.[C+GJS],
                P.[C-GJS]
        FROM    [dbo].[PodatkiObracuna_Skupni] P
        WHERE   P.[ObracunID] = @obracunId
        ORDER BY DATEPART(day, P.[Interval]) ASC,
                DATEPART(month, P.[Interval]) ASC,
                ( CASE WHEN DATEPART(HH, P.[Interval]) = 0 THEN 24
                       ELSE DATEPART(HH, P.[Interval])
                  END ) ASC
										  


    END

GO