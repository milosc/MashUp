

EXEC [dbo].[DropPRCorUDF] @ObjectName = 'BilnacniObracun_DES_Izvoz' 
GO

CREATE PROCEDURE [dbo].[BilnacniObracun_DES_Izvoz] ( @ObracunID INT )
AS 
    BEGIN
    
        DECLARE @VIRT_REGULACIJA INT
    
        SELECT  @VIRT_REGULACIJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(REG) VIRT_REGULACIJA' ;
        
        DECLARE @Datum DATETIME ;
        SET @Datum = GETDATE() ;
    
        SELECT  OO.[VeljaOd],
                OO.[VeljaDo]
        FROM    [dbo].[Obracun] O
                JOIN [dbo].[ObracunskoObdobje] OO ON O.[ObracunskoObdobjeID] = OO.[ObracunskoObdobjeID]
        WHERE   O.[ObracunID] = @ObracunID
    
    
        SELECT  A.OsebaID,
                A.Interval,
                A.[Odstopanje],
                A.EIC,
                A.[KoregiranTP],
                A.TrzniPlan,
                A.Regulacija,
                A.Realizacija,
                A.[TolerancniPas],
                A.PoravnavaSkupaj,
                A.[CpNov],
                A.[CnNov],
                A.Cpenalty,
                A.Penalizacija
        FROM    ( SELECT    P.OsebaID,
                            P.[Interval],
                            P.[Odstopanje],
                            ( CASE WHEN LEN(LTRIM(RTRIM(ISNULL(O.[EIC], '')))) < 5
                                   THEN 'EIC neveljaven! ID osebe: '
                                        + CAST(P.OsebaID AS VARCHAR(10))
                                   ELSE O.[EIC]
                              END ) AS EIC,
                            TP.[KoregiranTP],
                            TP.[Kolicina] AS TrzniPlan,
                            CAST(ISNULL(R.[SekRegM] + R.[SekRegP]
                                        + R.[TerRegM] + R.[TerRegP], 0) AS DECIMAL(18, 3)) AS Regulacija,
                            ( CASE WHEN KBS.[Kolicina] IS NOT NULL
                                   THEN KBS.Kolicina
                                   WHEN KBPS.Kolicina IS NOT NULL
                                   THEN KBPS.Kolicina
                                   ELSE NULL
                              END ) AS Realizacija,
                            P.[TolerancniPas],
                            ISNULL(P.[PoravnavaZnotrajT], 0)
                            + ISNULL(P.[PoravnavaZunajT], 0) AS PoravnavaSkupaj,
                            ( CASE WHEN OT.OsebaTipID = 103
                                   THEN P.[CpNov] / 1.03
                                   ELSE P.[CpNov]
                              END ) AS CpNov,
                            ( CASE WHEN OT.OsebaTipID = 103
                                   THEN P.[CnNov] / 0.97
                                   ELSE P.[CnNov]
                              END ) AS CnNov,
                            ( ISNULL(P.[Ckminus],0) + ISNULL(P.[Ckplus],0) ) AS Cpenalty,
                            ISNULL(P.[PoravnavaZunajT], 0) AS Penalizacija
                  FROM      [dbo].[PodatkiObracuna] P
                            JOIN [dbo].[Oseba] O ON P.[OsebaID] = O.[OsebaID]
                            JOIN dbo.OsebaTip OT ON O.OsebaID = OT.OsebaID
                                                    AND OT.DatumSpremembe IS NULL
                            JOIN [dbo].[TrzniPlan] TP ON P.[OsebaID] = TP.[OsebaID]
                                                         AND P.[Interval] = TP.[Interval]
                                                         AND TP.[DatumSpremembe] IS NULL
                            LEFT JOIN [dbo].[KolicinskaOdstopanjaPoBS] KBS ON KBS.[ObracunID] = P.[ObracunID]
                                                                              AND KBS.[OsebaID] = P.[OsebaID]
                                                                              AND KBS.[Interval] = P.[Interval]
                            LEFT JOIN [dbo].[KolicinskaOdstopanjaPoBPS] KBPS ON KBPS.[ObracunID] = P.[ObracunID]
                                                                                AND KBPS.[OsebaID] = P.[OsebaID]
                                                                                AND KBPS.[Interval] = P.[Interval]
                            LEFT JOIN PPM M ON Tp.[OsebaID] = M.Dobavitelj1
                                               AND M.[PPMTipID] = @VIRT_REGULACIJA
                                               AND ( ( GETDATE() BETWEEN M.DatumVnosa
                                                                 AND     dbo.infinite(M.DatumSpremembe) )
                                                     AND ( GETDATE() BETWEEN M.VeljaOd
                                                                     AND     dbo.infinite(M.VeljaDo) )
                                                   )
                            LEFT JOIN [Regulacija] R ON M.[PPMID] = R.PPMID
                                                        AND R.Interval = Tp.Interval
                                                        AND ( GETDATE() BETWEEN R.[DatumVnosa]
                                                                        AND     dbo.infinite(R.DatumSpremembe) )
                  WHERE     P.[ObracunID] = @obracunid
                            AND ( @Datum BETWEEN O.VeljaOd
                                         AND     dbo.infinite(o.VeljaDo) )
                            AND ( @Datum BETWEEN o.[DatumVnosa]
                                         AND     dbo.infinite(o.DatumSpremembe) )
					UNION ALL
					SELECT  KBPS.OsebaID,
                            KBPS.[Interval],
                            KBPS.Odstopanje,
                            ( CASE WHEN LEN(LTRIM(RTRIM(ISNULL(O.[EIC], '')))) < 5
                                   THEN 'EIC neveljaven! ID osebe: '
                                        + CAST(KBPS.OsebaID AS VARCHAR(10))
                                   ELSE O.[EIC]
                              END ) AS EIC,
                            TP.[KoregiranTP],
                            TP.[Kolicina] AS TrzniPlan,
                            CAST(ISNULL(R.[SekRegM] + R.[SekRegP]
                                        + R.[TerRegM] + R.[TerRegP], 0) AS DECIMAL(18, 3)) AS Regulacija,
                            KBPS.Kolicina AS Realizacija,
                            0.0 as[TolerancniPas],
                            0.0 AS PoravnavaSkupaj,
                            0.0 AS CpNov,
                            0.0 AS CnNov,
                            0.0 AS Cpenalty,
                            0.0 AS Penalizacija
                  FROM      KolicinskaOdstopanjaPoBPS KBPS
                            JOIN [dbo].[Oseba] O ON KBPS.[OsebaID] = O.[OsebaID]
                            JOIN [dbo].[TrzniPlan] TP ON KBPS.[OsebaID] = TP.[OsebaID]
                                                         AND KBPS.[Interval] = TP.[Interval]
                                                         AND TP.[DatumSpremembe] IS NULL
                            LEFT JOIN PPM M ON Tp.[OsebaID] = M.Dobavitelj1
                                               AND M.[PPMTipID] = @VIRT_REGULACIJA
                                               AND ( ( GETDATE() BETWEEN M.DatumVnosa
                                                                 AND     dbo.infinite(M.DatumSpremembe) )
                                                     AND ( GETDATE() BETWEEN M.VeljaOd
                                                                     AND     dbo.infinite(M.VeljaDo) )
                                                   )
                            LEFT JOIN [Regulacija] R ON M.[PPMID] = R.PPMID
                                                        AND R.Interval = Tp.Interval
                                                        AND ( GETDATE() BETWEEN R.[DatumVnosa]
                                                                        AND     dbo.infinite(R.DatumSpremembe) )
                  WHERE     
							KBPS.[ObracunID] = @obracunid
                            AND ( @Datum BETWEEN O.VeljaOd
                                         AND     dbo.infinite(o.VeljaDo) )
                            AND ( @Datum BETWEEN o.[DatumVnosa]
                                         AND     dbo.infinite(o.DatumSpremembe) )                                         
                                         
                ) A
        ORDER BY A.[OsebaID] ASC,
                DATEPART(month, A.[Interval]) ASC,
                DATEPART(day, A.[Interval]) ASC,
                ( CASE WHEN DATEPART(HH, A.[Interval]) = 0 THEN 24
                       ELSE DATEPART(HH, A.[Interval])
                  END ) ASC
        
    
    END
    
    