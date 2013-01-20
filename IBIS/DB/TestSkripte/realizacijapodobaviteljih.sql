EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_RealizacijaPoDobaviteljih'
GO 


CREATE PROCEDURE [dbo].[BilancniObracun_RealizacijaPoDobaviteljih]
    (
      @BP AS INT,
      @Bs AS XML,
      @DatumIntervalaDO AS DATETIME,
      @DatumIntervalaOD AS DATETIME,
      @DatumStanjaBaze AS DATETIME,
      @DatumVeljavnostiPodatkov AS DATETIME,
      @NewObracunID AS INT,
      @NOErrors AS INT OUTPUT,
      @PI AS INT,
      @UDO_P_IZGUBE AS INT,
      @VIRT_ELES_MERITVE AS INT,
      @VIRT_MERJEN_ODDAJA AS INT,
      @VIRT_MERJENI_ODJEM AS INT,
      @VIRT_NEMERJEN_ODDAJA AS INT,
      @VIRT_NEMERJENI_ODJEM AS INT,
      @VIRT_REGULACIJA AS INT,
      @ErrorHeadXML XML OUTPUT,
      @ErrorDetailsXML XML OUTPUT
    )
AS 
    BEGIN

        DECLARE @SQLString NVARCHAR(MAX) ;
        DECLARE @ParmDefinition NVARCHAR(4000) ;

        IF OBJECT_ID('#Errors') IS NOT NULL 
            DROP TABLE #Errors
        
        CREATE TABLE #Errors
            (
              ErrorID BIGINT IDENTITY(1, 1)
                             NOT NULL,
              Napaka VARCHAR(255) NOT NULL
            )

        IF OBJECT_ID('#ErrorDetail') IS NOT NULL 
            DROP TABLE #ErrorDetail
        
        CREATE TABLE #ErrorDetail
            (
              ErrorID BIGINT,
              ErrorDetail VARCHAR(900) NOT NULL
            )


        IF OBJECT_ID('#BS') IS NOT NULL 
            DROP TABLE #BS

        CREATE TABLE #BS
            (
              BilancnaSkupinaID BIGINT
            )
		    
        IF ( @Bs IS NOT NULL ) 
            BEGIN
                DECLARE @hdocVTC INT ;
                DECLARE @xmlpath VARCHAR(255) ;
                SET @xmlpath = '/SeznamBS/bskupine' ;
                EXEC sp_xml_preparedocument @hdocVTC OUTPUT, @Bs ;

                INSERT  INTO #BS ( BilancnaSkupinaID )
                        SELECT  bilancnaskupina
                        FROM    OPENXML(@hdocVTC,@xmlpath,2) WITH ( bilancnaskupina BIGINT )
                        ORDER BY bilancnaskupina ASC     
                EXEC sp_xml_removedocument @hdocVTC
            END
			--SODO MERITVE
        IF ( ( SELECT   COUNT(*)
               FROM     #BS
             ) = 0 ) 
            BEGIN

				SET @SQLString = '
                INSERT  INTO [RealizacijaPoDobaviteljih]
                        (
                          [Kolicina],
                          [Oddaja],
                          [Odjem],
                          [Interval],
                          [OsebaID],
                          [Nivo],
                          [ObracunID],
                          [NadrejenaOsebaID],
                          [SistemskiOperaterID]
				)
                        SELECT  SUM(( CASE WHEN PPM.[PPMTipID] IN (
                                                @VIRT_MERJENI_ODJEM,
                                                @VIRT_NEMERJENI_ODJEM,
                                                @UDO_P_IZGUBE )
                                           THEN ABS(M.Kolicina)
                                           WHEN PPM.[PPMTipID] IN (
                                                @VIRT_MERJEN_ODDAJA,
                                                @VIRT_NEMERJEN_ODDAJA )
                                           THEN -1 * M.Kolicina
                                           ELSE 0
                                      END )),
                                SUM(( CASE WHEN PPM.[PPMTipID] IN (
                                                @VIRT_MERJEN_ODDAJA,
                                                @VIRT_NEMERJEN_ODDAJA )
                                           THEN M.Kolicina
                                           ELSE 0
                                      END )),
                                SUM(( CASE WHEN PPM.[PPMTipID] IN (
                                                @VIRT_MERJENI_ODJEM,
                                                @VIRT_NEMERJENI_ODJEM,
                                                @UDO_P_IZGUBE )
                                           THEN ABS(M.Kolicina)
                                           ELSE 0
                                      END )),
                                M.[Interval],
                                PPM.[Dobavitelj1],
                                P.Nivo,
                                @NewObracunID,
                                NadrejenaOsebaID,
                                PPM.SistemskiOperater1
                        FROM    
                        '+[dbo].[ResolveTableName](@DatumIntervalaDO,@DatumIntervalaOD) +' M 
                                INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
                                INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
                        WHERE   M.[Interval] >= @DatumIntervalaOD
                                AND M.[Interval] <= DATEADD(DAY, 1,
                                                            @DatumIntervalaDO)
                                AND M.[DatumVnosa] <= @DatumStanjaBaze
                                AND ( PPM.[PPMTipID] <> @VIRT_REGULACIJA )
                                AND ( PPM.[PPMTipID] <> @VIRT_ELES_MERITVE )
                                AND PPM.[PPMTipID] IS NOT NULL
                                AND P.Nivo > 0
                                AND ( P.[PogodbaTipID] = @PI
                                      OR P.[PogodbaTipID] = @BP
                                    )
                                AND ( ( @DatumStanjaBaze BETWEEN PPM.DatumVnosa
                                                         AND     dbo.infinite(PPM.DatumSpremembe) )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN PPM.VeljaOd
                                                                      AND     dbo.infinite(PPM.VeljaDo) )
                                    )
                                AND ( @DatumStanjaBaze BETWEEN M.[DatumVnosa]
                                                       AND     dbo.infinite(M.[DatumSpremembe]) )
                                AND ( ( ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                           AND     dbo.infinite(P.DatumSpremembe)
                                          AND P.Aktivno = 1
                                        )
                                        OR ( P.Aktivno = 1 )
                                      )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                      AND     dbo.infinite(P.VeljaDo) )
                                    )
                        GROUP BY M.[Interval],
                                P.Nivo,
                                PPM.[Dobavitelj1],
                                P.NadrejenaOsebaID,
                                PPM.SistemskiOperater1
                OPTION  ( MAXDOP 1 )
                '
				
				SET @ParmDefinition = N'@DatumIntervalaDO datetime,
										@DatumIntervalaOD datetime,
										@DatumStanjaBaze datetime,
										@VIRT_REGULACIJA INT,
										@VIRT_ELES_MERITVE INT,
										@PI int,
										@BP int,
										@DatumVeljavnostiPodatkov datetime,
										@VIRT_MERJENI_ODJEM int,
										@VIRT_NEMERJENI_ODJEM int,
										@UDO_P_IZGUBE int,
										@VIRT_MERJEN_ODDAJA INT,
										@VIRT_NEMERJEN_ODDAJA INT,
										@NewObracunID int';


				EXECUTE sp_executesql @SQLString, @ParmDefinition,
										@DatumIntervalaDO = @DatumIntervalaDO,
										@DatumIntervalaOD = @DatumIntervalaOD,
										@DatumStanjaBaze = @DatumStanjaBaze,
										@VIRT_REGULACIJA = @VIRT_REGULACIJA,
										@VIRT_ELES_MERITVE = @VIRT_ELES_MERITVE,
										@PI = @PI,
										@BP = @BP,
										@DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
										@VIRT_MERJENI_ODJEM  = @VIRT_MERJENI_ODJEM,
										@VIRT_NEMERJENI_ODJEM  = @VIRT_NEMERJENI_ODJEM,
										@UDO_P_IZGUBE  = @UDO_P_IZGUBE,
										@VIRT_MERJEN_ODDAJA  = @VIRT_MERJEN_ODDAJA,
										@VIRT_NEMERJEN_ODDAJA  = @VIRT_NEMERJEN_ODDAJA,
										@NewObracunID  = @NewObracunID;

                      
                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 002: Napaka pri agregiranju realizacije po dobaviteljih (SODO).'
                            ) ;



            END
        ELSE 
            BEGIN
				--samo doloèene BS
				SET @SQLString = '
                INSERT  INTO [RealizacijaPoDobaviteljih]
                        (
                          [Kolicina],
                          [Oddaja],
                          [Odjem],
                          [Interval],
                          [OsebaID],
                          [Nivo],
                          [ObracunID],
                          [NadrejenaOsebaID],
                          [SistemskiOperaterID]
				)
                        SELECT  SUM(( CASE WHEN PPM.PPMTipID IN (
                                                @VIRT_MERJENI_ODJEM,
                                                @VIRT_NEMERJENI_ODJEM,
                                                @UDO_P_IZGUBE )
                                           THEN ABS(M.Kolicina)
                                           WHEN PPM.PPMTipID IN (
                                                @VIRT_MERJEN_ODDAJA,
                                                @VIRT_NEMERJEN_ODDAJA )
                                           THEN -1 * M.Kolicina
                                           ELSE 0
                                      END )),
                                SUM(( CASE WHEN PPM.PPMTipID IN (
                                                @VIRT_MERJEN_ODDAJA,
                                                @VIRT_NEMERJEN_ODDAJA )
                                           THEN M.Kolicina
                                           ELSE 0
                                      END )),
                                SUM(( CASE WHEN PPM.PPMTipID IN (
                                                @VIRT_MERJENI_ODJEM,
                                                @VIRT_NEMERJENI_ODJEM,
                                                @UDO_P_IZGUBE )
                                           THEN ABS(M.Kolicina)
                                           ELSE 0
                                      END )),
                                M.[Interval],
                                PPM.[Dobavitelj1],
                                P.Nivo,
                                @NewObracunID,
                                NadrejenaOsebaID,
                                PPM.SistemskiOperater1
                        FROM    
                        '+[dbo].[ResolveTableName](@DatumIntervalaDO,@DatumIntervalaOD) +' M 
                                INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
                                INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
                                INNER JOIN [#BS] BS ON ( BS.[BilancnaSkupinaID] = P.ClanBSID )
                        WHERE   M.[Interval] >= @DatumIntervalaOD
                                AND M.[Interval] <= DATEADD(DAY, 1,
                                                            @DatumIntervalaDO)
                                AND M.[DatumVnosa] <= @DatumStanjaBaze
                                AND ( PPM.[PPMTipID] <> @VIRT_REGULACIJA )
                                AND ( PPM.[PPMTipID] <> @VIRT_ELES_MERITVE )
                                AND PPM.[PPMTipID] IS NOT NULL
                                AND P.Nivo > 0
                                AND ( P.[PogodbaTipID] = @PI
                                      OR P.[PogodbaTipID] = @BP
                                    )
                                AND ( ( @DatumStanjaBaze BETWEEN PPM.DatumVnosa
                                                         AND     dbo.infinite(PPM.DatumSpremembe) )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN PPM.VeljaOd
                                                                      AND     dbo.infinite(PPM.VeljaDo) )
                                    )
                                AND ( @DatumStanjaBaze BETWEEN M.[DatumVnosa]
                                                       AND     dbo.infinite(M.DatumSpremembe) )
                                AND ( ( ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                           AND     dbo.infinite(P.DatumSpremembe)
                                          AND P.Aktivno = 1
                                        )
                                        OR ( P.Aktivno = 1 )
                                      )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                      AND     dbo.infinite(P.VeljaDo) )
                                    )
                        GROUP BY M.[Interval],
                                P.Nivo,
                                PPM.[Dobavitelj1],
                                P.NadrejenaOsebaID,
                                PPM.SistemskiOperater1
                OPTION  ( MAXDOP 1 )
                 '
				
				SET @ParmDefinition = N'@DatumIntervalaDO datetime,
										@DatumIntervalaOD datetime,
										@DatumStanjaBaze datetime,
										@VIRT_REGULACIJA INT,
										@VIRT_ELES_MERITVE INT,
										@PI int,
										@BP int,
										@DatumVeljavnostiPodatkov datetime,
										@VIRT_MERJENI_ODJEM int,
										@VIRT_NEMERJENI_ODJEM int,
										@UDO_P_IZGUBE int,
										@VIRT_MERJEN_ODDAJA INT,
										@VIRT_NEMERJEN_ODDAJA INT,
										@NewObracunID int';


				EXECUTE sp_executesql   @SQLString, @ParmDefinition,
										@DatumIntervalaDO = @DatumIntervalaDO,
										@DatumIntervalaOD = @DatumIntervalaOD,
										@DatumStanjaBaze = @DatumStanjaBaze,
										@VIRT_REGULACIJA = @VIRT_REGULACIJA,
										@VIRT_ELES_MERITVE = @VIRT_ELES_MERITVE,
										@PI = @PI,
										@BP = @BP,
										@DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
										@VIRT_MERJENI_ODJEM  = @VIRT_MERJENI_ODJEM,
										@VIRT_NEMERJENI_ODJEM  = @VIRT_NEMERJENI_ODJEM,
										@UDO_P_IZGUBE  = @UDO_P_IZGUBE,
										@VIRT_MERJEN_ODDAJA  = @VIRT_MERJEN_ODDAJA,
										@VIRT_NEMERJEN_ODDAJA  = @VIRT_NEMERJEN_ODDAJA,
										@NewObracunID  = @NewObracunID;


                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 003: Napaka pri agregiranju realizacije po dobaviteljih.'
                            ) ;
            END --SODO MERITVE
		
			
			--UPOŠTEVAMO ŠE SOPO MERITVE
        IF ( ( SELECT   COUNT(*)
               FROM     #BS
             ) = 0 ) 
            BEGIN --SOPO
				SET @SQLString = ' 
                INSERT  INTO [RealizacijaPoDobaviteljih]
                        (
                          [Kolicina],
                          [Oddaja],
                          [Odjem],
                          [Interval],
                          [OsebaID],
                          [Nivo],
                          [ObracunID],
                          [NadrejenaOsebaID],
                          [SistemskiOperaterID]
				)
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
                                PPM.[Dobavitelj1],
                                P.[Nivo],
                                @NewObracunID,
                                [NadrejenaOsebaID],
                                PPM.[SistemskiOperater1]
                        FROM  '+[dbo].[ResolveTableName](@DatumIntervalaDO,@DatumIntervalaOD) +' M 
                                INNER JOIN [dbo].[PPM] PPM ON M.[PPMID] = PPM.[PPMID]
                                INNER JOIN [dbo].[Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
                        WHERE   M.[Interval] >= @DatumIntervalaOD
                                AND M.[Interval] <= DATEADD(DAY, 1,
                                                            @DatumIntervalaDO)
                                AND M.[DatumVnosa] <= @DatumStanjaBaze
                                AND ( PPM.[PPMTipID] = @VIRT_ELES_MERITVE )
                                AND P.[Nivo] > 0
                                AND ( P.[PogodbaTipID] = @PI
                                      OR P.[PogodbaTipID] = @BP
                                    )
                                AND ( ( @DatumStanjaBaze BETWEEN PPM.[DatumVnosa]
                                                         AND     dbo.infinite(PPM.[DatumSpremembe]) )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN PPM.[VeljaOd]
                                                                      AND     dbo.infinite(PPM.[VeljaDo]) )
                                    )
                                AND ( @DatumStanjaBaze BETWEEN M.[DatumVnosa]
                                                       AND     dbo.infinite(M.DatumSpremembe) )
                                AND ( ( ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                           AND     dbo.infinite(P.DatumSpremembe)
                                          AND P.Aktivno = 1
                                        )
                                        OR ( P.Aktivno = 1 )
                                      )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                      AND     dbo.infinite(P.VeljaDo) )
                                    )
                        GROUP BY M.[Interval],
                                P.Nivo,
                                PPM.[Dobavitelj1],
                                P.NadrejenaOsebaID,
                                PPM.SistemskiOperater1
                OPTION  ( MAXDOP 1 )
                 '
				
				SET @ParmDefinition = N'@DatumIntervalaDO datetime,
										@DatumIntervalaOD datetime,
										@DatumStanjaBaze datetime,
										@VIRT_REGULACIJA INT,
										@VIRT_ELES_MERITVE INT,
										@PI int,
										@BP int,
										@DatumVeljavnostiPodatkov datetime,
										@VIRT_MERJENI_ODJEM int,
										@VIRT_NEMERJENI_ODJEM int,
										@UDO_P_IZGUBE int,
										@VIRT_MERJEN_ODDAJA INT,
										@VIRT_NEMERJEN_ODDAJA INT,
										@NewObracunID INT';


				EXECUTE sp_executesql   @SQLString, @ParmDefinition,
										@DatumIntervalaDO = @DatumIntervalaDO,
										@DatumIntervalaOD = @DatumIntervalaOD,
										@DatumStanjaBaze = @DatumStanjaBaze,
										@VIRT_REGULACIJA = @VIRT_REGULACIJA,
										@VIRT_ELES_MERITVE = @VIRT_ELES_MERITVE,
										@PI = @PI,
										@BP = @BP,
										@DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
										@VIRT_MERJENI_ODJEM  = @VIRT_MERJENI_ODJEM,
										@VIRT_NEMERJENI_ODJEM  = @VIRT_NEMERJENI_ODJEM,
										@UDO_P_IZGUBE  = @UDO_P_IZGUBE,
										@VIRT_MERJEN_ODDAJA  = @VIRT_MERJEN_ODDAJA,
										@VIRT_NEMERJEN_ODDAJA  = @VIRT_NEMERJEN_ODDAJA,
										@NewObracunID  = @NewObracunID;
				
                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 102: Napaka pri agregiranju realizacije po dobaviteljih (SOPO).'
                            ) ;
            END
        ELSE 
            BEGIN
				--samo doloèene BS
				SET @SQLString = ' 
                INSERT  INTO [RealizacijaPoDobaviteljih]
                        (
                          Kolicina,
                          Oddaja,
                          Odjem,
                          Interval,
                          OsebaID,
                          Nivo,
                          ObracunID,
                          NadrejenaOsebaID,
                          SistemskiOperaterID
				)
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
					--oddaja 1
                                SUM(( CASE WHEN PPMJeOddaja = 1
                                                AND M.Kolicina > 0
                                           THEN M.Kolicina
                                           WHEN PPMJeOddaja = 0
                                                AND M.Kolicina < 0
                                           THEN -1 * M.Kolicina
                                           ELSE 0
                                      END )),
					-- odjem 1
                                SUM(( CASE WHEN PPMJeOddaja = 1
                                                AND M.Kolicina < 0
                                           THEN -1 * M.Kolicina
                                           WHEN PPMJeOddaja = 0
                                                AND M.Kolicina >= 0
                                           THEN M.Kolicina
                                           ELSE 0
                                      END )),
                                M.[Interval],
                                PPM.[Dobavitelj1],
                                P.Nivo,
                                @NewObracunID,
                                NadrejenaOsebaID,
                                PPM.SistemskiOperater1
                        FROM    '+[dbo].[ResolveTableName](@DatumIntervalaDO,@DatumIntervalaOD) +' M 
                                INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
                                INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
                                INNER JOIN [#BS] BS ON ( BS.[BilancnaSkupinaID] = P.ClanBSID )
                        WHERE   M.[Interval] >= @DatumIntervalaOD
                                AND M.[Interval] <= DATEADD(DAY, 1,
                                                            @DatumIntervalaDO)
                                AND M.[DatumVnosa] <= @DatumStanjaBaze
                                AND ( PPM.[PPMTipID] = @VIRT_ELES_MERITVE )
                                AND P.Nivo > 0
                                AND ( P.[PogodbaTipID] = @PI
                                      OR P.[PogodbaTipID] = @BP
                                    )
                                AND ( ( @DatumStanjaBaze BETWEEN PPM.DatumVnosa
                                                         AND     dbo.infinite(PPM.DatumSpremembe) )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN PPM.VeljaOd
                                                                      AND     dbo.infinite(PPM.VeljaDo) )
                                    )
                                AND ( @DatumStanjaBaze BETWEEN M.[DatumVnosa]
                                                       AND     dbo.infinite(M.DatumSpremembe) )
                                AND ( ( ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                           AND     dbo.infinite(P.DatumSpremembe)
                                          AND P.Aktivno = 1
                                        )
                                        OR ( P.Aktivno = 1 )
                                      )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                      AND     dbo.infinite(P.VeljaDo) )
                                    )
                        GROUP BY M.[Interval],
                                P.Nivo,
                                PPM.[Dobavitelj1],
                                P.NadrejenaOsebaID,
                                PPM.SistemskiOperater1
                OPTION  ( MAXDOP 1 )
                 '
				
				SET @ParmDefinition = N'@DatumIntervalaDO datetime,
										@DatumIntervalaOD datetime,
										@DatumStanjaBaze datetime,
										@VIRT_REGULACIJA INT,
										@VIRT_ELES_MERITVE INT,
										@PI int,
										@BP int,
										@DatumVeljavnostiPodatkov datetime,
										@VIRT_MERJENI_ODJEM int,
										@VIRT_NEMERJENI_ODJEM int,
										@UDO_P_IZGUBE int,
										@VIRT_MERJEN_ODDAJA INT,
										@VIRT_NEMERJEN_ODDAJA INT,
										@NewObracunID INT';


				EXECUTE sp_executesql   @SQLString, @ParmDefinition,
										@DatumIntervalaDO = @DatumIntervalaDO,
										@DatumIntervalaOD = @DatumIntervalaOD,
										@DatumStanjaBaze = @DatumStanjaBaze,
										@VIRT_REGULACIJA = @VIRT_REGULACIJA,
										@VIRT_ELES_MERITVE = @VIRT_ELES_MERITVE,
										@PI = @PI,
										@BP = @BP,
										@DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
										@VIRT_MERJENI_ODJEM  = @VIRT_MERJENI_ODJEM,
										@VIRT_NEMERJENI_ODJEM  = @VIRT_NEMERJENI_ODJEM,
										@UDO_P_IZGUBE  = @UDO_P_IZGUBE,
										@VIRT_MERJEN_ODDAJA  = @VIRT_MERJEN_ODDAJA,
										@VIRT_NEMERJEN_ODDAJA  = @VIRT_NEMERJEN_ODDAJA,
										@NewObracunID  = @NewObracunID;
				
				
                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 103: Napaka pri agregiranju realizacije po dobaviteljih. (SOPO)'
                            ) ;
		
            END --SOPO MERITVE
			--END UPOŠTEVAMO ŠE SOPO MERITVE
			

        IF ( ( SELECT   COUNT(*)
               FROM     [RealizacijaPoDobaviteljih]
               WHERE    ObracunID = @NewObracunID
             ) > 0 ) 
            BEGIN --imamo podatke za obraèun
			--AGREGIRANJE
                DECLARE @maxNivo INT
                SELECT  @maxNivo = MAX(Nivo)
                FROM    [RealizacijaPoDobaviteljih] RPD
                WHERE   [ObracunID] = @NewObracunID
                SET @NOErrors = @NOErrors + @@ERROR

			
			
                WHILE ( @maxNivo ) > 2
                    BEGIN
				
                        UPDATE  [RealizacijaPoDobaviteljih]
                        SET     [RealizacijaPoDobaviteljih].[Kolicina] = [RealizacijaPoDobaviteljih].[Kolicina]
                                + RPD.Kolicina,
                                [RealizacijaPoDobaviteljih].[Oddaja] = [RealizacijaPoDobaviteljih].[Oddaja]
                                + RPD.[Oddaja],
                                [RealizacijaPoDobaviteljih].[Odjem] = [RealizacijaPoDobaviteljih].[Odjem]
                                + RPD.[Odjem]
                        FROM    [RealizacijaPoDobaviteljih]
                                LEFT JOIN [RealizacijaPoDobaviteljih] RPD ON [RealizacijaPoDobaviteljih].[OsebaID] = RPD.[NadrejenaOsebaID]
                                                                             AND [RealizacijaPoDobaviteljih].[Interval] = RPD.[Interval]
                        WHERE   [RealizacijaPoDobaviteljih].[Nivo] = @maxNivo
                                - 1
                                AND RPD.[Nivo] = @maxNivo
                                AND RPD.OsebaID <> [RealizacijaPoDobaviteljih].[OsebaID]
                        SET @NOErrors = @NOErrors + @@ERROR
                        IF ( @NOErrors > 0 ) 
                            INSERT  INTO [#Errors] ( [Napaka] )
                            VALUES  (
                                      'Napaka 005: Napaka pri agregaciji navzgor.'
                                    ) ;

					
                        UPDATE  [RealizacijaPoDobaviteljih]
                        SET     [Nivo] = [Nivo] - 1
                        WHERE   [ObracunID] = @NewObracunID
                                AND [Nivo] = @maxNivo
                        SET @NOErrors = @NOErrors + @@ERROR
                        SET @maxNivo = @maxNivo - 1
                        PRINT @maxNivo
				
                        IF ( SELECT MAX(Nivo)
                             FROM   [RealizacijaPoDobaviteljih]
                             WHERE  [ObracunID] = @NewObracunID
                           ) = 2 
                            BREAK
                        ELSE 
                            CONTINUE
                    END
		
            END

        IF ( @NOErrors <> 0 ) 
            BEGIN
                SET @ErrorHeadXML = ( SELECT TOP 20
                                                *
                                      FROM      #Errors
                                    FOR
                                      XML PATH('Napake'),
                                          ROOT('Root')
                                    )		
                SET @ErrorDetailsXML = ( SELECT TOP 50
                                                *
                                         FROM   #ErrorDetail
                                       FOR
                                         XML PATH('ErrorDetail'),
                                             ROOT('Root')
                                       )
            END
        ELSE 
            BEGIN
                SET @ErrorHeadXML = NULL
                SET @ErrorDetailsXML = NULL
            END

    END





GO