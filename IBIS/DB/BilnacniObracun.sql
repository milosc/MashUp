EXEC [dbo].[DropPRCorUDF] @ObjectName = '[BilnacniObracun]'
 -- varchar(max)
GO
-- ==============================================================
-- Author:		<MashU929p Miloš Cigoj s.p., milos.cigoj@mashup.si>
-- Create date: <8.8.2008(Korona d.d.), edited date : 26.04.2012 
-- ==============================================================

CREATE PROCEDURE [dbo].[BilnacniObracun]
    @ObracunskoObdobjeID INT ,
    @DatumVeljavnostiPodatkov DATETIME = GETDATE ,
    @DatumStanjaBaze DATETIME = GETDATE ,
    @Avtor INT ,
    @ObracunID INT OUTPUT ,
    @Naziv VARCHAR(50) ,
    @obracun INT = 0 ,
    @Bs XML = NULL , --seznam BS za obračun
    @ValidationErrorsXML XML = '' OUTPUT , --glave napak
    @ValidationErrorsDetailXML XML = '' OUTPUT , --vrstice posamezne napake
    @debugMode INT = 0
AS 
    BEGIN
        DECLARE @Time1 DATETIME
        DECLARE @Time2 DATETIME  
		    
        SET ANSI_WARNINGS, ARITHABORT ON
                                       
        DECLARE @NewObracunID INT
        DECLARE @DatumIntervalaOD DATETIME
        DECLARE @DatumIntervalaDO DATETIME
        DECLARE @VsotaT DECIMAL(18, 8) --vsota tolerančnih pasov BS
        DECLARE @SumWIzrPlus DECIMAL(18, 8) 
        DECLARE @SumWIzrMinus DECIMAL(18, 8) 
        DECLARE @CPlus DECIMAL(18, 2) 
        DECLARE @CMinus DECIMAL(18, 2) 
        DECLARE @CPlusNov DECIMAL(18, 2) 
        DECLARE @CMinusNov DECIMAL(18, 2) 
        DECLARE @NormiranPPP DECIMAL(18, 8) 
        DECLARE @NormiranPPO DECIMAL(18, 8) 
        DECLARE @NOErrors INT
        DECLARE @NOErrorsOUT INT
        DECLARE @k DECIMAL(18, 8)
        DECLARE @RegulacijskoObmocjSR DECIMAL(18, 8)

        DECLARE @novk DECIMAL(18, 8)
        SET @novk = 0.02; -- TO-DO:READ FROM SETTINGS

        SET @NOErrors = 0;
        SET @NOErrorsOUT = 0;
        SET @NewObracunID = -1;

--TIPI PPM

        DECLARE @VIRT_MERJENI_ODJEM INT
        DECLARE @VIRT_NEMERJENI_ODJEM INT
        DECLARE @VIRT_MERJEN_ODDAJA INT
        DECLARE @VIRT_NEMERJEN_ODDAJA INT 
        DECLARE @VIRT_REGULACIJA INT
        DECLARE @VIRT_ELES_ODJEM INT
        DECLARE @VIRT_ELES_ODDAJA INT
        DECLARE @VIRT_PBI INT
        DECLARE @VIRT_DSP INT
        DECLARE @UDO_P_MERJENI INT
        DECLARE @UDO_P_NEMERJENI INT
        DECLARE @UDO_P_IZGUBE INT
        DECLARE @MP_SKUPAJ INT
        DECLARE @MP_ND_NEMERJENI INT
        DECLARE @MP_ND_MERJENI INT
        DECLARE @MP_NP_NEMERJENI INT
        DECLARE @MP_NP_MERJENI INT
        DECLARE @MP_KP_NEMERJENI INT
        DECLARE @MP_KP_MERJENI INT
        DECLARE @VIRT_ELES_MERITVE INT
        DECLARE @MEJE INT
        DECLARE @ND_EL_PR INT
        DECLARE @ND_EL_MB INT
        DECLARE @ND_EL_LJ INT
        DECLARE @ND_EL_GO INT
        DECLARE @ND_EL_CE INT
        DECLARE @VIRT_ELES_MERITVE_PREVZEM_SODO INT
  
  --TIP POGODBE
        DECLARE @BP INT
        DECLARE @PI INT
        DECLARE @SSOPOBS INT
        DECLARE @PDOB INT
        DECLARE @PDSODOSOPO INT
        DECLARE @PDOBSODO INT
  
        DECLARE @CriticalError INT
        DECLARE @ValiodationErrors INT;


	--TIP OSEBE
        DECLARE @SodoTipID INT
        DECLARE @SOPOTipID INT
        DECLARE @TrgovecTipID INT
        DECLARE @RegulacijaTipID INT
        DECLARE @SRegulacijaTipID INT
        DECLARE @TRegulacijaTipID INT
        DECLARE @OTTipID INT
  
      
  --Postavitev globalnih konstant - ZAČETEK
        SELECT  @VIRT_ELES_MERITVE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SOPO) VIRT_ELES_MERITVE';
  
        SELECT  @VIRT_MERJENI_ODJEM = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_MERJENI_ODJEM';
  
        SELECT  @VIRT_NEMERJENI_ODJEM = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_NEMERJENI_ODJEM';
 
        SELECT  @VIRT_MERJEN_ODDAJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_MERJEN_ODDAJA';
  
        SELECT  @VIRT_NEMERJEN_ODDAJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_NEMERJEN_ODDAJA';
  
        SELECT  @VIRT_REGULACIJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(REG) VIRT_REGULACIJA';
  
        SELECT  @VIRT_ELES_ODJEM = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = 'VIRT_ELES_ODJEM';
  
        SELECT  @VIRT_ELES_ODDAJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = 'VIRT_ELES_ODDAJA';
  
        SELECT  @VIRT_PBI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_PBI';
  
        SELECT  @VIRT_DSP = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_DSP';
  
        SELECT  @UDO_P_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) UDO_P_MERJENI';
  
        SELECT  @UDO_P_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) UDO_P_NEMERJENI';
  
        SELECT  @UDO_P_IZGUBE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) UDO_P_IZGUBE';
  
        SELECT  @MP_SKUPAJ = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_SKUPAJ';
  
        SELECT  @MP_ND_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_ND_NEMERJENI';
  
        SELECT  @MP_ND_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_ND_MERJENI';
  
        SELECT  @MP_NP_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_NP_NEMERJENI';
  
        SELECT  @MP_NP_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_NP_MERJENI';
  
        SELECT  @MP_KP_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_KP_NEMERJENI';
  
        SELECT  @MP_KP_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_KP_MERJENI';

        SELECT  @MEJE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = 'MEJE';

        SELECT  @ND_EL_PR = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) ND_EL_PR';

        SELECT  @ND_EL_MB = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) ND_EL_MB';

        SELECT  @ND_EL_LJ = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) ND_EL_LJ';

        SELECT  @ND_EL_GO = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) ND_EL_GO';

        SELECT  @ND_EL_CE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) ND_EL_CE';
	  
        SELECT  @VIRT_ELES_MERITVE_PREVZEM_SODO = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SOPO) VIRT_ELES_MERITVE_PREVZEM_SODO';

        SELECT  @BP = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'B_POG';
  
        SELECT  @PI = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'P_IZR';
  
        SELECT  @SSOPOBS = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'S_SOPO_BS';
    
        SELECT  @PDOB = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'P_DOB';

  
        SELECT  @SodoTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'SODO';
  
        SELECT  @SOPOTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'SOPO';
    
        SELECT  @TrgovecTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'TRG';
    
        SELECT  @RegulacijaTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'REG';
    
        SELECT  @SRegulacijaTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'SREG';

        SELECT  @TRegulacijaTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'TREG';
  
        SELECT  @SodoTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'OT';

        SET @CriticalError = 0;
        SET @ValiodationErrors = 0;

        SELECT  @k = CAST(vrednost AS DECIMAL(18, 8))
        FROM    Nastavitev
        WHERE   oznaka = 'BilancniObracun_k'
                AND ( @DatumStanjaBaze BETWEEN [DatumVnosa]
                                       AND     dbo.infinite(DatumSpremembe) )

        SELECT  @RegulacijskoObmocjSR = CAST(vrednost AS DECIMAL(18, 8))
        FROM    Nastavitev
        WHERE   oznaka = 'RegulacijskoObmocjSR'
                AND ( @DatumStanjaBaze BETWEEN [DatumVnosa]
                                       AND     dbo.infinite(DatumSpremembe) )

 --Postavitev globalnih konstant - KONEC
 
  
  --Kreiranje začasnih tabel za napake
        IF OBJECT_ID('#Errors') IS NOT NULL 
            DROP TABLE #Errors
        
        CREATE TABLE #Errors
            (
              ErrorID BIGINT IDENTITY(1, 1)
                             NOT NULL ,
              Napaka VARCHAR(255) NOT NULL
            )

        IF OBJECT_ID('#ErrorDetail') IS NOT NULL 
            DROP TABLE #ErrorDetail
        
        CREATE TABLE #ErrorDetail
            (
              ErrorID BIGINT ,
              ErrorDetail VARCHAR(900) NOT NULL
            )
   
        SELECT  @DatumIntervalaOD = [VeljaOd] ,
                @DatumIntervalaDO = [VeljaDo]
        FROM    [ObracunskoObdobje]
        WHERE   [ObracunskoObdobjeID] = @ObracunskoObdobjeID
                AND ( @DatumStanjaBaze BETWEEN [DatumVnosa]
                                       AND     dbo.infinite(DatumSpremembe) )
    
        IF ( @RegulacijskoObmocjSR IS  NULL ) 
            BEGIN
                SET @NOErrors = @NOErrors + 1
                INSERT  INTO #Errors
                        ( Napaka 
                        )
                        SELECT  'Napaka 000a: Šifrant regulacijsko obmošje RS ni izpolnjen. Preverite Nastavitve.'
            END
      
        BEGIN TRANSACTION OBRACUN 
    
        IF ( @NOErrors = 0 ) 
            BEGIN      
	  --VALIDACIJA Obračuna
	  /*
	  Preveri popolnost intervalov kritičnih vhodnih tabel ter preveri pravilnost PDP, PDO. Podobno kot v Excelu.
	  */
                SET @Time1 = GETDATE();
                EXEC @ValiodationErrors = dbo.BilancniObracun_Validacija @DatumIntervalaDO,
                    @DatumStanjaBaze, @DatumIntervalaOD,
                    @DatumVeljavnostiPodatkov, @MP_KP_NEMERJENI,
                    @MP_NP_NEMERJENI, @NOErrorsOUT, @VIRT_MERJENI_ODJEM,
                    @VIRT_NEMERJEN_ODDAJA, @VIRT_PBI, @VIRT_NEMERJENI_ODJEM,
                    @ErrorHeadXML = @ValidationErrorsXML OUTPUT,
                    @ErrorDetailsXML = @ValidationErrorsDetailXML OUTPUT
	  
                IF ( @ValiodationErrors > 0 ) 
                    BEGIN
                        SET @NOErrors = @NOErrors + 1
                        DECLARE @hdocVTC1 INT;
                        DECLARE @xmlpath1 VARCHAR(255);
                        SET @xmlpath1 = '/Root/Napake';
                        EXEC sp_xml_preparedocument @hdocVTC1 OUTPUT,
                            @ValidationErrorsXML;

                        INSERT  INTO #Errors
                                ( Napaka 
                                )
                                SELECT  Napaka
                                FROM    OPENXML(@hdocVTC1,@xmlpath1,2) WITH ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                                ORDER BY ErrorID ASC     
                        EXEC sp_xml_removedocument @hdocVTC1
				
                        SET @xmlpath1 = '/Root/ErrorDetail';
                        EXEC sp_xml_preparedocument @hdocVTC1 OUTPUT,
                            @ValidationErrorsDetailXML;

                        INSERT  INTO #ErrorDetail
                                ( ErrorDetail 
                                )
                                SELECT  ErrorDetail
                                FROM    OPENXML(@hdocVTC1,@xmlpath1,2) WITH ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                                ORDER BY ErrorID ASC     
                        EXEC sp_xml_removedocument @hdocVTC1
		
                    END
                SET @Time2 = GETDATE();
                PRINT 'BilancniObracun_Validacija t= '
                    + CAST(DATEDIFF(SECOND, @Time1, @Time2) AS VARCHAR(100))
	  --END VALIODACIJA
            END
  
  --če nimamo napak pri validaciji lahko stopimo v naslednji korak obračuna
  --če imamo količinsko oračun grem kljub napakam dalje. Napake pa shranimo za prikaz.
        IF ( @NOErrors = 0 ) 
            BEGIN	
    --Pridobitev naslednjega prostega ID-ja
                SELECT  @NewObracunID = ISNULL(MAX(ObracunID), 0) + 1
                FROM    [Obracun]
 
                SET @ObracunID = @NewObracunID
	  --še enkrat preverimo vhodne parametre
                IF ( @NewObracunID > 0
                     AND @DatumIntervalaOD IS NOT NULL
                     AND @DatumIntervalaDO IS NOT NULL
                   ) 
                    BEGIN	--obračun

		  --naredimo nov obračun za potrebe sledenja bomo novi ObracunID postavili v vse obračunske tabele.
                        INSERT  INTO [Obracun]
                                ( [ObracunID] ,
                                  [ObracunskoObdobjeID] ,
                                  [ObracunStatusID] ,
                                  [DatumVnosa] ,
                                  [Avtor] ,
                                  [Naziv] ,
                                  ObracunTipID ,
                                  [velja]
                                )
                                SELECT  @NewObracunID ,
                                        @ObracunskoObdobjeID ,
                                        ObracunStatusID ,
                                        GETDATE() ,
                                        @Avtor ,
                                        @Naziv ,
                                        1 ,
                                        @DatumVeljavnostiPodatkov
                                FROM    [ObracunStatus]
                                WHERE   Sifra = 'INF'
			
         
                        IF ( @@ERROR <> 0 ) 
                            BEGIN
                                SET @NOErrors = @NOErrors + 1
                                INSERT  INTO [#Errors]
                                        ( [Napaka] 
                                        )
                                VALUES  ( 'Napaka 001: Napaka pri inicilaizaciji obračuna.'
                                        );
                            END
  		
		  --REALIZACIAJ PO DOBAVITELJIH
                        SET @Time1 = GETDATE();
					
                        EXEC dbo.BilancniObracun_RealizacijaPoDobaviteljih @BP = @BP,
                            @Bs = @Bs, @DatumIntervalaDO = @DatumIntervalaDO,
                            @DatumIntervalaOD = @DatumIntervalaOD,
                            @DatumStanjaBaze = @DatumStanjaBaze,
                            @DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
                            @NewObracunID = @NewObracunID,
                            @NOErrors = @NOErrorsOUT OUTPUT, @PI = @PI,
                            @UDO_P_IZGUBE = @UDO_P_IZGUBE,
                            @VIRT_ELES_MERITVE = @VIRT_ELES_MERITVE,
                            @VIRT_MERJEN_ODDAJA = @VIRT_MERJEN_ODDAJA,
                            @VIRT_MERJENI_ODJEM = @VIRT_MERJENI_ODJEM,
                            @VIRT_NEMERJEN_ODDAJA = @VIRT_NEMERJEN_ODDAJA,
                            @VIRT_NEMERJENI_ODJEM = @VIRT_NEMERJENI_ODJEM,
                            @VIRT_REGULACIJA = @VIRT_REGULACIJA,
                            @ErrorHeadXML = @ValidationErrorsXML OUTPUT,
                            @ErrorDetailsXML = @ValidationErrorsDetailXML OUTPUT



                        IF ( @NOErrorsOUT <> 0 ) 
                            BEGIN
                                SET @NOErrors = @NOErrors + 1;
                                DECLARE @hdocVTC2 INT;
                                DECLARE @xmlpath2 VARCHAR(255);
                                SET @xmlpath2 = '/Root/Napake';
                                EXEC sp_xml_preparedocument @hdocVTC2 OUTPUT,
                                    @ValidationErrorsXML;


                                INSERT  INTO #Errors
                                        ( Napaka 
                                        )
                                        SELECT  Napaka
                                        FROM    OPENXML(@hdocVTC2,@xmlpath2,2)
                                                WITH ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                                        ORDER BY ErrorID ASC     
                                EXEC sp_xml_removedocument @hdocVTC2
						
                                SET @xmlpath2 = '/Root/ErrorDetail';
                                EXEC sp_xml_preparedocument @hdocVTC2 OUTPUT,
                                    @ValidationErrorsDetailXML;

                                INSERT  INTO #ErrorDetail
                                        ( ErrorDetail 
                                        )
                                        SELECT  ErrorDetail
                                        FROM    OPENXML(@hdocVTC2,@xmlpath2,2)
                                                WITH ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                                        ORDER BY ErrorID ASC     
                                EXEC sp_xml_removedocument @hdocVTC2
				
                            END
                        SET @Time2 = GETDATE();
                        PRINT 'BilancniObracun_RealizacijaPoDobaviteljih t= '
                            + CAST(DATEDIFF(SECOND, @Time1, @Time2) AS VARCHAR(100))
               

			--END REALIZACIAJ PO DOBAVITELJIH
			

		  --če imamo vsaj en zapis v realizaciji po dobavitejih potem imamo realne možnosti za nadaljevanje obračuna
		  --TO-DO: za še nadlajno optimizacijo lahko vrnemo record_count že iz SP BilanciObracun_RealizacijaPODobaviteljih
                        IF ( EXISTS ( SELECT    COUNT(*)
                                      FROM      [RealizacijaPoDobaviteljih]
                                      WHERE     ObracunID = @NewObracunID ) ) 
                            BEGIN --imamo podatke za obračun

			
			--Izračun realizacije BPS in BS
                                SET @Time1 = GETDATE();
                                PRINT 'BilancniObracun_RealizacijaBSinBPS t= '
                                    + CAST(DATEDIFF(SECOND, @Time1, @Time2) AS VARCHAR(100))
                                EXEC dbo.BilancniObracun_RealizacijaBSinBPS @BP,
                                    @DatumStanjaBaze,
                                    @DatumVeljavnostiPodatkov, @NewObracunID,
                                    @NOErrorsOUT OUTPUT, @PI,
                                    @ValidationErrorsXML OUTPUT,
                                    @ValidationErrorsDetailXML OUTPUT
      
			
                                IF ( @NOErrorsOUT <> 0 ) 
                                    BEGIN
                                        SET @NOErrors = @NOErrors + 1;
                                        DECLARE @hdocVTC6 INT;
                                        DECLARE @xmlpath6 VARCHAR(255);
                                        SET @xmlpath6 = '/Root/Napake';
                                        EXEC sp_xml_preparedocument @hdocVTC6 OUTPUT,
                                            @ValidationErrorsXML;

                                        INSERT  INTO #Errors
                                                ( Napaka 
                                                )
                                                SELECT  Napaka
                                                FROM    OPENXML(@hdocVTC6,@xmlpath6,2)
                                                        WITH ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                                                ORDER BY ErrorID ASC     
                                        EXEC sp_xml_removedocument @hdocVTC6
						
                                        SET @xmlpath6 = '/Root/ErrorDetail';
                                        EXEC sp_xml_preparedocument @hdocVTC6 OUTPUT,
                                            @ValidationErrorsDetailXML;

                                        INSERT  INTO #ErrorDetail
                                                ( ErrorDetail 
                                                )
                                                SELECT  ErrorDetail
                                                FROM    OPENXML(@hdocVTC6,@xmlpath6,2)
                                                        WITH ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                                                ORDER BY ErrorID ASC     
                                        EXEC sp_xml_removedocument @hdocVTC6
				
                                    END
                 
                                SET @Time2 = GETDATE();
                                PRINT 'BilancniObracun_RealizacijaBSinBPS t= '
                                    + CAST(DATEDIFF(SECOND, @Time1, @Time2) AS VARCHAR(100))

		 --preverimo če imamo vse podatke za naslednje korake. Tukaj se preverja če imamo za obračun na voljo SIPX, TržniPlan,...
                               
                                SET @Time1 = GETDATE();
                                EXEC dbo.BilancniObracun_CheckInputSets @CriticalError OUTPUT,
                                    @DatumIntervalaDO, @DatumIntervalaOD,
                                    @DatumStanjaBaze,
                                    @DatumVeljavnostiPodatkov,
                                    @NOErrorsOUT OUTPUT,
                                    @ValidationErrorsXML OUTPUT,
                                    @ValidationErrorsDetailXML OUTPUT
                
                                SET @Time2 = GETDATE();
                                PRINT 'BilancniObracun_CheckInputSets t= '
                                    + CAST(DATEDIFF(SECOND, @Time1, @Time2) AS VARCHAR(100))
                
                
                                IF ( @NOErrorsOUT <> 0 ) 
                                    BEGIN
                                        SET @NOErrors = @NOErrors + 1;
                                        DECLARE @hdocVTC7 INT;
                                        DECLARE @xmlpath7 VARCHAR(255);
                                        SET @xmlpath7 = '/Root/Napake';
                                        EXEC sp_xml_preparedocument @hdocVTC7 OUTPUT,
                                            @ValidationErrorsXML;

                                        INSERT  INTO #Errors
                                                ( Napaka 
                                                )
                                                SELECT  Napaka
                                                FROM    OPENXML(@hdocVTC7,@xmlpath7,2)
                                                        WITH ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                                                ORDER BY ErrorID ASC     
                                        EXEC sp_xml_removedocument @hdocVTC7
						
                                        SET @xmlpath7 = '/Root/ErrorDetail';
                                        EXEC sp_xml_preparedocument @hdocVTC7 OUTPUT,
                                            @ValidationErrorsDetailXML;

                                        INSERT  INTO #ErrorDetail
                                                ( ErrorDetail 
                                                )
                                                SELECT  ErrorDetail
                                                FROM    OPENXML(@hdocVTC7,@xmlpath7,2)
                                                        WITH ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                                                ORDER BY ErrorID ASC     
                                        EXEC sp_xml_removedocument @hdocVTC7
				
                                    END
                                
             					
			 --ZAČASNA tabela za potrebe agregacije navzgor
                                IF OBJECT_ID('#KorekcijaTP') IS NOT NULL 
                                    DROP TABLE #KorekcijaTP
				
    
                                CREATE TABLE #KorekcijaTP
                                    (
                                      INTERVAL DATETIME NOT NULL ,
                                      OsebaId INT NOT NULL ,
                                      Nivo INT NOT NULL ,
                                      NadrejenaOsebaID INT NOT NULL ,
                                      VrednostKorekcijeTP DECIMAL(18, 1) NULL ,
                                      Kolicina DECIMAL(18, 1) NOT NULL ,
                                      KoregiranTP DECIMAL(18, 1) NOT NULL
                                    )
			 
                                CREATE NONCLUSTERED INDEX IX_KorekcijaTP ON #KorekcijaTP ( INTERVAL, OsebaId );
								
                                SET @Time1 = GETDATE();
					
			  --inicializacija Tržnega Plana
                                UPDATE  [TrzniPlan]
                                SET     KoregiranTP = TP.Kolicina ,
                                        [JeKorigiran] = 0 ,
                                        VrednostPopravkaTP = 0
                                FROM    [TrzniPlan] TP
                                WHERE   TP.[Interval] >= @DatumIntervalaOD
                                        AND TP.[Interval] < DATEADD(DAY, 1,
                                                              @DatumIntervalaDO)
                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(TP.DatumSpremembe) )
			
                                IF ( @@ERROR <> 0 ) 
                                    BEGIN
                                        SET @NOErrors = @NOErrors + 1
                                        INSERT  INTO [#Errors]
                                                ( [Napaka] 
                                                )
                                        VALUES  ( 'Napaka 0582: Napaka pri inicilaizaciji Tržnega plana.'
                                                );
                                    END
				
				
  --	      še sekundarna in tercilana regulacija
                                UPDATE  [TrzniPlan]
                                SET     [KoregiranTP] = ISNULL([KoregiranTP],
                                                              0)
                                        - ISNULL(R.[SekRegM] + R.[SekRegP], 0) ,
                                        [JeKorigiran] = 1
                                FROM    [TrzniPlan] TP
                                        JOIN PPM M ON Tp.[OsebaID] = M.Dobavitelj1
                                                      AND M.[PPMTipID] = @VIRT_REGULACIJA
                                        LEFT JOIN [Regulacija] R ON M.[PPMID] = R.PPMID
                                                              AND R.Interval = TP.Interval
                                WHERE   TP.[Interval] >= @DatumIntervalaOD
                                        AND TP.[Interval] < DATEADD(DAY, 1,
                                                              @DatumIntervalaDO)
                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(TP.DatumSpremembe) )
                                        AND ( @DatumStanjaBaze BETWEEN R.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(R.DatumSpremembe) )
                                        AND ( ( @DatumStanjaBaze BETWEEN M.DatumVnosa
                                                              AND
                                                              dbo.infinite(M.DatumSpremembe) )
                                              AND ( @DatumVeljavnostiPodatkov BETWEEN M.VeljaOd
                                                              AND
                                                              dbo.infinite(M.VeljaDo) )
                                            )

                                IF ( @@ERROR <> 0 ) 
                                    BEGIN
                                        SET @NOErrors = @NOErrors + 1
                                        INSERT  INTO [#Errors]
                                                ( [Napaka] 
                                                )
                                        VALUES  ( 'Napaka 008f: Napaka pri izračunu koregiranega tržnega plana.'
                                                );
                                    END 
                                    
              --Napolnimo polje za ugotavljanje korekcije tržnega plana
                                UPDATE  dbo.TrzniPlan
                                SET     VrednostPopravkaTP = Kolicina
                                        - KoregiranTP
                                WHERE   [INTERVAL] >= @DatumIntervalaOD
                                        AND [INTERVAL] < DATEADD(DAY, 1,
                                                              @DatumIntervalaDO)
                                        AND ( @DatumStanjaBaze BETWEEN [DatumVnosa]
                                                              AND
                                                              dbo.infinite(DatumSpremembe) )
                                IF ( @@ERROR <> 0 ) 
                                    BEGIN
                                        SET @NOErrors = @NOErrors + 1
                                        INSERT  INTO [#Errors]
                                                ( [Napaka] 
                                                )
                                        VALUES  ( 'Napaka 008g: Napaka pri izračunu koregiranega tržnega plana - izračun faktorja korekcije TP.'
                                                );
                                    END 

                 
                                SET @Time2 = GETDATE();
                                PRINT 'inicializacija Tržnega Plana t= '
                                    + CAST(DATEDIFF(SECOND, @Time1, @Time2) AS VARCHAR(100))

                                IF ( @CriticalError = 0 ) 
                                    BEGIN
			
				--Odstopanja po BPS
                                        SET @Time1 = GETDATE();
                                        INSERT  INTO [KolicinskaOdstopanjaPoBPS]
                                                ( [Kolicina] ,
                                                  [VozniRed] ,
                                                  [Odstopanje] ,
                                                  [OsebaID] ,
                                                  [INTERVAL] ,
                                                  [ObracunID] ,
                                                  [KoregiranTP],
												  [Odjem],
												  [Oddaja]
                                                )
                                                SELECT  ISNULL(RBPS.Kolicina,
                                                              0) ,
                                                        ISNULL(ROUND(Tp.Kolicina,
                                                              1), 0) ,
                                                        ROUND(ISNULL(RBPS.Kolicina,
                                                              0)
                                                              - ISNULL(Tp.KoregiranTP,
                                                              0), 3) ,
                                                        RBPS.OsebaID ,
                                                        RBPS.Interval ,
                                                        @NewObracunID ,
                                                        ISNULL(Tp.KoregiranTP,
                                                              0),
														ISNULL(RBPS.Odjem,0),
														ISNULL(RBPS.Oddaja,0)
                                                FROM    [RealizacijaPoBPS] RBPS
                                                        INNER JOIN [TrzniPlan] TP ON RBPS.[Interval] = TP.[Interval]
                                                              AND Tp.[OsebaID] = RBPS.[OsebaID]
                                                WHERE   RBPS.[ObracunID] = @NewObracunID
                                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(TP.DatumSpremembe) )

                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN 
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors]
                                                        ( [Napaka] 
                                                        )
                                                VALUES  ( 'Napaka 009: Napaka pri kalkulaciji količinskega obračuna po bilančnih podskupinah.'
                                                        );
                                            END
                                        SET @Time2 = GETDATE();
                                        PRINT 'KolicinskaOdstopanjaPoBPS t= '
                                            + CAST(DATEDIFF(SECOND, @Time1,
                                                            @Time2) AS VARCHAR(100))

                                        SET @Time1 = GETDATE();
                                        INSERT  INTO [KolicinskaOdstopanjaPoBS]
                                                ( [Kolicina] ,
                                                  [VozniRed] ,
                                                  [Odstopanje] ,
                                                  [OsebaID] ,
                                                  [INTERVAL] ,
                                                  [ObracunID] ,
                                                  [KoregiranTP],
												  [Odjem],
												  [Oddaja]
                                                )
                                                SELECT  ISNULL(RBS.Kolicina, 0) ,
                                                        ISNULL(ROUND(Tp.Kolicina,1), 0) ,
                                                        (CASE WHEN TP.OsebaID <> 46 THEN (ISNULL(RBS.Kolicina, 0) - ISNULL(Tp.KoregiranTP,0) ) ELSE (ISNULL(ABS(RBS.Kolicina), 0) - ISNULL(ABS(Tp.KoregiranTP),0) )END),
                                                        TP.OsebaID ,
                                                        tp.Interval ,
                                                        @NewObracunID ,
                                                        ISNULL(Tp.KoregiranTP,
                                                              0),
														isnull(RBS.[Odjem],0),
														isnull(RBS.[Oddaja],0)
                                                FROM    [TrzniPlan] TP
                                                        JOIN [dbo].[Pogodba] P ON TP.[OsebaID] = P.[Partner2]
                                                              AND P.[PogodbaTipID] = @BP
                                                        LEFT JOIN [RealizacijaPoBS] RBS ON RBS.[Interval] = TP.[Interval]
                                                              AND Tp.[OsebaID] = RBS.[OsebaID]
                                                              AND RBS.[ObracunID] = @NewObracunID
                                                WHERE   TP.[Interval] >= @DatumIntervalaOD
                                                        AND TP.[Interval] < DATEADD(DAY,
                                                              1,
                                                              @DatumIntervalaDO)
                                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(TP.DatumSpremembe) )
                                                        AND ( @DatumStanjaBaze BETWEEN P.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(P.DatumSpremembe) )
                                                        AND ( @DatumVeljavnostiPodatkov BETWEEN p.VeljaOd
                                                              AND
                                                              dbo.infinite(p.VeljaDo) ) 

         
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors]
                                                        ( [Napaka] 
                                                        )
                                                VALUES  ( 'Napaka 010: Napaka pri kalkulaciji količinskega obračuna po bilančnih skupinah.'
                                                        );
                                            END 
                                        SET @Time2 = GETDATE();
                                        PRINT 'KolicinskaOdstopanjaPoBS t= '
                                            + CAST(DATEDIFF(SECOND, @Time1,
                                                            @Time2) AS VARCHAR(100))   
						
--					 TOLERANČNI PAS
                                        SET @Time1 = GETDATE();
                                        EXEC dbo.BilancniObracun_TolerancniPas @DatumStanjaBaze,
                                            @k, @NewObracunID,
                                            @NOErrorsOUT OUTPUT, @novk,
                                            @RegulacijskoObmocjSR,
                                            @TrgovecTipID,
                                            @ValidationErrorsXML OUTPUT,
                                            @ValidationErrorsDetailXML OUTPUT
              
                                        IF ( @NOErrorsOUT <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1;
                                                DECLARE @hdocVTC8 INT;
                                                DECLARE @xmlpath8 VARCHAR(255);
                                                SET @xmlpath8 = '/Root/Napake';
                                                EXEC sp_xml_preparedocument @hdocVTC8 OUTPUT,
                                                    @ValidationErrorsXML;

                                                INSERT  INTO #Errors
                                                        ( Napaka 
                                                        )
                                                        SELECT
                                                              Napaka
                                                        FROM  OPENXML(@hdocVTC8,@xmlpath8,2) WITH ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                                                        ORDER BY ErrorID ASC     
                                                EXEC sp_xml_removedocument @hdocVTC8
						
                                                SET @xmlpath8 = '/Root/ErrorDetail';
                                                EXEC sp_xml_preparedocument @hdocVTC8 OUTPUT,
                                                    @ValidationErrorsDetailXML;

                                                INSERT  INTO #ErrorDetail
                                                        ( ErrorDetail 
                                                        )
                                                        SELECT
                                                              ErrorDetail
                                                        FROM  OPENXML(@hdocVTC8,@xmlpath8,2) WITH ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                                                        ORDER BY ErrorID ASC     
                                                EXEC sp_xml_removedocument @hdocVTC8
				
                                            END
                                        SET @Time2 = GETDATE();
                                        PRINT 'BilancniObracun_TolerancniPas t= '
                                            + CAST(DATEDIFF(SECOND, @Time1,
                                                            @Time2) AS VARCHAR(100)) 
								--določanje cene odstopanj
					--ustvarjanje začasne tabele za te namene
                                        IF OBJECT_ID('#tmpCena') IS NOT NULL 
                                            DROP TABLE #tmpCena

                                        CREATE TABLE #tmpCena
                                            (
                                              INTERVAL DATETIME ,
                                              Cplus DECIMAL(24, 2) , --stara pravila
                                              Cminus DECIMAL(24, 2) ,--stara pravila
                                              SIPX DECIMAL(24, 2)
                                            )			
										
                                        IF OBJECT_ID('#AgregiranaIzravnava') IS NOT NULL 
                                            DROP TABLE #AgregiranaIzravnava

                                        CREATE TABLE #AgregiranaIzravnava
                                            (
                                              INTERVAL DATETIME ,
                                              Wp DECIMAL(18, 8) NOT NULL ,
                                              Wm DECIMAL(18, 8) NOT NULL ,
                                              Sp DECIMAL(18, 8) NOT NULL ,
                                              Sm DECIMAL(18, 8) NOT NULL
                                            )	
                                        SET @Time1 = GETDATE();
					                        
                                        INSERT  INTO #AgregiranaIzravnava
                                                ( INTERVAL ,
                                                  Wp ,
                                                  Wm ,
                                                  Sp ,
                                                  Sm
										        )
                                                SELECT  I.Interval ,
                                                        ( ISNULL(I.Wp, 0)
                                                          + RWp ) ,
                                                        ( ISNULL(I.Wm, 0)
                                                          + RWm ) ,
                                                        ( ISNULL(I.Sp, 0)
                                                          + RSp ) ,
                                                        ( ISNULL(I.Sm, 0)
                                                          + RSm )
                                                FROM    Izravnava I
                                                        LEFT JOIN ( SELECT
                                                              INTERVAL ,
                                                              SUM(ISNULL(SekRegP,
                                                              0)
                                                              + ISNULL(TerRegP,
                                                              0)) AS RWp ,
                                                              SUM(ISNULL(SekRegM,
                                                              0)
                                                              + ISNULL(TerRegM,
                                                              0)) RWm ,
                                                              SUM(ISNULL(SekRegSp,
                                                              0)
                                                              + ISNULL(TerRegSp,
                                                              0)) AS RSp ,
                                                              SUM(ISNULL(SekRegSm,
                                                              0)
                                                              + ISNULL(TerRegSm,
                                                              0)) AS RSm
                                                              FROM
                                                              dbo.Regulacija
                                                              WHERE
                                                              INTERVAL >= @DatumIntervalaOD
                                                              AND INTERVAL < DATEADD(DAY,
                                                              1,
                                                              @DatumIntervalaDO)
                                                              AND @DatumStanjaBaze BETWEEN [DatumVnosa]
                                                              AND
                                                              dbo.infinite(DatumSpremembe)
                                                              GROUP BY INTERVAL
                                                              ) R ON I.Interval = R.Interval
                                                WHERE   I.Interval >= @DatumIntervalaOD
                                                        AND I.Interval < DATEADD(DAY,
                                                              1,
                                                              @DatumIntervalaDO)
                                                        AND I.[DatumVnosa] < @DatumStanjaBaze
                                                        AND ( @DatumStanjaBaze BETWEEN I.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(I.DatumSpremembe) )
                                                                   		
                                        
										SET @Time2 = GETDATE();
                                        PRINT '#AgregiranaIzravnava t= '
                                            + CAST(DATEDIFF(SECOND, @Time1,
                                                            @Time2) AS VARCHAR(100)) 

                                        SET @Time1 = GETDATE();
                                        INSERT  INTO #tmpCena
                                                ( INTERVAL ,
                                                  Cplus ,
                                                  Cminus ,
                                                  SIPX
                                                )
                                                SELECT  I.Interval ,
                                                        ROUND(CAST(ISNULL(( CASE
                                                              WHEN Wp > 0
                                                              AND Wm = 0
                                                              THEN 1.03 * Sp
                                                              / NULLIF(Wp,0)
                                                              WHEN Wp = 0
                                                              AND Wm < 0
                                                              THEN 1.03
                                                              * ( CASE
                                                              WHEN C.Vrednost >= Sm
                                                              / NULLIF(Wm,0)
                                                              THEN C.Vrednost
                                                              ELSE Sm / NULLIF(Wm,0)
                                                              END )
                                                              WHEN Wp + Wm > 0
                                                              THEN 1.03 * Sp
                                                              / NULLIF(Wp,0)
                                                              WHEN Wp + Wm < 0
                                                              THEN 1.03
                                                              * ( CASE
                                                              WHEN ( CASE
                                                              WHEN C.Vrednost >= Sm
                                                              / NULLIF(Wm,0)
                                                              THEN C.Vrednost
                                                              ELSE Sm / NULLIF(Wm,0)
                                                              END ) < Sp / NULLIF(Wp,0)
                                                              THEN ( CASE
                                                              WHEN C.Vrednost >= Sm
                                                              / NULLIF(Wm,0)
                                                              THEN C.Vrednost
                                                              ELSE Sm / NULLIF(Wm,0)
                                                              END )
                                                              ELSE Sp / NULLIF(Wp,0)
                                                              END )
                                                              WHEN Wp + Wm = 0
                                                              THEN 1.03
                                                              * C.Vrednost
                                                              END ), 0) AS DECIMAL(18,
                                                              2)), 2) ,
                                                        ROUND(CAST(ISNULL(( CASE
                                                              WHEN Wp > 0
                                                              AND Wm = 0
                                                              THEN 0.97
                                                              * ( CASE
                                                              WHEN C.Vrednost < Sp
                                                              / NULLIF(Wp,0)
                                                              THEN C.Vrednost
                                                              ELSE Sp / NULLIF(Wp,0)
                                                              END )
                                                              WHEN Wp = 0
                                                              AND Wm < 0
                                                              THEN 0.97 * Sm
                                                              / NULLIF(Wm,0)
                                                              WHEN Wp + Wm > 0
                                                              THEN 0.97
                                                              * ( CASE
                                                              WHEN ( CASE
                                                              WHEN C.Vrednost < Sp
                                                              / NULLIF(Wp,0)
                                                              THEN C.Vrednost
                                                              ELSE Sp / NULLIF(Wp,0)
                                                              END ) >= Sm / NULLIF(Wm,0)
                                                              THEN ( CASE
                                                              WHEN C.Vrednost < Sp
                                                              / NULLIF(Wp,0)
                                                              THEN C.Vrednost
                                                              ELSE Sp / NULLIF(Wp,0)
                                                              END )
                                                              ELSE Sm / NULLIF(Wm,0)
                                                              END )
                                                              WHEN Wp + Wm < 0
                                                              THEN 0.97 * Sm
                                                              / NULLIF(Wm,0)
                                                              WHEN Wp + Wm = 0
                                                              THEN 0.97
                                                              * C.Vrednost
                                                              END ), 0) AS DECIMAL(18,
                                                              2)), 2) ,
                                                        ROUND(C.[Vrednost], 2)
                                                FROM    #AgregiranaIzravnava I
                                                        INNER JOIN [dbo].[SIPX] C ON I.Interval = C.Interval
                                                WHERE   I.Interval >= @DatumIntervalaOD
                                                        AND I.Interval < DATEADD(DAY,
                                                              1,
                                                              @DatumIntervalaDO)
                                                        
													
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors]
                                                        ( [Napaka] 
                                                        )
                                                VALUES  ( 'Napaka 013: Napaka pri izračunu izhodiščnih cen.'
                                                        );
                                            END

                                        UPDATE  [#tmpCena]
                                        SET     [Cplus] = [Cminus]
                                        WHERE   [Cplus] < [Cminus]        

                                        SET @Time2 = GETDATE();
                                        PRINT '#tmpCena t= '
                                            + CAST(DATEDIFF(SECOND, @Time1,
                                                            @Time2) AS VARCHAR(100)) 

                                        SET @Time1 = GETDATE();
                                        SELECT  P.[Partner2]
                                        INTO    #OsebeZaSaldoObdobja
                                        FROM    [dbo].[Pogodba] P
                                                JOIN [dbo].[Oseba] O ON P.[Partner2] = O.[OsebaID]
                                                JOIN [dbo].[OsebaZCalc] ZC ON P.[Partner2] = ZC.[OsebaID]
                                                JOIN [dbo].[OsebaZId] Z ON ZC.[OsebaZID] = Z.[OsebaZId]
                                                              AND Z.[OsebaZId] <> 5
                                        WHERE   P.[PogodbaTipID] = @BP
                                                AND ( @DatumVeljavnostiPodatkov BETWEEN p.VeljaOd
                                                              AND
                                                              dbo.infinite(p.VeljaDo) )
                                                AND ( @DatumStanjaBaze BETWEEN P.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(P.DatumSpremembe) )
                                                AND ( @DatumVeljavnostiPodatkov BETWEEN o.VeljaOd
                                                              AND
                                                              dbo.infinite(o.VeljaDo) )
                                                AND ( @DatumStanjaBaze BETWEEN o.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(o.DatumSpremembe) )
                                                AND ( @DatumStanjaBaze BETWEEN ZC.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(ZC.DatumSpremembe) )                     
												
                                        SELECT  K.[Interval] ,
                                                SUM(K.[Odstopanje]) AS Odstopanje ,
                                                SUM(ISNULL(Tp.[KoregiranTP], 0)) AS TrzniPlan ,
                                                ROUND(SUM(Odjem - [Oddaja]),3) AS Realizacija ,
                                                SUM(CASE WHEN K.[Odstopanje] > 0
                                                         THEN K.[Odstopanje]
                                                         ELSE 0
                                                    END) AS Wgjs_p ,
                                                SUM(CASE WHEN K.[Odstopanje] < 0
                                                         THEN K.[Odstopanje]
                                                         ELSE 0
                                                    END) AS Wgjs_m ,
                                                K.[OsebaID]
                                        INTO    #GJS
                                        FROM    [dbo].[Oseba] O
                                                JOIN [dbo].[OsebaZCalc] OZ ON O.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                                              AND OZT.[Sifra] = 'GJS'
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] K ON K.[ObracunID] = @NewObracunID
                                                              AND O.[OsebaID] = K.[OsebaID]
                                                LEFT JOIN [dbo].[TrzniPlan] TP ON K.[OsebaID] = TP.[OsebaID]
                                                              AND K.[Interval] = TP.[Interval]
                                        WHERE   @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(OZ.DatumSpremembe)
                                                AND @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(TP.DatumSpremembe)
                                                AND @DatumStanjaBaze BETWEEN O.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(O.DatumSpremembe)
                                                AND ( @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd
                                                              AND
                                                              dbo.infinite(O.VeljaDo) )
                                        GROUP BY K.[Interval] ,
                                                K.[OsebaID]
										
										
										                 
                                        SELECT  K.[Interval] ,
                                                SUM(CASE WHEN K.[Odstopanje] > 0
                                                         THEN K.[Odstopanje]
                                                         ELSE 0
                                                    END) AS W_p ,
                                                SUM(CASE WHEN K.[Odstopanje] < 0
                                                         THEN K.[Odstopanje]
                                                         ELSE 0
                                                    END) AS W_m ,
                                                K.[OsebaID]
                                        INTO    #NonGJS
                                        FROM    [dbo].[Oseba] O
                                                JOIN [dbo].[OsebaZCalc] OZ ON O.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                                              AND UPPER(OZT.[Sifra]) <> 'GJS'
                                                              AND UPPER(OZT.[Sifra]) <> 'ME'
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] K ON K.[ObracunID] = @NewObracunID
                                                              AND O.[OsebaID] = K.[OsebaID]
                                                LEFT JOIN [dbo].[TrzniPlan] TP ON K.[OsebaID] = TP.[OsebaID]
                                                              AND K.[Interval] = TP.[Interval]
                                        WHERE   @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(OZ.DatumSpremembe)
                                                AND @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(TP.DatumSpremembe)
                                                AND @DatumStanjaBaze BETWEEN O.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(O.DatumSpremembe)
                                                AND ( @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd
                                                              AND
                                                              dbo.infinite(O.VeljaDo) )
                                        GROUP BY K.[Interval] ,
                                                K.[OsebaID]
								                            
                                        SET @Time2 = GETDATE();
                                        PRINT '#tmp#OsebeZaSaldoObdobja in GJS  t= '
                                            + CAST(DATEDIFF(SECOND, @Time1,
                                                            @Time2) AS VARCHAR(100)) 
												
												
                                        SET @Time1 = GETDATE();
                                        INSERT  INTO [dbo].[PodatkiObracuna_Skupni]
                                                ( [ObracunID] ,
                                                  [INTERVAL] ,
                                                  [W+] ,
                                                  [W-] ,
                                                  [S+] ,
                                                  [S-] ,
                                                  [SroskiIzravnave]
										   
                                                )
                                                SELECT  @NewObracunID ,
                                                        I.[Interval] ,
                                                        SUM(ISNULL(I.Wp, 0)) ,
                                                        SUM(ISNULL(I.Wm, 0)) ,
                                                        SUM(ISNULL(I.Sp, 0)) ,
                                                        SUM(ISNULL(I.Sm, 0)) ,
                                                        SUM(ISNULL(I.Sp, 0)
                                                            + ISNULL(I.Sm, 0))--[SroskiIzravnave]
                                                FROM    [#AgregiranaIzravnava] I
                                                WHERE   I.Interval >= @DatumIntervalaOD
                                                        AND I.Interval < DATEADD(DAY,
                                                              1,
                                                              @DatumIntervalaDO)
                                                GROUP BY I.Interval   
               
                                      
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors]
                                                        ( [Napaka] 
                                                        )
                                                VALUES  ( 'Napaka 0132: Napaka pri inicializacij skupnih parametrov obračna'
                                                        );
                                            END
										
                                        UPDATE  PodatkiObracuna_Skupni
                                        SET     PodatkiObracuna_Skupni.TP_GJS = ROUND(P1.TP_GJS,
                                                              1) ,
                                                PodatkiObracuna_Skupni.Realizacija_GJS = ROUND(P1.Realizacija_GJS,
                                                              3) ,
                                                PodatkiObracuna_Skupni.Odstopanje_GJS = ROUND(P1.Odstopanje_GJS,
                                                              3) ,
                                                PodatkiObracuna_Skupni.[Wgjs_p] = ROUND(P1.[Wgjs_p],
                                                              3) ,
                                                PodatkiObracuna_Skupni.[Wgjs_m] = ROUND(P1.[Wgjs_m],
                                                              3)
                                        FROM    ( SELECT    ISNULL(SUM(ISNULL(G.TrzniPlan,
                                                              0)), 0) AS TP_GJS ,
                                                            SUM(G.Realizacija) AS Realizacija_GJS ,
                                                            SUM(G.Odstopanje) AS Odstopanje_GJS ,
                                                            SUM(G.[Wgjs_p]) AS Wgjs_p ,
                                                            SUM(G.[Wgjs_m]) AS Wgjs_m ,
                                                            G.[Interval]
                                                  FROM      PodatkiObracuna_Skupni P
                                                            JOIN #GJS G ON P.Interval = G.Interval
                                                  WHERE     P.[ObracunID] = @NewObracunID
                                                  GROUP BY  G.Interval
                                                ) P1
                                        WHERE   PodatkiObracuna_Skupni.[Interval] = P1.Interval
                                                AND PodatkiObracuna_Skupni.[ObracunID] = @NewObracunID
                                      
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors]
                                                        ( [Napaka] 
                                                        )
                                                VALUES  ( 'Napaka 0131: Napaka pri izračunu odstopanj GJS.'
                                                        );
                                            END
                              
                      
                                     
                                        UPDATE  P
                                        SET     P.[C+] = ROUND(T.Cplus, 2) ,
                                                P.[C-] = ROUND(T.Cminus, 2) ,
                                                P.[C+'] = ROUND(T.Cplus, 2) ,
                                                P.[C-'] = ROUND(T.Cminus, 2) ,
                                                P.SIPXurni = ROUND(T.SIPX, 2)
                                        FROM    PodatkiObracuna_Skupni P
                                                JOIN [#tmpCena] T ON P.Interval = T.Interval
                                        WHERE   ObracunID = @NewObracunID

                                        UPDATE  PodatkiObracuna_Skupni
                                        SET     PodatkiObracuna_Skupni.Wplusi = ROUND(P1.Wpi,
                                                              3) ,
                                                PodatkiObracuna_Skupni.Wminusi = ROUND(P1.Wmi,
                                                              3)
                                        FROM    ( SELECT    SUM(G.[W_p]) AS Wpi ,
                                                            SUM(G.[W_m]) AS Wmi ,
                                                            G.[Interval]
                                                  FROM      PodatkiObracuna_Skupni P
                                                            JOIN #NonGJS G ON P.Interval = G.Interval
                                                  WHERE     P.[ObracunID] = @NewObracunID
                                                  GROUP BY  G.Interval
                                                ) P1
                                        WHERE   PodatkiObracuna_Skupni.[Interval] = P1.Interval
                                                AND [dbo].[PodatkiObracuna_Skupni].[ObracunID] = @NewObracunID
                                      
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors]
                                                        ( [Napaka] 
                                                        )
                                                VALUES  ( 'Napaka 01345: Napaka pri izračunu odstopanj NE GJS.'
									                        
                                                        );
                                            END
		
                              
                                  
                                        UPDATE  PodatkiObracuna_Skupni
                                        SET     PodatkiObracuna_Skupni.SaldoStroskiObracunov = ISNULL(ROUND(O.Saldo,
                                                              2), 0) ,
                                                PodatkiObracuna_Skupni.SkupnaOdstopanja = ROUND(O.SkupnaOdstopanja,
                                                              3) ,
                                                PodatkiObracuna_Skupni.Razlika = ROUND(ISNULL(O.Saldo,
                                                              0), 2)
                                                - ROUND(PodatkiObracuna_Skupni.SroskiIzravnave,
                                                        2)
                                        FROM    ( SELECT    SUM(CASE
                                                              WHEN ISNULL(R.[Odstopanje],
                                                              0) > 0
                                                              THEN ROUND(ISNULL(R.[Odstopanje],
                                                              0)
                                                              * ROUND(P1.[C+]
                                                              / NULLIF(( CASE
                                                              WHEN OZT.Sifra = 'GJS'
                                                              THEN 1.03
                                                              ELSE 1.00
                                                              END ),0), 2), 2)
                                                              ELSE ROUND(ISNULL(R.[Odstopanje],
                                                              0)
                                                              * ROUND(P1.[C-]
                                                              / NULLIF(( CASE
                                                              WHEN OZT.Sifra = 'GJS'
                                                              THEN 0.97
                                                              ELSE 1.00
                                                              END ),0), 2), 2)
                                                              END) AS Saldo ,
                                                            SUM(ISNULL(R.[Odstopanje],
                                                              0)) AS SkupnaOdstopanja ,
                                                            R.Interval
                                                  FROM      [#OsebeZaSaldoObdobja] S
                                                            JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                                              AND R.[ObracunID] = @NewObracunID
                                                            JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                                                              AND P1.[ObracunID] = @NewObracunID
                                                            JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                                            JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                                  WHERE     R.[ObracunID] = @NewObracunID
                                                            AND P1.[ObracunID] = @NewObracunID
                                                            AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(OZ.DatumSpremembe)
                                                  GROUP BY  R.Interval
                                                ) O
                                        WHERE   PodatkiObracuna_Skupni.ObracunID = @NewObracunID
                                                AND PodatkiObracuna_Skupni.[Interval] = O.Interval
                                                 
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors]
                                                        ( [Napaka] 
                                                        )
                                                VALUES  ( 'Napaka 0512: Napaka pri inicilaizaciji skupnih saldov obračunov, razlike in skupnih odstopanj.'
                                                        );
                                            END
                                        SET @Time2 = GETDATE();
                                        PRINT '[PodatkiObracuna_Skupni]  t= '
                                            + CAST(DATEDIFF(SECOND, @Time1,
                                                            @Time2) AS VARCHAR(100)) 	
                                     --KOREKCIJA 
                                        SET @Time1 = GETDATE();
                                        EXEC dbo.BilancniObracun_Korekcija @DatumIntervalaDO = @DatumIntervalaDO,
                                            @DatumIntervalaOD = @DatumIntervalaOD,
                                            @DatumStanjaBaze = @DatumStanjaBaze,
                                            @DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
                                            @NewObracunID = @NewObracunID,
                                            @NOErrors = @NOErrorsOUT OUTPUT,
                                            @ErrorHeadXML = @ValidationErrorsXML OUTPUT,
                                            @ErrorDetailsXML = @ValidationErrorsDetailXML OUTPUT
   							
                                        DECLARE @CenaIzravnave DECIMAL(24, 8);
                                        DECLARE @SaldoOsnovnihObracunov DECIMAL(24,
                                                              8);
        		       						
                                        SELECT  @CenaIzravnave = SUM(SroskiIzravnave) ,
                                                @SaldoOsnovnihObracunov = SUM(SaldoStroskiObracunov)
                                        FROM    PodatkiObracuna_Skupni
                                        WHERE   [ObracunID] = @NewObracunID 

                                        DROP TABLE #OsebeZaSaldoObdobja
                                        SET @Time2 = GETDATE();
                                        PRINT 'BilancniObracun_Korekcija  t= '
                                            + CAST(DATEDIFF(SECOND, @Time1,
                                                            @Time2) AS VARCHAR(100)) 
										--CENA ODSTOPANJ
                                            

                                        SET @Time1 = GETDATE();
                                        INSERT  INTO [PodatkiObracuna]
                                                ( [ObracunID] ,
                                                  [OsebaID] ,
                                                  [INTERVAL] ,
                                                  [TolerancniPas] ,
                                                  [Odstopanje] ,
                                                  [Cplus] ,--stara pravila
                                                  [Cminus] ,--stara pravila
                                                  [CpNov] ,--OBSOLETE
                                                  [CnNov] ,--OBSOLETE
                                                  Ckplus ,
                                                  Ckminus ,
                                                  Zplus ,--stara pravila
                                                  Zminus ,--stara pravila
                                                  [PoravnavaZunajT] ,--stara pravila
                                                  [PoravnavaZnotrajT]--stara pravila
                                                )
                                                SELECT  @NewObracunID ,
                                                        T.[OsebaID] ,
                                                        T.[Interval] ,
                                                        ISNULL(TP.[KoregiranT],
                                                              0) ,
                                                        K.Odstopanje ,
                                                        P.[C+] ,--stara pravila
                                                        P.[C-] ,--stara pravila
                                                        P.[C+'] , --C+'
                                                        P.[C-'] , --C-'
                                                        ROUND(( CASE
                                                              WHEN Z.Sifra <> 'GJS'
                                                              THEN ( CASE
                                                              WHEN K.Odstopanje <= TP.[KoregiranT]
                                                              THEN 0.0
                                                              WHEN TP.[KoregiranT] < K.Odstopanje
                                                              AND K.Odstopanje <= 4
                                                              * TP.[KoregiranT]
                                                              THEN ROUND(POWER(( ( K.Odstopanje
                                                              - TP.[KoregiranT] )
                                                              / NULLIF(( 3
                                                              * TP.[KoregiranT] ),0) ),
                                                              2) * P.[C+'], 2)
                                                              WHEN 4
                                                              * TP.[KoregiranT] < K.Odstopanje
                                                              THEN P.[C+']
                                                              END )
                                                              ELSE 0.0 --GJS
                                                              END ), 2) , --Ck+
                                                        ROUND(( CASE
                                                              WHEN Z.Sifra <> 'GJS'
                                                              THEN ( CASE
                                                              WHEN -1
                                                              * TP.[KoregiranT] <= K.Odstopanje
                                                              THEN 0
                                                              WHEN -4
                                                              * TP.[KoregiranT] <= K.Odstopanje
                                                              AND K.Odstopanje < -1
                                                              * TP.[KoregiranT]
                                                              THEN ROUND(POWER(( ( K.Odstopanje
                                                              + TP.[KoregiranT] )
                                                              / NULLIF(( 3
                                                              * TP.[KoregiranT] ),0) ),
                                                              2) * P.[C-'], 2)
                                                              WHEN K.Odstopanje < -4
                                                              * TP.[KoregiranT]
                                                              THEN P.[C-']
                                                              END )
                                                              ELSE 0.0 --GJS
                                                              END ), 2) , --Ck-
                                                        ( CASE
                                                              WHEN Z.Sifra <> 'GJS'
                                                              THEN ( CASE
                                                              WHEN ( K.Odstopanje > 0
                                                              AND K.Odstopanje < TP.[KoregiranT]
                                                              )
                                                              OR ( K.[Odstopanje] > 0
                                                              AND K.[Odstopanje] > TP.[KoregiranT]
                                                              AND P.[C+] < 0
                                                              )
                                                              THEN ROUND(P.[C+]
                                                              * K.Odstopanje,
                                                              2)
                                                              WHEN K.[Odstopanje] > 0
                                                              AND K.[Odstopanje] > TP.[KoregiranT]
                                                              AND P.[C+] > 0
                                                              THEN ROUND(( P.[C+]
                                                              * K.Odstopanje )
                                                              + ( K.[Odstopanje]
                                                              - TP.[KoregiranT] )
                                                              * ROUND(( CASE
                                                              WHEN K.Odstopanje <= TP.[KoregiranT]
                                                              THEN 0.0
                                                              WHEN TP.[KoregiranT] < K.Odstopanje
                                                              AND K.Odstopanje <= 4
                                                              * TP.[KoregiranT]
                                                              THEN POWER(( ( K.Odstopanje
                                                              - TP.[KoregiranT] )
                                                              / NULLIF(( 3
                                                              * TP.[KoregiranT] ),0) ),
                                                              2) * P.[C+']
                                                              WHEN 4
                                                              * TP.[KoregiranT] < K.Odstopanje
                                                              THEN P.[C+']
                                                              END ), 2), 2) --Ck+
                                                              ELSE 0.0
                                                              END )
                                                              ELSE ( CASE
                                                              WHEN K.[Odstopanje] > 0
                                                              THEN ROUND(P.[C+GJS]
                                                              * K.Odstopanje,
                                                              2)
                                                              ELSE ROUND(P.[C-GJS]
                                                              * K.Odstopanje,
                                                              2)
                                                              END )--GJS
                                                          END ) ,--Zplus --zotraj T poravnava POZITIVNA
                                                        ( CASE
                                                              WHEN Z.Sifra <> 'GJS'
                                                              THEN ( CASE
                                                              WHEN ( K.Odstopanje < 0
                                                              AND K.Odstopanje < TP.[KoregiranT]
                                                              )
                                                              OR ( K.[Odstopanje] < 0
                                                              AND K.[Odstopanje] > TP.[KoregiranT]
                                                              AND P.[C-] < 0
                                                              )
                                                              THEN ROUND(P.[C-]
                                                              * K.Odstopanje,
                                                              2)
                                                              WHEN K.[Odstopanje] < 0
                                                              AND K.[Odstopanje] > TP.[KoregiranT]
                                                              AND P.[C-'] > 0
                                                              THEN ROUND(( P.[C-']
                                                              * K.Odstopanje )
                                                              - ( K.[Odstopanje]
                                                              + TP.[KoregiranT] )
                                                              * ROUND(( CASE
                                                              WHEN -1
                                                              * TP.[KoregiranT] <= K.Odstopanje
                                                              THEN 0
                                                              WHEN -4
                                                              * TP.[KoregiranT] <= K.Odstopanje
                                                              AND K.Odstopanje < -1
                                                              * TP.[KoregiranT]
                                                              THEN POWER(( ( K.Odstopanje
                                                              + TP.[KoregiranT] )
                                                              / NULLIF(( 3
                                                              * TP.[KoregiranT] ),0) ),
                                                              2) * P.[C-']
                                                              WHEN K.Odstopanje < -4
                                                              * TP.[KoregiranT]
                                                              THEN P.[C-']
                                                              END ), 2), 2)  --Ck-
                                                              ELSE 0.0
                                                              END )
                                                              ELSE ( CASE
                                                              WHEN K.[Odstopanje] > 0
                                                              THEN ROUND(P.[C+GJS]
                                                              * K.Odstopanje,
                                                              2)
                                                              ELSE ROUND(P.[C-GJS]
                                                              * K.Odstopanje,
                                                              2)
                                                              END )--GJS --GJS
                                                          END ) ,--zMinus --zotraj T poravnava negativna
                                                        ( CASE
                                                              WHEN Z.Sifra <> 'GJS'
                                                              AND OTID.Sifra <> 'TRG'
                                                              THEN ( CASE
                                                              WHEN K.Odstopanje > 0
                                                              THEN ( CASE
                                                              WHEN P.[C+'] < 0
                                                              THEN ROUND(K.Odstopanje
                                                              * P.[C+'], 2)
                                                              ELSE ROUND(( K.Odstopanje
                                                              - TP.KoregiranT )
                                                              * ( ROUND(( CASE
                                                              WHEN K.Odstopanje <= TP.[KoregiranT]
                                                              THEN 0.0
                                                              WHEN TP.[KoregiranT] < K.Odstopanje
                                                              AND K.Odstopanje <= 4
                                                              * TP.[KoregiranT]
                                                              THEN POWER(( ( K.Odstopanje
                                                              - TP.[KoregiranT] )
                                                              / NULLIF(( 3
                                                              * TP.[KoregiranT] ),0) ),
                                                              2) * P.[C+']
                                                              WHEN 4
                                                              * TP.[KoregiranT] < K.Odstopanje
                                                              THEN P.[C+']
                                                              END ), 2) /*--Ck+*/
                                                              + ROUND(( CASE
                                                              WHEN -1
                                                              * TP.[KoregiranT] <= K.Odstopanje
                                                              THEN 0
                                                              WHEN -4
                                                              * TP.[KoregiranT] <= K.Odstopanje
                                                              AND K.Odstopanje < -1
                                                              * TP.[KoregiranT]
                                                              THEN POWER(( ( K.Odstopanje
                                                              + TP.[KoregiranT] )
                                                              / NULLIF(( 3
                                                              * TP.[KoregiranT] ),0) ),
                                                              2) * P.[C-']
                                                              WHEN K.Odstopanje < -4
                                                              * TP.[KoregiranT]
                                                              THEN P.[C-']
                                                              END ), 2)/*--Ck-*/
                                                              ), 2)/*--Ck-*/
                                                              END )
                                                              ELSE ( CASE
                                                              WHEN P.[C-'] < 0
                                                              THEN ROUND(P.[C-']
                                                              * K.Odstopanje,
                                                              2)
                                                              ELSE ROUND(( -1
                                                              * ( K.Odstopanje
                                                              + TP.KoregiranT ) )
                                                              * ( ROUND(( CASE
                                                              WHEN K.Odstopanje <= TP.[KoregiranT]
                                                              THEN 0.0
                                                              WHEN TP.[KoregiranT] < K.Odstopanje
                                                              AND K.Odstopanje <= 4
                                                              * TP.[KoregiranT]
                                                              THEN POWER(( ( K.Odstopanje
                                                              - TP.[KoregiranT] )
                                                              / NULLIF(( 3
                                                              * TP.[KoregiranT] ),0) ),
                                                              2) * P.[C+']
                                                              WHEN 4
                                                              * TP.[KoregiranT] < K.Odstopanje
                                                              THEN P.[C+']
                                                              END ), 2) /*--Ck+*/
                                                              + ROUND(( CASE
                                                              WHEN -1
                                                              * TP.[KoregiranT] <= K.Odstopanje
                                                              THEN 0
                                                              WHEN -4
                                                              * TP.[KoregiranT] <= K.Odstopanje
                                                              AND K.Odstopanje < -1
                                                              * TP.[KoregiranT]
                                                              THEN POWER(( ( K.Odstopanje
                                                              + TP.[KoregiranT] )
                                                              / NULLIF(( 3
                                                              * TP.[KoregiranT] ),0) ),
                                                              2) * P.[C-']
                                                              WHEN K.Odstopanje < -4
                                                              * TP.[KoregiranT]
                                                              THEN P.[C-']
                                                              END ), 2)/*--Ck-*/
                                                              ), 2)
                                                              END )
                                                              END )
                                                              WHEN Z.Sifra <> 'GJS'
                                                              AND OTID.Sifra = 'TRG'
                                                              THEN ( CASE
                                                              WHEN K.Odstopanje >= 0
                                                              AND P.[C+'] > 0
                                                              THEN ROUND(K.Odstopanje
                                                              * P.[C+'], 2)
                                                              WHEN K.Odstopanje < 0
                                                              AND P.[C-'] < 0
                                                              THEN ROUND(-1
                                                              * K.Odstopanje
                                                              * P.[C-'], 2)
                                                              ELSE 0
                                                              END )
                                                              ELSE 0.0 --GJS
                                                          END ) ,	--PoravnavaZunajT == PENALIZACIJA
                                                        ( CASE
                                                              WHEN Z.Sifra <> 'GJS'
                                                              AND OTID.Sifra <> 'TRG'
														      THEN
															     ( CASE
																  WHEN K.Odstopanje > 0
																  THEN ROUND(K.Odstopanje
																  * P.[C+'], 2)
																  ELSE ROUND(K.Odstopanje
																  * P.[C-'], 2)
																  END )
                                                              WHEN Z.Sifra <> 'GJS'
                                                              AND OTID.Sifra = 'TRG'
															  THEN 
																  ( CASE
																  WHEN K.Odstopanje >= 0 AND P.[C+'] > 0 THEN ROUND(2*K.Odstopanje* P.[C+'], 2)
																  WHEN K.Odstopanje >= 0 AND P.[C+'] < 0 THEN 0
																  WHEN K.Odstopanje < 0	 AND P.[C-'] < 0 THEN ROUND(2*K.Odstopanje* P.[C-'], 2)
																  ELSE 0
																  END )
															 ELSE 
																  ( CASE
																  WHEN K.[Odstopanje] > 0
																  THEN ROUND(P.[C+GJS]
																  * K.Odstopanje,
																  2)
																  ELSE ROUND(P.[C-GJS]
																  * K.Odstopanje,
																  2)
																  END )--GJS 
                                                          END )  --PoravnavaZnotrajT == OSNOVNI OBRAČUN
                                                FROM    [TrzniPlan] T
                                                        INNER JOIN [dbo].[PodatkiObracuna_Skupni] P ON P.[ObracunID] = @NewObracunID
                                                              AND T.[Interval] = P.[Interval]
                                                        INNER JOIN [KolicinskaOdstopanjaPoBS] K ON K.[ObracunID] = @NewObracunID
                                                              AND T.OsebaID = K.OsebaID
                                                              AND T.Interval = K.Interval
                                                        LEFT JOIN [TolerancniPas] TP ON TP.[OsebaID] = T.OsebaID
                                                              AND TP.[ObracunID] = @NewObracunID
                                                              AND TP.[Interval] = T.[Interval]
                                                        --LEFT JOIN [Izravnava] I ON ( T.Interval = I.Interval
                                                        --                             AND T.OsebaID = I.OsebaID
                                                        --                             AND ( @DatumStanjaBaze BETWEEN I.[DatumVnosa]
                                                        --                                                    AND     dbo.infinite(I.DatumSpremembe) )
                                                        --                           )
                                                        LEFT JOIN dbo.Izpadi Izp ON Izp.interval = T.interval
                                                              AND Izp.OsebaID = Tp.osebaID
                                                              AND ( @DatumStanjaBaze BETWEEN Izp.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(Izp.DatumSpremembe) )
                                                        LEFT JOIN dbo.OsebaTip OT ON T.OsebaID = OT.OsebaID
                                                              AND ( @DatumStanjaBaze BETWEEN OT.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(OT.DatumSpremembe) )
                                                        LEFT JOIN [dbo].[OsebaTipID] OTID ON OTID.[OsebaTipID] = OT.[OsebaTipID]
                                                        LEFT JOIN [dbo].[OsebaZCalc] ZC ON T.[OsebaID] = ZC.[OsebaID]
                                                              AND ( @DatumStanjaBaze BETWEEN ZC.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(ZC.DatumSpremembe) )
                                                        LEFT JOIN [dbo].[OsebaZId] Z ON ZC.[OsebaZID] = Z.[OsebaZId]
                                                WHERE   T.Interval >= @DatumIntervalaOD
                                                        AND T.Interval < DATEADD(DAY,
                                                              1,
                                                              @DatumIntervalaDO)
                                                        AND K.[ObracunID] = @NewObracunID
                                                        AND ( @DatumStanjaBaze BETWEEN T.[DatumVnosa]
                                                              AND
                                                              dbo.infinite(T.DatumSpremembe) )
                                                ORDER BY Tp.[Interval] ASC 
                      	                      
						
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors]
                                                        ( [Napaka] 
                                                        )
                                                VALUES  ( 'Napaka 014: Napaka pri izvajanju bilančnega obračuna.'
                                                        );
                                            END
                                        SET @Time2 = GETDATE();
                                        PRINT '[PodatkiObracuna]  t= '
                                            + CAST(DATEDIFF(SECOND, @Time1,
                                                            @Time2) AS VARCHAR(100)) 
                                                                                  
                                    END --imamo vse podatke za obračun ..@CriticalError = 0
	
				
                            END --imamo podatke za obraun
                        ELSE 
                            BEGIN
                                INSERT  INTO [#Errors]
                                        ( [Napaka] 
                                        )
                                VALUES  ( 'Napaka 000: Ni podatkov za obračun (meritve).'
                                        );
                                SET @ValidationErrorsXML = ( SELECT
                                                              *
                                                             FROM
                                                              #Errors
                                                           FOR
                                                             XML
                                                              PATH('Napake') ,
                                                              ROOT('Root')
                                                           )
                                SET @NewObracunID = -10
                            END
                    END--end obračUN
                ELSE 
                    BEGIN
			--error
                        INSERT  INTO [#Errors]
                                ( [Napaka] 
                                )
                        VALUES  ( 'Napaka 000: Napačni vhodni parametri.'
                                );
                        SET @ValidationErrorsXML = ( SELECT *
                                                     FROM   #Errors
                                                   FOR
                                                     XML PATH('Napake') ,
                                                         ROOT('Root')
                                                   )
                        SET @NewObracunID = -1
                    END

		
      --REVIZIJA
                --IF ( @debugMode > 0 ) 
                --    PRINT 'Revizijska Sled'
                --EXEC dbo.BilancniObracun_RevizijskaSled @DatumIntervalaDO,
                --    @DatumIntervalaOD, @DatumStanjaBaze,
                --    @DatumVeljavnostiPodatkov, @NewObracunID,
                --    @NOErrorsOUT OUTPUT, @ObracunskoObdobjeID, @Bs,
                --    @ValidationErrorsXML, @ValidationErrorsDetailXML 

                --IF ( @NOErrorsOUT <> 0 ) 
                --    BEGIN
                --        SET @NOErrors = @NOErrors + 1 ;
                --        DECLARE @hdocVTC3 INT ;
                --        DECLARE @xmlpath3 VARCHAR(255) ;
                --        SET @xmlpath3 = '/Root/Napake' ;
                --        EXEC sp_xml_preparedocument @hdocVTC3 OUTPUT,
                --            @ValidationErrorsXML ;

                --        INSERT  INTO #Errors ( Napaka )
                --                SELECT  Napaka
                --                FROM    OPENXML(@hdocVTC3,@xmlpath3,2) WITH ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                --                ORDER BY ErrorID ASC     
                --        EXEC sp_xml_removedocument @hdocVTC3
						
                --        SET @xmlpath3 = '/Root/ErrorDetail' ;
                --        EXEC sp_xml_preparedocument @hdocVTC3 OUTPUT,
                --            @ValidationErrorsDetailXML ;

                --        INSERT  INTO #ErrorDetail ( ErrorDetail )
                --                SELECT  ErrorDetail
                --                FROM    OPENXML(@hdocVTC3,@xmlpath3,2) WITH ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                --                ORDER BY ErrorID ASC     
                --        EXEC sp_xml_removedocument @hdocVTC3
				
                --    END
                --IF ( @debugMode > 0 ) 
                --    PRINT 'Revizijska Sled - END'
		--REVIZIJA END
		
            END --KONTROLA VHODNIH PODATKOV ok


        IF ( @NOErrors <> 0 ) 
            BEGIN
                SET @ValidationErrorsXML = ( SELECT *
                                             FROM   #Errors
                                           FOR
                                             XML PATH('Napake') ,
                                                 ROOT('Root')
                                           )
                IF ( SELECT COUNT(*)
                     FROM   [#ErrorDetail]
                   ) > 0 
                    SET @ValidationErrorsDetailXML = ( SELECT *
                                                       FROM   [#ErrorDetail]
                                                     FOR
                                                       XML PATH('ErrorDetail') ,
                                                           ROOT('Root')
                                                     )
                SET @NewObracunID = -3;										
            END

        IF OBJECT_ID('tempDB..#Errors') IS NOT NULL 
            DROP TABLE #Errors
 

        IF EXISTS ( SELECT  name
                    FROM    sys.indexes
                    WHERE   name = N'IX_KorekcijaTP' ) 
            DROP INDEX IX_KorekcijaTP ON #KorekcijaTP;

        IF OBJECT_ID('#KorekcijaTP') IS NOT NULL 
            DROP TABLE #KorekcijaTP
    

        

		
	

        IF ( @NOErrors = 0 ) 
            BEGIN 
                COMMIT TRANSACTION OBRACUN
            END 
        ELSE 
            BEGIN
                ROLLBACK TRANSACTION OBRACUN
            END
  
        SET @Time1 = GETDATE();
        IF ( @NOErrors = 0 ) 
            EXEC dbo.BilancniObracun_UpdateData_DW @DatumIntervalaDO = @DatumIntervalaDO,
                @DatumIntervalaOD = @DatumIntervalaOD,
                @DatumStanjaBaze = @DatumStanjaBaze,
                @DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
                @ObracunID = @NewObracunID 
        SET @Time2 = GETDATE();
        PRINT '[BilancniObracun_UpdateData_DW]  t= '
            + CAST(DATEDIFF(SECOND, @Time1, @Time2) AS VARCHAR(100)) 

        RETURN @NewObracunID

    END

GO
