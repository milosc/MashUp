EXEC [dbo].[DropPRCorUDF] @ObjectName = 'newReport'
GO


CREATE PROCEDURE [dbo].[newReport]
    (
      @obracunid INT,
      @osebaid INT,
      @del INT   -- 0:datum, 1: kolicinski, 2:financni, 3: sumarno. 
    )
AS 
    BEGIN
    
        DECLARE @VIRT_REGULACIJA INT
    
        SELECT  @VIRT_REGULACIJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(REG) VIRT_REGULACIJA' ;
        
-- select * from oseba where datumSpremembe is null 

        IF ( @del = 0 ) 
            BEGIN
                SELECT  dbo.mk24ur(Interval) AS Datum
                FROM    [dbo].[PodatkiObracuna_Skupni]
                WHERE   ObracunID = @obracunid
                ORDER BY Datum ASC
                RETURN ;
            END

        DECLARE @tipOsebe INT
        DECLARE @dt DATETIME
        SELECT  @dt = datumvnosa
        FROM    Obracun
        WHERE   ObracunID = @ObracunID
  
        SELECT  @tipOsebe = OsebaZid
        FROM    OsebaZCalc
        WHERE   OsebaID = @osebaid
                AND @dt BETWEEN DatumVnosa
                        AND     dbo.infinite(datumSpremembe)

        SET @tipOsebe = ISNULL(@tipOsebe, 1) ;

        IF ( @tipOsebe = 3 ) 
            BEGIN
                DECLARE @nPosebnih INT   
                SELECT  @nPosebnih = COUNT(tip)
                FROM    reportSpecifike
                WHERE   osebaId = @osebaid
                IF ( @nPosebnih > 0 )  -- to je CP
                    SET @tipOsebe = 103
            END

        DECLARE @osebaBs INT
        SET @osebaBs = 0

        DECLARE @nivo INT
        SET @nivo = 0
        SELECT  @nivo = nivo
        FROM    [dbo].[Pogodba] P
                JOIN [dbo].[Oseba] O ON P.[Partner2] = O.[OsebaID]
        WHERE   P.Partner2 = @osebaid
                AND ( @dt BETWEEN p.VeljaOd AND dbo.infinite(p.VeljaDo) )
                AND ( @dt BETWEEN P.[DatumVnosa]
                          AND     dbo.infinite(P.DatumSpremembe) )
                AND ( @dt BETWEEN o.VeljaOd AND dbo.infinite(o.VeljaDo) )
                AND ( @dt BETWEEN o.[DatumVnosa]
                          AND     dbo.infinite(o.DatumSpremembe) )
           
                
        SET @nivo = ISNULL(@nivo, 0)
        IF ( @nivo = 1 ) 
            SET @osebaBs = 1

--select 'tipOsebe=',@tipOsebe as tip, @osebaBS as isBs, @nivo as nivo
--return 
-- naprej rabimo osebaBs in tipOsebe !!
--  exec newReport 91,43 , 2
--return;

-- select * from osebazid  (1,2,4 =  penali, 3:gjs, 5 meja)


        IF ( @del = 1 ) 
            BEGIN 
                  
                IF ( @tipOsebe IN ( 1, 2, 103 ) ) 
                    BEGIN --103 je CP /nov tip
                 
                        IF ( @osebaBs = 1 ) 
                            BEGIN --JE BS
             
                                SELECT  --dbo.mk24ur(b.interval) AS Datum,
                                        ( CASE WHEN DATEPART(hour, b.interval) = 0
                                               THEN CONVERT (VARCHAR(20), DATEADD(day, -1, b.interval), 104)
                                                    + ' 24'
                                               WHEN DATEPART(hour, b.interval) < 10
                                               THEN CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' 0'
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                               ELSE CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' '
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                          END ) AS Datum,
                                        b.TP AS [Tržni Plan],
                                        b.Regulacija,
                                        b.KorigiranTP AS [Korigiran TP],
                                        b.Realizacija,
                                        b.Odstopanje AS [Odstopanje]
                                FROM    ( SELECT    K.interval,
                                                    CAST(T.Kolicina AS DECIMAL(18, 3)) AS TP,
                                                    CAST(ISNULL(R.[SekRegM] + R.[SekRegP] + R.[TerRegM] + R.[TerRegP], 0) AS DECIMAL(18, 3)) AS Regulacija,
                                                    CAST(ISNULL(K.KoregiranTP, 0) AS DECIMAL(18, 3)) AS KorigiranTP,
                                                    CAST(K.Kolicina AS DECIMAL(18, 3)) AS Realizacija,
                                                    CAST(K.Odstopanje AS DECIMAL(18, 3)) AS Odstopanje
                                          FROM      [dbo].[KolicinskaOdstopanjaPoBS] K
                                                    JOIN TrzniPlan T ON K.OsebaId = T.OsebaID
                                                                        AND K.Interval = T.Interval
                                                                        AND T.DatumSpremembe IS NULL
                                                                        AND ( @dt BETWEEN T.[DatumVnosa]
                                                                                  AND     dbo.infinite(T.DatumSpremembe) )
                                                    LEFT JOIN PPM M ON T.[OsebaID] = M.Dobavitelj1
                                                                       AND M.[PPMTipID] = @VIRT_REGULACIJA
                                                                       AND ( ( @dt BETWEEN M.DatumVnosa
                                                                                   AND     dbo.infinite(M.DatumSpremembe) )
                                                                             AND ( @dt BETWEEN M.VeljaOd AND dbo.infinite(M.VeljaDo) )
                                                                           )
                                                    LEFT JOIN [Regulacija] R ON M.[PPMID] = R.PPMID
                                                                                AND R.Interval = T.Interval
                                                                                AND ( @dt BETWEEN R.[DatumVnosa]
                                                                                          AND     dbo.infinite(R.DatumSpremembe) )
                                          WHERE     K.ObracunID = @obracunid
                                                    AND K.OsebaID = @osebaid
                                        ) AS b
                                --ORDER BY Interval ASC
                                ORDER BY DATEPART(day, [Interval]) ASC,
                                        DATEPART(month, [Interval]) ASC,
                                        ( CASE WHEN DATEPART(HH, [Interval]) = 0
                                               THEN 24
                                               ELSE DATEPART(HH, [Interval])
                                          END ) ASC
                            END
                        ELSE 
                            BEGIN
                                
                                SELECT  --dbo.mk24ur(b.interval) AS Datum,
                                        ( CASE WHEN DATEPART(hour, b.interval) = 0
                                               THEN CONVERT (VARCHAR(20), DATEADD(day, -1, b.interval), 104)
                                                    + ' 24'
                                               WHEN DATEPART(hour, b.interval) < 10
                                               THEN CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' 0'
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                               ELSE CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' '
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                          END ) AS Datum,
                                        b.TP AS [Tržni Plan],
                                        b.Regulacija,
                                        b.KorigiranTP AS [Korigiran TP],
                                        b.Realizacija,
                                        b.Odstopanje AS [Odstopanje]
                                FROM    ( SELECT    K.interval,
                                                    ( CASE WHEN TP2.Kolicina IS NOT NULL
                                                           THEN CAST(TP2.Kolicina AS DECIMAL(18, 3))
                                                           ELSE CAST(T.Kolicina AS DECIMAL(18, 3))
                                                      END ) AS TP,
                                                    CAST(ISNULL(R.[SekRegM] + R.[SekRegP] + R.[TerRegM] + R.[TerRegP], 0) AS DECIMAL(18, 3)) AS Regulacija,
                                                    ( CASE WHEN TP2.Kolicina IS NOT NULL
                                                           THEN CAST(ISNULL(TP2.KoregiranTP, 0) AS DECIMAL(18, 3))
                                                           ELSE CAST(ISNULL(T.KoregiranTP, 0) AS DECIMAL(18, 3))
                                                      END ) AS KorigiranTP,
                                                   
												   ( CASE WHEN K2.Kolicina IS NOT NULL AND K2.Kolicina <> 0 THEN  CAST(K2.Odjem-K2.Oddaja AS DECIMAL(18, 3))
                                                   ELSE
                                                   CAST(K.Odjem-K.Oddaja AS DECIMAL(18, 3)) END) AS Realizacija,

                                                ( CASE WHEN K2.Kolicina IS NOT NULL AND K2.Kolicina <> 0 THEN  CAST(K2.Odjem-K2.Oddaja AS DECIMAL(18, 3))
                                                   ELSE
                                                   CAST(K.Odjem-K.Oddaja AS DECIMAL(18, 3)) END) -   ( CASE WHEN TP2.Kolicina IS NOT NULL
                                                           THEN CAST(ISNULL(TP2.KoregiranTP, 0) AS DECIMAL(18, 3))
                                                           ELSE CAST(ISNULL(T.KoregiranTP, 0) AS DECIMAL(18, 3))
                                                      END ) AS Odstopanje
                                          FROM      [dbo].[KolicinskaOdstopanjaPoBPS] K
                                                    LEFT JOIN ( SELECT  SUM(K2.Kolicina) AS Kolicina,
																		SUM(K2.Odjem) AS Odjem,
																		SUM(K2.Oddaja) AS Oddaja,
																		SUM(K2.Odstopanje) AS Odstopanje,
                                                                        K2.Interval,
                                                                        P.NadrejenaOsebaID
                                                                FROM    KolicinskaOdstopanjaPoBPS K2
                                                                        JOIN dbo.Pogodba P ON ( K2.OsebaID = P.Partner1 OR K2.OsebaID = P.Partner2 )
                                                                WHERE   K2.ObracunId = @obracunid
                                                                     --   AND K2.OsebaID = @osebaid
                                                                        AND ( @dt BETWEEN p.VeljaOd AND dbo.infinite(p.VeljaDo) )
                                                                        AND ( @dt BETWEEN P.[DatumVnosa]
                                                                                  AND     dbo.infinite(P.DatumSpremembe) )
                                                                GROUP BY K2.Interval,
                                                                        P.NadrejenaOsebaID
                                                              ) K2 ON K.OsebaId = K2.NadrejenaOsebaID
                                                                      AND K.Interval = K2.Interval
                                                    LEFT JOIN ( SELECT  SUM(VR.Kolicina) AS Kolicina,
                                                                        SUM(VR.KoregiranTP) AS KoregiranTP,
                                                                        P.NadrejenaOsebaID,
                                                                        VR.Interval
                                                                FROM    TrzniPlan VR
                                                                        JOIN dbo.Pogodba P ON ( VR.OsebaID = P.Partner1
                                                                                                OR VR.OsebaID = P.Partner2
                                                                                              )
                                                                WHERE   VR.DatumSpremembe IS NULL
                                                                        AND ( @dt BETWEEN VR.[DatumVnosa]
                                                                                  AND     dbo.infinite(VR.DatumSpremembe) )
                                                                        AND ( @dt BETWEEN p.VeljaOd AND dbo.infinite(p.VeljaDo) )
                                                                        AND ( @dt BETWEEN P.[DatumVnosa]
                                                                                  AND     dbo.infinite(P.DatumSpremembe) )
                                                                GROUP BY VR.Interval,
                                                                        P.NadrejenaOsebaID
                                                              ) T ON K.OsebaId = T.NadrejenaOsebaID
                                                                     AND K.Interval = T.Interval
                                                    JOIN dbo.TrzniPlan TP2 ON K.OsebaId = TP2.OsebaId
                                                                              AND K.Interval = TP2.Interval
                                                                              AND TP2.DatumSpremembe IS NULL
                                                                              AND ( @dt BETWEEN TP2.[DatumVnosa]
                                                                                        AND     dbo.infinite(TP2.DatumSpremembe) )
                                                    LEFT JOIN PPM M ON T.NadrejenaOsebaID = M.Dobavitelj1
                                                                       AND M.[PPMTipID] = @VIRT_REGULACIJA
                                                                       AND ( ( @dt BETWEEN M.DatumVnosa
                                                                                   AND     dbo.infinite(M.DatumSpremembe) )
                                                                             AND ( @dt BETWEEN M.VeljaOd AND dbo.infinite(M.VeljaDo) )
                                                                           )
                                                    LEFT JOIN [Regulacija] R ON M.[PPMID] = R.PPMID
                                                                                AND R.Interval = T.Interval
                                                                                AND ( @dt BETWEEN R.[DatumVnosa]
                                                                                          AND     dbo.infinite(R.DatumSpremembe) )
                                          WHERE     K.ObracunID = @obracunid
                                                    AND K.OsebaID = @osebaid
                                        ) AS b
                                --ORDER BY Interval ASC
                                ORDER BY DATEPART(day, [Interval]) ASC,
                                        DATEPART(month, [Interval]) ASC,
                                        ( CASE WHEN DATEPART(HH, [Interval]) = 0
                                               THEN 24
                                               ELSE DATEPART(HH, [Interval])
                                          END ) ASC
                            END
                    END
                IF ( @tipOsebe IN ( 3, 5 ) ) 
                    BEGIN  --GJS
                        IF ( @osebaBs = 1 ) 
                            BEGIN --JE BS
                                SELECT  --dbo.mk24ur(b.interval) AS Datum,
                                        ( CASE WHEN DATEPART(hour, b.interval) = 0
                                               THEN CONVERT (VARCHAR(20), DATEADD(day, -1, b.interval), 104)
                                                    + ' 24'
                                               WHEN DATEPART(hour, b.interval) < 10
                                               THEN CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' 0'
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                               ELSE CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' '
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                          END ) AS Datum,
                                        b.TP AS [Tržni Plan],
                                        b.Realizacija,
                                        b.Odstopanje AS [Odstopanje]
                                FROM    ( SELECT    K.interval,
                                                    CAST(T.Kolicina AS DECIMAL(18, 3)) AS TP,
                                                    CAST(K.Kolicina AS DECIMAL(18, 3)) AS Realizacija,
                                                    CAST(K.Odstopanje AS DECIMAL(18, 3)) AS Odstopanje
                                          FROM      [dbo].[KolicinskaOdstopanjaPoBS] K
                                                    JOIN TrzniPlan T ON K.OsebaId = T.OsebaID
                                                                        AND K.Interval = T.Interval
                                                                        AND T.DatumSpremembe IS NULL
                                          WHERE     K.OsebaID = @osebaid
                                                    AND K.ObracunID = @ObracunID
                                        ) AS b
                                --ORDER BY Interval ASC
                                ORDER BY DATEPART(day, [Interval]) ASC,
                                        DATEPART(month, [Interval]) ASC,
                                        ( CASE WHEN DATEPART(HH, [Interval]) = 0
                                               THEN 24
                                               ELSE DATEPART(HH, [Interval])
                                          END ) ASC
                            END
                        ELSE 
                            BEGIN --JE BpS
                                SELECT  --dbo.mk24ur(b.interval) AS Datum,
                                        ( CASE WHEN DATEPART(hour, b.interval) = 0
                                               THEN CONVERT (VARCHAR(20), DATEADD(day, -1, b.interval), 104)
                                                    + ' 24'
                                               WHEN DATEPART(hour, b.interval) < 10
                                               THEN CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' 0'
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                               ELSE CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' '
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                          END ) AS Datum,
                                        b.TP AS [Tržni Plan],
                                        b.Realizacija,
                                        b.Odstopanje AS [Odstopanje]
                                FROM    ( SELECT    K.interval,
                                                    CAST(T.Kolicina AS DECIMAL(18, 3)) AS TP,
                                                    CAST(K.Kolicina AS DECIMAL(18, 3)) AS Realizacija,
                                                    CAST(K.Odstopanje AS DECIMAL(18, 3)) AS Odstopanje
                                          FROM      [dbo].[KolicinskaOdstopanjaPoBPS] K
                                                    JOIN TrzniPlan T ON K.OsebaId = T.OsebaID
                                                                        AND K.Interval = T.Interval
                                                                        AND T.DatumSpremembe IS NULL
                                          WHERE     K.OsebaID = @osebaid
                                                    AND K.ObracunID = @ObracunID
                                        ) AS b
                                ORDER BY DATEPART(day, [Interval]) ASC,
                                        DATEPART(month, [Interval]) ASC,
                                        ( CASE WHEN DATEPART(HH, [Interval]) = 0
                                               THEN 24
                                               ELSE DATEPART(HH, [Interval])
                                          END ) ASC
                            END
                    END
                IF ( @tipOsebe IN ( 4 ) ) 
                    BEGIN -- trgovci
                  
                        IF ( @osebaBs = 1 ) 
                            BEGIN --JE BS
                                SELECT  --dbo.mk24ur(b.interval) AS Datum,
                                        ( CASE WHEN DATEPART(hour, b.interval) = 0
                                               THEN CONVERT (VARCHAR(20), DATEADD(day, -1, b.interval), 104)
                                                    + ' 24'
                                               WHEN DATEPART(hour, b.interval) < 10
                                               THEN CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' 0'
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                               ELSE CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' '
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                          END ) AS Datum,
                                        b.TP AS [Tržni Plan],
                                        b.Odstopanje AS [Odstopanje]
                                FROM    ( SELECT    K.interval,
                                                    CAST(T.kolicina AS DECIMAL(18, 3)) AS TP,
                                                    CAST(K.Odstopanje AS DECIMAL(18, 3)) AS Odstopanje
                                          FROM      KolicinskaOdstopanjaPoBS K
                                                    JOIN TrzniPlan T ON K.OsebaId = T.OsebaID
                                                                        AND K.Interval = T.Interval
                                                                        AND T.DatumSpremembe IS NULL
                                          WHERE     K.OsebaID = @osebaid
                                                    AND K.ObracunID = @ObracunID
                                        ) AS b
                                --ORDER BY Interval ASC
                                ORDER BY DATEPART(day, [Interval]) ASC,
                                        DATEPART(month, [Interval]) ASC,
                                        ( CASE WHEN DATEPART(HH, [Interval]) = 0
                                               THEN 24
                                               ELSE DATEPART(HH, [Interval])
                                          END ) ASC
                            END
                        ELSE 
                            BEGIN --JE BpS
                                SELECT  --dbo.mk24ur(b.interval) AS Datum,
                                        ( CASE WHEN DATEPART(hour, b.interval) = 0
                                               THEN CONVERT (VARCHAR(20), DATEADD(day, -1, b.interval), 104)
                                                    + ' 24'
                                               WHEN DATEPART(hour, b.interval) < 10
                                               THEN CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' 0'
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                               ELSE CONVERT (VARCHAR(10), b.interval, 104)
                                                    + ' '
                                                    + CAST(DATEPART(hour, b.interval) AS VARCHAR(5))
                                          END ) AS Datum,
                                        b.TP AS [Tržni Plan],
                                        b.Odstopanje AS [Odstopanje]
                                FROM    ( SELECT    K.interval,
                                                    CAST(T.kolicina AS DECIMAL(18, 3)) AS TP,
                                                    CAST(K.Odstopanje AS DECIMAL(18, 3)) AS Odstopanje
                                          FROM      KolicinskaOdstopanjaPoBPS K
                                                    JOIN TrzniPlan T ON K.OsebaId = T.OsebaID
                                                                        AND K.Interval = T.Interval
                                                                        AND T.DatumSpremembe IS NULL
                                          WHERE     K.OsebaID = @osebaid
                                                    AND K.ObracunID = @ObracunID
                                        ) AS b
                                --ORDER BY Interval ASC
                                ORDER BY DATEPART(day, [Interval]) ASC,
                                        DATEPART(month, [Interval]) ASC,
                                        ( CASE WHEN DATEPART(HH, [Interval]) = 0
                                               THEN 24
                                               ELSE DATEPART(HH, [Interval])
                                          END ) ASC
                            END
                    END
            END  --------------------konec dela 1 -- kolicinski.


        IF ( @del = 2 ) 
            BEGIN  --- financni izpis ...
                IF ( @osebaBs = 0 ) 
                    RETURN
					
                IF ( @tipOsebe IN ( 1 ) ) 
                    BEGIN 
                        SELECT  --dbo.mk24ur(a.interval) AS Datum,
                                ( CASE WHEN DATEPART(hour, a.interval) = 0
                                       THEN CONVERT (VARCHAR(20), DATEADD(day, -1, a.interval), 104)
                                            + ' 24'
                                       WHEN DATEPART(hour, a.interval) < 10
                                       THEN CONVERT (VARCHAR(10), a.interval, 104)
                                            + ' 0'
                                            + CAST(DATEPART(hour, a.interval) AS VARCHAR(5))
                                       ELSE CONVERT (VARCHAR(10), a.interval, 104)
                                            + ' '
                                            + CAST(DATEPART(hour, a.interval) AS VARCHAR(5))
                                  END ) AS Datum,
                                a.TPas AS [Tolerančni pas],
                                a.[CPnov] AS [C+],
                                a.[CnNov] AS [C-],
                                a.osnovni AS [Osnovni obračun],
                                a.Ck AS [Ck],
                                a.Pen AS [Penalizacija],
                                a.skupaj AS [Skupaj obračun]              
    --   a.Cpm as [C+/1,03],
    --   a.Cmm as [C-/0.97],
                        FROM    ( SELECT    P.Interval,
                                            CAST(T.KoregiranT AS DECIMAL(18, 3)) AS TPas,
                                            P.[CPNov],
                                            P.[CnNov],
                                            isnull(P.PoravnavaZnotrajT,0) AS osnovni,
                                            P.Ckplus + P.Ckminus AS Ck,
                                            P.PoravnavaZunajT AS Pen,
                                            isnull(P.PoravnavaZnotrajT,0)
                                            + isnull(P.PoravnavaZunajT,0) AS skupaj 
		      --cast(Cplus/1.03 as decimal (18,2)) as Cpm, cast(Cminus/0.97  as decimal (18,2)) as Cmm,
			  --PoravnavaZnotrajT
                                  FROM      PodatkiObracuna P
                                            JOIN [dbo].[TolerancniPas] T ON P.ObracunID = T.ObracunId
                                                                            AND P.OsebaId = t.OsebaId
                                                                            AND P.Interval = T.interval
                                  WHERE     P.OsebaID = @osebaid
                                            AND P.ObracunID = @obracunid
                                ) AS a
                        ORDER BY DATEPART(day, [Interval]) ASC,
                                DATEPART(month, [Interval]) ASC,
                                ( CASE WHEN DATEPART(HH, [Interval]) = 0
                                       THEN 24
                                       ELSE DATEPART(HH, [Interval])
                                  END ) ASC
                    END
                IF ( @tipOsebe IN ( 103 ) ) 
                    BEGIN 
                        SELECT  --dbo.mk24ur(a.interval) AS Datum,
                                ( CASE WHEN DATEPART(hour, a.interval) = 0
                                       THEN CONVERT (VARCHAR(20), DATEADD(day, -1, a.interval), 104)
                                            + ' 24'
                                       WHEN DATEPART(hour, a.interval) < 10
                                       THEN CONVERT (VARCHAR(10), a.interval, 104)
                                            + ' 0'
                                            + CAST(DATEPART(hour, a.interval) AS VARCHAR(5))
                                       ELSE CONVERT (VARCHAR(10), a.interval, 104)
                                            + ' '
                                            + CAST(DATEPART(hour, a.interval) AS VARCHAR(5))
                                  END ) AS Datum,
      -- a.Cplus as [C+],a.Cminus as [C-],
                                a.Cpm AS [C+/1,03],
                                a.Cmm AS [C-/0,97],
                                a.skupaj AS [Skupaj obračun]
                        FROM    ( SELECT    P.Interval,
                                            CAST(T.koregiranT AS DECIMAL(18, 3)) AS TPas,
		      --Cplus,Cminus,
                                            CAST(P.CpNov / 1.03 AS DECIMAL(18, 2)) AS Cpm,
                                            CAST(P.[CnNov] / 0.97 AS DECIMAL(18, 2)) AS Cmm,
                                            isnull(P.PoravnavaZnotrajT,0) AS skupaj
                                  FROM      PodatkiObracuna P
                                            JOIN [dbo].[TolerancniPas] T ON P.ObracunID = T.ObracunId
                                                                            AND P.OsebaId = t.OsebaId
                                                                            AND P.Interval = T.interval
                                  WHERE     P.OsebaID = @osebaid
                                            AND P.ObracunID = @obracunid
                                ) AS a
                        --ORDER BY Interval ASC
                        ORDER BY DATEPART(day, [Interval]) ASC,
                                DATEPART(month, [Interval]) ASC,
                                ( CASE WHEN DATEPART(HH, [Interval]) = 0
                                       THEN 24
                                       ELSE DATEPART(HH, [Interval])
                                  END ) ASC
                    END
                IF ( @tipOsebe IN ( 3 ) ) 
                    BEGIN 
                        SELECT  --dbo.mk24ur(a.interval) AS Datum,
                                ( CASE WHEN DATEPART(hour, a.interval) = 0
                                       THEN CONVERT (VARCHAR(20), DATEADD(day, -1, a.interval), 104)
                                            + ' 24'
                                       WHEN DATEPART(hour, a.interval) < 10
                                       THEN CONVERT (VARCHAR(10), a.interval, 104)
                                            + ' 0'
                                            + CAST(DATEPART(hour, a.interval) AS VARCHAR(5))
                                       ELSE CONVERT (VARCHAR(10), a.interval, 104)
                                            + ' '
                                            + CAST(DATEPART(hour, a.interval) AS VARCHAR(5))
                                  END ) AS Datum,
                                a.[CpNov] AS [C+],
                                a.[CnNov] AS [C-],
                                a.Cpm AS [C+/1,03],
                                a.Cmm AS [C-/0,97],
                                a.skupaj AS [Skupaj obračun]
                        FROM    ( SELECT    P.Interval,
                                            CAST(T.koregiranT AS DECIMAL(18, 3)) AS TPas,
                                            P.[CpNov],
                                            P.[CnNov],
                                            CAST(P.[CpNov] / 1.03 AS DECIMAL(18, 2)) AS Cpm,
                                            CAST(P.[CnNov] / 0.97 AS DECIMAL(18, 2)) AS Cmm,
                                            isnull(P.PoravnavaZnotrajT,0) AS skupaj
                                  FROM      PodatkiObracuna P
                                            JOIN [dbo].[TolerancniPas] T ON P.ObracunID = T.ObracunId
                                                                            AND P.OsebaId = t.OsebaId
                                                                            AND P.Interval = T.interval
                                  WHERE     P.OsebaID = @osebaid
                                            AND P.ObracunID = @obracunid
                                ) AS a
                       --ORDER BY Interval ASC
                        ORDER BY DATEPART(day, [Interval]) ASC,
                                DATEPART(month, [Interval]) ASC,
                                ( CASE WHEN DATEPART(HH, [Interval]) = 0
                                       THEN 24
                                       ELSE DATEPART(HH, [Interval])
                                  END ) ASC
                    END

                IF ( @tipOsebe IN ( 4 ) ) 
                    BEGIN  -- Trgovec. 

					

                        SELECT  --dbo.mk24ur(a.interval) AS Datum,
                                ( CASE WHEN DATEPART(hour, a.interval) = 0
                                       THEN CONVERT (VARCHAR(20), DATEADD(day, -1, a.interval), 104)
                                            + ' 24'
                                       WHEN DATEPART(hour, a.interval) < 10
                                       THEN CONVERT (VARCHAR(10), a.interval, 104)
                                            + ' 0'
                                            + CAST(DATEPART(hour, a.interval) AS VARCHAR(5))
                                       ELSE CONVERT (VARCHAR(10), a.interval, 104)
                                            + ' '
                                            + CAST(DATEPART(hour, a.interval) AS VARCHAR(5))
                                  END ) AS Datum,
                                a.[CpNov] AS [C+],
                                a.[CnNov] AS [C-],
                                a.skupaj AS [Skupaj obračun]
                        FROM    ( SELECT    Interval,
                                            [CpNov],
                                            [CnNov],
		      --cast(Cplus/1.03 as decimal (18,2)) as Cpm, cast(Cminus/0.97  as decimal (18,2)) as Cmm,
                                            isnull(PoravnavaZnotrajT,0)
                                            + isnull(PoravnavaZunajT,0) AS skupaj
                                  FROM      PodatkiObracuna
                                  WHERE     OsebaID = @osebaid
                                            AND ObracunID = @obracunid
                                ) AS a
                        --ORDER BY Interval ASC
                        ORDER BY DATEPART(day, [Interval]) ASC,
                                DATEPART(month, [Interval]) ASC,
                                ( CASE WHEN DATEPART(HH, [Interval]) = 0
                                       THEN 24
                                       ELSE DATEPART(HH, [Interval])
                                  END ) ASC
                    END
                IF ( @tipOsebe IN ( 5 ) ) 
                    BEGIN  -- meja. 
 -- tu rabimo C+/C- zato poiscemo eno penalizirano osebo.
 
                        DECLARE @tInterval DATETIME 
                        DECLARE @osebaPen INT 
                        SELECT TOP 1
                                @tInterval = interval
                        FROM    PodatkiObracuna
                        WHERE   ObracunID = @ObracunID
                        SELECT  @dt = datumvnosa
                        FROM    Obracun
                        WHERE   ObracunID = @ObracunID
                        SELECT  @osebaPen = OsebaID
                        FROM    OsebaZCalc
                        WHERE   OsebaZId = 1  -- penaliziran=1
                                AND @dt BETWEEN DatumVnosa
                                        AND     dbo.infinite(datumSpremembe)
                                AND OsebaID IN ( SELECT DISTINCT
                                                        osebaid
                                                 FROM   PodatkiObracuna
                                                 WHERE  Interval = @tInterval ) 
             
                        SELECT  --dbo.mk24ur(a.interval) AS Datum,
                                ( CASE WHEN DATEPART(hour, a.interval) = 0
                                       THEN CONVERT (VARCHAR(20), DATEADD(day, -1, a.interval), 104)
                                            + ' 24'
                                       WHEN DATEPART(hour, a.interval) < 10
                                       THEN CONVERT (VARCHAR(10), a.interval, 104)
                                            + ' 0'
                                            + CAST(DATEPART(hour, a.interval) AS VARCHAR(5))
                                       ELSE CONVERT (VARCHAR(10), a.interval, 104)
                                            + ' '
                                            + CAST(DATEPART(hour, a.interval) AS VARCHAR(5))
                                  END ) AS Datum,
                                b.CplusPen AS [C+],
                                b.CminusPen AS [C-],
                                a.Cplus AS [V+],
                                a.Cminus AS [V-],
                                a.skupaj AS [Skupaj obračun]
                        FROM    ( SELECT    Interval,
                                            CAST(TolerancniPas AS DECIMAL(18, 3)) AS TPas,
                                            Cplus,
                                            Cminus,
                                            isnull(PoravnavaZnotrajT,0) AS skupaj
                                  FROM      PodatkiObracuna
                                  WHERE     OsebaID = @osebaid
                                            AND ObracunID = @obracunid
                                ) AS a,
                                ( SELECT    Interval,
                                            [CpNov] AS CplusPen,
                                            [CnNov] AS CminusPen,
                                             isnull(PoravnavaZnotrajT,0) AS skupaj
                                  FROM      PodatkiObracuna
                                  WHERE     OsebaID = @osebaPen
                                            AND ObracunID = @obracunid
                                ) AS b
                        WHERE   a.Interval = b.Interval
                        --ORDER BY Interval ASC
                        ORDER BY DATEPART(day, a.[Interval]) ASC,
                                DATEPART(month, a.[Interval]) ASC,
                                ( CASE WHEN DATEPART(HH, a.[Interval]) = 0
                                       THEN 24
                                       ELSE DATEPART(HH, a.[Interval])
                                  END ) ASC
                    END
 

            END

        IF ( @del = 3 ) 
            BEGIN  --sumarni izpis
                IF ( @osebaBs = 1 ) 
                    BEGIN --JE BS
					
                        SELECT  a.odstopanje,
                                a.osnovni,
                                a.penali,
                                a.skupaj,
                                a.isBS,
                                a.tipOsebe
                        FROM    ( SELECT    SUM(P.odstopanje) AS odstopanje,
                                            SUM(PoravnavaZnotrajT) AS osnovni,
                                            SUM(PoravnavaZunajT) AS penali,
                                            SUM(PoravnavaZnotrajT
                                                + PoravnavaZunajT) AS skupaj,
                                            @osebaBs AS isBS,
                                            @tipOsebe AS tipOsebe
                                  FROM      [dbo].[PodatkiObracuna] P
                                  WHERE     P.ObracunID = @obracunid
                                            AND P.OsebaID = @osebaid
                                ) AS a
	 
                    END
                ELSE 
                    BEGIN --JE BS
					
                        SELECT  a.odstopanje,
                                a.osnovni,
                                a.penali,
                                a.skupaj,
                                a.isBS,
                                a.tipOsebe
                        FROM    ( SELECT    SUM(P.odstopanje) AS odstopanje,
                                            SUM(0.0) AS osnovni,
                                            SUM(0.0) AS penali,
                                            SUM(0.0) AS skupaj,
                                            @osebaBs AS isBS,
                                            @tipOsebe AS tipOsebe
                                  FROM      [dbo].[KolicinskaOdstopanjaPoBPS] P
                                  WHERE     P.ObracunID = @obracunid
                                            AND P.OsebaID = @osebaid
                                ) AS a
	 
                    END
				
				
            END

    END


GO