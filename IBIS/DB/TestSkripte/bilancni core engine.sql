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
    @Naziv VARCHAR(50),
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
        DECLARE @CPlus DECIMAL(18, 8) 
        DECLARE @CMinus DECIMAL(18, 8) 
        DECLARE @CPlusNov DECIMAL(18, 8) 
        DECLARE @CMinusNov DECIMAL(18, 8) 
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
                                  ObracunTipID
                                )
                                SELECT  @NewObracunID,
                                        @ObracunskoObdobjeID,
                                        ObracunStatusID,
                                        GETDATE(),
                                        @Avtor,
                                        @Naziv,
                                        1
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
                                        
--                                        /*REGION REALIZACIJA CHECK*/
--SELECT  'Realizacija',R.*,O1.[Naziv] AS Oseba,O2.[Naziv] AS Nadrejena, O3.[Naziv] AS SistemskiOperater
--FROM    dbo.RealizacijaPoDobaviteljih R JOIN [dbo].[Oseba] O1 ON R.[OsebaID] = O1.[OsebaID] AND O1.[DatumSpremembe] IS NULL AND O1.[VeljaDo] IS NULL 
--JOIN [dbo].[Oseba] O2 ON R.[NadrejenaOsebaID] = O2.[OsebaID] AND O2.[DatumSpremembe] IS NULL AND O2.[VeljaDo] IS NULL 
--JOIN [dbo].[Oseba] O3 ON R.[SistemskiOperaterID] = O3.[OsebaID] AND O3.[DatumSpremembe] IS NULL AND O3.[VeljaDo] IS NULL 
--WHERE   R.ObracunID = @NewObracunID
--        AND R.Interval = '2012-01-01 01:00:00.000'
--ORDER BY R.OsebaID ASC


--/*REGION REALIZACIJA CHECK*/
--SELECT  'Realiczacija BS',R.*
--FROM    dbo.[RealizacijaPoBS] R
--WHERE   R.ObracunID = @NewObracunID
--        AND R.Interval = '2012-01-01 01:00:00.000'
--ORDER BY R.Interval ASC,R.OsebaID ASC

--SELECT  'Realiczacija BPS',R.*
--FROM    dbo.[RealizacijaPoBPS] R
--WHERE   R.ObracunID = @NewObracunID
--        AND R.Interval = '2012-01-01 01:00:00.000'
--ORDER BY R.Interval ASC,R.OsebaID ASC
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
                                      VrednostKorekcijeTP DECIMAL(18, 8) NULL,
                                      Kolicina DECIMAL(18, 8) NOT NULL,
                                      KoregiranTP DECIMAL(18, 8) NOT NULL
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
				--SELECT 'TP pred regukacijo0',* FROM [dbo].[TrzniPlan] WHERE [OsebaID]=3 AND [Interval] = '2012-01-02 00:00:00'
				
  --	      še sekundarna in tercilana regulacija
                                UPDATE  [TrzniPlan]
                                SET     [KoregiranTP] = ISNULL([KoregiranTP], 0)
                                        - ISNULL(R.[SekRegM] + R.[SekRegP]
                                                 + R.[TerRegM] + R.[TerRegP],
                                                 0),
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
             --SELECT 'PO regukacijo0',* FROM [dbo].[TrzniPlan] WHERE [OsebaID]=3 AND [Interval] = '2012-01-02 00:00:00'
                                --IF ( @debugMode = 4 ) 
                                --    SELECT  'DEBUG trzniPlan',
                                --            *
                                --    FROM    [dbo].[TrzniPlan]
                                --    WHERE   [Interval] = '2012-01-01 01:00:00.000'
                                    
                                    
              --Napolnimo polje za ugotavljanje korekcije tržnega plana
                                UPDATE  dbo.TrzniPlan
                                SET     VrednostPopravkaTP = Kolicina
                                        - KoregiranTP
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
                                --IF ( @debugMode = 2 ) 
                                --    SELECT  'DEBUG',
                                --            *
                                --    FROM    [dbo].[TrzniPlan]
                                --    WHERE   [Interval] = '2012-01-01 01:00:00.000'
             
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
                                        KoregiranTP = ISNULL(KTP.Kolicina, 0)
                                        - ISNULL(ATP.VrednostKorekcijeTP, 0)
                                FROM    #KorekcijaTP KTP
                                        INNER JOIN #AgregiranTP ATP ON KTP.OsebaId = ATP.NadrejenaOsebaID
                                                                       AND KTP.Interval = ATP.Interval


                                UPDATE  dbo.TrzniPlan
                                SET     VrednostPopravkaTP = ISNULL(KTP.VrednostKorekcijeTP, 0),
                                        KoregiranTP = ISNULL(KTP.KoregiranTP,
                                                             0)
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
                
                                IF ( @debugMode = 4 ) 
                                    SELECT  'Koregiran navzgor',
                                            *
                                    FROM    [dbo].[TrzniPlan]
                                    WHERE   [Interval] = '2012-01-01 01:00:00.000'
			
                                IF ( @debugMode = 4 ) 
                                    PRINT 'KOREKCIJA TP - END'
			
              --èe do sedaj nismo imeli kritiène napake in imamo vse potrebne vhodne podatke, lahko gremo v izraèun Kolièinskih odstopanj
                                IF ( @debugMode > 0 ) 
                                    PRINT 'Critical error '
                                        + CAST(@CriticalError AS VARCHAR)
              
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
                                                  [ObracunID]
						
                                                )
                                                SELECT  RBPS.Kolicina,
                                                        ISNULL(Tp.KoregiranTP, 0),
                                                        RBPS.Kolicina
                                                        - ISNULL(Tp.KoregiranTP, 0),
                                                        RBPS.OsebaID,
                                                        RBPS.Interval,
                                                        @NewObracunID
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
                                                  [ObracunID]
						
                                                )
                                                SELECT  RBS.Kolicina,
                                                        ISNULL(Tp.KoregiranTP, 0),
                                                        RBS.Kolicina-ISNULL(Tp.KoregiranTP, 0),
                                                        RBS.OsebaID,
                                                        RBS.Interval,
                                                        @NewObracunID
                                                FROM    [RealizacijaPoBS] RBS
                                                        INNER JOIN [TrzniPlan] TP ON RBS.[Interval] = TP.[Interval]
                                                                                     AND Tp.[OsebaID] = RBS.[OsebaID]
                                                WHERE   RBS.[ObracunID] = @NewObracunID
                                                        AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
                                                                               AND     dbo.infinite(TP.DatumSpremembe) )

       SELECT 'Kolièinks HSE',* FROM [dbo].KolicinskaOdstopanjaPoBS WHERE [OsebaID]=3 AND [Interval] = '2012-01-01 00:00:00'
       
        SELECT 'REALIZACIJA HSE',* FROM [dbo].RealizacijaPoBS WHERE [OsebaID]=3 AND [Interval] = '2012-01-02 00:00:00'
         
         
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
                                                        ISNULL(Tp.KoregiranTP, 0),
                                                        -1*ISNULL(Tp.KoregiranTP, 0),
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
                                            
                
              --                SELECT 'Kolicinksa Odstopanja TRGOVCI',
              --                 0,
              --                                          ISNULL(Tp.KoregiranTP, 0),
              --                                          -1*ISNULL(Tp.KoregiranTP, 0),
              --                                          O1.Naziv,
              --                                          TP.Interval,
              --                                          @NewObracunID
              --                                  FROM    [TrzniPlan] TP JOIN [dbo].[OsebaTip] O ON TP.[OsebaID] = O.[OsebaID] AND o.[OsebaTipID] = @TrgovecTipID
              --                                  JOIN Oseba O1 ON TP.[OsebaID] = O1.OsebaID
              --                                  WHERE  TP.[Interval] >= @DatumIntervalaOD
														--AND TP.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
              --                                          AND ( @DatumStanjaBaze BETWEEN TP.[DatumVnosa]
              --                                                                 AND     dbo.infinite(TP.DatumSpremembe) )
              --                                          AND ( @DatumStanjaBaze BETWEEN O.[DatumVnosa]
              --                                                                 AND     dbo.infinite(O.DatumSpremembe) )
              --                                                AND ( @DatumVeljavnostiPodatkov BETWEEN o1.VeljaOd
              --                                                                  AND     dbo.infinite(o1.VeljaDo) )
              --                         AND ( @DatumStanjaBaze BETWEEN o1.[DatumVnosa]
              --                                                         AND     dbo.infinite(o1.DatumSpremembe) )                   
     
     
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 010: Napaka pri kalkulaciji kolièinskega obraèuna po bilanènih skupinah (Trgovci).'
                                                        ) ;
                                            END 
                                            
			
                                        --IF ( @debugMode = 3 ) 
                                        --    SELECT  'ODSTOPANJA BPS',
                                        --            *
                                        --    FROM    KolicinskaOdstopanjaPoBPS
                                        --    WHERE   Interval = '2012-01-01 01:00:00.000'
                                        
                                        ----IF ( @debugMode = 3 ) 
                                        --    SELECT  'ODSTOPANJA BS',
                                        --            *
                                        --    FROM    KolicinskaOdstopanjaPoBS
                                        --    WHERE   Interval = '2012-01-01 01:00:00.000'

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
                                              Cplus DECIMAL(24, 8), --stara pravila
                                              Cminus DECIMAL(24, 8),--stara pravila
                                              SIPX DECIMAL(24, 8)
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
                                                                            END ), 0) AS DECIMAL(18, 8)), 8),
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
                                                                            END ), 0) AS DECIMAL(18, 8)), 8),
                                                           C.[Vrednost]
                                                FROM    [Izravnava] I
                                                        INNER JOIN [dbo].[SIPX] C ON I.Interval = C.Interval
                                                WHERE   I.Interval >= @DatumIntervalaOD
                                                        AND I.Interval <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                                        AND I.[DatumVnosa] <= @DatumStanjaBaze
                                                        AND ( @DatumStanjaBaze BETWEEN I.[DatumVnosa]
                                                                               AND     dbo.infinite(I.DatumSpremembe) )
                                                        AND ( @DatumStanjaBaze BETWEEN C.[DatumVnosa]
                                                                               AND     dbo.infinite(C.DatumSpremembe) )
													
											SELECT @@ROWCOUNT AS insertedInterval
											
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
										   		PodatkiObracuna_Skupni.TP_GJS = P1.TP_GJS ,
										   		PodatkiObracuna_Skupni.Realizacija_GJS = P1.Realizacija_GJS,
												PodatkiObracuna_Skupni.Odstopanje_GJS = P1.Odstopanje_GJS,										   	
												PodatkiObracuna_Skupni.[Wgjs_p] = P1.[Wgjs_p],
												PodatkiObracuna_Skupni.[Wgjs_m] = P1.[Wgjs_m]
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
										  GROUP BY G.Interval   
										  ) P1	
										 WHERE PodatkiObracuna_Skupni.[Interval] = P1.Interval
                                      
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 013: Napaka pri izraèunu odstopanj GJS.'
                                                        ) ;
                                            END
                              
                      
                                     
                                     UPDATE  P
                                     SET P.[C+]= T.Cplus,
										 P.[C-]= T.Cminus,
										 P.[C+']= T.Cplus,
										 P.[C-']= T.Cminus,
										 P.SIPXurni = T.SIPX
                                     FROM PodatkiObracuna_Skupni P JOIN [#tmpCena] T ON P.Interval = T.Interval
                                     WHERE ObracunID=@NewObracunID

									UPDATE PodatkiObracuna_Skupni
										  SET   
										   		PodatkiObracuna_Skupni.Wplusi = P1.Wpi,
												PodatkiObracuna_Skupni.Wminusi =P1.Wmi
										  FROM  
										  (
										  SELECT 
										   SUM(G.[W_p]) AS Wpi,
										   SUM(G.[W_m]) AS Wmi,
										   G.[Interval]	
										 FROM 
										  PodatkiObracuna_Skupni P 
										    JOIN #NonGJS G ON P.Interval = G.Interval
										  GROUP BY G.Interval   
										  ) P1	
										 WHERE PodatkiObracuna_Skupni.[Interval] = P1.Interval
                                      
                                        IF ( @@ERROR <> 0 ) 
                                            BEGIN
                                                SET @NOErrors = @NOErrors + 1
                                                INSERT  INTO [#Errors] ( [Napaka] )
                                                VALUES  (
                                                          'Napaka 013: Napaka pri izraèunu odstopanj non GJS.'
                                                        ) ;
                                            END
									
									
                                    
									SELECT 'TEST ODST PODROBNO',SUM(CASE WHEN ISNULL(R.[Odstopanje],0) > 0 THEN ISNULL(R.[Odstopanje],0) * P1.[C+]/(CASE WHEN OZT.Sifra = 'GJS' THEN 1.03 ELSE 1.00 end) 
													 ELSE ISNULL(R.[Odstopanje],0) * P1.[C-]/(CASE WHEN OZT.Sifra = 'GJS' THEN 0.97 ELSE 1.00 end) END) AS Saldo,
													 
											SUM(CASE WHEN ISNULL(R.[Odstopanje],0) > 0 THEN ISNULL(R.[Odstopanje],0) * P1.[C+] 
													 ELSE ISNULL(R.[Odstopanje],0) * P1.[C-] END) AS SaldoBrezDeljenjaGJS,
											SUM(ISNULL(R.[Odstopanje],0)) AS SkupnaOdstopanja,
                                            R.Interval,
                                            O.Naziv
                                      FROM
                                       [#OsebeZaSaldoObdobja] S
                                       JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                       JOIN Oseba O ON O.OsebaId = R.OsebaID 
                                       JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
                                       JOIN [dbo].[OsebaZCalc] OZ ON R.[OsebaID] = OZ.[OsebaID]
                                       JOIN [dbo].[OsebaZId] OZT ON OZ.[OsebaZID] = OZT.[OsebaZId]
                                                                              
                                     WHERE 
                                       R.[ObracunID] = @NewObracunID 
                                       AND R.[Interval] = '2012-01-09 20:00:00'
                                       AND P1.[ObracunID] = @NewObracunID 
                                       AND @DatumStanjaBaze BETWEEN OZ.[DatumVnosa]
                                                                 AND     dbo.infinite(OZ.DatumSpremembe)
                                       AND ( @DatumVeljavnostiPodatkov BETWEEN o.VeljaOd
                                                                                AND     dbo.infinite(o.VeljaDo) )
                                       AND ( @DatumStanjaBaze BETWEEN o.[DatumVnosa]
                                                                       AND     dbo.infinite(o.DatumSpremembe) )
                                  GROUP BY R.Interval,O.Naziv
                                          ORDER BY R.Interval asc
                        
                                    
         --                           SELECT 'Skupni Podatki Pred Korekcijo',
									--		R.[Odstopanje] AS SkupnaOdstopanja,
         --                                   R.Interval,
         --                                   R.[OsebaID]
         --                             FROM
         --                              [#OsebeZaSaldoObdobja] S
         --                              JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
         --                            WHERE 
         --                              R.[ObracunID] = @NewObracunID 
         --                              AND R.[Interval] between '2012-01-01 23:00:00' and '2012-01-02 00:00:00'
									--ORDER BY R.Interval ASC, R.[OsebaID] asc
                                  
                                  
                                  
                                     UPDATE  PodatkiObracuna_Skupni
                                     SET PodatkiObracuna_Skupni.SaldoStroskiObracunov = isnull(O.Saldo,0),
										 PodatkiObracuna_Skupni.SkupnaOdstopanja = O.SkupnaOdstopanja,
									     PodatkiObracuna_Skupni.Razlika = ISNULL(O.Saldo,0) - PodatkiObracuna_Skupni.SroskiIzravnave
                                     FROM 
                                     (
                                     SELECT SUM(CASE WHEN R.[Odstopanje] > 0 THEN R.[Odstopanje] * P1.[C+]/(CASE WHEN OZT.Sifra = 'GJS' THEN 1.03 ELSE 1 end) 
													 ELSE R.[Odstopanje] * P1.[C-]/(CASE WHEN OZT.Sifra = 'GJS' THEN 0.97 ELSE 1 end) END) AS Saldo,
											SUM(R.Odstopanje) AS SkupnaOdstopanja,
                                            R.Interval
                                      FROM
                                       [#OsebeZaSaldoObdobja] S
                                       JOIN [dbo].[KolicinskaOdstopanjaPoBS] R ON S.[Partner2] = R.[OsebaID]
                                       JOIN PodatkiObracuna_Skupni P1 ON R.Interval = P1.Interval
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


        
        SELECT  @CenaIzravnave AS CenaIzr,
                @SaldoOsnovnihObracunov AS Saldo
		
        SELECT 'PO KOREKCII', @SaldoOsnovnihObracunov , @CenaIzravnave,@SaldoOsnovnihObracunov - @CenaIzravnave
        
			       						
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
                                                  CPlusNov,--OBSOLETE
                                                  CMinusNov,--OBSOLETE
                                                  [Cp],--stara pravila
                                                  [Cn],--stara pravila
                                                  [CpNov],--OBSOLETE
                                                  [CnNov],--OBSOLETE
                                                  Ckplus,
                                                  Ckminus,
                                                  Zplus,--stara pravila
                                                  Zminus,--stara pravila
                                                  ZplusNov,--OBSOLETE
                                                  ZminusNov,--OBSOLETE
                                                  [PoravnavaZunajT],--stara pravila
                                                  [PoravnavaZnotrajT],--stara pravila
                                                  PoravnavaZnotrajTNova,--OBSOLETE
                                                  PoravnavaZunajTNova--OBSOLETE
									
                                                )
                                                SELECT  @NewObracunID,
                                                        TP.[OsebaID],
                                                        TP.[Interval],
                                                        TP.[NormiranT],
                                                        K.Odstopanje,
                                                        C.CPlus,--stara pravila
                                                        C.CMinus,--stara pravila
                                                        CAST(0 AS DECIMAL(24, 8)),--OBSOLETE
                                                        CAST(0 AS DECIMAL(24, 8)),--OBSOLETE
                                                        CAST(0 AS DECIMAL(24, 8)), --CpNov
                                                        CAST(0 AS DECIMAL(24, 8)), --CnNov
                                                        CAST(0 AS DECIMAL(24, 8)), --Ckplus
                                                        CAST(0 AS DECIMAL(24, 8)),--CkMinus
                                                        0,--OBSOLETE
                                                        0,--OBSOLETE
                                                        CAST(0 * K.Odstopanje AS DECIMAL(24, 8)),--Zplus
                                                        CAST(0 * K.Odstopanje AS DECIMAL(24, 8)),--zMinus
                                                        CAST(0 AS DECIMAL(24, 8)),----OBSOLETE
                                                        CAST(0 AS DECIMAL(24, 8)),----OBSOLETE
                                                        CAST(0 AS DECIMAL(24, 8)),--PoravnavaZunajT
                                                        CAST(0 AS DECIMAL(24, 8)),--PoravnavaZnotrajT
                                                        0,--OBSOLETE
                                                        0 --OBSOLETE
                                                FROM    [TolerancniPas] TP
                                                        INNER JOIN [KolicinskaOdstopanjaPoBS] K ON TP.OsebaID = K.OsebaID
                                                                                                   AND TP.Interval = K.Interval
                                                        INNER JOIN [TrzniPlan] T ON TP.[OsebaID] = T.OsebaID
                                                                                    AND TP.[Interval] = T.[Interval]
                                                        LEFT JOIN [Izravnava] I ON ( TP.Interval = I.Interval
                                                                                     AND TP.OsebaID = I.OsebaID
                                                                                     AND ( @DatumStanjaBaze BETWEEN I.[DatumVnosa]
                                                                                                            AND     dbo.infinite(I.DatumSpremembe) )
                                                                                   )
                                                        INNER JOIN [#tmpCena] C ON T.Interval = C.Interval
                                                        LEFT JOIN dbo.Izpadi Izp ON Izp.interval = Tp.interval
                                                                                    AND Izp.OsebaID = Tp.osebaID
                                                                                    AND ( @DatumStanjaBaze BETWEEN Izp.[DatumVnosa]
                                                                                                           AND     dbo.infinite(Izp.DatumSpremembe) )
                                                        INNER JOIN dbo.OsebaTip OT ON TP.OsebaID = OT.OsebaID
                                                                                      AND ( @DatumStanjaBaze BETWEEN OT.[DatumVnosa]
                                                                                                             AND     dbo.infinite(OT.DatumSpremembe) )
                                                WHERE   TP.[ObracunID] = @NewObracunID
                                                        AND K.[ObracunID] = @NewObracunID
                                                        AND TP.Interval >= @DatumIntervalaOD
                                                        AND TP.Interval <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                                        AND ( @DatumStanjaBaze BETWEEN T.[DatumVnosa]
                                                                               AND     dbo.infinite(T.DatumSpremembe) )
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

