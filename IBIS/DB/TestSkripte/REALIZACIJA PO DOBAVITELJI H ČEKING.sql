 DROP TABLE #test
 
 SELECT *
 INTO #test
 FROM
 (
 SELECT  SUM(( CASE WHEN PPM.[PPMTipID] IN (
                                                1,
                                                2,
                                                13 )
                                           THEN ABS(M.Kolicina)
                                           WHEN PPM.[PPMTipID] IN (
                                                4,
                                                5 )
                                           THEN -1 * M.Kolicina
                                           ELSE 0
                                      END )) AS realizacija,
                                SUM(( CASE WHEN PPM.[PPMTipID] IN (
                                                4,
                                                5 )
                                           THEN M.Kolicina
                                           ELSE 0
                                      END )) AS oddaja,
                                SUM(( CASE WHEN PPM.[PPMTipID] IN (
                                                1,
                                                2,
                                                13 )
                                           THEN ABS(M.Kolicina)
                                           ELSE 0
                                      END )) AS odjem,
                                M.[Interval],
                                PPM.[Dobavitelj1] AS OsebaId,
                                P.Nivo,
                                NadrejenaOsebaID,
                                PPM.SistemskiOperater1
                        FROM    
                        Meritve_Jan_12 M 
                                INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
                                INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
                        WHERE   M.[Interval] >= '2012-01-01 00:00:00'
                                AND M.[Interval] <= DATEADD(DAY, 1,
                                                            '2012-01-31 00:00:00')
                                                            
                                AND M.[Interval] = '2012-01-01 01:00:00'                       
                                AND M.[DatumVnosa] <= GETDATE()
                                AND M.DatumSpremembe IS NULL
                                AND ( PPM.[PPMTipID] <> 6 )
                                AND ( PPM.[PPMTipID] <> 21 )
                                AND PPM.[PPMTipID] IS NOT NULL
                                AND P.Nivo > 0
                                AND ( P.[PogodbaTipID] = 2
                                      OR P.[PogodbaTipID] = 1
                                    )
                                AND ( ( GETDATE() BETWEEN PPM.DatumVnosa
                                                         AND     dbo.infinite(PPM.DatumSpremembe) )
                                      AND ( GETDATE() BETWEEN PPM.VeljaOd
                                                                      AND     dbo.infinite(PPM.VeljaDo) )
                                    )
                                AND ( GETDATE() BETWEEN M.[DatumVnosa]
                                                       AND     dbo.infinite(M.[DatumSpremembe]) )
                                AND ( ( ( GETDATE() BETWEEN P.DatumVnosa
                                                           AND     dbo.infinite(P.DatumSpremembe)
                                          
                                        )
                                        
                                      )
                                      AND ( GETDATE() BETWEEN P.VeljaOd
                                                                      AND     dbo.infinite(P.VeljaDo) )
                                    )
                        GROUP BY M.[Interval],
                                P.Nivo,
                                PPM.[Dobavitelj1],
                                P.NadrejenaOsebaID,
                                PPM.SistemskiOperater1
                                                UNION all
                         SELECT  SUM(( ( CASE WHEN PPMJeOddaja = 1
                                                  AND M.Kolicina < 0
                                             THEN -1 * M.Kolicina
                                             WHEN PPMJeOddaja = 0
                                                  AND M.Kolicina >= 0
                                             THEN M.Kolicina
                                             ELSE 0
                                        END )
                                      - ( CASE WHEN PPMJeOddaja = 1
                                                    AND M.Kolicina > 0
                                               THEN M.Kolicina
                                               WHEN PPMJeOddaja = 0
                                                    AND M.Kolicina < 0
                                               THEN -1 * M.Kolicina
                                               ELSE 0
                                          END ) )),
					--oddaja
                                SUM(( CASE WHEN PPMJeOddaja = 1
                                                AND M.Kolicina > 0
                                           THEN M.Kolicina
                                           WHEN PPMJeOddaja = 0
                                                AND M.Kolicina < 0
                                           THEN -1 * M.Kolicina
                                           ELSE 0
                                      END )),
					--odjem
                                SUM(( CASE WHEN PPMJeOddaja = 1
                                                AND M.Kolicina < 0
                                           THEN -1 * M.Kolicina
                                           WHEN PPMJeOddaja = 0
                                                AND M.Kolicina >= 0
                                           THEN M.Kolicina
                                           ELSE 0
                                      END )),
                                M.[Interval],
                                PPM.[Dobavitelj1] AS OsebaId,
                                P.[Nivo],
                                [NadrejenaOsebaID],
                                PPM.[SistemskiOperater1]
                        FROM Meritve_Jan_12 M 
                                INNER JOIN [dbo].[PPM] PPM ON M.[PPMID] = PPM.[PPMID]
                                INNER JOIN [dbo].[Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
                        WHERE   M.[Interval] >= '2012-01-01 00:00:00'
                                AND M.[Interval] <= DATEADD(DAY, 1,
                                                            '2012-01-31 00:00:00')
                                AND M.[DatumVnosa] <= GETDATE()
                                AND M.DatumSpremembe IS NULL
                                AND M.[Interval] = '2012-01-01 00:00:00'
                                AND ( PPM.[PPMTipID] = 21 )
                                AND P.[Nivo] > 0
                                AND ( P.[PogodbaTipID] = 2
                                      OR P.[PogodbaTipID] = 1
                                    )
                                AND ( ( GETDATE() BETWEEN PPM.[DatumVnosa]
                                                         AND     dbo.infinite(PPM.[DatumSpremembe]) )
                                      AND ( GETDATE() BETWEEN PPM.[VeljaOd]
                                                                      AND     dbo.infinite(PPM.[VeljaDo]) )
                                    )
                                AND ( GETDATE() BETWEEN M.[DatumVnosa]
                                                       AND     dbo.infinite(M.DatumSpremembe) )
                                AND ( ( ( GETDATE() BETWEEN P.DatumVnosa
                                                           AND     dbo.infinite(P.DatumSpremembe)
                                          
                                        )
                                        
                                      )
                                      AND ( GETDATE() BETWEEN P.VeljaOd
                                                                      AND     dbo.infinite(P.VeljaDo) )
                                    )
                        GROUP BY M.[Interval],
                                P.Nivo,
                                PPM.[Dobavitelj1],
                                P.NadrejenaOsebaID,
                                PPM.SistemskiOperater1
                                ) A
                                ORDER BY A.[OsebaId] ASC,A.NadrejenaOsebaID ASC
                        
                        
                        SELECT * FROM #test
                                
                                
                                DECLARE @maxNivo INT
                SELECT  @maxNivo = MAX(Nivo)
                FROM    #test RPD
    
			
                WHILE ( @maxNivo ) > 2
                    BEGIN
				
                        UPDATE  [#test]
                        SET     [#test].[realizacija] = [#test].[realizacija]
                                + RPD.realizacija,
                                [#test].[Oddaja] = [#test].[Oddaja]
                                + RPD.[Oddaja],
                                [#test].[Odjem] = [#test].[Odjem]
                                + RPD.[Odjem]
                        FROM    [#test]
                                LEFT JOIN [#test] RPD ON [#test].[OsebaId] = RPD.[NadrejenaOsebaID]
                                                                             AND [#test].[Interval] = RPD.[Interval]
                        WHERE   [#test].[Nivo] = @maxNivo   - 1
                                AND RPD.[Nivo] = @maxNivo
                                AND RPD.OsebaId <> [#test].[OsebaId]
                                
      					
                        UPDATE  [#test]
                        SET     [Nivo] = [Nivo] - 1
                        WHERE   [Nivo] = @maxNivo
                   
                        SET @maxNivo = @maxNivo - 1
                        PRINT @maxNivo
				
                        IF ( SELECT MAX(Nivo)
                             FROM   [#test]
                           ) = 2 
                            BREAK
                        ELSE 
                            CONTINUE
                    END
		
           
            
            SELECT * FROM #test