USE [IBIS2]
GO

EXEC dbo.DropPRCorUDF @ObjectName = 'BilnacniObracun'
GO

-- ==============================================================
-- Author:		<MashUp Miloš Cigoj s.p., milos.cigoj@mashup.si>
-- Create date: <8.8.2008(Korona d.d.), edited date : 26.04.2012 
-- ==============================================================

CREATE PROCEDURE [dbo].[BilnacniObracun]
    @ObracunskoObdobjeID INT,
    @DatumVeljavnostiPodatkov DATETIME = GETDATE,
    @DatumStanjaBaze DATETIME = GETDATE,
    @Avtor INT,
    @ObracunID INT OUTPUT,
    @Naziv VARCHAR(50),
    @obracun INT =0,
    @Bs XML = NULL, --seznam BS za obraèun
    @ValidationErrorsXML XML = '' OUTPUT, --glave napak
    @ValidationErrorsDetailXML XML = '' OUTPUT, --vrstice posamezne napake
    @debugMode INT = 0
AS 
    BEGIN

        SET ANSI_WARNINGS, ARITHABORT ON

        
                                        
        DECLARE @NewObracunID INT
        DECLARE @DatumIntervalaOD DATETIME
        DECLARE @DatumIntervalaDO DATETIME
        DECLARE @VsotaT DECIMAL(18, 8) --vsota toleranènih pasov BS
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
        SET @novk = 0.02 ; -- TO-DO:READ FROM SETTINGS

        SET @NOErrors = 0 ;
        SET @NOErrorsOUT = 0 ;
        SET @NewObracunID = -1 ;

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
        DECLARE @ValiodationErrors INT ;


	--TIP OSEBE
        DECLARE @SodoTipID INT
        DECLARE @SOPOTipID INT
        DECLARE @TrgovecTipID INT
        DECLARE @RegulacijaTipID INT
        DECLARE @SRegulacijaTipID INT
        DECLARE @TRegulacijaTipID INT
        DECLARE @OTTipID INT
  
      
  --Postavitev globalnih konstant - ZAÈETEK
        SELECT  @VIRT_ELES_MERITVE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SOPO) VIRT_ELES_MERITVE' ;
  
        SELECT  @VIRT_MERJENI_ODJEM = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_MERJENI_ODJEM' ;
  
        SELECT  @VIRT_NEMERJENI_ODJEM = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_NEMERJENI_ODJEM' ;
 
        SELECT  @VIRT_MERJEN_ODDAJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_MERJEN_ODDAJA' ;
  
        SELECT  @VIRT_NEMERJEN_ODDAJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_NEMERJEN_ODDAJA' ;
  
        SELECT  @VIRT_REGULACIJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(REG) VIRT_REGULACIJA' ;
  
        SELECT  @VIRT_ELES_ODJEM = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = 'VIRT_ELES_ODJEM' ;
  
        SELECT  @VIRT_ELES_ODDAJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = 'VIRT_ELES_ODDAJA' ;
  
        SELECT  @VIRT_PBI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_PBI' ;
  
        SELECT  @VIRT_DSP = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) VIRT_DSP' ;
  
        SELECT  @UDO_P_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) UDO_P_MERJENI' ;
  
        SELECT  @UDO_P_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) UDO_P_NEMERJENI' ;
  
        SELECT  @UDO_P_IZGUBE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) UDO_P_IZGUBE' ;
  
        SELECT  @MP_SKUPAJ = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_SKUPAJ' ;
  
        SELECT  @MP_ND_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_ND_NEMERJENI' ;
  
        SELECT  @MP_ND_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_ND_MERJENI' ;
  
        SELECT  @MP_NP_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_NP_NEMERJENI' ;
  
        SELECT  @MP_NP_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_NP_MERJENI' ;
  
        SELECT  @MP_KP_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_KP_NEMERJENI' ;
  
        SELECT  @MP_KP_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) MP_KP_MERJENI' ;

        SELECT  @MEJE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = 'MEJE' ;

        SELECT  @ND_EL_PR = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) ND_EL_PR' ;

        SELECT  @ND_EL_MB = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) ND_EL_MB' ;

        SELECT  @ND_EL_LJ = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) ND_EL_LJ' ;

        SELECT  @ND_EL_GO = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) ND_EL_GO' ;

        SELECT  @ND_EL_CE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SODO) ND_EL_CE' ;
	  
        SELECT  @VIRT_ELES_MERITVE_PREVZEM_SODO = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SOPO) VIRT_ELES_MERITVE_PREVZEM_SODO' ;

        SELECT  @BP = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'B_POG' ;
  
        SELECT  @PI = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'P_IZR' ;
  
        SELECT  @SSOPOBS = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'S_SOPO_BS' ;
    
        SELECT  @PDOB = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'P_DOB' ;

  
        SELECT  @SodoTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'SODO' ;
  
        SELECT  @SOPOTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'SOPO' ;
    
        SELECT  @TrgovecTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'TRG' ;
    
        SELECT  @RegulacijaTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'REG' ;
    
        SELECT  @SRegulacijaTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'SREG' ;

        SELECT  @TRegulacijaTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'TREG' ;
  
        SELECT  @SodoTipID = OsebaTipID
        FROM    OsebaTipID
        WHERE   Sifra = 'OT' ;

        SET @CriticalError = 0 ;
        SET @ValiodationErrors = 0 ;

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
 
  
  --Kreiranje zaèasnih tabel za napake
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
   
        SELECT  @DatumIntervalaOD = [VeljaOd],
                @DatumIntervalaDO = [VeljaDo]
        FROM    [ObracunskoObdobje]
        WHERE   [ObracunskoObdobjeID] = @ObracunskoObdobjeID
                AND ( @DatumStanjaBaze BETWEEN [DatumVnosa]
                                       AND     dbo.infinite(DatumSpremembe) )
    
        IF ( @RegulacijskoObmocjSR IS  NULL ) 
            BEGIN
                SET @NOErrors = @NOErrors + 1
                INSERT  INTO #Errors ( Napaka )
                        SELECT  'Napaka 000a: Šifrant regulacijsko obmošje RS ni izpolnjen. Preverite Nastavitve.'
            END
      
  --BEGIN TRANSACTION OBRACUN --DEMO
    
  --IF ( @NOErrors = 0 ) 
  --  begin      
	 -- --VALIDACIJA Obraèuna
	 -- /*
	 -- Preveri popolnost intervalov kritiènih vhodnih tabel ter preveri pravilnost PDP, PDO. Podobno kot v Excelu.
	 -- */
  --    EXEC @ValiodationErrors = dbo.BilancniObracun_Validacija @DatumIntervalaDO, @DatumStanjaBaze, @DatumIntervalaOD,
  --      @DatumVeljavnostiPodatkov, @MP_KP_NEMERJENI, @MP_NP_NEMERJENI, @NOErrorsOUT, @VIRT_MERJENI_ODJEM,
  --      @VIRT_NEMERJEN_ODDAJA, @VIRT_PBI, @VIRT_NEMERJENI_ODJEM, @ErrorHeadXML = @ValidationErrorsXML output,
  --      @ErrorDetailsXML = @ValidationErrorsDetailXML OUTPUT
	  
  --    IF ( @ValiodationErrors > 0 ) 
  --      BEGIN
  --        SET @NOErrors = @NOErrors + 1
  --        declare @hdocVTC1 int ;
  --        declare @xmlpath1 varchar(255) ;
  --        set @xmlpath1 = '/Root/Napake' ;
  --        exec sp_xml_preparedocument @hdocVTC1 OUTPUT, @ValidationErrorsXML ;

  --        insert  into #Errors ( Napaka )
  --                select  Napaka
  --                from    openxml(@hdocVTC1,@xmlpath1,2) with ( ErrorID BIGINT, Napaka VARCHAR(8000) )
  --                order by ErrorID asc     
  --        exec sp_xml_removedocument @hdocVTC1
				
  --        set @xmlpath1 = '/Root/ErrorDetail' ;
  --        exec sp_xml_preparedocument @hdocVTC1 OUTPUT, @ValidationErrorsDetailXML ;

  --        insert  into #ErrorDetail ( ErrorDetail )
  --                select  ErrorDetail
  --                from    openxml(@hdocVTC1,@xmlpath1,2) with ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
  --                order by ErrorID asc     
  --        exec sp_xml_removedocument @hdocVTC1
		
  --      END
	 -- --END VALIODACIJA
  --  END
  
  --èe nimamo napak pri validaciji lahko stopimo v naslednji korak obraèuna
  --èe imamo kolièinsko oraèun grem kljub napakam dalje. Napake pa shranimo za prikaz.
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
                    BEGIN	--obraèun

		  --naredimo nov obraèun za potrebe sledenja bomo novi ObracunID postavili v vse obraèunske tabele.
                        INSERT  INTO [Obracun]
                                (
                                  [ObracunID],
                                  [ObracunskoObdobjeID],
                                  [ObracunStatusID],
                                  [DatumVnosa],
                                  [Avtor],
                                  [Naziv],
                                  ObracunTipID,
                                  [velja]
                                )
                                SELECT  @NewObracunID,
                                        @ObracunskoObdobjeID,
                                        ObracunStatusID,
                                        GETDATE(),
                                        @Avtor,
                                        @Naziv,
                                        1,
                                        @DatumVeljavnostiPodatkov
                                FROM    [ObracunStatus]
                                WHERE   Sifra = 'INF'
			
         
                        IF ( @@ERROR <> 0 ) 
                            BEGIN
                                SET @NOErrors = @NOErrors + 1
                                INSERT  INTO [#Errors] ( [Napaka] )
                                VALUES  (
                                          'Napaka 001: Napaka pri inicilaizaciji obraèuna.'
                                        ) ;
                            END
                        IF ( @debugMode = 1 ) 
                            PRINT 'Realizacija po dobavteljih'			
		  --REALIZACIAJ PO DOBAVITELJIH
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
                                SET @NOErrors = @NOErrors + 1 ;
                                DECLARE @hdocVTC2 INT ;
                                DECLARE @xmlpath2 VARCHAR(255) ;
                                SET @xmlpath2 = '/Root/Napake' ;
                                EXEC sp_xml_preparedocument @hdocVTC2 OUTPUT,
                                    @ValidationErrorsXML ;


                                INSERT  INTO #Errors ( Napaka )
                                        SELECT  Napaka
                                        FROM    OPENXML(@hdocVTC2,@xmlpath2,2)
                                                WITH ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                                        ORDER BY ErrorID ASC     
                                EXEC sp_xml_removedocument @hdocVTC2
						
                                SET @xmlpath2 = '/Root/ErrorDetail' ;
                                EXEC sp_xml_preparedocument @hdocVTC2 OUTPUT,
                                    @ValidationErrorsDetailXML ;

                                INSERT  INTO #ErrorDetail ( ErrorDetail )
                                        SELECT  ErrorDetail
                                        FROM    OPENXML(@hdocVTC2,@xmlpath2,2)
                                                WITH ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                                        ORDER BY ErrorID ASC     
                                EXEC sp_xml_removedocument @hdocVTC2
				
                            END
            
                        IF ( @debugMode > 0 ) 
                            PRINT 'Realizacija po dobavteljih - END'

			--END REALIZACIAJ PO DOBAVITELJIH
			

		  --èe imamo vsaj en zapis v realizaciji po dobavitejih potem imamo realne možnosti za nadaljevanje obraèuna
		  --TO-DO: za še nadlajno optimizacijo lahko vrnemo record_count že iz SP BilanciObracun_RealizacijaPODobaviteljih
                        IF ( ( SELECT   COUNT(*)
                               FROM     [RealizacijaPoDobaviteljih]
                               WHERE    ObracunID = @NewObracunID
                             ) > 0 ) 
                            BEGIN --imamo podatke za obraèun

			
			--Izraèun realizacije BPS in BS
                                IF ( @debugMode = 1 ) 
                                    PRINT 'ralizacija BPS in BS'
                                EXEC dbo.BilancniObracun_RealizacijaBSinBPS @BP,
                                    @DatumStanjaBaze,
                                    @DatumVeljavnostiPodatkov, @NewObracunID,
                                    @NOErrorsOUT OUTPUT, @PI,
                                    @ValidationErrorsXML OUTPUT,
                                    @ValidationErrorsDetailXML OUTPUT
      
			
                                IF ( @NOErrorsOUT <> 0 ) 
                                    BEGIN
                                        SET @NOErrors = @NOErrors + 1 ;
                                        DECLARE @hdocVTC6 INT ;
                                        DECLARE @xmlpath6 VARCHAR(255) ;
                                        SET @xmlpath6 = '/Root/Napake' ;
                                        EXEC sp_xml_preparedocument @hdocVTC6 OUTPUT,
                                            @ValidationErrorsXML ;

                                        INSERT  INTO #Errors ( Napaka )
                                                SELECT  Napaka
                                                FROM    OPENXML(@hdocVTC6,@xmlpath6,2)
                                                        WITH ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                                                ORDER BY ErrorID ASC     
                                        EXEC sp_xml_removedocument @hdocVTC6
						
                                        SET @xmlpath6 = '/Root/ErrorDetail' ;
                                        EXEC sp_xml_preparedocument @hdocVTC6 OUTPUT,
                                            @ValidationErrorsDetailXML ;

                                        INSERT  INTO #ErrorDetail ( ErrorDetail )
                                                SELECT  ErrorDetail
                                                FROM    OPENXML(@hdocVTC6,@xmlpath6,2)
                                                        WITH ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                                                ORDER BY ErrorID ASC     
                                        EXEC sp_xml_removedocument @hdocVTC6
				
                                    END
                                IF ( @debugMode > 0 ) 
                                    PRINT 'ralizacija BPS in BS - END'
			
                                IF ( @debugMode > 0 ) 
                                    PRINT 'Critical error '
                                        + CAST(@CriticalError AS VARCHAR)
                                        
		 --preverimo èe imamo vse podatke za naslednje korake. Tukaj se preverja èe imamo za obraèun na voljo SIPX, TržniPlan,...
                                PRINT 'BilancniObracun_CheckInputSets'
                                EXEC dbo.BilancniObracun_CheckInputSets @CriticalError OUTPUT,
                                    @DatumIntervalaDO, @DatumIntervalaOD,
                                    @DatumStanjaBaze,
                                    @DatumVeljavnostiPodatkov,
                                    @NOErrorsOUT OUTPUT,
                                    @ValidationErrorsXML OUTPUT,
                                    @ValidationErrorsDetailXML OUTPUT
                
                
                
                                IF ( @NOErrorsOUT <> 0 ) 
                                    BEGIN
                                        SET @NOErrors = @NOErrors + 1 ;
                                        DECLARE @hdocVTC7 INT ;
                                        DECLARE @xmlpath7 VARCHAR(255) ;
                                        SET @xmlpath7 = '/Root/Napake' ;
                                        EXEC sp_xml_preparedocument @hdocVTC7 OUTPUT,
                                            @ValidationErrorsXML ;

                                        INSERT  INTO #Errors ( Napaka )
                                                SELECT  Napaka
                                                FROM    OPENXML(@hdocVTC7,@xmlpath7,2)
                                                        WITH ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                                                ORDER BY ErrorID ASC     
                                        EXEC sp_xml_removedocument @hdocVTC7
						
                                        SET @xmlpath7 = '/Root/ErrorDetail' ;
                                        EXEC sp_xml_preparedocument @hdocVTC7 OUTPUT,
                                            @ValidationErrorsDetailXML ;

                                        INSERT  INTO #ErrorDetail ( ErrorDetail )
                                                SELECT  ErrorDetail
                                                FROM    OPENXML(@hdocVTC7,@xmlpath7,2)
                                                        WITH ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                                                ORDER BY ErrorID ASC     
                                        EXEC sp_xml_removedocument @hdocVTC7
				
                                    END
                                IF ( @debugMode > 0 ) 
                                    PRINT 'BilancniObracun_CheckInputSets - END'
             					
			 --ZAÈASNA tabela za potrebe agregacije navzgor
                                IF OBJECT_ID('#KorekcijaTP') IS NOT NULL 
                                    DROP TABLE #KorekcijaTP
				
    
                                CREATE TABLE #KorekcijaTP
                                    (
                                      Interval DATETIME NOT NULL,
                                      OsebaId INT NOT NULL,
                                      Nivo INT NOT NULL,
                                      NadrejenaOsebaID INT NOT NULL,
                                      VrednostKorekcijeTP DECIMAL(18, 1) NULL,
                                      Kolicina DECIMAL(18, 1) NOT NULL,
                                      KoregiranTP DECIMAL(18, 1) NOT NULL
                                    )
			 
                                CREATE NONCLUSTERED INDEX IX_KorekcijaTP ON #KorekcijaTP ( Interval, OsebaId ) ;

                                IF ( @debugMode > 0 ) 
                                    PRINT 'KOREKCIJA TP'
			  --inicializacija Tržnega Plana
                                UPDATE  [TrzniPlan]
                                SET     KoregiranTP = TP.Kolicina,
                                        [JeKorigiran] = 0,
                                        VrednostPopravkaTP = 0
                                FROM    [TrzniPlan] TP
                                WHERE   TP.[Interval] >= @DatumIntervalaOD
                                        AND TP.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                               AND     dbo.infinite(TP.DatumSpremembe) )
				
  --	      še sekundarna in tercilana regulacija
                                UPDATE  [TrzniPlan]
                                SET     [KoregiranTP] = ISNULL([KoregiranTP], 0) - ISNULL(R.[SekRegM] + R.[SekRegP] + R.[TerRegM] + R.[TerRegP],0),
                                        [JeKorigiran] = 1
                                FROM    [TrzniPlan] TP
                                        JOIN PPM M ON Tp.[OsebaID] = M.Dobavitelj1
                                                      AND M.[PPMTipID] = @VIRT_REGULACIJA
                                        LEFT JOIN [Regulacija] R ON M.[PPMID] = R.PPMID
                                                                    AND R.Interval = TP.Interval
                                WHERE   TP.[Interval] >= @DatumIntervalaOD
                                        AND TP.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                               AND     dbo.infinite(TP.DatumSpremembe) )
                                        AND ( @DatumStanjaBaze BETWEEN R.[DatumVnosa]
                                                               AND     dbo.infinite(R.DatumSpremembe) )
                                        AND ( ( @DatumStanjaBaze BETWEEN M.DatumVnosa
                                                                 AND     dbo.infinite(M.DatumSpremembe) )
                                              AND ( @DatumVeljavnostiPodatkov BETWEEN M.VeljaOd
                                                                              AND     dbo.infinite(M.VeljaDo) )
                                            )

                                IF ( @@ERROR <> 0 ) 
                                    BEGIN
                                        SET @NOErrors = @NOErrors + 1
                                        INSERT  INTO [#Errors] ( [Napaka] )
                                        VALUES  (
                                                  'Napaka 008f: Napaka pri izraèunu koregiranega tržnega plana.'
                                                ) ;
                                    END 
                                    
              --Napolnimo polje za ugotavljanje korekcije tržnega plana
                                UPDATE  dbo.TrzniPlan
                                SET     VrednostPopravkaTP = Kolicina - KoregiranTP
                                WHERE   [Interval] >= @DatumIntervalaOD
                                        AND [Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                        AND ( @DatumStanjaBaze BETWEEN [DatumVnosa]
                                                               AND     dbo.infinite(DatumSpremembe) )
                                IF ( @@ERROR <> 0 ) 
                                    BEGIN
                                        SET @NOErrors = @NOErrors + 1
                                        INSERT  INTO [#Errors] ( [Napaka] )
                                        VALUES  (
                                                  'Napaka 008g: Napaka pri izraèunu koregiranega tržnega plana - izraèun faktorja korekcije TP.'
                                                ) ;
                                    END 

             
                                INSERT  INTO #KorekcijaTP
                                        (
                                          Interval,
                                          OsebaId,
                                          Nivo,
                                          NadrejenaOsebaID,
                                          VrednostKorekcijeTP,
                                          Kolicina,
                                          KoregiranTP
										)
                                        SELECT  TP.Interval,
                                                TP.OsebaID,
                                                P.Nivo,
                                                P.NadrejenaOsebaID,
                                                TP.VrednostPopravkaTP,
                                                TP.Kolicina,
                                                TP.KoregiranTP
                                        FROM    dbo.TrzniPlan TP
                                                INNER JOIN [Pogodba] P ON TP.OsebaID = P.[Partner2]
                                        WHERE   TP.[Interval] >= @DatumIntervalaOD
                                                AND TP.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                                AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                                       AND     dbo.infinite(TP.DatumSpremembe) )
                                                AND P.Nivo > 0
                                                AND ( P.[PogodbaTipID] = @BP
                                                      OR P.[PogodbaTipID] = @PI
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
                                                    
                                IF ( @@ERROR <> 0 ) 
                                    BEGIN
                                        SET @NOErrors = @NOErrors + 1
                                        INSERT  INTO [#Errors] ( [Napaka] )
                                        VALUES  (
                                                  'Napaka 008h: Napaka pri izraèunu koregiranega tržnega plana - izraèun faktorja korekcije TP.'
                                                ) ;
                                    END 

                                SELECT  SUM(ISNULL(TPA.VrednostKorekcijeTP, 0)) AS VrednostKorekcijeTP,
                                        TPA.NadrejenaOsebaID,
                                        TPA.Interval
                                INTO    #AgregiranTP
                                FROM    #KorekcijaTP TPA
                                GROUP BY TPA.Interval,
                                        TPA.NadrejenaOsebaID

                                UPDATE  #KorekcijaTP
                                SET     VrednostKorekcijeTP = ISNULL(ATP.VrednostKorekcijeTP, 0),
                                        KoregiranTP = ISNULL(KTP.Kolicina, 0) - ISNULL(ATP.VrednostKorekcijeTP, 0)
                                FROM    #KorekcijaTP KTP
                                        INNER JOIN #AgregiranTP ATP ON KTP.OsebaId = ATP.NadrejenaOsebaID
                                                                       AND KTP.Interval = ATP.Interval


                                UPDATE  dbo.TrzniPlan
                                SET     VrednostPopravkaTP = ISNULL(KTP.VrednostKorekcijeTP, 0),
                                        KoregiranTP = ISNULL(KTP.KoregiranTP,0)
                                FROM    dbo.TrzniPlan TP
                                        LEFT JOIN #KorekcijaTP KTP ON TP.Interval = KTP.Interval
                                                                      AND TP.OsebaID = KTP.OsebaID
                                WHERE   TP.[Interval] >= @DatumIntervalaOD
                                        AND TP.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                               AND     dbo.infinite(TP.DatumSpremembe) )

	
                                IF ( @@ERROR <> 0 ) 
                                    BEGIN
                                        SET @NOErrors = @NOErrors + 1
                                        INSERT  INTO [#Errors] ( [Napaka] )
                                        VALUES  (
                                                  'Napaka 008k: Napaka pri izraèunu koregiranega tržnega plana - zapis agregacije v osnovno tabelo.'
						  
                                                ) ;
                                    END 
                
                --SELECT 'Trzni plan PO KOREKCIJI UP regukacijo0',* FROM [dbo].[TrzniPlan] WHERE [OsebaID]=3 AND [Interval] = '2012-01-02 00:00:00'
                
              --                  IF ( @debugMode = 4 ) 
              --                      SELECT  'Koregiran navzgor',
              --                              *
              --                      FROM    [dbo].[TrzniPlan]
              --                      WHERE   [Interval] = '2012-01-01 01:00:00.000'
			
              --                  IF ( @debugMode = 4 ) 
              --                      PRINT 'KOREKCIJA TP - END'
			
              ----èe do sedaj nismo imeli kritiène napake in imamo vse potrebne vhodne podatke, lahko gremo v izraèun Kolièinskih odstopanj
              --                  IF ( @debugMode > 0 ) 
              --                      PRINT 'Critical error '
              --                          + CAST(@CriticalError AS VARCHAR)
              
                                IF ( @CriticalError = 0 ) 
                                    BEGIN
			
				--Odstopanja po BPS
                                        IF ( @debugMode > 0 ) 
                                            PRINT 'KolicinskaOdstopanjaPoBPS'
                                        INSERT  INTO [KolicinskaOdstopanjaPoBPS]
                                                (
                                                  [Kolicina],
                                                  [VozniRed],
                                                  [Odstopanje],
                                                  [OsebaID],
                                                  [Interval],
                                                  [ObracunID],
                                                  [KoregiranTP]
						
                                                )
                                                SELECT  CAST(ROUND(CAST(RBPS.Kolicina AS DECIMAL(19,2))/1000,3) AS DECIMAL(24,3))*1000,
                                                        ISNULL(ROUND(Tp.KoregiranTP,1), 0),
                                                        ROUND(ROUND(CAST(RBPS.Kolicina-ISNULL(Tp.KoregiranTP, 0)  AS DECIMAL(19,3)),0)/1000,3)*1000,
                                                        RBPS.OsebaID,
                                                        RBPS.Interval,
                                                        @NewObracunID,
                                                        ISNULL(Tp.KoregiranTP, 0)
                                                FROM    [RealizacijaPoBPS] RBPS
                                                        INNER JOIN [TrzniPlan] TP ON RBPS.[Interval] = TP.[Interval]
                                                                                     AND Tp.[OsebaID] = RBPS.[OsebaID]
                                                WHERE   RBPS.[ObracunID] = @NewObracunID
                                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                                               AND     dbo.infinite(TP.DatumSpremembe) )

                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN 
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 009: Napaka pri kalkulaciji kolièinskega obraèuna po bilanènih podskupinah.'
                                                        ) ;
                                            END
                                        IF ( @debugMode > 0 ) 
                                            PRINT 'KolicinskaOdstopanjaPoBPS - END '
 
--				  Odstopanja po BS
                                        IF ( @debugMode > 0 ) 
                                            PRINT 'KolicinskaOdstopanjaPoBS  '
                                        INSERT  INTO [KolicinskaOdstopanjaPoBS]
                                                (
                                                  [Kolicina],
                                                  [VozniRed],
                                                  [Odstopanje],
                                                  [OsebaID],
                                                  [Interval],
                                                  [ObracunID],
												  [KoregiranTP]
                                                )
                                                SELECT  CAST(ROUND(CAST(RBS.Kolicina AS DECIMAL(19,2))/1000,3) AS DECIMAL(24,3))*1000,
                                                        ISNULL(ROUND(Tp.KoregiranTP,1), 0),
                                                        --CAST(ROUND(RBS.Kolicina/1000,3) AS DECIMAL(24,2))*1000
                                                        ---ISNULL(ROUND(Tp.KoregiranTP/1000,1)*1000, 0),
                                                        --ROUND(ROUND(CAST(RBS.Kolicina-ISNULL(Tp.KoregiranTP, 0)  AS DECIMAL(19,3)),0)/1000,3)*1000,
                                                        CAST((RBS.Kolicina-ISNULL(Tp.KoregiranTP, 0))/1000  AS DECIMAL(19,3))*1000,
                                                        RBS.OsebaID,
                                                        RBS.Interval,
                                                        @NewObracunID,
                                                        ISNULL(Tp.KoregiranTP, 0)
                                                FROM    [RealizacijaPoBS] RBS
                                                        INNER JOIN [TrzniPlan] TP ON RBS.[Interval] = TP.[Interval]
                                                                                     AND Tp.[OsebaID] = RBS.[OsebaID]
                                                WHERE   RBS.[ObracunID] = @NewObracunID
                                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                                               AND     dbo.infinite(TP.DatumSpremembe) )


--SELECT  'HSE',
--RBS.Kolicina,
--                                                        ISNULL(ROUND(Tp.KoregiranTP,1), 0),
--                                                        CAST(ROUND(ROUND(RBS.Kolicina,3)/1000,2)*1000-ISNULL(ROUND(ROUND(Tp.KoregiranTP,1)/1000,2)*1000, 0) AS DECIMAL(19,3)) AS odst,
--                                                        CAST(ROUND(ROUND(RBS.Kolicina,3)/1000,2)*1000 AS DECIMAL(19,2)),
--                                                        CAST(ROUND(ROUND(RBS.Kolicina/1000,3)*1000,2) AS DECIMAL(19,2)),
--														CAST(ROUND(CAST(RBS.Kolicina AS DECIMAL(19,2))/1000,3) AS DECIMAL(24,2))*1000,
--														CAST(RBS.Kolicina-ISNULL(Tp.KoregiranTP, 0)  AS DECIMAL(19,2)) AS odst1,
--														ROUND(CAST(RBS.Kolicina-ISNULL(Tp.KoregiranTP, 0)  AS DECIMAL(19,2)),0) AS odst11,
--														ROUND(ROUND(CAST(RBS.Kolicina-ISNULL(Tp.KoregiranTP, 0)  AS DECIMAL(19,2)),0)/1000,2)*1000 AS odst12,
--														RBS.Kolicina AS kOLICINAnormal,
--                                                        Tp.KoregiranTP,
--                                                        RBS.OsebaID,
--                                                        RBS.Interval,
--                                                        @NewObracunID
--                                                FROM    [RealizacijaPoBS] RBS
--                                                        INNER JOIN [TrzniPlan] TP ON RBS.[Interval] = TP.[Interval]
--                                                                                     AND Tp.[OsebaID] = RBS.[OsebaID]
--                                                WHERE   RBS.[ObracunID] = @NewObracunID
--                                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
--                                                                               AND     dbo.infinite(TP.DatumSpremembe) )
--                                                         AND RBS.[OsebaID]=3
--                                                        AND rbs.[Interval] = '2012-01-08 11:00:00'
                                                                               
      -- SELECT 'Kolièinks HSE',* FROM [dbo].KolicinskaOdstopanjaPoBS WHERE [OsebaID]=3 AND [Interval] = '2012-01-01 00:00:00'
       
       --- SELECT 'REALIZACIJA HSE',* FROM [dbo].RealizacijaPoBS WHERE [OsebaID]=3 AND [Interval] = '2012-01-02 00:00:00'
         
         
                                        IF ( @debugMode > 0 ) 
                                            PRINT 'KolicinskaOdstopanjaPoBS - END '
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 010: Napaka pri kalkulaciji kolièinskega obraèuna po bilanènih skupinah.'
                                                        ) ;
                                            END 
                                            
                                       --DODAMO ŠE TRGOVCE     
                                            
                                               IF ( @debugMode > 0 ) 
                                            PRINT 'KolicinskaOdstopanjaPoBS - TRGOVCI '
                                        INSERT  INTO [KolicinskaOdstopanjaPoBS]
                                                (
                                                  [Kolicina],
                                                  [VozniRed],
                                                  [Odstopanje],
                                                  [OsebaID],
                                                  [Interval],
                                                  [ObracunID]
						                        )
                                                SELECT  0,
                                                        ISNULL(ROUND(Tp.KoregiranTP,1), 0),
                                                        ROUND(-1*ISNULL(ROUND(Tp.KoregiranTP,1), 0),0),
                                                        TP.OsebaID,
                                                        TP.Interval,
                                                        @NewObracunID
                                                FROM    [TrzniPlan] TP JOIN [dbo].[OsebaTip] O ON TP.[OsebaID] = O.[OsebaID] AND o.[OsebaTipID] = @TrgovecTipID
                                                WHERE  TP.[Interval] >= @DatumIntervalaOD
														AND TP.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                                               AND     dbo.infinite(TP.DatumSpremembe) )
                                                        AND ( @DatumStanjaBaze BETWEEN O.[DatumVnosa]
                                                                               AND     dbo.infinite(O.DatumSpremembe) )

                                        IF ( @debugMode > 0 ) 
                                            PRINT 'KolicinskaOdstopanjaPoBS TRGOVCI- END '
                                            
                
                
     
     
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 010: Napaka pri kalkulaciji kolièinskega obraèuna po bilanènih skupinah (Trgovci).'
                                                        ) ;
                                            END 
                                            
                                           -- SELECT 'REALIZACIJA CP 17 09:00',* FROM [dbo].RealizacijaPoBS WHERE [OsebaID]=33 AND [Interval] = '2012-01-17 09:00:00'

						

				  --NOVO KOLIÈINSKI OBRAÈUN PO SODO IN SOPO
                                        INSERT  INTO dbo.ObracunKolicinski
                                                (
                                                  ObracunID,
                                                  OsebaID,
                                                  Interval,
                                                  SODO_SOPO_ID,
                                                  Realizacija
                                                )
                                                SELECT  @NewObracunID,
                                                        RPD.OsebaID,
                                                        RPD.Interval,
                                                        RPD.SistemskiOperaterID,
                                                        SUM(RPD.Kolicina)
                                                FROM    dbo.RealizacijaPoDobaviteljih RPD
                                                WHERE   [ObracunID] = @NewObracunID
                                                GROUP BY RPD.Interval,
                                                        Rpd.OsebaID,
                                                        RPD.SistemskiOperaterID
                                  
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN   
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 010b: Napaka pri kalkulaciji kolièinskega obraèuna po SODO/SOPO.'
                                                        ) ;
                                            END 
						
						
						
						--/*KORONA STUFF KOLICINE*/
						
						--   insert into [dbo].[Kolicine] (
						--		[ObracunID],
						--		[OsebaID],
						--		[Interval],
						--		[TrzniPlan],
						--		[Regulacija],
						--		[KorigiranTP],
						--		[Realizacija],
						--		[Odstopanje],
						--		[BS]
						--	)
						--	SELECT 
						--	@NewObracunID,
						--	K.[NadrejenaOsebaID],
						--	K.[Interval],
						--	SUM(TP.[Kolicina]),
						--	sum(ISNULL(R.[SekRegM],0) + ISNULL(R.[SekRegP],0) + ISNULL(R.[TerRegM],0)+ ISNULL(R.[TerRegP],0)),
						--	SUM(TP.[KoregiranTP]),
						--	SUM(K.[Kolicina]),
						--	SUM(ROUND(K.Kolicina,3)-ISNULL(ROUND(Tp.KoregiranTP,1), 0)),
						--	(case when p.Nivo=1 then 1 else 0 END)
						--	FROM 
						--	[dbo].[RealizacijaPoDobaviteljih] K 
						--	JOIN [dbo].[TrzniPlan] TP ON K.NadrejenaOsebaID = TP.[OsebaID] and K.[Interval] = TP.[Interval]
						--	JOIN [Pogodba] P ON K.[NadrejenaOsebaID] = P.[Partner2] 
						--		AND (((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe) and P.Aktivno=1) or (P.Aktivno=1)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
						--	JOIN [dbo].[Regulacija] R ON K.[Interval] = R.[Interval] AND @DatumStanjaBaze between R.DatumVnosa and dbo.infinite(R.DatumSpremembe)
						--	WHERE K.[ObracunID]=@NewObracunID
						--	GROUP BY K.[NadrejenaOsebaID],K.Interval,P.Nivo
							
						--	--+++f01 popravek odstopanja za meje 
						--	-- po novem je TP-realizacija, oz obratno, kot za vse ostale.
						--	declare @osebeMeje table (id int)
						--	insert into @osebeMeje 
						--	select k.osebaid 
						--	  from kolicine k
						--	  inner join OsebaZCalc t on k.OsebaID=t.OsebaID
						--	  where  k.bs=1 
						--	  and k.Interval = @DatumIntervalaDO
						--	  and k.ObracunID=@NewObracunID
						--	  and @DatumStanjaBaze between t.datumvnosa  and dbo.infinite(t.DatumSpremembe)
						--	  and t.OsebaZId=5 -- meje !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!MEJE SPET IZJEMA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
						--	order by k.OsebaID asc

						--	update Kolicine set Odstopanje=-Odstopanje where 
						--		 ObracunID=@obracunID and 
						--		 OsebaID in (select id from @osebeMeje)

						--	--+++ konec popravka

						--/*KOLICINE KORONA END*/
						
						
--					 TOLERANÈNI PAS
                                        IF ( @debugMode > 0 ) 
                                            PRINT 'Toleranèni PAS'
                                        EXEC dbo.BilancniObracun_TolerancniPas @DatumStanjaBaze,
                                            @k, @NewObracunID,
                                            @NOErrorsOUT OUTPUT, @novk,
                                            @RegulacijskoObmocjSR,
                                            @TrgovecTipID,
                                            @ValidationErrorsXML OUTPUT,
                                            @ValidationErrorsDetailXML OUTPUT
              
                                        IF ( @debugMode > 0 ) 
                                            PRINT 'Toleranèni PAS - END'   
               
                                        IF ( @debugMode = 4 ) 
                                            SELECT  'Toleranèni PAS',
                                                    *
                                            FROM    [dbo].[TolerancniPas]
                                            WHERE   Interval = '2012-01-04 08:00:00.000'
		      
                        
                                        IF ( @NOErrorsOUT <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1 ;
                                                DECLARE @hdocVTC8 INT ;
                                                DECLARE @xmlpath8 VARCHAR(255) ;
                                                SET @xmlpath8 = '/Root/Napake' ;
                                                EXEC sp_xml_preparedocument @hdocVTC8 OUTPUT,
                                                    @ValidationErrorsXML ;

                                                INSERT  INTO #Errors ( Napaka )
                                                        SELECT  Napaka
                                                        FROM    OPENXML(@hdocVTC8,@xmlpath8,2) WITH ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                                                        ORDER BY ErrorID ASC     
                                                EXEC sp_xml_removedocument @hdocVTC8
						
                                                SET @xmlpath8 = '/Root/ErrorDetail' ;
                                                EXEC sp_xml_preparedocument @hdocVTC8 OUTPUT,
                                                    @ValidationErrorsDetailXML ;

                                                INSERT  INTO #ErrorDetail ( ErrorDetail )
                                                        SELECT  ErrorDetail
                                                        FROM    OPENXML(@hdocVTC8,@xmlpath8,2) WITH ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                                                        ORDER BY ErrorID ASC     
                                                EXEC sp_xml_removedocument @hdocVTC8
				
                                            END

								--doloèanje cene odstopanj
					--ustvarjanje zaèasne tabele za te namene
                                        IF OBJECT_ID('#tmpCena') IS NOT NULL 
                                            DROP TABLE #tmpCena

                                        CREATE TABLE #tmpCena
                                            (
                                              Interval DATETIME,
                                              Cplus DECIMAL(24, 2), --stara pravila
                                              Cminus DECIMAL(24, 2),--stara pravila
                                              SIPX DECIMAL(24, 2)
                                            )			

                                        IF ( @debugMode > 0 ) 
                                            PRINT 'Temp Cena'	
											
																	
                                        INSERT  INTO #tmpCena ( Interval, Cplus, Cminus,SIPX)
                                                SELECT  I.Interval,
                                                        ROUND(CAST(ISNULL(( CASE WHEN Wp > 0
                                                                                      AND Wm = 0 THEN 1.03 * Sp / Wp
                                                                                 WHEN Wp = 0
                                                                                      AND Wm < 0 THEN 1.03 * ( CASE WHEN C.Vrednost >= Sm / Wm THEN C.Vrednost
                                                                                                                    ELSE Sm / Wm
                                                                                                               END )
                                                                                 WHEN Wp + Wm > 0 THEN 1.03 * Sp / Wp
                                                                                 WHEN Wp + Wm < 0 THEN 1.03 * ( CASE WHEN ( CASE WHEN C.Vrednost >= Sm / Wm THEN C.Vrednost
                                                                                                                                 ELSE Sm / Wm
                                                                                                                            END ) < Sp / Wp THEN ( CASE WHEN C.Vrednost >= Sm / Wm THEN C.Vrednost
                                                                                                                                                        ELSE Sm / Wm
                                                                                                                                                   END )
                                                                                                                     ELSE Sp / Wp
                                                                                                                END )
                                                                                 WHEN Wp + Wm = 0 THEN 1.03 * C.Vrednost
                                                                            END ), 0) AS DECIMAL(18, 2)), 2),
                                                        ROUND(CAST(ISNULL(( CASE WHEN Wp > 0
                                                                                      AND Wm = 0 THEN 0.97 * ( CASE WHEN C.Vrednost < Sp / Wp THEN C.Vrednost
                                                                                                                    ELSE Sp / Wp
                                                                                                               END )
                                                                                 WHEN Wp = 0
                                                                                      AND Wm < 0 THEN 0.97 * Sm / Wm
                                                                                 WHEN Wp + Wm > 0 THEN 0.97 * ( CASE WHEN ( CASE WHEN C.Vrednost < Sp / Wp THEN C.Vrednost
                                                                                                                                 ELSE Sp / Wp
                                                                                                                            END ) >= Sm / Wm THEN ( CASE WHEN C.Vrednost < Sp / Wp THEN C.Vrednost
                                                                                                                                                         ELSE Sp / Wp
                                                                                                                                                    END )
                                                                                                                     ELSE Sm / Wm
                                                                                                                END )
                                                                                 WHEN Wp + Wm < 0 THEN 0.97 * Sm / Wm
                                                                                 WHEN Wp + Wm = 0 THEN 0.97 * C.Vrednost
                                                                            END ), 0) AS DECIMAL(18, 2)), 2),
                                                       ROUND(C.[Vrednost],2)
                                                FROM    [Izravnava] I
                                                        INNER JOIN [dbo].[SIPX] C ON I.Interval = C.Interval
                                                WHERE   I.Interval >= @DatumIntervalaOD
                                                        AND I.Interval <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                                        AND I.[DatumVnosa] <= @DatumStanjaBaze
                                                        AND ( @DatumStanjaBaze BETWEEN I.[DatumVnosa]
                                                                               AND     dbo.infinite(I.DatumSpremembe) )
                                                        AND ( @DatumStanjaBaze BETWEEN C.[DatumVnosa]
                                                                               AND     dbo.infinite(C.DatumSpremembe) )
													
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 013: Napaka pri izraèunu izhodišènih cen.'
                                                        ) ;
                                            END
                                        IF ( @debugMode > 0 ) 
                                            PRINT 'Temp Cena - END'
                      
                                        UPDATE  [#tmpCena]
                                        SET     [Cplus] = [Cminus]
                                        WHERE   [Cplus] < [Cminus]        

                                        --IF ( @debugMode = 5 ) 
                                        --    SELECT  *
                                        --    FROM    #tmpCena
                                        --    WHERE   Interval = '2012-01-01 01:00:00.000'
                                       

                                        IF ( @debugMode > 0 ) 
                                            PRINT 'PodatkiObracuna_Skupni'	
                                            
                                        SELECT  P.[Partner2]
                                        INTO    #OsebeZaSaldoObdobja
                                        FROM    [dbo].[Pogodba] P
                                                JOIN [dbo].[Oseba] O ON P.[Partner2] = O.[OsebaID]
                                                JOIN [dbo].[OsebaZCalc] ZC ON P.[Partner2] = ZC.[OsebaID]
                                                JOIN [dbo].[OsebaZId] Z ON ZC.[OsebaZID] = Z.[OsebaZId] AND Z.[OsebaZId] <> 5 
                                        WHERE   P.[PogodbaTipID] = @BP
--                                                AND P.[Partner2] <> 46 --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
												
                                        SELECT  K.[Interval],
												SUM(K.[Odstopanje]) AS Odstopanje,
												SUM(ISNULL(Tp.[KoregiranTP],0)) AS TrzniPlan,
												SUM(K.[Kolicina]) AS Realizacija,
												sum(CASE WHEN K.[Odstopanje] > 0 THEN K.[Odstopanje] ELSE 0 end) AS Wgjs_p,
												sum(CASE WHEN K.[Odstopanje] < 0 THEN K.[Odstopanje] ELSE 0 end) AS Wgjs_m,
												K.[OsebaID]
 										INTO #GJS												
                                        FROM    [dbo].[Oseba] O
                                                JOIN [dbo].[OsebaZCalc] OZ ON O.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                                                             AND OZT.[Sifra] = 'GJS'
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] K ON K.[ObracunID] =  @NewObracunID and O.[OsebaID] = K.[OsebaID]
                                                LEFT JOIN [dbo].[TrzniPlan] TP ON K.[OsebaID] = TP.[OsebaID] AND  K.[Interval] = TP.[Interval]
                                        WHERE   @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                 AND     dbo.infinite(OZ.DatumSpremembe)
                                                AND @DatumStanjaBaze BETWEEN O.[DatumVnosa]
                                                                     AND     dbo.infinite(O.DatumSpremembe)
                                                AND ( @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd
                                                                                AND     dbo.infinite(O.VeljaDo) )   
										GROUP BY K.[Interval],K.[OsebaID]
										
										
                                                         
                                        SELECT  K.[Interval],
												sum(CASE WHEN K.[Odstopanje] > 0 THEN K.[Odstopanje] ELSE 0 end) AS W_p,
												sum(CASE WHEN K.[Odstopanje] < 0 THEN K.[Odstopanje] ELSE 0 end) AS W_m,
												K.[OsebaID]
 										INTO #NonGJS												
                                        FROM    [dbo].[Oseba] O
                                                JOIN [dbo].[OsebaZCalc] OZ ON O.[OsebaID] = OZ.[OsebaID]
                                                JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                                                             AND OZT.[Sifra] <> 'GJS'
                                                JOIN [dbo].[KolicinskaOdstopanjaPoBS] K ON K.[ObracunID] =  @NewObracunID and O.[OsebaID] = K.[OsebaID]
                                                LEFT JOIN [dbo].[TrzniPlan] TP ON K.[OsebaID] = TP.[OsebaID] AND  K.[Interval] = TP.[Interval]
                                        WHERE   @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                 AND     dbo.infinite(OZ.DatumSpremembe)
                                                AND @DatumStanjaBaze BETWEEN O.[DatumVnosa]
                                                                     AND     dbo.infinite(O.DatumSpremembe)
                                                AND ( @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd
                                                                                AND     dbo.infinite(O.VeljaDo) )   
										GROUP BY K.[Interval],K.[OsebaID]
										
										                            
																				
                                        INSERT INTO [dbo].[PodatkiObracuna_Skupni] (
										   	[ObracunID],
										   	[Interval],
										   	[W+],
										   	[W-],
										   	[S+],
										   	[S-],
										   	[SroskiIzravnave]
										   	--[SkupnaOdstopanja],
										   	--[TP_GJS],
										   	--[Realizacija_GJS],
										   	--[Odstopanje_GJS]
										   )
										SELECT
										    @NewObracunID,
										   	I.[Interval],
										   	SUM(ISNULL(I.Wp, 0)),
										   	SUM(ISNULL(I.Wm, 0)),
										   	SUM(ISNULL(I.Sp, 0)),
										   	SUM(ISNULL(I.Sm, 0)),
										   	SUM(ISNULL(I.Sp, 0) + ISNULL(I.Sm, 0))--[SroskiIzravnave]
										  FROM    [Izravnava] I
                                          WHERE   
												I.Interval >= @DatumIntervalaOD
                                            AND I.Interval <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                            AND I.[DatumVnosa] <= @DatumStanjaBaze
                                            AND (@DatumStanjaBaze BETWEEN I.[DatumVnosa] AND dbo.infinite(I.DatumSpremembe))
										  GROUP BY I.Interval   
                   
                                      
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 013: Napaka pri izraèunu izhodišènih cen.'
                                                        ) ;
                                            END
										
										  UPDATE PodatkiObracuna_Skupni
										  SET   
										   		PodatkiObracuna_Skupni.TP_GJS = ROUND(P1.TP_GJS,1) ,
										   		PodatkiObracuna_Skupni.Realizacija_GJS = ROUND(P1.Realizacija_GJS,3),
												PodatkiObracuna_Skupni.Odstopanje_GJS = ROUND(P1.Odstopanje_GJS,3),										   	
												PodatkiObracuna_Skupni.[Wgjs_p] = ROUND(P1.[Wgjs_p],3),
												PodatkiObracuna_Skupni.[Wgjs_m] = ROUND(P1.[Wgjs_m],3)
										  FROM  
										  (
										  SELECT 
										   ISNULL(SUM(ISNULL(G.TrzniPlan,0)),0) AS TP_GJS,
										   SUM(G.Realizacija) AS Realizacija_GJS,
										   SUM(G.Odstopanje) AS Odstopanje_GJS,
										   SUM(G.[Wgjs_p]) AS Wgjs_p,
										   SUM(G.[Wgjs_m]) AS Wgjs_m,
										   G.[Interval]	
										 FROM 
										  PodatkiObracuna_Skupni P 
										    JOIN #GJS G ON P.Interval = G.Interval
										  WHERE P.[ObracunID]=@NewObracunID
										  GROUP BY G.Interval   
										  ) P1	
										 WHERE PodatkiObracuna_Skupni.[Interval] = P1.Interval AND PodatkiObracuna_Skupni.[ObracunID]=@NewObracunID
                                      
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 013: Napaka pri izraèunu odstopanj GJS.'
                                                        ) ;
                                            END
                              
                      
                                     
                                     UPDATE  P
                                     SET P.[C+]= ROUND(T.Cplus,2),
										 P.[C-]= ROUND(T.Cminus,2),
										 P.[C+']= ROUND(T.Cplus,2),
										 P.[C-']= ROUND(T.Cminus,2),
										 P.SIPXurni = ROUND(T.SIPX,2)
                                     FROM PodatkiObracuna_Skupni P JOIN [#tmpCena] T ON P.Interval = T.Interval
                                     WHERE ObracunID=@NewObracunID

									UPDATE PodatkiObracuna_Skupni
										  SET   
										   		PodatkiObracuna_Skupni.Wplusi = ROUND(P1.Wpi,3),
												PodatkiObracuna_Skupni.Wminusi =ROUND(P1.Wmi,3)
										  FROM  
										  (
										  SELECT 
										   SUM(G.[W_p]) AS Wpi,
										   SUM(G.[W_m]) AS Wmi,
										   G.[Interval]	
										 FROM 
										  PodatkiObracuna_Skupni P 
										    JOIN #NonGJS G ON P.Interval = G.Interval
										    WHERE P.[ObracunID]=@NewObracunID
										  GROUP BY G.Interval   
										  ) P1	
										 WHERE PodatkiObracuna_Skupni.[Interval] = P1.Interval AND [dbo].[PodatkiObracuna_Skupni].[ObracunID]=@NewObracunID
                                      
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 013: Napaka pri izraèunu odstopanj non GJS.'
                                                        ) ;
                                            END
									
									
									--SELECT 
									--P1.[C+], P1.[C-],*
									--FROM  PodatkiObracuna_Skupni P1
									--WHERE P1.[Interval] = '2012-01-17 09:00:00'
         --                              AND P1.[ObracunID] = @NewObracunID 
                                    
         --                           SELECT R.[Odstopanje],
									--	   OZT.[Sifra],
									--	   ISNULL(R.[Odstopanje]/1000,0) * P1.[C+]/(CASE WHEN OZT.Sifra = 'GJS' THEN 1.03 ELSE 1.00 end), 
									--	   (ISNULL(R.[Odstopanje],0) * (P1.[C+]/(CASE WHEN OZT.Sifra = 'GJS' THEN 1.03 ELSE 1.00 end)))/1000, 
									--	   O.naziv,
									--	   P1.[C+]	
         --                            FROM
         --                              [#OsebeZaSaldoObdobja] S
         --                              JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
         --                              JOIN Oseba O ON O.OsebaId = R.OsebaID 
         --                              JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
         --                              JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
         --                              JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
         --                            WHERE 
         --                              R.[ObracunID] = @NewObracunID 
         --                              AND R.[Interval] = '2012-01-17 09:00:00'
         --                              AND P1.[ObracunID] = @NewObracunID 
         --                              AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
         --                                                        AND     dbo.infinite(OZ.DatumSpremembe)
         --                              AND ( @DatumVeljavnostiPodatkov BETWEEN o.VeljaOd
         --                                                                       AND     dbo.infinite(o.VeljaDo) )
         --                              AND ( @DatumStanjaBaze BETWEEN o.[DatumVnosa]
         --                                                              AND     dbo.infinite(o.DatumSpremembe) )
                                  
         --                                 ORDER BY R.Interval asc
                                  
                                    
									--SELECT 'TEST ODST PODROBNO 2012-01-09 00:00',
									--		ROUND(SUM(CASE WHEN ISNULL(R.[Odstopanje],0) > 0 THEN  ROUND(ISNULL(R.[Odstopanje],0),2) * ROUND(P1.[C+]/(CASE WHEN OZT.Sifra = 'GJS' THEN 1.03 ELSE 1.00 end),2) 
									--												ELSE ROUND(ISNULL(R.[Odstopanje],0),2) * ROUND(P1.[C-]/(CASE WHEN OZT.Sifra = 'GJS' THEN 0.97 ELSE 1.00 end),2) END),2) AS Saldo,
									--		SUM(CASE WHEN ISNULL(R.[Odstopanje],0) > 0 THEN  ROUND(P1.[C+]/(CASE WHEN OZT.Sifra = 'GJS' THEN 1.03 ELSE 1.00 end),2) 
									--												ELSE     ROUND(P1.[C-]/(CASE WHEN OZT.Sifra = 'GJS' THEN 0.97 ELSE 1.00 end),2) END)
									--												AS Kolicnik,
									--		SUM(R.[Odstopanje]/1000) AS SumOdstopanjeUnrounded,
									--		(SELECT [C+] FROM PodatkiObracuna_Skupni WHERE interval='2012-01-09 00:00:00') AS Cp,
									--		(SELECT [C-] FROM PodatkiObracuna_Skupni WHERE interval='2012-01-09 00:00:00') AS Cm,
         --                                   R.Interval,
         --                                   O.Naziv
         --                             FROM
         --                              [#OsebeZaSaldoObdobja] S
         --                              JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
         --                              JOIN Oseba O ON O.OsebaId = R.OsebaID 
         --                              JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
         --                              JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
         --                              JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
         --                            WHERE 
         --                              R.[ObracunID] = @NewObracunID 
         --                              AND R.[Interval] = '2012-01-09 00:00:00'
         --                              AND P1.[ObracunID] = @NewObracunID 
         --                              AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
         --                                                        AND     dbo.infinite(OZ.DatumSpremembe)
         --                              AND ( @DatumVeljavnostiPodatkov BETWEEN o.VeljaOd
         --                                                                       AND     dbo.infinite(o.VeljaDo) )
         --                              AND ( @DatumStanjaBaze BETWEEN o.[DatumVnosa]
         --                                                              AND     dbo.infinite(o.DatumSpremembe) )
         --                         GROUP BY R.Interval,O.Naziv
         --                                 ORDER BY R.Interval asc
                        
                                    
                              
                                  
                                     UPDATE  PodatkiObracuna_Skupni
                                     SET PodatkiObracuna_Skupni.SaldoStroskiObracunov = isnull(ROUND(O.Saldo,3),0),
										 PodatkiObracuna_Skupni.SkupnaOdstopanja = ROUND(O.SkupnaOdstopanja,6),
									     PodatkiObracuna_Skupni.Razlika = ROUND(ISNULL(O.Saldo,0) - PodatkiObracuna_Skupni.SroskiIzravnave,6)
                                     FROM 
                                     (
                                     SELECT SUM(CASE WHEN ISNULL(R.[Odstopanje],0) > 0 THEN ROUND(ISNULL(R.[Odstopanje],0),3) * ROUND(P1.[C+]/(CASE WHEN OZT.Sifra = 'GJS' THEN 1.03 ELSE 1.00 end),2) 
													 ELSE ROUND(ISNULL(R.[Odstopanje],0),3) * ROUND(P1.[C-]/(CASE WHEN OZT.Sifra = 'GJS' THEN 0.97 ELSE 1.00 end),2) END) AS Saldo,
											SUM(ROUND(ISNULL(R.[Odstopanje],0),3)) AS SkupnaOdstopanja,
                                            R.Interval
                                      FROM
                                       [#OsebeZaSaldoObdobja] S
                                       JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID] AND R.[ObracunID]=@NewObracunID
                                       JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval AND P1.[ObracunID]=@NewObracunID
                                       JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                       JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                                                              
                                     WHERE 
                                       R.[ObracunID] = @NewObracunID 
                                       AND P1.[ObracunID] = @NewObracunID 
                                       AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                 AND     dbo.infinite(OZ.DatumSpremembe)
                                          GROUP BY R.Interval
                                     ) O
                                     WHERE PodatkiObracuna_Skupni.ObracunID= @NewObracunID AND
                                     PodatkiObracuna_Skupni.[Interval] = O.Interval
                                     
                                     
                                     --KONTROLA SISTEMA
 --                                    EXEC [dbo].[BilancniObracun_Kontrola_Sistema]
	--@DatumStanjaBaze = @DatumStanjaBaze,
	--									@DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
	--@NewObracunID = @NewObracunID,
	--@DatumIntervalaDO = @DatumIntervalaDO,
	--									@DatumIntervalaOD = @DatumIntervalaOD

--SELECT * FROM [dbo].[Kontrola_Sistema] ORDER BY [Interval] asc
                                     
                           
                                     --KOREKCIJA 
                                     
                                        IF ( @debugMode > 0 ) 
                                            PRINT 'Korekcija'
                                        EXEC dbo.BilancniObracun_Korekcija 
													@DatumIntervalaDO = @DatumIntervalaDO,
													@DatumIntervalaOD = @DatumIntervalaOD,
													@DatumStanjaBaze = @DatumStanjaBaze,
													@DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
													@NewObracunID = @NewObracunID,
													@NOErrors = @NOErrorsOUT OUTPUT, 
													@ErrorHeadXML = @ValidationErrorsXML OUTPUT,
													@ErrorDetailsXML = @ValidationErrorsDetailXML OUTPUT

                                        IF ( @debugMode > 0 ) 
                                            PRINT 'Korekcija - END'   		       						
			       							
			       							DECLARE @CenaIzravnave DECIMAL(24, 8) ;
        DECLARE @SaldoOsnovnihObracunov DECIMAL(24, 8) ;
        		       						
		
		SELECT  @CenaIzravnave = SUM(SroskiIzravnave),
                @SaldoOsnovnihObracunov = SUM(SaldoStroskiObracunov)
        FROM    PodatkiObracuna_Skupni
        WHERE   [ObracunID] = @NewObracunID 


        --    SELECT  'SkupniPOdatki PO KOREKCIJI',
        --        *
        --FROM    PodatkiObracuna_Skupni R
        --ORDER BY DATEPART(day, R.[Interval]) ASC,
        --        DATEPART(month, R.[Interval]) ASC,
        --        ( CASE WHEN DATEPART(HH, R.[Interval]) = 0 THEN 24
        --               ELSE DATEPART(HH, R.[Interval])
        --          END ) ASC
        
        
      
        --SELECT 'PO KOREKCII', @SaldoOsnovnihObracunov , @CenaIzravnave,@SaldoOsnovnihObracunov - @CenaIzravnave
        
			       			--SELECT 'TolerancniPas',* FROM [dbo].[TolerancniPas] WHERE [ObracunID]= @NewObracunID  AND interval='2012-01-14 23:00:00'
			       				
                                        DROP TABLE #OsebeZaSaldoObdobja

		--CENA ODSTOPANJ
                                        IF ( @debugMode > 0 ) 
                                            PRINT 'PodatkiObracuna'
                                            
                                        INSERT  INTO [PodatkiObracuna]
                                                (
                                                  [ObracunID],
                                                  [OsebaID],
                                                  [Interval],
                                                  [TolerancniPas],
                                                  [Odstopanje],
                                                  [Cplus],--stara pravila
                                                  [Cminus],--stara pravila
                                                  [CpNov],--OBSOLETE
                                                  [CnNov],--OBSOLETE
                                                  Ckplus,
                                                  Ckminus,
                                                  Zplus,--stara pravila
                                                  Zminus,--stara pravila
                                                  [PoravnavaZunajT],--stara pravila
                                                  [PoravnavaZnotrajT]--stara pravila
                                                )
                                                SELECT  @NewObracunID,
                                                        TP.[OsebaID],
                                                        TP.[Interval],
                                                        TP.[KoregiranT],
                                                        K.Odstopanje,
                                                        P.[C+],--stara pravila
                                                        P.[C-],--stara pravila
                                                        P.[C+'], --C+'
                                                        P.[C-'], --C-'
                                                        (CASE WHEN Z.Sifra <> 'GJS' THEN
															(CASE 
																WHEN K.Odstopanje <= TP.[KoregiranT] THEN 0.0
																WHEN TP.[KoregiranT] < K.Odstopanje AND K.Odstopanje <= 4*TP.[KoregiranT] THEN POWER(ROUND(((ROUND(K.Odstopanje,2)-ROUND(TP.[KoregiranT],2))/(3*ROUND(TP.[KoregiranT],2))),3),2)*P.[C+']
																WHEN 4*TP.[KoregiranT] < K.Odstopanje THEN P.[C+']
															 END)
                                                         ELSE 0.0 --GJS
                                                         END)
                                                         , --Ck+
                                                         (CASE WHEN Z.Sifra <> 'GJS' THEN
                                                        (CASE 
															WHEN -1*TP.[KoregiranT] <= K.Odstopanje THEN 0
															WHEN -4*TP.[KoregiranT] <= K.Odstopanje AND K.Odstopanje < -1*TP.[KoregiranT] THEN POWER(ROUND(((ROUND(K.Odstopanje,2)+ROUND(TP.[KoregiranT],2))/(3*ROUND(TP.[KoregiranT],2))),3),2)*P.[C-']
															WHEN K.Odstopanje < -4*TP.[KoregiranT] THEN P.[C-']
                                                         END)
                                                            ELSE 0.0 --GJS
                                                         END), --Ck-
                                                         (CASE WHEN Z.Sifra <> 'GJS' THEN
                                                        (CASE WHEN (K.Odstopanje > 0 AND K.Odstopanje < TP.[KoregiranT]) OR (K.[Odstopanje] > 0 AND K.[Odstopanje] > TP.[KoregiranT] AND P.[C+] < 0) THEN P.[C+]*ROUND(K.Odstopanje,2)
															  WHEN K.[Odstopanje] > 0 AND K.[Odstopanje] > TP.[KoregiranT] AND P.[C+] > 0 
																		THEN (P.[C+]*ROUND(K.Odstopanje,2))
																				+ (K.[Odstopanje] - TP.[KoregiranT])*  (CASE 
																													WHEN K.Odstopanje <= TP.[KoregiranT] THEN 0.0
																													WHEN TP.[KoregiranT] < K.Odstopanje AND K.Odstopanje <= 4*TP.[KoregiranT] 
																															THEN POWER(ROUND(((ROUND(K.Odstopanje,2)-ROUND(TP.[KoregiranT],2))/(3*ROUND(TP.[KoregiranT],2))),3),2)*P.[C+']
																													WHEN 4*TP.[KoregiranT] < K.Odstopanje THEN P.[C+']
																												 END) --Ck+
															 ELSE 0.0
                                                         END)
                                                          ELSE 
                                                          (CASE WHEN K.[Odstopanje] > 0 THEN P.[C+']*ROUND(K.Odstopanje,2)/1.03 
																ELSE  P.[C-']*ROUND(K.Odstopanje,2)/0.97  
															END)--GJS
                                                         END),--Zplus --zotraj T poravnava POZITIVNA
                                                         (CASE WHEN Z.Sifra <> 'GJS' THEN
                                                        (CASE WHEN (K.Odstopanje < 0 AND K.Odstopanje < TP.[KoregiranT]) OR (K.[Odstopanje] < 0 AND K.[Odstopanje] > TP.[KoregiranT] AND P.[C-] < 0) THEN P.[C-]*ROUND(K.Odstopanje,2)
															  WHEN K.[Odstopanje] < 0 AND K.[Odstopanje] > TP.[KoregiranT] AND P.[C-'] > 0 
																		THEN (P.[C-']*ROUND(K.Odstopanje,2))
																				- (K.[Odstopanje] + TP.[KoregiranT])*  (CASE 
																													WHEN -1*TP.[KoregiranT] <= K.Odstopanje THEN 0
																													WHEN -4*TP.[KoregiranT] <= K.Odstopanje AND K.Odstopanje < -1*TP.[KoregiranT] 
																													      THEN POWER(ROUND(((ROUND(K.Odstopanje,2)+ROUND(TP.[KoregiranT],2))/(3*ROUND(TP.[KoregiranT],2))),3),2)*P.[C-']
																													WHEN K.Odstopanje < -4*TP.[KoregiranT] THEN P.[C-']
																											   END)  --Ck-
                                                              ELSE 0.0
                                                         END)
                                                          ELSE   
                                                           (CASE WHEN K.[Odstopanje] > 0 THEN P.[C+']*ROUND(K.Odstopanje,2)/1.03 
																ELSE  P.[C-']*ROUND(K.Odstopanje,2)/0.97  
															END)--GJS --GJS
                                                         END),--zMinus --zotraj T poravnava negativna
                                                        (CASE WHEN Z.Sifra <> 'GJS' THEN
                                                       (CASE WHEN K.Odstopanje > 0 THEN 
															(CASE WHEN P.[C+'] < 0 THEN ROUND(K.Odstopanje,2) * P.[C+']
																  ELSE ROUND(K.Odstopanje - TP.KoregiranT,2)*
																														((CASE 
																															WHEN K.Odstopanje <= TP.[KoregiranT] THEN 0.0
																															WHEN TP.[KoregiranT] < K.Odstopanje AND K.Odstopanje <= 4*TP.[KoregiranT] THEN POWER(ROUND(((ROUND(K.Odstopanje,2)-ROUND(TP.[KoregiranT],2))/(3*ROUND(TP.[KoregiranT],2))),3),2)*P.[C+']
																															WHEN 4*TP.[KoregiranT] < K.Odstopanje THEN P.[C+']
																														 END) /*--Ck+*/
																														 +
																														(CASE 
																															WHEN -1*TP.[KoregiranT] <= K.Odstopanje THEN 0
																															WHEN -4*TP.[KoregiranT] <= K.Odstopanje AND K.Odstopanje < -1*TP.[KoregiranT] THEN POWER(ROUND(((ROUND(K.Odstopanje,2)+ROUND(TP.[KoregiranT],2))/(3*ROUND(TP.[KoregiranT],2))),3),2)*P.[C-']
																															WHEN K.Odstopanje < -4*TP.[KoregiranT] THEN P.[C-']
																														 END))/*--Ck-*/
																  
																  END)
															else
															(CASE WHEN P.[C-'] < 0 THEN P.[C-'] * ROUND(K.Odstopanje,2) else -1*(ROUND(K.Odstopanje+TP.KoregiranT /*AAAA*/,2))*
																														((CASE 
																															WHEN K.Odstopanje <= TP.[KoregiranT] THEN 0.0
																															WHEN TP.[KoregiranT] < K.Odstopanje AND K.Odstopanje <= 4*TP.[KoregiranT] THEN POWER(ROUND(((ROUND(K.Odstopanje,2)-ROUND(TP.[KoregiranT],2))/(3*ROUND(TP.[KoregiranT],2))),3),2)*P.[C+']
																															WHEN 4*TP.[KoregiranT] < K.Odstopanje THEN P.[C+']
																														 END) /*--Ck+*/
																														 +
																														(CASE 
																															WHEN -1*TP.[KoregiranT] <= K.Odstopanje THEN 0
																															WHEN -4*TP.[KoregiranT] <= K.Odstopanje AND K.Odstopanje < -1*TP.[KoregiranT] THEN POWER(ROUND(((ROUND(K.Odstopanje,2)+ROUND(TP.[KoregiranT],2))/(3*ROUND(TP.[KoregiranT],2))),3),2)*P.[C-']
																															WHEN K.Odstopanje < -4*TP.[KoregiranT] THEN P.[C-']
																														 END))/*--Ck-*/
															 end)
															
														END)
														ELSE 0.0 --GJS
														END) ,--PoravnavaZunajT == PENALIZACIJA
														 (CASE WHEN Z.Sifra <> 'GJS' THEN
                                                        (CASE WHEN K.Odstopanje > 0 THEN ROUND(K.Odstopanje,2) * P.[C+'] ELSE ROUND(K.Odstopanje,2) * P.[C-'] END)
                                                        ELSE
															(CASE WHEN K.[Odstopanje] > 0 THEN P.[C+']*ROUND(K.Odstopanje,2)/1.03 
																ELSE  P.[C-']*ROUND(K.Odstopanje,2)/0.97  
															END)--GJS 
                                                        END)  --PoravnavaZnotrajT == OSNOVNI OBRAÈUN
                                                FROM    [TolerancniPas] TP
														INNER JOIN [dbo].[PodatkiObracuna_Skupni] P ON  P.[ObracunID] = @NewObracunID AND TP.[Interval] = P.[Interval]
                                                        INNER JOIN [KolicinskaOdstopanjaPoBS] K ON K.[ObracunID] = @NewObracunID  AND TP.OsebaID = K.OsebaID
                                                                                                   AND TP.Interval = K.Interval
                                                        INNER JOIN [TrzniPlan] T ON TP.[OsebaID] = T.OsebaID
                                                                                    AND TP.[Interval] = T.[Interval]
                                                        LEFT JOIN [Izravnava] I ON ( TP.Interval = I.Interval
                                                                                     AND TP.OsebaID = I.OsebaID
                                                                                     AND ( @DatumStanjaBaze BETWEEN I.[DatumVnosa]
                                                                                                            AND     dbo.infinite(I.DatumSpremembe) )
                                                                                   )
                                                        LEFT JOIN dbo.Izpadi Izp ON Izp.interval = Tp.interval
                                                                                    AND Izp.OsebaID = Tp.osebaID
                                                                                    AND ( @DatumStanjaBaze BETWEEN Izp.[DatumVnosa]
                                                                                                           AND     dbo.infinite(Izp.DatumSpremembe) )
                                                        INNER JOIN dbo.OsebaTip OT ON TP.OsebaID = OT.OsebaID
                                                                                      AND ( @DatumStanjaBaze BETWEEN OT.[DatumVnosa]
                                                                                                             AND     dbo.infinite(OT.DatumSpremembe) )
                                                                                                             
														JOIN [dbo].[OsebaZCalc] ZC ON TP.[OsebaID] = ZC.[OsebaID]
														JOIN [dbo].[OsebaZId] Z ON ZC.[OsebaZID] = Z.[OsebaZId]
														
                                                WHERE   TP.[ObracunID] = @NewObracunID
                                                        AND K.[ObracunID] = @NewObracunID
                                                        AND TP.Interval >= @DatumIntervalaOD
                                                        AND TP.Interval <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                                        AND ( @DatumStanjaBaze BETWEEN T.[DatumVnosa]
                                                                               AND     dbo.infinite(T.DatumSpremembe) )
                                                        AND ( @DatumStanjaBaze BETWEEN ZC.[DatumVnosa]
                                                                       AND     dbo.infinite(ZC.DatumSpremembe) )    
                                                ORDER BY Tp.[Interval] ASC 
                      	                      
						
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 014: Napaka pri izvajanju bilanènega obraèuna.'
                                                        ) ;
                                            END
                                        IF ( @debugMode > 0 ) 
                                            PRINT 'Cena Odstopanj - END'	
                                            
                                         --SELECT 'AAA',* FROM 	PodatkiObracuna WHERE [ObracunID] = @NewObracunID AND [Interval] = '2012-01-14 23:00:00'
                                         
                                    END --imamo vse podatke za obraèun ..@CriticalError = 0
                                IF ( @debugMode > 0 ) 
                                    PRINT 'Obracun error '
                                        + CAST(@@ERROR AS VARCHAR)
                                        + ' error num '
                                        + CAST(@NOErrors AS VARCHAR)
		
				
                            END --imamo podatke za obraun
                        ELSE 
                            BEGIN
                                INSERT  INTO [#Errors] ( [Napaka] )
                                VALUES  (
                                          'Napaka 000: Ni podatkov za obraèun (meritve).'
                                        ) ;
                                SET @ValidationErrorsXML = ( SELECT *
                                                             FROM   #Errors
                                                           FOR
                                                             XML PATH('Napake'),
                                                                 ROOT('Root')
                                                           )
                                SET @NewObracunID = -10
                            END
                    END--end obraèun
                ELSE 
                    BEGIN
			--error
                        INSERT  INTO [#Errors] ( [Napaka] )
                        VALUES  (
                                  'Napaka 000: Napaèni vhodni parametri.'
                                ) ;
                        SET @ValidationErrorsXML = ( SELECT *
                                                     FROM   #Errors
                                                   FOR
                                                     XML PATH('Napake'),
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
                                             XML PATH('Napake'),
                                                 ROOT('Root')
                                           )
                IF ( SELECT COUNT(*)
                     FROM   [#ErrorDetail]
                   ) > 0 
                    SET @ValidationErrorsDetailXML = ( SELECT   *
                                                       FROM     [#ErrorDetail]
                                                     FOR
                                                       XML PATH('ErrorDetail'),
                                                           ROOT('Root')
                                                     )
                SET @NewObracunID = -3 ;										
            END

        IF OBJECT_ID('tempDB..#Errors') IS NOT NULL 
            DROP TABLE #Errors
 

        IF EXISTS ( SELECT  name
                    FROM    sys.indexes
                    WHERE   name = N'IX_KorekcijaTP' ) 
            DROP INDEX IX_KorekcijaTP ON #KorekcijaTP ;

        IF OBJECT_ID('#KorekcijaTP') IS NOT NULL 
            DROP TABLE #KorekcijaTP
    

  --IF ( @NOErrors = 0 ) 
  --  BEGIN 
  --    ROLLBACK TRANSACTION OBRACUN --FOR DEMO ONLY ... ALLWAYS ROLLBACK
  --  end 
  --ELSE 
  --  BEGIN
  --    ROLLBACK TRANSACTION OBRACUN
  --  END
  
        RETURN @NewObracunID

    END

