EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_RevizijskaSled'
GO

CREATE PROCEDURE [dbo].[BilancniObracun_RevizijskaSled]
    (
      @DatumIntervalaDO AS DATETIME,
      @DatumIntervalaOD AS DATETIME,
      @DatumStanjaBaze AS DATETIME,
      @DatumVeljavnostiPodatkov AS DATETIME,
      @NewObracunID AS INT,
      @NOErrors AS INT OUTPUT,
      @ObracunskoObdobjeID AS INT,
      @Bs AS XML,
      @ErrorHeadXML XML OUTPUT,
      @ErrorDetailsXML XML OUTPUT
    )
AS 
    BEGIN

        DECLARE @ObjektID INT ;
        DECLARE @PSEKREG INT ;
        DECLARE @PTERREG INT ;

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


        IF ( @NOErrors = 0
             AND @NewObracunID > 0
           ) 
            BEGIN
		
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
			
			--meritve
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'view_Meritve'
                        AND ( (@DatumStanjaBaze BETWEEN [DatumVnosa]
                                                AND     dbo.infinite(DatumSpremembe)) )
			
                IF ( ( SELECT   COUNT(*)
                       FROM     #BS
                     ) = 0 ) 
                    BEGIN	
                        SET @SQLString = ' 
				INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
				SELECT
				0,
				@NewObracunID,
				@ObjektID,
				M.[ID],
				GETDATE()
				FROM
				 ' + [dbo].[ResolveTableName](@DatumIntervalaDO,
                                                      @DatumIntervalaOD)
                            + ' M 
					INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
					INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
				WHERE 
					M.[Interval] > @DatumIntervalaOD
				AND M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
				AND M.[DatumVnosa] <= @DatumStanjaBaze
				AND PPM.[PPMTipID] <> 6
				AND P.Nivo > 0
		        AND ((@DatumStanjaBaze between PPM.DatumVnosa and dbo.infinite(PPM.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between PPM.VeljaOd and dbo.infinite(PPM.VeljaDo)))
				AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
				AND (((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe) and P.Aktivno=1) or (P.Aktivno=1)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
				OPTION (MAXDOP 1)
				'
				
				
                        SET @ParmDefinition = N'@DatumIntervalaDO datetime,
										@DatumIntervalaOD datetime,
										@DatumStanjaBaze datetime,
										@DatumVeljavnostiPodatkov datetime,
										@NewObracunID INT,
										@ObjektID int' ;


                        EXECUTE sp_executesql @SQLString, @ParmDefinition,
                            @DatumIntervalaDO = @DatumIntervalaDO,
                            @DatumIntervalaOD = @DatumIntervalaOD,
                            @DatumStanjaBaze = @DatumStanjaBaze,
                            @DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
                            @NewObracunID = @NewObracunID,
                            @ObjektID = @ObjektID ;
										
                        SET @NOErrors = @NOErrors + @@ERROR
                        IF ( @NOErrors > 0 ) 
                            INSERT  INTO [#Errors] ( [Napaka] )
                            VALUES  (
                                      'Napaka 015: Napaka pri ustvarjanju revizijske sledi - meritve.'
                                    ) ;

                    END
                ELSE 
                    BEGIN
                        SET @SQLString = ' 
				INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
				SELECT
				0,
				@NewObracunID,
				@ObjektID,
				M.[ID],
				GETDATE()
				FROM 
						 '
                            + [dbo].[ResolveTableName](@DatumIntervalaDO,
                                                       @DatumIntervalaOD)
                            + ' M 
					INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
					INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
					INNER JOIN [#BS] BS ON (BS.[BilancnaSkupinaID] = P.ClanBSID)
				WHERE 
					M.[Interval] > @DatumIntervalaOD
				AND M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
				AND M.[DatumVnosa] <= @DatumStanjaBaze
				AND PPM.[PPMTipID] <> 6
				AND P.Nivo > 0
		        AND ((@DatumStanjaBaze between PPM.DatumVnosa and dbo.infinite(PPM.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between PPM.VeljaOd and dbo.infinite(PPM.VeljaDo)))
				AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
				AND (((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe) and P.Aktivno=1) or (P.Aktivno=1)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
				OPTION (MAXDOP 1)
				'
				
                        SET @ParmDefinition = N'@DatumIntervalaDO datetime,
										@DatumIntervalaOD datetime,
										@DatumStanjaBaze datetime,
										@DatumVeljavnostiPodatkov datetime,
										@NewObracunID int,
										@ObjektID int' ;


                        EXECUTE sp_executesql @SQLString, @ParmDefinition,
                            @DatumIntervalaDO = @DatumIntervalaDO,
                            @DatumIntervalaOD = @DatumIntervalaOD,
                            @DatumStanjaBaze = @DatumStanjaBaze,
                            @DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
                            @NewObracunID = @NewObracunID,
                            @ObjektID = @ObjektID ;
                            
                        SET @NOErrors = @NOErrors + @@ERROR
                        IF ( @NOErrors > 0 ) 
                            INSERT  INTO [#Errors] ( [Napaka] )
                            VALUES  (
                                      'Napaka 016: Napaka pri ustvarjanju revizijske sledi - meritve.'
                                    ) ;

                    END

			--POGODBA TIP
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'PogodbaTip'
			
                INSERT  INTO [Revizija]
                        (
                          [ObracunTipID],
                          [ObracunID],
                          [ObjektID],
                          [ID],
                          [Datum]
				)
                        SELECT  0,
                                @NewObracunID,
                                @ObjektID,
                                P.[PogodbaTipID],
                                GETDATE()
                        FROM    PogodbaTip P
                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 017: Napaka pri ustvarjanju revizijske sledi - tip pogodbe.'
                            ) ;

			 
			 
			--POGODBA
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'Pogodba'
                        AND ( (@DatumStanjaBaze BETWEEN [DatumVnosa]
                                                AND     dbo.infinite(DatumSpremembe)) )

                INSERT  INTO [Revizija]
                        (
                          [ObracunTipID],
                          [ObracunID],
                          [ObjektID],
                          [ID],
                          [Datum]
				)
                        SELECT  0,
                                @NewObracunID,
                                @ObjektID,
                                P.[ID],
                                GETDATE()
                        FROM    [Pogodba] P
                        WHERE   ( ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                     AND     dbo.infinite(P.DatumSpremembe)
                                    AND P.Aktivno = 1
                                  )
                                  OR ( P.Aktivno = 1 )
                                )
                                AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                AND     dbo.infinite(P.VeljaDo) )
                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 018: Napaka pri ustvarjanju revizijske sledi - pogodbe.'
                            ) ;

			--PPM TIP
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'PPMTip'
			
                INSERT  INTO [Revizija]
                        (
                          [ObracunTipID],
                          [ObracunID],
                          [ObjektID],
                          [ID],
                          [Datum]
				)
                        SELECT  0,
                                @NewObracunID,
                                @ObjektID,
                                P.PPMTipID,
                                GETDATE()
                        FROM    PPMTip P
                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 019: Napaka pri ustvarjanju revizijske sledi - tip PPM.'
                            ) ;

			 
			--PPM
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'PPM'
                        AND ( (@DatumStanjaBaze BETWEEN [DatumVnosa]
                                                AND     dbo.infinite(DatumSpremembe)) )
			
                IF ( ( SELECT   COUNT(*)
                       FROM     #BS
                     ) = 0 ) 
                    BEGIN	
                        INSERT  INTO [Revizija]
                                (
                                  [ObracunTipID],
                                  [ObracunID],
                                  [ObjektID],
                                  [ID],
                                  [Datum]
					  )
                                SELECT  0,
                                        @NewObracunID,
                                        @ObjektID,
                                        PPM.[ID],
                                        GETDATE()
                                FROM    [view_Meritve] M
                                        INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
                                        INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
                                WHERE   M.[Interval] > @DatumIntervalaOD
                                        AND M.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                        AND M.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
                                        AND PPM.[PPMTipID] <> 6
                                        AND P.Nivo > 0
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
                        OPTION  ( MAXDOP 1 )
                        SET @NOErrors = @NOErrors + @@ERROR
                        IF ( @NOErrors > 0 ) 
                            INSERT  INTO [#Errors] ( [Napaka] )
                            VALUES  (
                                      'Napaka 020: Napaka pri ustvarjanju revizijske sledi - PPM.'
                                    ) ;

                    END
                ELSE 
                    BEGIN
                        INSERT  INTO [Revizija]
                                (
                                  [ObracunTipID],
                                  [ObracunID],
                                  [ObjektID],
                                  [ID],
                                  [Datum]
					  )
                                SELECT  0,
                                        @NewObracunID,
                                        @ObjektID,
                                        PPM.[ID],
                                        GETDATE()
                                FROM    [view_Meritve] M
                                        INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
                                        INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
                                        INNER JOIN [#BS] BS ON ( BS.[BilancnaSkupinaID] = P.ClanBSID )
                                WHERE   M.[Interval] > @DatumIntervalaOD
                                        AND M.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                        AND M.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
                                        AND PPM.[PPMTipID] <> 6
                                        AND P.Nivo > 0
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
                        OPTION  ( MAXDOP 1 )
                        SET @NOErrors = @NOErrors + @@ERROR
                        IF ( @NOErrors > 0 ) 
                            INSERT  INTO [#Errors] ( [Napaka] )
                            VALUES  (
                                      'Napaka 021: Napaka pri ustvarjanju revizijske sledi - PPM.'
                                    ) ;

                    END
			
			--OSEBA
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'Oseba'
                        AND ( (@DatumStanjaBaze BETWEEN [DatumVnosa]
                                                AND     dbo.infinite(DatumSpremembe)) )
			
                INSERT  INTO [Revizija]
                        (
                          [ObracunTipID],
                          [ObracunID],
                          [ObjektID],
                          [ID],
                          [Datum]
				)
                        SELECT  0,
                                @NewObracunID,
                                @ObjektID,
                                P.[ID],
                                GETDATE()
                        FROM    [Oseba] P
                        WHERE   ( ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                     AND     dbo.infinite(P.DatumSpremembe) )
                                  AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                  AND     dbo.infinite(P.VeljaDo) )
                                )
                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 022: Napaka pri ustvarjanju revizijske sledi - osebe.'
                            ) ;

			 --OSEBA TIP
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'OsebaTip'
			
                INSERT  INTO [Revizija]
                        (
                          [ObracunTipID],
                          [ObracunID],
                          [ObjektID],
                          [ID],
                          [Datum]
				)
                        SELECT  0,
                                @NewObracunID,
                                @ObjektID,
                                [OsebaTipID],
                                GETDATE()
                        FROM    [OsebaTipID] 
                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 023: Napaka pri ustvarjanju revizijske sledi - tip osebe.'
                            ) ;

			 
			 
			 --Regulacija
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'Regulacija'
                        AND ( (@DatumStanjaBaze BETWEEN [DatumVnosa]
                                                AND     dbo.infinite(DatumSpremembe)) )
			
                INSERT  INTO [Revizija]
                        (
                          [ObracunTipID],
                          [ObracunID],
                          [ObjektID],
                          [ID],
                          [Datum]
				)
                        SELECT  0,
                                @NewObracunID,
                                @ObjektID,
                                R.[ID],
                                GETDATE()
                        FROM    [TrzniPlan] TP
                                INNER JOIN Pogodba P ON TP.[OsebaID] = P.Partner1
                                LEFT JOIN [Regulacija] R ON TP.[Interval] = R.[Interval]
                                LEFT JOIN PPM M ON M.[PPMID] = R.PPMID
                        WHERE   ( P.[PogodbaTipID] = @PSEKREG
                                  OR P.[PogodbaTipID] = @PTERREG
                                ) 
--			AND	P.Partner2 = R.[OsebaID]
                                AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                       AND     dbo.infinite(TP.DatumSpremembe) )
                                AND ( @DatumStanjaBaze BETWEEN R.[DatumVnosa]
                                                       AND     dbo.infinite(R.DatumSpremembe) )
                                AND ( ( @DatumStanjaBaze BETWEEN M.DatumVnosa
                                                         AND     dbo.infinite(M.DatumSpremembe) )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN M.VeljaOd
                                                                      AND     dbo.infinite(M.VeljaDo) )
                                    )
                                AND ( ( ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                           AND     dbo.infinite(P.DatumSpremembe)
                                          AND P.Aktivno = 1
                                        )
                                        OR ( P.Aktivno = 1 )
                                      )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                      AND     dbo.infinite(P.VeljaDo) )
                                    )
                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 024: Napaka pri ustvarjanju revizijske sledi - regulacija.'
                            ) ;

			 --Izravnava
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'Izravnava'
                        AND ( (@DatumStanjaBaze BETWEEN [DatumVnosa]
                                                AND     dbo.infinite(DatumSpremembe)) )


                INSERT  INTO [Revizija]
                        (
                          [ObracunTipID],
                          [ObracunID],
                          [ObjektID],
                          [ID],
                          [Datum]
				)
                        SELECT  0,
                                @NewObracunID,
                                @ObjektID,
                                I.[ID],
                                GETDATE()
                        FROM    [Izravnava] I
                        WHERE   I.Interval BETWEEN @DatumIntervalaOD
                                           AND     DATEADD(DAY, 1,
                                                           @DatumIntervalaDO)
                                AND ( @DatumStanjaBaze BETWEEN I.[DatumVnosa]
                                                       AND     dbo.infinite(I.DatumSpremembe) )

                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 025: Napaka pri ustvarjanju revizijske sledi - izravnava.'
                            ) ;


			 --CSLOEX
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'CSLOEX'
                        AND ( (@DatumStanjaBaze BETWEEN [DatumVnosa]
                                                AND     dbo.infinite(DatumSpremembe)) )
			
                INSERT  INTO [Revizija]
                        (
                          [ObracunTipID],
                          [ObracunID],
                          [ObjektID],
                          [ID],
                          [Datum]
				)
                        SELECT  0,
                                @NewObracunID,
                                @ObjektID,
                                C.[ID],
                                GETDATE()
                        FROM    [Izravnava] I
                                INNER JOIN [CSLOEX] C ON I.Interval = C.Interval
                        WHERE   I.Interval BETWEEN @DatumIntervalaOD
                                           AND     DATEADD(DAY, 1,
                                                           @DatumIntervalaDO)
                                AND I.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
                                AND ( @DatumStanjaBaze BETWEEN I.[DatumVnosa]
                                                       AND     dbo.infinite(I.DatumSpremembe) )

                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 026: Napaka pri ustvarjanju revizijske sledi - CSloEX.'
                            ) ;

			 --TrzniPlan
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'TrzniPlan'
                        AND ( (@DatumStanjaBaze BETWEEN [DatumVnosa]
                                                AND     dbo.infinite(DatumSpremembe)) )
			
                INSERT  INTO [Revizija]
                        (
                          [ObracunTipID],
                          [ObracunID],
                          [ObjektID],
                          [ID],
                          [Datum]
				)
                        SELECT  0,
                                @NewObracunID,
                                @ObjektID,
                                T.[ID],
                                GETDATE()
                        FROM    [TolerancniPas] TP
                                INNER JOIN [TrzniPlan] T ON TP.[OsebaID] = T.OsebaID
                                                            AND TP.[Interval] = T.[Interval]
                        WHERE   TP.[ObracunID] = @NewObracunID
                                AND TP.Interval BETWEEN @DatumIntervalaOD
                                                AND     DATEADD(DAY, 1, @DatumIntervalaDO)
                                AND ( @DatumStanjaBaze BETWEEN T.[DatumVnosa]
                                                       AND     dbo.infinite(T.DatumSpremembe) )

                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 027: Napaka pri ustvarjanju revizijske sledi - tržni plan.'
                            ) ;
					

			--IZJEME
			--NOT USING THEM RIHGT NOW !!!?????!!!!
			
			--Izpadi
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'Izpadi'
                        AND ( (@DatumStanjaBaze BETWEEN [DatumVnosa]
                                                AND     dbo.infinite(DatumSpremembe)) )
			
                INSERT  INTO [Revizija]
                        (
                          [ObracunTipID],
                          [ObracunID],
                          [ObjektID],
                          [ID],
                          [Datum]
				)
                        SELECT  0,
                                @NewObracunID,
                                @ObjektID,
                                I.ID,
                                GETDATE()
                        FROM    Oseba P
                                INNER JOIN dbo.Izpadi I ON P.OsebaID = I.OsebaID
                        WHERE   I.[Interval] > @DatumIntervalaOD
                                AND I.[Interval] <= DATEADD(DAY, 1,
                                                            @DatumIntervalaDO)
                                AND ( ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                         AND     dbo.infinite(P.DatumSpremembe) )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                      AND     dbo.infinite(P.VeljaDo) )
                                    )
                                AND ( (@DatumStanjaBaze BETWEEN I.[DatumVnosa]
                                                        AND     dbo.infinite(I.DatumSpremembe)) )

			
			--ObracunskoObdobje
                SELECT  @ObjektID = [ObjektID]
                FROM    [Objekt]
                WHERE   [Naziv] = 'ObracunskoObdobje'
                        AND ( (@DatumStanjaBaze BETWEEN [DatumVnosa]
                                                AND     dbo.infinite(DatumSpremembe)) )
			
                INSERT  INTO [Revizija]
                        (
                          [ObracunTipID],
                          [ObracunID],
                          [ObjektID],
                          [ID],
                          [Datum]
				)
                        SELECT  0,
                                @NewObracunID,
                                @ObjektID,
                                T.ID,
                                GETDATE()
                        FROM    [ObracunskoObdobje] T
                        WHERE   [ObracunskoObdobjeID] = @ObracunskoObdobjeID
                                AND ( @DatumStanjaBaze BETWEEN T.[DatumVnosa]
                                                       AND     dbo.infinite(T.DatumSpremembe) )

                SET @NOErrors = @NOErrors + @@ERROR
                IF ( @NOErrors > 0 ) 
                    INSERT  INTO [#Errors] ( [Napaka] )
                    VALUES  (
                              'Napaka 028: Napaka pri ustvarjanju revizijske sledi - obračunsko obdoboje.'
                            ) ;

				
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

        RETURN @NOErrors
    END





GO