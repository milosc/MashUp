
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
        DECLARE @SkupnaRazlika DECIMAL(24, 4) ;
        DECLARE @PredzadnjaSkupnaRazlika DECIMAL(24, 3) ;
        DECLARE @StanjeSistema VARCHAR(4) ; --PRES ... presežek ; --PRIM ...primankljaj ; --EQAL ...Izravnan 
        DECLARE @BP INT ;
		
        SELECT  @BP = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'B_POG' ;
  
  
        SELECT  P.[Partner2]
        INTO    #OsebeZaSaldoObdobja
        FROM    [dbo].[Pogodba] P
                JOIN [dbo].[Oseba] O ON P.[Partner2] = O.[OsebaID]
                JOIN [dbo].[OsebaZCalc] ZC ON P.[Partner2] = ZC.[OsebaID]
                JOIN [dbo].[OsebaZId] Z ON ZC.[OsebaZID] = Z.[OsebaZId] AND Z.[OsebaZId] <> 5
        WHERE   P.[PogodbaTipID] = @BP
                AND ( @DatumVeljavnostiPodatkov BETWEEN p.VeljaOd
                                                AND     dbo.infinite(p.VeljaDo) )
                AND ( @DatumStanjaBaze BETWEEN P.[DatumVnosa]
                                       AND     dbo.infinite(P.DatumSpremembe) )
                AND ( @DatumVeljavnostiPodatkov BETWEEN o.VeljaOd
                                                AND     dbo.infinite(o.VeljaDo) )
                AND ( @DatumStanjaBaze BETWEEN o.[DatumVnosa]
                                       AND     dbo.infinite(o.DatumSpremembe) )
                AND ( @DatumStanjaBaze BETWEEN ZC.[DatumVnosa]
                                        AND     dbo.infinite(ZC.DatumSpremembe) )                                                     
                                                                       
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


       -- DECLARE @Razlika DECIMAL(24, 8) ;

       
		--IRAÈUNAMO STANJE SISTEMA;
        SELECT  @CenaIzravnave = ROUND(SUM(SroskiIzravnave), 3),
                @SaldoOsnovnihObracunov = ROUND(SUM(SaldoStroskiObracunov), 2),
                @SkupnaRazlika = SUM(Razlika)
        FROM    PodatkiObracuna_Skupni
        WHERE   [ObracunID] = @NewObracunID 


		IF ( @CenaIzravnave < @SaldoOsnovnihObracunov ) 
            SET @StanjeSistema = 'PRES'
        ELSE 
            IF ( @CenaIzravnave > @SaldoOsnovnihObracunov ) 
                SET @StanjeSistema = 'PRIM'
            ELSE 
                IF ( @CenaIzravnave = @SaldoOsnovnihObracunov ) 
                    SET @StanjeSistema = 'EQAL'
		
		
        DECLARE @MaxRazlika DECIMAL(24, 3) ;
        DECLARE @MaxInterval DATETIME ;
        DECLARE @ExitCondition INT = 0 ;
        DECLARE @C_Interval DATETIME ;
        DECLARE @C_Razlika DECIMAL(24, 3) ;
        DECLARE @C_SkupnaOdstopanja DECIMAL(24, 3) ;
        DECLARE @LoopCount INT = 0 --never ending loops
        DECLARE @NetoOdstopanjaPozitivna INT = 0 ;
        DECLARE @NetoOdstopanjaNegativna INT = 0 ;
        DECLARE @PrimanjkljajPresezekZadnjiInterval INT = 0 ;
        DECLARE @PresezekPrimanjkljajZadnjiInterval INT = 0 ;
        DECLARE @CpNov DECIMAL(24, 2) ;
        DECLARE @CmNov DECIMAL(24, 2) ;
        DECLARE @C_Cp DECIMAL(24, 2) ;
        DECLARE @C_Cm DECIMAL(24, 2) ;

        DECLARE @Qp DECIMAL(24, 3) ;
        DECLARE @Qm DECIMAL(24, 3) ;
        DECLARE @C_StrIzravnave DECIMAL(24, 3) ;
        DECLARE @C_SaldoStroski DECIMAL(24, 3) ;
        DECLARE @C_Wgjs_p DECIMAL(24, 3) ;
        DECLARE @C_Wgjs_m DECIMAL(24, 3) ;
        DECLARE @C_Wpi DECIMAL(24, 3) ;
        DECLARE @C_Wmi DECIMAL(24, 3) ;
        DECLARE @C_SIPXurni DECIMAL(24, 2) ;
         

            -- select 'Pred korekcijo' as A, * from [PodatkiObracuna_Skupni] where [ObracunID] = @NewObracunID order by Razlika desc

        WHILE @ExitCondition = 0
            BEGIN
						
                GOTO NekstMaxInterval
                     
                NekstMaxInterval:
                SET @LoopCount = @LoopCount + 1
                SET @CpNov = 0 ;	
                SET @CmNov = 0 ;
                SET @Qp = 0 ;
                SET @Qm = 0 ;
                IF ( @LoopCount > 800 ) 
                    BREAK ;
                IF ( @StanjeSistema = 'PRES' ) 
                    BEGIN
						  --MAX INTERVAL  
                        SELECT TOP 1
                                @C_Interval = P.Interval,
                                @C_SkupnaOdstopanja = P.[SkupnaOdstopanja],
                                @C_Cp = P.[C+],
                                @C_Cm = P.[C-],
                                @C_Razlika = P.[Razlika],
                                @C_StrIzravnave = P.[SroskiIzravnave],
                                @C_SaldoStroski = P.[SaldoStroskiObracunov],
                                @C_Wgjs_p = P.Wgjs_p,
                                @C_Wgjs_m = P.Wgjs_m,
                                @C_Wpi = P.Wplusi,
                                @C_Wmi = P.Wminusi,
                                @C_SIPXurni = SIPXurni
                        FROM    [dbo].[PodatkiObracuna_Skupni] P
                        WHERE   P.[ObracunID] = @NewObracunID
                                AND P.[Korekcija] = '9999'
                        ORDER BY P.[Razlika] DESC,P.Interval asc
						print 'PRESEŽEK'
                    END
                ELSE 
                    IF ( @StanjeSistema = 'PRIM' ) 
                        BEGIN
						  --MAX INTERVAL  
                            SELECT TOP 1
                                    @C_Interval = P.Interval,
                                    @C_SkupnaOdstopanja = P.[SkupnaOdstopanja],
                                    @C_Cp = P.[C+],
                                    @C_Cm = P.[C-],
                                    @C_Razlika = P.[Razlika],
                                    @C_StrIzravnave = P.[SroskiIzravnave],
                                    @C_SaldoStroski = P.[SaldoStroskiObracunov],
                                    @C_Wgjs_p = P.Wgjs_p,
                                    @C_Wgjs_m = P.Wgjs_m,
                                    @C_Wpi = P.Wplusi,
                                    @C_Wmi = P.Wminusi,
                                    @C_SIPXurni = SIPXurni
                            FROM    [dbo].[PodatkiObracuna_Skupni] P
                            WHERE   P.[ObracunID] = @NewObracunID
                                    AND P.[Korekcija] = '9999'
                            ORDER BY P.[Razlika] ASC,P.Interval asc
							print 'PRIMANKLJAJ'
                        END
			      
			      
					 --NETO ODSTOPANJA
                IF @C_SkupnaOdstopanja > 0
                    AND @StanjeSistema = 'PRIM' 
                    BEGIN
                        SET @NetoOdstopanjaPozitivna = 1 ;
                        SET @NetoOdstopanjaNegativna = 0 ;
						print 'NETO ODSTOPANJA + PRIMANKLJAJ'+' Interval = '+cast(@C_Interval as varchar(24))
                        GOTO NovaCenaOdsPozPrimankljaj
                    END
                ELSE 
                    IF @C_SkupnaOdstopanja < 0
                        AND @StanjeSistema = 'PRIM' 
                        BEGIN
                            SET @NetoOdstopanjaPozitivna = 0 ;
                            SET @NetoOdstopanjaNegativna = 1 ;
							print 'NETO ODSTOPANJA - PRIMANKLJAJ'+' Interval = '+cast(@C_Interval as varchar(24))
                            GOTO NovaCenaOdsNegPrimankljaj
                        END
                    ELSE 
                        IF @C_SkupnaOdstopanja > 0
                            AND @StanjeSistema = 'PRES' 
                            BEGIN
                                SET @NetoOdstopanjaPozitivna = 1 ;
                                SET @NetoOdstopanjaNegativna = 0 ;
								print 'NETO ODSTOPANJA + PRESEZEK'+' Interval = '+cast(@C_Interval as varchar(24))
                                GOTO NovaCenaOdsPozPresezek
                            END
                        ELSE 
                            IF @C_SkupnaOdstopanja < 0
                                AND @StanjeSistema = 'PRES' 
                                BEGIN
                                    SET @NetoOdstopanjaPozitivna = 0 ;
                                    SET @NetoOdstopanjaNegativna = 1 ;
									print 'NETO ODSTOPANJA - PRESEZEK'+' Interval = '+cast(@C_Interval as varchar(24))
                                    GOTO NovaCenaOdsNegPresezek
                                END
					 
            
                            
                NovaCenaOdsPozPrimankljaj:
                IF ( @NetoOdstopanjaPozitivna = 1
                     AND @PrimanjkljajPresezekZadnjiInterval = 1
                   ) 
                    BEGIN
                        SET @CpNov = @C_Cp ;	
                        SET @CmNov = @C_Cm ;
                        SET @Qp = ABS(@PredzadnjaSkupnaRazlika) / ( @C_Wpi+@C_Wgjs_p/1.03)
                                     SET @CpNov = ROUND(@Qp + @C_Cp, 2);
                        SET @Qm = 0 ;
                        SET @ExitCondition = 1 ;
							
                        GOTO Konec
                    END
                ELSE 
                    IF ( @NetoOdstopanjaPozitivna = 1 ) 
                        BEGIN
                            SET @CpNov = @C_Cp ;	
                            SET @CmNov = @C_Cm ;
                            SET @Qp = ROUND(( @C_StrIzravnave
                                              - @C_Wmi*@C_Cm - @C_Wpi*@C_Cp - @C_Wgjs_p*(@C_Cp/1.03)- @C_Wgjs_m*(@C_Cm/0.97)
                                            ) / ( @C_Wpi + ( @C_Wgjs_p / 1.03 ) ),
                                            2)
                            SET @CpNov = ROUND(@Qp + @C_Cp, 2) ;
                            SET @Qm = 0 ;
							
                            GOTO BilancaObracunaNovaCena
                        END
						
                      
                BilancaObracunaNovaCena:
                SET @PredzadnjaSkupnaRazlika = @SkupnaRazlika ;
				
				print 'BilancaObracunaNovaCena: Predzadnja razlika = '+cast(@PredzadnjaSkupnaRazlika as varchar(20))

                UPDATE  P
                SET     P.[C+'] = @CpNov,
                        P.[C-'] = @CmNov,
                        P.[q+] = @Qp,
                        P.[q-] = @Qm,
                        [Korekcija] = CAST(@LoopCount AS VARCHAR(4))
                FROM    [dbo].[PodatkiObracuna_Skupni] P
                WHERE   P.[ObracunID] = @NewObracunID
                        AND P.Interval = @C_Interval
                        AND P.[Korekcija] = '9999'
             
                          
                UPDATE  PodatkiObracuna_Skupni
                SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(ROUND(O.Saldo, 3), 0),
                        PodatkiObracuna_Skupni.Razlika = ROUND(ISNULL(O.Saldo, 0) - [dbo].[PodatkiObracuna_Skupni].SroskiIzravnave,3)
                FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                                             THEN R.[Odstopanje]
                                                  * @CpNov
                                                  / ( CASE WHEN OZT.Sifra = 'GJS'
                                                           THEN 1.03
                                                           ELSE 1
                                                      END )
                                             ELSE R.[Odstopanje]
                                                  * @CmNov
                                                  / ( CASE WHEN OZT.Sifra = 'GJS'
                                                           THEN 0.97
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
                                     
                SELECT  @SaldoOsnovnihObracunov = ROUND(SUM(SaldoStroskiObracunov),2),
                        @SkupnaRazlika = ROUND(SUM(Razlika),3)
                FROM    PodatkiObracuna_Skupni
                WHERE   [ObracunID] = @NewObracunID 


                UPDATE  PodatkiObracuna_Skupni
                SET     [dbo].[PodatkiObracuna_Skupni].[PreostalaVrednost] = @SkupnaRazlika
                WHERE   [ObracunID] = @NewObracunID
                        AND Interval = @C_Interval
				
				print 'BilancaObracunaNovaCena: NOVA razlika = '+cast(@SkupnaRazlika as varchar(20))+' in Saldo obraèunov = '+cast(@SaldoOsnovnihObracunov as varchar(24))+ ' in Cena Izravnave = '+cast(@CenaIzravnave as varchar(24))				     

                IF ( @StanjeSistema = 'PRES'
                     AND @CenaIzravnave < @SaldoOsnovnihObracunov
                   ) 
                    BEGIN
						print 'PRES Poišèi naslednji interval' 
                        GOTO NekstMaxInterval
                    END
                ELSE 
                    IF ( @StanjeSistema = 'PRES'
                         AND @CenaIzravnave > @SaldoOsnovnihObracunov
                       ) 
                        BEGIN
							  
                            SET @PresezekPrimanjkljajZadnjiInterval = 1
                            IF ( @NetoOdstopanjaPozitivna = 1 ) 
                                BEGIN
								print 'Zadnji interval + PRESEŽEK'   
                                    GOTO NovaCenaOdsPozPresezek
                                END    
                            ELSE 
                                IF ( @NetoOdstopanjaNegativna = 1 ) 
                                    BEGIN
										print 'Zadnji interval - PRESEŽEK'   
                                        GOTO NovaCenaOdsNegPresezek
                                    END
                        END
                    ELSE 
                        IF ( @StanjeSistema = 'PRIM'
                             AND @CenaIzravnave > @SaldoOsnovnihObracunov
                           ) 
                            BEGIN
							    print 'PRIM Poišèi naslednji interval'
                                GOTO NekstMaxInterval
                            END
                        ELSE 
                            IF ( @StanjeSistema = 'PRIM'
                                 AND @CenaIzravnave < @SaldoOsnovnihObracunov
                               ) 
                                BEGIN
                                    --UPDATE  PodatkiObracuna_Skupni
                                    --SET     [dbo].[PodatkiObracuna_Skupni].[PreostalaVrednost] = @PredzadnjaSkupnaRazlika
                                    --WHERE   [ObracunID] = @NewObracunID
                                    --        AND Interval = @C_Interval
								     
                                    SET @PrimanjkljajPresezekZadnjiInterval = 1
                                    IF ( @NetoOdstopanjaPozitivna = 1 ) 
									begin
									print 'Zadnji interval + PRIM'   
                                        GOTO NovaCenaOdsPozPrimankljaj
									end
                                    ELSE 
                                        IF ( @NetoOdstopanjaNegativna = 1 ) 
										begin
										print 'Zadnji interval - PRIM'   
                                            GOTO NovaCenaOdsNegPrimankljaj
										end 
                                END
							
							
						
                NovaCenaOdsNegPrimankljaj:
                IF ( @NetoOdstopanjaNegativna = 1
                     AND @PrimanjkljajPresezekZadnjiInterval = 1
                   ) 
                    BEGIN
                    
                        SET @CpNov = @C_Cp ;	
                        SET @CmNov = @C_Cm ;
                        SET @SkupnaRazlika = @PredzadnjaSkupnaRazlika ;
                        SET @Qm = ABS(ROUND(( @PredzadnjaSkupnaRazlika )
                                            / ( -1 * @C_Wmi - ( 1 * @C_Wgjs_m / 0.97 ) ),
                                            2))
                        SET @Qp = 0 ;
                        SET @CmNov = ROUND(-1 * @Qm + @C_Cm, 2) ;
                        IF ( @CmNov < 0 ) 
                            SET @CmNov = 0 ;
	                        SET @ExitCondition = 1 ;
                        GOTO Konec
                    END
                ELSE 
                    IF ( @NetoOdstopanjaNegativna = 1 ) 
                        BEGIN
                            SET @CpNov = @C_Cp ;	
                            SET @CmNov = @C_Cm ;
                            SET @Qm = ROUND(( -1 * @C_StrIzravnave + @C_Wmi*@C_Cm + @C_Wpi*@C_Cp +@C_Wgjs_p*(@C_Cp/1.03)+@C_Wgjs_m*(@C_Cm/0.97)) / ( @C_Wmi + ( @C_Wgjs_m / 0.97 ) ),
                                            2)
                                            
                            SET @Qp = 0 ;
                            SET @CmNov = ROUND(@C_Cm-@Qm, 2) ;
                            IF ( @CmNov < 0 ) 
                                SET @CmNov = 0 ;
                            GOTO BilancaObracunaNovaCena
                        END
						
					
                NovaCenaOdsPozPresezek:
                IF ( @NetoOdstopanjaPozitivna = 1
                     AND @PresezekPrimanjkljajZadnjiInterval = 1
                   ) 
                    BEGIN
						
                        SET @CpNov = @C_Cp ;	
                        SET @CmNov = @C_Cm ;
                        SET @SkupnaRazlika = @PredzadnjaSkupnaRazlika ;
                        SET @Qp = @PredzadnjaSkupnaRazlika / ( @C_Wpi + ( @C_Wgjs_p / 1.03 ) )
                        SET @Qm = 0 ;
                        SET @CpNov = -1 * @Qp + @C_Cp ;
                        SET @ExitCondition = 1 ;
                        GOTO Konec
                    END
                ELSE 
                    IF ( @NetoOdstopanjaPozitivna = 1 ) 
                        BEGIN
                            SET @CpNov = @C_SIPXurni ;	 
                            SET @CmNov = @C_SIPXurni ;
                            SET @Qp = 0 ;
                            SET @Qm = 0 ;
							
                            GOTO BilancaObracunaNovaCena
                        END
						
                NovaCenaOdsNegPresezek:
                IF ( @NetoOdstopanjaNegativna = 1
                     AND @PresezekPrimanjkljajZadnjiInterval = 1
                   ) 
                    BEGIN
         
                        
                        SET @CpNov =  @C_Cp ;	
                        SET @CmNov = @C_Cm ;
						Set @Qp = 0;
						SET @SkupnaRazlika = @PredzadnjaSkupnaRazlika ;
						
                        SET @Qm = ROUND(@SkupnaRazlika / ( -1 * @C_Wmi
                                                           - ( @C_Wgjs_m / 0.97 ) ),
                                        2) 
                        
                        SET @CmNov = ROUND(@C_Cm+@Qm, 2) ;

                        print 'NovaCenaOds - Presezek: FINAL SKUPNA RAZLIKA = '+cast(@SkupnaRazlika as varchar(24))+ ' iA ='+cast(-1*@C_Wmi as varchar(24))+ ' iB ='+cast(@C_Wgjs_m / 0.97 as varchar(24))+ ' Q-='+cast(@Qm as varchar(24))+ ' C-='+cast(@CmNov as varchar(24))+' Skupna Odstopanja= '+cast(@C_SkupnaOdstopanja as varchar(24))+' Saldo stroški = '+cast(@C_SaldoStroski as varchar(24))+' Stroški Izravnave = '+cast(@C_StrIzravnave as varchar(24))
                        IF ( @CmNov < 0 ) 
                            SET @CmNov = 0 ;
                        SET @ExitCondition = 1 ;
                        GOTO Konec
                    END
                ELSE 
                    IF ( @NetoOdstopanjaNegativna = 1 ) 
                        BEGIN
                            SET @CpNov = @C_SIPXurni ;	 
                            SET @CmNov = @C_SIPXurni ;
                            
                            SET @Qp = 0 ;
                            SET @Qm = 0 ;
							
                            GOTO BilancaObracunaNovaCena
                        END
					
                Konec: 
                UPDATE  P
                SET     P.[C+'] = @CpNov,
                        P.[C-'] = @CmNov,
                        P.[q+] = @Qp,
                        P.[q-] = @Qm,
                        [Korekcija] = CAST(@LoopCount AS VARCHAR(4))
                FROM    [dbo].[PodatkiObracuna_Skupni] P
                WHERE   P.[ObracunID] = @NewObracunID
                        AND P.Interval = @C_Interval
							
                UPDATE  PodatkiObracuna_Skupni
                SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(ROUND(O.Saldo, 2), 0),
                        PodatkiObracuna_Skupni.Razlika = ROUND(ISNULL(O.Saldo,0) - [dbo].[PodatkiObracuna_Skupni].SroskiIzravnave,3)
                FROM    ( SELECT    SUM(CASE WHEN R.[Odstopanje] > 0
                                             THEN R.[Odstopanje]
                                                  * @CpNov
                                                  / ( CASE WHEN OZT.Sifra = 'GJS'
                                                           THEN 1.03
                                                           ELSE 1
                                                      END )
                                             ELSE R.[Odstopanje]
                                                  * @CmNov
                                                  / ( CASE WHEN OZT.Sifra = 'GJS'
                                                           THEN 0.97
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
                        AND PodatkiObracuna_Skupni.Interval = @C_Interval
                            
                                    
                SELECT  @SaldoOsnovnihObracunov = ROUND(SUM(SaldoStroskiObracunov),2),
                        @SkupnaRazlika = ROUND(SUM(Razlika),3)
                FROM    PodatkiObracuna_Skupni
                WHERE   [ObracunID] = @NewObracunID

                UPDATE  PodatkiObracuna_Skupni
                SET     [dbo].[PodatkiObracuna_Skupni].[PreostalaVrednost] = @SkupnaRazlika
                WHERE   [ObracunID] = @NewObracunID
                        AND Interval = @C_Interval
									 
                BREAK ;
							
                
                IF @ExitCondition = 1
                    OR @LoopCount > 800 
                    BREAK
                ELSE 
                    CONTINUE
                      
                        
            END
				

       UPDATE [dbo].[PodatkiObracuna_Skupni]
		SET [C+GJS] = ROUND([C+']/1.03,2),
			[C-GJS] = ROUND([C-']/0.97,2)
	   WHERE [ObracunID] = @NewObracunID

        
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