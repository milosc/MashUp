EXEC [dbo].[DropPRCorUDF] @ObjectName = 'newReportIzravnava'
GO

CREATE PROCEDURE [dbo].[newReportIzravnava]
    (
      @veljaOd DATETIME,
      @veljaDo DATETIME,
      @stanje DATETIME
    )
AS 
    BEGIN 

      SELECT  dbo.mk24ur(I.Interval) AS Datum,
                (CAST(ISNULL(i.[W+], 0) + RWp AS DECIMAL(24, 8))) AS [W+],
                (CAST(ISNULL(i.[W-], 0) + RWm AS DECIMAL(24, 8))) AS [W-],
                (CAST(i.[S+]+ RSp AS DECIMAL(24, 8))) AS [S+],
                (CAST(i.[S-]+RSm  AS DECIMAL(24, 8))) AS [S-]
        FROM  (  select 
        tp.Interval,
				sum(ISNULL(tp.[Wp], 0)) AS [W+],
                sum(ISNULL(tp.[Wm], 0)) AS [W-],
                sum(tp.Sp) AS [S+],
                sum(tp.Sm) AS [S-]
        from Izravnava tp
          WHERE   tp.Interval >= @VeljaOd
                AND ( tp.Interval < DATEADD(d, 1, @VeljaDo) )
                AND ( @stanje BETWEEN tp.DatumVnosa
                              AND     dbo.infinite(tp.DatumSpremembe) )
       group by Interval            
        ) AS I
                LEFT JOIN (SELECT interval,
																		   sum(ISNULL(SekRegP,0)+ISNULL(TerRegP,0)) as RWp,
																		   sum(ISNULL(SekRegM,0)+ISNULL(TerRegM,0)) RWm,
																		   sum(ISNULL(SekRegSp,0)+ISNULL(TerRegSp,0)) as RSp,
																		   sum(ISNULL(SekRegSm,0)+ISNULL(TerRegSm,0)) as RSm
										from dbo.Regulacija
										where 
											Interval >= @VeljaOd
                                        AND Interval < DATEADD(DAY, 1, @VeljaDo)
										AND @stanje BETWEEN [DatumVnosa] AND dbo.infinite(DatumSpremembe) 
										and DatumSpremembe is null
										GROUP BY Interval 
										) R ON I.Interval = R.Interval
       
        ORDER BY Datum ASC

    END
