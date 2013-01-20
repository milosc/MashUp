USE [IBIS2]
GO

EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_Korekcija'
GO 


CREATE PROCEDURE [dbo].[BilancniObracun_Korekcija]
    (
      @DatumIntervalaDO AS DATETIME,
      @DatumIntervalaOD AS DATETIME,
      @DatumStanjaBaze AS DATETIME,
      @DatumVeljavnostiPodatkov AS DATETIME,
      @NewObracunID AS INT,
      @NOErrors AS INT OUTPUT,
      @ErrorHeadXML XML OUTPUT,
      @ErrorDetailsXML XML OUTPUT
    )
AS 
    BEGIN
SET NOCOUNT ON
        DECLARE @CenaIzravnave DECIMAL(24, 2) ;
        DECLARE @SaldoOsnovnihObracunov DECIMAL(24, 2) ;
        DECLARE @SkupnaRazlika DECIMAL(24, 2) ;
        DECLARE @StanjeSistema VARCHAR(4) ; --PRES ... presežek ; --PRIM ...primankljaj ; --EQAL ...Izravnan 
        DECLARE @BP INT ;
		
        SELECT  @BP = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'B_POG' ;
  
  
        SELECT  P.[Partner2]
        INTO    #OsebeZaSaldoObdobja
        FROM    [dbo].[Pogodba] P
                JOIN [dbo].[Oseba] O ON P.[Partner2] = O.[OsebaID]
        WHERE   P.[PogodbaTipID] = @BP
                AND P.[Partner2] <> 46 --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                AND ( @DatumVeljavnostiPodatkov BETWEEN p.VeljaOd
                                                AND     dbo.infinite(p.VeljaDo) )
                AND ( @DatumStanjaBaze BETWEEN P.[DatumVnosa]
                                       AND     dbo.infinite(P.DatumSpremembe) )
                AND ( @DatumVeljavnostiPodatkov BETWEEN o.VeljaOd
                                                AND     dbo.infinite(o.VeljaDo) )
                AND ( @DatumStanjaBaze BETWEEN o.[DatumVnosa]
                                       AND     dbo.infinite(o.DatumSpremembe) )
                                                                       
                                                                       
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



        SELECT  'SkupniPOdatki pRED KO',
                *
        FROM    PodatkiObracuna_Skupni R
        ORDER BY 
DATEPART(day,R.[Interval]) asc,
DATEPART(month,R.[Interval]) asc,
(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

       -- DECLARE @Razlika DECIMAL(24, 8) ;
		
		--IRAÈUNAMO STANJE SISTEMA;
        SELECT  @CenaIzravnave = SUM(ROUND(SroskiIzravnave,3)),
                @SaldoOsnovnihObracunov = SUM(ROUND(SaldoStroskiObracunov,2)),
                @SkupnaRazlika = SUM(ROUND(Razlika,2))
        FROM    PodatkiObracuna_Skupni
        WHERE   [ObracunID] = @NewObracunID 

        SELECT  @CenaIzravnave AS CenaIzr,
                @SaldoOsnovnihObracunov AS Saldo
		
--        SET @Razlika = @SaldoOsnovnihObracunov - @CenaIzravnave
		PRINT 'SKUPNA RAZLIKA PRED KORECIJO = '+CAST(@SkupnaRazlika AS VARCHAR(20));
		--@StanjeSistema VARCHAR(4) ; --PRES ... presežek ; --PRIM ...primankljaj ; --EQAL ...Izravnan 
        IF ( @CenaIzravnave < @SaldoOsnovnihObracunov ) 
            SET @StanjeSistema = 'PRES'
        ELSE 
            IF ( @CenaIzravnave > @SaldoOsnovnihObracunov ) 
                SET @StanjeSistema = 'PRIM'
            ELSE 
                IF ( @CenaIzravnave = @SaldoOsnovnihObracunov ) 
                    SET @StanjeSistema = 'EQAL'
		
        SELECT  @StanjeSistema 
		
        DECLARE @MaxRazlika DECIMAL(24, 2) ;
        DECLARE @MaxInterval DATETIME ;
        DECLARE @ExitCondition INT = 0 ;
        DECLARE @C_Interval DATETIME ;
        DECLARE @C_Razlika DECIMAL(24, 2) ;
        DECLARE @C_SkupnaOdstopanja DECIMAL(24, 2) ;
        DECLARE @LoopCount INT = 0 --never ending loops
        DECLARE @NetoOdstopanjaPozitivna INT = 0 ;
        DECLARE @NetoOdstopanjaNegativna INT = 0 ;
        DECLARE @PrimanjkljajPresezekZadnjiInterval INT = 0 ;
        DECLARE @PresezekPrimanjkljajZadnjiInterval INT = 0 ;
        DECLARE @CpNov DECIMAL(24, 2) ;
        DECLARE @CmNov DECIMAL(24, 2) ;
        DECLARE @C_Cp DECIMAL(24, 2) ;
        DECLARE @C_Cm DECIMAL(24, 2) ;

        DECLARE @Qp DECIMAL(24, 2) ;
        DECLARE @Qm DECIMAL(24, 2) ;
        DECLARE @C_StrIzravnave DECIMAL(24, 3) ;
        DECLARE @C_SaldoStroski DECIMAL(24, 3) ;
        DECLARE @C_Wgjs_p DECIMAL(24, 3) ;
        DECLARE @C_Wgjs_m DECIMAL(24, 3) ;
        DECLARE @C_Wpi DECIMAL(24, 3) ;
        DECLARE @C_Wmi DECIMAL(24, 3) ;
        DECLARE @C_SIPXurni DECIMAL(24, 2) ;
         

        WHILE @ExitCondition = 0
            BEGIN
						
                GOTO NekstMaxInterval
                     
                NekstMaxInterval:
                SET @LoopCount = @LoopCount + 1
                SET @CpNov = 0 ;	
                SET @CmNov = 0 ;
                SET @Qp = 0 ;
                SET @Qm = 0 ;
                IF (@LoopCount  > 800) BREAK;
                IF ( @StanjeSistema = 'PRES' ) 
                    BEGIN
						  --MAX INTERVAL  
                        SELECT TOP 1
                                @C_Interval = P.Interval,
                                @C_SkupnaOdstopanja = ROUND(P.[SkupnaOdstopanja],2),
                                @C_Cp = P.[C+],
                                @C_Cm = P.[C-],
                                @C_Razlika = ROUND(P.[Razlika],2),
                                @C_StrIzravnave = ROUND(P.[SroskiIzravnave],3),
                                @C_SaldoStroski = ROUND(P.[SaldoStroskiObracunov],2),
                                @C_Wgjs_p = P.Wgjs_p,
                                @C_Wgjs_m = P.Wgjs_m,
                                @C_Wpi = P.Wplusi,
                                @C_Wmi = P.Wminusi,
                                @C_SIPXurni = SIPXurni
                        FROM    [dbo].[PodatkiObracuna_Skupni] P
                        WHERE   P.[ObracunID] = @NewObracunID
                                AND P.[Korekcija] <> 'D'
                        ORDER BY P.[Razlika] DESC
						--SELECT 'Maxint',  @C_Interval,  @C_SkupnaOdstopanja AS SkupnaOdstBS, @C_Razlika AS azlika, @C_StrIzravnave AS StrIzr,@C_SaldoStroski AS SaldoObBS
                    END
                ELSE 
                    IF ( @StanjeSistema = 'PRIM' ) 
                        BEGIN
						  --MAX INTERVAL  
                            SELECT TOP 1
                                    @C_Interval = P.Interval,
                                    @C_SkupnaOdstopanja = ROUND(P.[SkupnaOdstopanja],2),
                                    @C_Cp = P.[C+],
                                    @C_Cm = P.[C-],
                                    @C_Razlika = ROUND(P.[Razlika],2),
									@C_StrIzravnave = ROUND(P.[SroskiIzravnave],3),
									@C_SaldoStroski = ROUND(P.[SaldoStroskiObracunov],2),
                                    @C_Wgjs_p = P.Wgjs_p,
                                    @C_Wgjs_m = P.Wgjs_m,
                                    @C_Wpi = P.Wplusi,
                                    @C_Wmi = P.Wminusi,
                                    @C_SIPXurni = SIPXurni
                            FROM    [dbo].[PodatkiObracuna_Skupni] P
                            WHERE   P.[ObracunID] = @NewObracunID
                                    AND P.[Korekcija] <> 'D'
                            ORDER BY P.[Razlika] ASC
                        END
			      
			      
					 --NETO ODSTOPANJA
					 --SELECT @C_SkupnaOdstopanja,@LoopCount
                IF @C_SkupnaOdstopanja > 0
                    AND @StanjeSistema = 'PRIM' 
                    BEGIN
						print 'A NovaCenaOdsPozPrimankljaj  C_SkupnaOdstopanja > 0 && PRIMANLJAJ Interval = '+CAST(@C_Interval AS VARCHAR(24))+ ' Skupna odstopanja v intervalu = '+CAST(@C_SkupnaOdstopanja AS VARCHAR(20))
						PRINT '-------------------------------------------------------------------------------------------------------------------------------------------------------------'
                        SET @NetoOdstopanjaPozitivna = 1 ;
                        SET @NetoOdstopanjaNegativna = 0 ;
                        GOTO NovaCenaOdsPozPrimankljaj
                    END
                ELSE 
                    IF @C_SkupnaOdstopanja < 0
                        AND @StanjeSistema = 'PRIM' 
                        BEGIN
                        print 'B NovaCenaOdsNegPrimankljaj  --C_SkupnaOdstopanja < 0 && PRIMANKLJAJ interval = '+CAST(@C_Interval AS VARCHAR(24))+ ' Skupna odstopanja v intervalu = '+CAST(@C_SkupnaOdstopanja AS VARCHAR(20))
                        PRINT '-------------------------------------------------------------------------------------------------------------------------------------------------------------'
                            SET @NetoOdstopanjaPozitivna = 0 ;
                            SET @NetoOdstopanjaNegativna = 1 ;
                            GOTO NovaCenaOdsNegPrimankljaj
                        END
                    ELSE 
                        IF @C_SkupnaOdstopanja > 0
                            AND @StanjeSistema = 'PRES' 
                            BEGIN
                            print 'C NovaCenaOdsPozPresezek -- C_SkupnaOdstopanja > 0 && PRESEŽEK interval= '+CAST(@C_Interval AS VARCHAR(24))+ ' Skupna odstopanja v intervalu = '+CAST(@C_SkupnaOdstopanja AS VARCHAR(20))
                            PRINT '-------------------------------------------------------------------------------------------------------------------------------------------------------------'
                                SET @NetoOdstopanjaPozitivna = 1 ;
                                SET @NetoOdstopanjaNegativna = 0 ;
                                GOTO NovaCenaOdsPozPresezek
                            END
                        ELSE 
                            IF @C_SkupnaOdstopanja < 0
                                AND @StanjeSistema = 'PRES' 
                                BEGIN
                                print 'D NovaCenaOdsNegPresezek C_SkupnaOdstopanja < 0 && PRESEŽEK Interval = '+CAST(@C_Interval AS VARCHAR(24))+ ' Skupna odstopanja v intervalu = '+CAST(@C_SkupnaOdstopanja AS VARCHAR(20))
                                PRINT '-------------------------------------------------------------------------------------------------------------------------------------------------------------'
                                    SET @NetoOdstopanjaPozitivna = 0 ;
                                    SET @NetoOdstopanjaNegativna = 1 ;
                                    GOTO NovaCenaOdsNegPresezek
                                END
					 
            
                            
                NovaCenaOdsPozPrimankljaj:
                IF ( @NetoOdstopanjaPozitivna = 1
                     AND @PrimanjkljajPresezekZadnjiInterval = 1
                   ) 
                    BEGIN
                        SET @CpNov = @C_Cp;	
                        SET @CmNov = @C_Cm;
                        --PRINT 'RAZLIKA ZADNJI ='+CAST(@SkupnaRazlika AS varchar(20));
                       -- SET @Razlika = ABS(@SkupnaRazlika)
                        --PRINT 'RAZLIKA ZADNJI 1='+CAST(@SkupnaRazlika AS varchar(20));
                        SET @Qp = ABS(ROUND(@SkupnaRazlika,2)) / ( ROUND(@C_Wpi,3) + ROUND((ROUND(@C_Wgjs_p,3) / 1.03 ),2) )
                        SET @CpNov = ROUND(@Qp,2) + @C_Cp;
                        
                        
                        PRINT 'NovaCenaOdsPozPrimankljaj ZADNJI INTERVAL = '+CAST(@C_Interval AS VARCHAR(24))+ ' Skupna razlika = '+CAST(ABS(@SkupnaRazlika) AS VARCHAR(20))+ ' Qp ='+CAST(@Qp AS VARCHAR(20))
                        
                        SET @Qm = 0;
							
                                        
								UPDATE  P
                                SET     P.[C+'] = @CpNov,
                                        P.[C-'] = @CmNov,
                                        P.[q+] = @Qp,
                                        P.[q-] = @Qm,
                                        [Korekcija] = 'D'
                                FROM    [dbo].[PodatkiObracuna_Skupni] P
                                WHERE   P.[ObracunID] = @NewObracunID
                                        AND P.Interval = @C_Interval
                                        AND P.[Korekcija] <> 'D'
                                        
                            UPDATE  PodatkiObracuna_Skupni
                            SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(ROUND(O.Saldo,2), 0),
								    PodatkiObracuna_Skupni.Razlika = ISNULL(ROUND(O.Saldo,2), 0) -ROUND([dbo].[PodatkiObracuna_Skupni].SroskiIzravnave,3) 
                            FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                                                         THEN ROUND(R.[Odstopanje],3) * @CpNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 1.03
                                                                                                 ELSE 1
                                                                                            END )
                                                         ELSE ROUND(R.[Odstopanje],3) * @CmNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 0.97
                                                                                                 ELSE 1
                                                                                            END )
                                                    END) AS Saldo,
                                                P1.Interval
                                      FROM      [#OsebeZaSaldoObdobja] S
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                                JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                                                JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                      WHERE     R.[ObracunID] = @NewObracunID
                                                AND P1.[ObracunID] = @NewObracunID
                                                AND P1.Interval = @C_Interval
                                                AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                     AND     dbo.infinite(OZ.DatumSpremembe)
                                      GROUP BY  P1.interval
                                    ) O
                            WHERE   PodatkiObracuna_Skupni.[Interval] = O.Interval	
                                     
                            SELECT  @SaldoOsnovnihObracunov = SUM(ROUND(SaldoStroskiObracunov,2)),
									@SkupnaRazlika = SUM(Razlika)
                            FROM    PodatkiObracuna_Skupni
                            WHERE   [ObracunID] = @NewObracunID 
                            
                            
                            UPDATE  PodatkiObracuna_Skupni
                            SET     [dbo].[PodatkiObracuna_Skupni].[PreostalaVrednost] = ROUND(@SkupnaRazlika,2)
                            WHERE   [ObracunID] = @NewObracunID 
								     AND Interval = @C_Interval
                            
                            SET @ExitCondition = 1 ;
							
                        GOTO Konec
                    END
                ELSE 
                    IF ( @NetoOdstopanjaPozitivna = 1 ) 
                        BEGIN
                            SET @CpNov = @C_Cp ;	
                            SET @CmNov = @C_Cm ;
                            SET @Qp = ROUND(( @C_StrIzravnave - @C_SaldoStroski ) / ( ROUND(@C_Wpi,3) + ( ROUND(@C_Wgjs_p,3) / 1.03 ) ),2)
                            SET @CpNov = ROUND(@Qp + @C_Cp,2) ;
							SET @Qm = 0;
							
							UPDATE  P
                                SET     P.[C+'] = @CpNov,
                                        P.[C-'] = @CmNov,
                                        P.[q+] = @Qp,
                                        P.[q-] = @Qm,
                                        [Korekcija] = 'D'
                                FROM    [dbo].[PodatkiObracuna_Skupni] P
                                WHERE   P.[ObracunID] = @NewObracunID
                                        AND P.Interval = @C_Interval
                                        AND P.[Korekcija] <> 'D'
                                        
                                         UPDATE  PodatkiObracuna_Skupni
                            SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(ROUND(O.Saldo,2), 0),
								    PodatkiObracuna_Skupni.Razlika = ISNULL(ROUND(O.Saldo,2), 0) -ROUND([dbo].[PodatkiObracuna_Skupni].SroskiIzravnave,3) 
                            FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                                                         THEN ROUND(R.[Odstopanje],3) * @CpNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 1.03
                                                                                                 ELSE 1
                                                                                            END )
                                                         ELSE ROUND(R.[Odstopanje],3) * @CmNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 0.97
                                                                                                 ELSE 1
                                                                                            END )
                                                    END) AS Saldo,
                                                P1.Interval
                                      FROM      [#OsebeZaSaldoObdobja] S
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                                JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                                                JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                      WHERE     R.[ObracunID] = @NewObracunID
                                                AND P1.[ObracunID] = @NewObracunID
                                                AND P1.Interval = @C_Interval
                                                AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                     AND     dbo.infinite(OZ.DatumSpremembe)
                                      GROUP BY  P1.interval
                                    ) O
                            WHERE   PodatkiObracuna_Skupni.[Interval] = O.Interval	
                            
                            SELECT  @SaldoOsnovnihObracunov = SUM(ROUND(SaldoStroskiObracunov,2)),
									@SkupnaRazlika = SUM(Razlika)
                            FROM    PodatkiObracuna_Skupni
                            WHERE   [ObracunID] = @NewObracunID 
                            
                            
                            UPDATE  PodatkiObracuna_Skupni
                            SET     [dbo].[PodatkiObracuna_Skupni].[PreostalaVrednost] = ROUND(@SkupnaRazlika,2)
                            WHERE   [ObracunID] = @NewObracunID 
								     AND Interval = @C_Interval
                            
                        
                            GOTO BilancaObracunaNovaCena
                        END
						
                      
                BilancaObracunaNovaCena:
                print '.........BilancaObracunaNovaCena SaldoOsnovnihObracunov ='+ CAST(@SaldoOsnovnihObracunov AS varchar(20))+' LoopCount='+CAST(@LoopCount  AS VARCHAR(20))+' RAZLIKA = '+CAST(@C_Razlika AS varchar(20))
                IF ( @StanjeSistema = 'PRES'
                     AND @CenaIzravnave < @SaldoOsnovnihObracunov
                   ) 
                    BEGIN
                        --UPDATE  P
                        --SET     P.[C+'] = @CpNov,
                        --        P.[C-'] = @CmNov,
                        --        P.[q+] = @Qp,
                        --        P.[q-] = @Qm,
                        --        [Korekcija] = 'D'
                        --FROM    [dbo].[PodatkiObracuna_Skupni] P
                        --WHERE   P.[ObracunID] = @NewObracunID
                        --        AND P.Interval = @C_Interval
                        --        AND P.[Korekcija] <> 'D'
								
								     
                        --UPDATE  PodatkiObracuna_Skupni
                        --SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(O.Saldo, 0)
                        --FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                        --                             THEN R.[Odstopanje]
                        --                                  * P1.[C+']
                        --                                  / ( CASE WHEN OZT.Sifra = 'GJS' THEN 1.03
                        --                                           ELSE 1
                        --                                      END )
                        --                             ELSE R.[Odstopanje]
                        --                                  * P1.[C-']
                        --                                  / ( CASE WHEN OZT.Sifra = 'GJS' THEN 0.97
                        --                                           ELSE 1
                        --                                      END )
                        --                        END) AS Saldo,
                        --                    P1.Interval
                        --          FROM      [#OsebeZaSaldoObdobja] S
                        --                    JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                        --                    JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                        --                    JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                        --                    JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                        --          WHERE     R.[ObracunID] = @NewObracunID
                        --                    AND P1.[ObracunID] = @NewObracunID
                        --                    AND P1.Interval = @C_Interval
                        --                    AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                        --                                         AND     dbo.infinite(OZ.DatumSpremembe)
                        --          GROUP BY  P1.interval
                        --        ) O
                        --WHERE   PodatkiObracuna_Skupni.[Interval] = O.Interval	
                                     
                        --SELECT  @SaldoOsnovnihObracunov = SUM(SaldoStroskiObracunov)
                        --FROM    PodatkiObracuna_Skupni
                        --WHERE   [ObracunID] = @NewObracunID 
									
                        GOTO NekstMaxInterval
                    END
                ELSE 
                    IF ( @StanjeSistema = 'PRES'
                         AND @CenaIzravnave > @SaldoOsnovnihObracunov
                       ) 
                        BEGIN
							PRINT '!!!!!!!!!!!!!!!!! ...... PRESEŽEK Izravnava > SALDO .......... !!!!!!!!!!!!!!'
                            SET @PresezekPrimanjkljajZadnjiInterval = 1
                            IF ( @NetoOdstopanjaPozitivna = 1 ) 
                                GOTO NovaCenaOdsPozPresezek
                            ELSE 
                                IF ( @NetoOdstopanjaNegativna = 1 ) 
                                    GOTO NovaCenaOdsNegPresezek
                        END
                    ELSE 
                        IF ( @StanjeSistema = 'PRIM'
                             AND @CenaIzravnave > @SaldoOsnovnihObracunov
                           ) 
                            BEGIN
                                --UPDATE  P
                                --SET     P.[C+'] = @CpNov,
                                --        P.[C-'] = @CmNov,
                                --        P.[q+] = @Qp,
                                --        P.[q-] = @Qm,
                                --        [Korekcija] = 'D'
                                --FROM    [dbo].[PodatkiObracuna_Skupni] P
                                --WHERE   P.[ObracunID] = @NewObracunID
                                --        AND P.Interval = @C_Interval
                                --        AND P.[Korekcija] <> 'D'
									
                                --UPDATE  PodatkiObracuna_Skupni
                                --SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(O.Saldo, 0)
                                --FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                                --                             THEN R.[Odstopanje] * P1.[C+'] / ( CASE WHEN OZT.Sifra = 'GJS' THEN 1.03
                                --                                                                     ELSE 1
                                --                                                                END )
                                --                             ELSE R.[Odstopanje] * P1.[C-'] / ( CASE WHEN OZT.Sifra = 'GJS' THEN 0.97
                                --                                                                     ELSE 1
                                --                                                                END )
                                --                        END) AS Saldo,
                                --                    P1.Interval
                                --          FROM      [#OsebeZaSaldoObdobja] S
                                --                    JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                --                    JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                                --                    JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                --                    JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                --          WHERE     R.[ObracunID] = @NewObracunID
                                --                    AND P1.[ObracunID] = @NewObracunID
                                --                    AND P1.Interval = @C_Interval
                                --                    AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                --                                         AND     dbo.infinite(OZ.DatumSpremembe)
                                --          GROUP BY  P1.interval
                                --        ) O
                                --WHERE   PodatkiObracuna_Skupni.[Interval] = O.Interval	
                                     
                                --SELECT  @SaldoOsnovnihObracunov = SUM(SaldoStroskiObracunov)
                                --FROM    PodatkiObracuna_Skupni
                                --WHERE   [ObracunID] = @NewObracunID 
									 
                                GOTO NekstMaxInterval
                            END
                        ELSE 
                            IF ( @StanjeSistema = 'PRIM'
                                 AND @CenaIzravnave < @SaldoOsnovnihObracunov
                               ) 
                                BEGIN
                                    SET @PrimanjkljajPresezekZadnjiInterval = 1
                                    IF ( @NetoOdstopanjaPozitivna = 1 ) 
                                        GOTO NovaCenaOdsPozPrimankljaj
                                    ELSE 
                                        IF ( @NetoOdstopanjaNegativna = 1 ) 
                                            GOTO NovaCenaOdsNegPrimankljaj
                                END
							
							
						
                NovaCenaOdsNegPrimankljaj:
                IF ( @NetoOdstopanjaNegativna = 1
                     AND @PrimanjkljajPresezekZadnjiInterval = 1
                   ) 
                    BEGIN
                    
                        SET @CpNov = @C_Cp ;	
                        SET @CmNov = @C_Cm ;
                        --PRINT 'RAZLIKA ZADNJI ='+CAST(@SkupnaRazlika AS varchar(20));
                        --SET @Razlika = ABS(@SkupnaRazlika)
                        --PRINT 'RAZLIKA ZADNJI 1='+CAST(@SkupnaRazlika AS varchar(20));
                        SET @Qm = ABS(ROUND((@SkupnaRazlika)/( -1*@C_Wmi - ( 1*@C_Wgjs_m / 0.97 )),2))
                        SET @Qp = 0;
                        SET @CmNov = ROUND(-1*@Qm + @C_Cm,2) ;
                        IF (@CmNov < 0) SET @CmNov = 0;
                        PRINT 'NovaCenaOdsNegPrimankljaj ZADNJI INTERVAL = '+CAST(@C_Interval AS VARCHAR(24))+' Razlika = '+CAST(ABS(@SkupnaRazlika) AS VARCHAR(20))+ ' Qm ='+CAST(@Qm AS VARCHAR(20))
                        
                                 
								UPDATE  P
                                SET     P.[C+'] = @CpNov,
                                        P.[C-'] = @CmNov,
                                        P.[q+] = @Qp,
                                        P.[q-] = @Qm,
                                        [Korekcija] = 'D'
                                FROM    [dbo].[PodatkiObracuna_Skupni] P
                                WHERE   P.[ObracunID] = @NewObracunID
                                        AND P.Interval = @C_Interval
                                        AND P.[Korekcija] <> 'D'
                                        
                          UPDATE  PodatkiObracuna_Skupni
                            SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(ROUND(O.Saldo,2), 0),
								    PodatkiObracuna_Skupni.Razlika = ISNULL(ROUND(O.Saldo,2), 0) -ROUND([dbo].[PodatkiObracuna_Skupni].SroskiIzravnave,3) 
                            FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                                                         THEN ROUND(R.[Odstopanje],3) * @CpNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 1.03
                                                                                                 ELSE 1
                                                                                            END )
                                                         ELSE ROUND(R.[Odstopanje],3) * @CmNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 0.97
                                                                                                 ELSE 1
                                                                                            END )
                                                    END) AS Saldo,
                                                P1.Interval
                                      FROM      [#OsebeZaSaldoObdobja] S
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                                JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                                                JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                      WHERE     R.[ObracunID] = @NewObracunID
                                                AND P1.[ObracunID] = @NewObracunID
                                                AND P1.Interval = @C_Interval
                                                AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                     AND     dbo.infinite(OZ.DatumSpremembe)
                                      GROUP BY  P1.interval
                                    ) O
                            WHERE   PodatkiObracuna_Skupni.[Interval] = O.Interval	
                                     
                           SELECT  @SaldoOsnovnihObracunov = SUM(ROUND(SaldoStroskiObracunov,2)),
									@SkupnaRazlika = SUM(Razlika)
                            FROM    PodatkiObracuna_Skupni
                            WHERE   [ObracunID] = @NewObracunID 
                            
                            
                            UPDATE  PodatkiObracuna_Skupni
                            SET     [dbo].[PodatkiObracuna_Skupni].[PreostalaVrednost] = ROUND(@SkupnaRazlika,2)
                            WHERE   [ObracunID] = @NewObracunID 
								     AND Interval = @C_Interval
                            
                        SET @ExitCondition = 1 ;
                        GOTO Konec
                    END
                ELSE 
                    IF ( @NetoOdstopanjaPozitivna = 1 ) 
                        BEGIN
                        PRINT 'NovaCenaOdsNegPrimankljaj INTERVAL = '+CAST(@C_Interval AS VARCHAR(24))
                            SET @CpNov = @C_Cp ;	
                            SET @CmNov = @C_Cm ;
                            SET @Qm = ROUND(( -1*@C_StrIzravnave + @C_SaldoStroski ) / ( @C_Wmi + ( @C_Wgjs_m / 0.97 ) ),2)
                            SET @Qp = 0;
                            SET @CmNov = ROUND(@Qm + @C_Cm,2) ;
                            IF (@CmNov < 0) SET @CmNov = 0;
                       
							
							UPDATE  P
                                SET     P.[C+'] = @CpNov,
                                        P.[C-'] = @CmNov,
                                        P.[q+] = @Qp,
                                        P.[q-] = @Qm,
                                        [Korekcija] = 'D'
                                FROM    [dbo].[PodatkiObracuna_Skupni] P
                                WHERE   P.[ObracunID] = @NewObracunID
                                        AND P.Interval = @C_Interval
                                        AND P.[Korekcija] <> 'D'
                                        
                             UPDATE  PodatkiObracuna_Skupni
                            SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(ROUND(O.Saldo,2), 0),
								    PodatkiObracuna_Skupni.Razlika = ISNULL(ROUND(O.Saldo,2), 0) -ROUND([dbo].[PodatkiObracuna_Skupni].SroskiIzravnave,3) 
                            FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                                                         THEN ROUND(R.[Odstopanje],3) * @CpNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 1.03
                                                                                                 ELSE 1
                                                                                            END )
                                                         ELSE ROUND(R.[Odstopanje],3) * @CmNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 0.97
                                                                                                 ELSE 1
                                                                                            END )
                                                    END) AS Saldo,
                                                P1.Interval
                                      FROM      [#OsebeZaSaldoObdobja] S
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                                JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                                                JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                      WHERE     R.[ObracunID] = @NewObracunID
                                                AND P1.[ObracunID] = @NewObracunID
                                                AND P1.Interval = @C_Interval
                                                AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                     AND     dbo.infinite(OZ.DatumSpremembe)
                                      GROUP BY  P1.interval
                                    ) O
                            WHERE   PodatkiObracuna_Skupni.[Interval] = O.Interval	
                            
                            
                            SELECT  @SaldoOsnovnihObracunov = SUM(ROUND(SaldoStroskiObracunov,2)),
									@SkupnaRazlika = SUM(Razlika)
                            FROM    PodatkiObracuna_Skupni
                            WHERE   [ObracunID] = @NewObracunID 
                            
                            
                            UPDATE  PodatkiObracuna_Skupni
                            SET     [dbo].[PodatkiObracuna_Skupni].[PreostalaVrednost] = ROUND(@SkupnaRazlika,2)
                            WHERE   [ObracunID] = @NewObracunID 
								     AND Interval = @C_Interval
                            
                            PRINT 'NovaCenaOdsNegPrimankljaj @SaldoOsnovnihObracunov = '+CAST(@SaldoOsnovnihObracunov AS VARCHAR(20));		 
                            GOTO BilancaObracunaNovaCena
                        END
						
					
                NovaCenaOdsPozPresezek:
                IF ( @NetoOdstopanjaPozitivna = 1
                     AND @PresezekPrimanjkljajZadnjiInterval = 1
                   ) 
                    BEGIN
						
                        SET @CpNov = @C_Cp ;	
                        SET @CmNov = @C_Cm ;
                         --PRINT 'RAZLIKA ZADNJI ='+CAST(@SkupnaRazlika AS varchar(20));
                        --SET @Razlika = @SkupnaRazlika
                        --PRINT 'RAZLIKA ZADNJI 1='+CAST(@SkupnaRazlika AS varchar(20));
                       SET @Qp = @SkupnaRazlika / ( @C_Wpi + ( @C_Wgjs_p / 1.03 ) )
                        SET @Qm = 0;
                        SET @CpNov =  @Qp + @C_Cp ;
                     SELECT  @C_Wpi AS Wpi,@C_Wgjs_p AS GJS,@SkupnaRazlika AS razlika,@Qp AS qplus,@CpNov AS CpNov
                        PRINT 'NovaCenaOdsPozPresezek ZADNJI INTERVAL = '+CAST(@C_Interval AS VARCHAR(24))+ ' skupna razlika = '+CAST(@SkupnaRazlika AS VARCHAR(20))+ ' Qp = '+CAST(@Qm AS VARCHAR(20))
                        
                        
							UPDATE  P
                                SET     P.[C+'] = @CpNov,
                                        P.[C-'] = @CmNov,
                                        P.[q+] = @Qp,
                                        P.[q-] = @Qm,
                                        [Korekcija] = 'D'
                                FROM    [dbo].[PodatkiObracuna_Skupni] P
                                WHERE   P.[ObracunID] = @NewObracunID
                                        AND P.Interval = @C_Interval
                                        --AND P.[Korekcija] <> 'D'
                                        
                                        PRINT 'ROWS AFFECTED UPDATE = '+CAST(@@ROWCOUNT AS VARCHAR(10));
                                        
                                      UPDATE  PodatkiObracuna_Skupni
                            SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(ROUND(O.Saldo,2), 0),
								    PodatkiObracuna_Skupni.Razlika = ISNULL(ROUND(O.Saldo,2), 0) -ROUND([dbo].[PodatkiObracuna_Skupni].SroskiIzravnave,3) 
                            FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                                                         THEN ROUND(R.[Odstopanje],2) * ROUND(@CpNov,2) / ( CASE WHEN OZT.Sifra = 'GJS' THEN 1.03
                                                                                                 ELSE 1
                                                                                            END )
                                                         ELSE ROUND(R.[Odstopanje],2) * ROUND(@CmNov,2) / ( CASE WHEN OZT.Sifra = 'GJS' THEN 0.97
                                                                                                 ELSE 1
                                                                                            END )
                                                    END) AS Saldo,
                                                P1.Interval
                                      FROM      [#OsebeZaSaldoObdobja] S
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                                JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                                                JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                      WHERE     R.[ObracunID] = @NewObracunID
                                                AND P1.[ObracunID] = @NewObracunID
                                                AND P1.Interval = @C_Interval
                                                AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                     AND     dbo.infinite(OZ.DatumSpremembe)
                                      GROUP BY  P1.interval
                                    ) O
                            WHERE   PodatkiObracuna_Skupni.[Interval] = O.Interval		
                                     
                            SELECT  @SaldoOsnovnihObracunov = SUM(ROUND(SaldoStroskiObracunov,2)),
									@SkupnaRazlika = SUM(Razlika)
                            FROM    PodatkiObracuna_Skupni
                            WHERE   [ObracunID] = @NewObracunID 
                            
                            
                            UPDATE  PodatkiObracuna_Skupni
                            SET     [dbo].[PodatkiObracuna_Skupni].[PreostalaVrednost] = ROUND(@SkupnaRazlika,2)
                            WHERE   [ObracunID] = @NewObracunID 
								     AND Interval = @C_Interval
								     
                        SET @ExitCondition = 1 ;
                        GOTO Konec
                    END
                ELSE 
                    IF ( @NetoOdstopanjaPozitivna = 1 ) 
                        BEGIN
							PRINT 'NovaCenaOdsPozPresezek  Interval'+CAST(@C_Interval AS VARCHAR(24))
                            SET @CpNov = @C_SIPXurni ;	 
                            SET @CmNov = @C_SIPXurni ;
							SET @Qp = 0;
							SET @Qm = 0;
							
							UPDATE  P
                                SET     P.[C+'] = @CpNov,
                                        P.[C-'] = @CmNov,
                                        P.[q+] = @Qp,
                                        P.[q-] = @Qm,
                                        [Korekcija] = 'D'
                                FROM    [dbo].[PodatkiObracuna_Skupni] P
                                WHERE   P.[ObracunID] = @NewObracunID
                                        AND P.Interval = @C_Interval
                                        AND P.[Korekcija] <> 'D'
                                        
                                        UPDATE  PodatkiObracuna_Skupni
                            SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(ROUND(O.Saldo,2), 0),
								    PodatkiObracuna_Skupni.Razlika = ISNULL(ROUND(O.Saldo,2), 0) -ROUND([dbo].[PodatkiObracuna_Skupni].SroskiIzravnave,3) 
                            FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                                                         THEN ROUND(R.[Odstopanje],2) * ROUND(@CpNov,2) / ( CASE WHEN OZT.Sifra = 'GJS' THEN 1.03
                                                                                                 ELSE 1
                                                                                            END )
                                                         ELSE ROUND(R.[Odstopanje],2) * ROUND(@CmNov,2) / ( CASE WHEN OZT.Sifra = 'GJS' THEN 0.97
                                                                                                 ELSE 1
                                                                                            END )
                                                    END) AS Saldo,
                                                P1.Interval
                                      FROM      [#OsebeZaSaldoObdobja] S
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                                JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                                                JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                      WHERE     R.[ObracunID] = @NewObracunID
                                                AND P1.[ObracunID] = @NewObracunID
                                                AND P1.Interval = @C_Interval
                                                AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                     AND     dbo.infinite(OZ.DatumSpremembe)
                                      GROUP BY  P1.interval
                                    ) O
                            WHERE   PodatkiObracuna_Skupni.[Interval] = O.Interval	
                                     
                            SELECT  @SaldoOsnovnihObracunov = SUM(ROUND(SaldoStroskiObracunov,2)),
									@SkupnaRazlika = SUM(Razlika)
                            FROM    PodatkiObracuna_Skupni
                            WHERE   [ObracunID] = @NewObracunID 
                            
                            
                            UPDATE  PodatkiObracuna_Skupni
                            SET     [dbo].[PodatkiObracuna_Skupni].[PreostalaVrednost] = ROUND(@SkupnaRazlika,2)
                            WHERE   [ObracunID] = @NewObracunID 
								     AND Interval = @C_Interval
								     
							PRINT 'NovaCenaOdsPozPresezek @SaldoOsnovnihObracunov = '+CAST(@SaldoOsnovnihObracunov AS VARCHAR(20));		 
							
                            GOTO BilancaObracunaNovaCena
                        END
						
                NovaCenaOdsNegPresezek:
                IF ( @NetoOdstopanjaNegativna = 1
                     AND @PresezekPrimanjkljajZadnjiInterval = 1
                   ) 
                    BEGIN
         
                            
                        SET @CpNov = @C_Cp ;	
                        SET @CmNov = @C_Cm ;
                        --PRINT 'RAZLIKA ZADNJI ='+CAST(@SkupnaRazlika AS varchar(20));
                        --SET @Razlika = @SkupnaRazlika
                        --PRINT 'RAZLIKA ZADNJI 1='+CAST(@SkupnaRazlika AS varchar(20));
                        --PRINT '@C_SkupnaOdstopanja = '+CAST(@C_SkupnaOdstopanja AS VARCHAR(20))+' @C_Cm = '+CAST(@/C_Cm AS VARCHAR(10))
                        
                        SET @Qp = ROUND(@SkupnaRazlika / ( -1 * @C_Wmi - ( @C_Cm / 0.97 ) ),2) 
                        
                        SET @CmNov =  ROUND(@Qm + @C_Cm,2);
                        
                        IF ( @CmNov < 0 ) 
                            SET @CmNov = 0 ;
                            
                            UPDATE  P
                                SET     P.[C+'] = @CpNov,
                                        P.[C-'] = @CmNov,
                                        P.[q+] = @Qp,
                                        P.[q-] = @Qm,
                                        [Korekcija] = 'D'
                                FROM    [dbo].[PodatkiObracuna_Skupni] P
                                WHERE   P.[ObracunID] = @NewObracunID
                                        AND P.Interval = @C_Interval
                                        AND P.[Korekcija] <> 'D'
                                        
                                  UPDATE  PodatkiObracuna_Skupni
                            SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(ROUND(O.Saldo,2), 0),
								    PodatkiObracuna_Skupni.Razlika = ISNULL(ROUND(O.Saldo,2), 0) -ROUND([dbo].[PodatkiObracuna_Skupni].SroskiIzravnave,3) 
                            FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                                                         THEN ROUND(R.[Odstopanje],3) * @CpNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 1.03
                                                                                                 ELSE 1
                                                                                            END )
                                                         ELSE ROUND(R.[Odstopanje],3) * @CmNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 0.97
                                                                                                 ELSE 1
                                                                                            END )
                                                    END) AS Saldo,
                                                P1.Interval
                                      FROM      [#OsebeZaSaldoObdobja] S
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                                JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                                                JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                      WHERE     R.[ObracunID] = @NewObracunID
                                                AND P1.[ObracunID] = @NewObracunID
                                                AND P1.Interval = @C_Interval
                                                AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                     AND     dbo.infinite(OZ.DatumSpremembe)
                                      GROUP BY  P1.interval
                                    ) O
                            WHERE   PodatkiObracuna_Skupni.[Interval] = O.Interval	
                                     
                           SELECT  @SaldoOsnovnihObracunov = SUM(ROUND(SaldoStroskiObracunov,2)),
									@SkupnaRazlika = SUM(Razlika)
                            FROM    PodatkiObracuna_Skupni
                            WHERE   [ObracunID] = @NewObracunID 
                            
                            
                            UPDATE  PodatkiObracuna_Skupni
                            SET     [dbo].[PodatkiObracuna_Skupni].[PreostalaVrednost] = ROUND(@SkupnaRazlika,2)
                            WHERE   [ObracunID] = @NewObracunID 
								     AND Interval = @C_Interval
								    
                         PRINT 'NovaCenaOdsNegPresezek ZADNJI Interval'+CAST(@C_Interval AS VARCHAR(24))+' skupna RAZLIKA = '+CAST(@SkupnaRazlika AS VARCHAR(20))+ ' Qp ='+CAST(@Qm AS VARCHAR(20))
                        SET @ExitCondition = 1 ;
                        GOTO Konec
                    END
                ELSE 
                    IF ( @NetoOdstopanjaNegativna = 1 ) 
                        BEGIN
                        PRINT 'NovaCenaOdsNegPresezek  Interval'+CAST(@C_Interval AS VARCHAR(24))
                            SET @CpNov = @C_SIPXurni ;	 
                            SET @CmNov = @C_SIPXurni ;
                            
                            SET @Qp = 0;
							SET @Qm = 0;
							
                          	UPDATE  P
                                SET     P.[C+'] = @CpNov,
                                        P.[C-'] = @CmNov,
                                        P.[q+] = @Qp,
                                        P.[q-] = @Qm,
                                        [Korekcija] = 'D'
                                FROM    [dbo].[PodatkiObracuna_Skupni] P
                                WHERE   P.[ObracunID] = @NewObracunID
                                        AND P.Interval = @C_Interval
                                        AND P.[Korekcija] <> 'D'
                                        
                            UPDATE  PodatkiObracuna_Skupni
                            SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(ROUND(O.Saldo,2), 0),
								    PodatkiObracuna_Skupni.Razlika = ISNULL(ROUND(O.Saldo,2), 0) -ROUND([dbo].[PodatkiObracuna_Skupni].SroskiIzravnave,3) 
                            FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                                                         THEN ROUND(R.[Odstopanje],3) * @CpNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 1.03
                                                                                                 ELSE 1
                                                                                            END )
                                                         ELSE ROUND(R.[Odstopanje],3) * @CmNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 0.97
                                                                                                 ELSE 1
                                                                                            END )
                                                    END) AS Saldo,
                                                P1.Interval
                                      FROM      [#OsebeZaSaldoObdobja] S
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                                JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                                                JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                      WHERE     R.[ObracunID] = @NewObracunID
                                                AND P1.[ObracunID] = @NewObracunID
                                                AND P1.Interval = @C_Interval
                                                AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                     AND     dbo.infinite(OZ.DatumSpremembe)
                                      GROUP BY  P1.interval
                                    ) O
                            WHERE   PodatkiObracuna_Skupni.[Interval] = O.Interval	
                                     
                            SELECT  @SaldoOsnovnihObracunov = SUM(ROUND(SaldoStroskiObracunov,2)),
									@SkupnaRazlika = SUM(Razlika)
                            FROM    PodatkiObracuna_Skupni
                            WHERE   [ObracunID] = @NewObracunID 
                            
                            
                            UPDATE  PodatkiObracuna_Skupni
                            SET     [dbo].[PodatkiObracuna_Skupni].[PreostalaVrednost] = ROUND(@SkupnaRazlika,2)
                            WHERE   [ObracunID] = @NewObracunID 
								     AND Interval = @C_Interval
								     
							PRINT 'NovaCenaOdsNegPresezek @SaldoOsnovnihObracunov = '+CAST(@SaldoOsnovnihObracunov AS VARCHAR(20));		 
							
                            GOTO BilancaObracunaNovaCena
                        END
					
                Konec: 
         --       	UPDATE  P
         --                       SET     P.[C+'] = @CpNov,
         --                               P.[C-'] = @CmNov,
         --                               P.[q+] = @Qp,
         --                               P.[q-] = @Qm,
         --                               [Korekcija] = 'D'
         --                       FROM    [dbo].[PodatkiObracuna_Skupni] P
         --                       WHERE   P.[ObracunID] = @NewObracunID
         --                               AND P.Interval = @C_Interval
         --                               AND P.[Korekcija] <> 'D'
                                        
         --                   UPDATE  PodatkiObracuna_Skupni
         --                   SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(O.Saldo, 0),
								 --   PodatkiObracuna_Skupni.Razlika = ISNULL(O.Saldo, 0) -[dbo].[PodatkiObracuna_Skupni].SroskiIzravnave 
         --                   FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
         --                                                THEN R.[Odstopanje] * @CpNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 1.03
         --                                                                                        ELSE 1
         --                                                                                   END )
         --                                                ELSE R.[Odstopanje] * @CmNov / ( CASE WHEN OZT.Sifra = 'GJS' THEN 0.97
         --                                                                                        ELSE 1
         --                                                                                   END )
         --                                           END) AS Saldo,
         --                                       P1.Interval
         --                             FROM      [#OsebeZaSaldoObdobja] S
         --                                       JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
         --                                       JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
         --                                       JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
         --                                       JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
         --                             WHERE     R.[ObracunID] = @NewObracunID
         --                                       AND P1.[ObracunID] = @NewObracunID
         --                                       AND P1.Interval = @C_Interval
         --                                       AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
         --                                                            AND     dbo.infinite(OZ.DatumSpremembe)
         --                             GROUP BY  P1.interval
         --                           ) O
         --                   WHERE   PodatkiObracuna_Skupni.[Interval] = O.Interval	
                                     
         --                   SELECT  @SaldoOsnovnihObracunov = SUM(SaldoStroskiObracunov),
									--@SkupnaRazlika = SUM(Razlika)
         --                   FROM    PodatkiObracuna_Skupni
         --                   WHERE   [ObracunID] = @NewObracunID 
                            
				PRINT '$$$$$$$$$$$$$$$$$$$$$$$$$$$$ KONEC ZadnjiInterval = '+CAST(@C_Interval AS VARCHAR(24))+ ' Konèni Saldo = '+	CAST(@SaldoOsnovnihObracunov AS VARCHAR(20))+' Ralika = '+	CAST(@SkupnaRazlika AS VARCHAR(20)) + ' C_Razlika = ' +CAST(@C_Razlika AS VARCHAR(20)) 
									 
                BREAK ;
							
                
                IF @ExitCondition = 1
                    OR @LoopCount > 800 
                    BREAK
                ELSE 
                    CONTINUE
                      
                        
            END
				
             						

                        --IF ( @NOErrors > 0 ) 
                        --    INSERT  INTO [#Errors] ( [Napaka] )
                        --    VALUES  (
                        --              'Napaka 005: Napaka pri agregaciji navzgor.'


        SELECT  'SkupniPOdatki PO KOREKCIJI',
                *
        FROM    PodatkiObracuna_Skupni R
        ORDER BY 
DATEPART(day,R.[Interval]) asc,
DATEPART(month,R.[Interval]) asc,
(CASE WHEN DATEPART(HH,R.[Interval]) = 0 THEN 24 ELSE DATEPART(HH,R.[Interval]) end) asc

        
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

SET NOCOUNT OFF
    END





GO