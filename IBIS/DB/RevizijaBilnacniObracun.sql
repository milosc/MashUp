EXEC dbo.DropPRCorUDF	@ObjectName = 'RevizijaBilnacniObracun' --  varchar(max)
GO

-- =============================================
-- Author:		<Miloš Cigoj, milos.cigoj@t-2.net, milos.cigoj@korona.si>
-- Create date: <8.8.2008
-- Description:	<Bilancni obračun K-1248>
-- =============================================
CREATE PROCEDURE [dbo].[RevizijaBilnacniObracun]
  @ObracunskoObdobjeID INT,
  @DatumVeljavnostiPodatkov DATETIME = GETDATE,
  @DatumStanjaBaze DATETIME = GETDATE,
  @Avtor INT,
  @Naziv VARCHAR(50),
  @Obracun int, -- način obracunavanja (0-oba, 1-star nacin, 2-nov nacin,3-samo kolicinski)
  @Bs XML = null, --seznam BS za obračun
  @ObracunID INT OUTPUT, --ID generiranega obračuna
  @ValidationErrorsXML XML = '' OUTPUT, --glave napak
  @ValidationErrorsDetailXML xml = '' OUTPUT --vrstice posamezne napake
AS 
BEGIN
  SET ANSI_WARNINGS, ARITHABORT ON

  DECLARE @NewObracunID INT
  DECLARE @DatumIntervalaOD DATETIME
  DECLARE @DatumIntervalaDO DATETIME
  DECLARE @VsotaT DECIMAL(18, 8) --vsota tolerančnih pasov BS
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
--DECLARE @ObracunTipID INT
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
  
  BEGIN TRANSACTION OBRACUN

  --Postavitev globalnih konstant - ZAČETEK
  SELECT  @VIRT_ELES_MERITVE = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SOPO) VIRT_ELES_MERITVE'
  SELECT  @VIRT_MERJENI_ODJEM = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) VIRT_MERJENI_ODJEM'
  SELECT  @VIRT_NEMERJENI_ODJEM = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) VIRT_NEMERJENI_ODJEM'
  SELECT  @VIRT_MERJEN_ODDAJA = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) VIRT_MERJEN_ODDAJA'
  SELECT  @VIRT_NEMERJEN_ODDAJA = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) VIRT_NEMERJEN_ODDAJA'
  SELECT  @VIRT_REGULACIJA = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(REG) VIRT_REGULACIJA'
  SELECT  @VIRT_ELES_ODJEM = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = 'VIRT_ELES_ODJEM'
  SELECT  @VIRT_ELES_ODDAJA = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = 'VIRT_ELES_ODDAJA'
  SELECT  @VIRT_PBI = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) VIRT_PBI'
  SELECT  @VIRT_DSP = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) VIRT_DSP'
  SELECT  @UDO_P_MERJENI = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) UDO_P_MERJENI'
  SELECT  @UDO_P_NEMERJENI = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) UDO_P_NEMERJENI'
  SELECT  @UDO_P_IZGUBE = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) UDO_P_IZGUBE'
  SELECT  @MP_SKUPAJ = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) MP_SKUPAJ'
  SELECT  @MP_ND_NEMERJENI = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) MP_ND_NEMERJENI'
  SELECT  @MP_ND_MERJENI = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) MP_ND_MERJENI'
  SELECT  @MP_NP_NEMERJENI = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) MP_NP_NEMERJENI'
  SELECT  @MP_NP_MERJENI = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) MP_NP_MERJENI'
  SELECT  @MP_KP_NEMERJENI = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) MP_KP_NEMERJENI'
  SELECT  @MP_KP_MERJENI = [PPMTipID]
  FROM    [PPMTip]
  WHERE   Naziv = '(SODO) MP_KP_MERJENI'

  --TIP OBRAČUNA
  DECLARE @Obracun_Po_Novih_in_starih_pravilih INT
  DECLARE @Obracun_Po_obstojecih_pravilih INT
  DECLARE @Obracun_Po_Novih_pravilih INT
  DECLARE @Kolicinski_obracun INT
  DECLARE @CriticalError INT
  DECLARE @ValiodationErrors INT ;

  SELECT  @Obracun_Po_Novih_in_starih_pravilih = [ObracunTipID]
  FROM    [ObracunTip]
  WHERE   [Sifra] = 'NIS'
  SELECT  @Obracun_Po_obstojecih_pravilih = [ObracunTipID]
  FROM    [ObracunTip]
  WHERE   [Sifra] = 'S'
  SELECT  @Obracun_Po_Novih_pravilih = [ObracunTipID]
  FROM    [ObracunTip]
  WHERE   [Sifra] = 'N'
  SELECT  @Kolicinski_obracun = [ObracunTipID]
  FROM    [ObracunTip]
  WHERE   [Sifra] = 'K'
print '@Obraacun-'+cast(@Obracun as varchar)
print '@@Kolicinski_obracun-'+cast(@Kolicinski_obracun as varchar)

  --TIP POGODBE
  DECLARE @BP INT
  DECLARE @PI INT
  DECLARE @SSOPOBS INT
  DECLARE @PDOB INT
  DECLARE @PDSODOSOPO INT
  DECLARE @PDOBSODO INT

  SELECT  @BP = [PogodbaTipID]
  FROM    [PogodbaTip]
  WHERE   Sifra = 'B_POG'
  SELECT  @PI = [PogodbaTipID]
  FROM    [PogodbaTip]
  WHERE   Sifra = 'P_IZR'
  SELECT  @SSOPOBS = [PogodbaTipID]
  FROM    [PogodbaTip]
  WHERE   Sifra = 'S_SOPO_BS'
    
  SELECT  @PDOB = [PogodbaTipID]
  FROM    [PogodbaTip]
  WHERE   Sifra = 'P_DOB'

  DECLARE @SodoTipID INT
  SELECT  @SodoTipID = OsebaTipID
  FROM    OsebaTipID
  WHERE   Sifra = 'SODO'
  DECLARE @SOPOTipID INT
  SELECT  @SOPOTipID = OsebaTipID
  FROM    OsebaTipID
  WHERE   Sifra = 'SOPO'
  DECLARE @TrgovecTipID INT
  SELECT  @TrgovecTipID = OsebaTipID
  FROM    OsebaTipID
  WHERE   Sifra = 'TRG'
  DECLARE @RegulacijaTipID INT
  SELECT  @RegulacijaTipID = OsebaTipID
  FROM    OsebaTipID
  WHERE   Sifra = 'REG'
  DECLARE @SRegulacijaTipID INT
  SELECT  @SRegulacijaTipID = OsebaTipID
  FROM    OsebaTipID
  WHERE   Sifra = 'SREG'
  DECLARE @TRegulacijaTipID INT
  SELECT  @TRegulacijaTipID = OsebaTipID
  FROM    OsebaTipID
  WHERE   Sifra = 'TREG'
  DECLARE @OTTipID INT
  SELECT  @SodoTipID = OsebaTipID
  FROM    OsebaTipID
  WHERE   Sifra = 'OT'

  SET @CriticalError = 0 ;
  SET @ValiodationErrors = 0 ;

  SELECT  @k = cast(vrednost as decimal(18, 8))
  from    Nastavitev
  where   oznaka = 'BilancniObracun_k'
          AND ( @DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe) )

  SELECT  @RegulacijskoObmocjSR = cast(vrednost as decimal(18, 8))
  from    Nastavitev
  where   oznaka = 'RegulacijskoObmocjSR'
          AND ( @DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe) )

 --Postavitev globalnih konstant - KONEC
 
  
  --Kreiranje začasnih tabel za napake
  if object_id('#Errors') is not null 
    drop table #Errors
        
  CREATE TABLE #Errors
  (
    ErrorID BIGINT IDENTITY(1, 1)
                   NOT NULL,
    Napaka VARCHAR(255) NOT NULL
  )

  if object_id('#ErrorDetail') is not null 
    drop table #ErrorDetail
        
  CREATE TABLE #ErrorDetail
  (
    ErrorID BIGINT,
    ErrorDetail VARCHAR(900) NOT NULL
  )
   
  SELECT  @DatumIntervalaOD = [VeljaOd],
          @DatumIntervalaDO = [VeljaDo]
  FROM    [ObracunskoObdobje]
  WHERE   [ObracunskoObdobjeID] = @ObracunskoObdobjeID
          AND ( @DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe) )
    
  IF ( @RegulacijskoObmocjSR IS  null ) 
    BEGIN
      SET @NOErrors = @NOErrors + 1
      insert  into #Errors ( Napaka )
              SELECT  'Napaka 000a: Šifrant regulacijsko obmošje RS ni izpolnjen. Preverite Nastavitve.'
    END
      
  IF ( @NOErrors = 0 ) 
    begin      
	  --VALIDACIJA Obračuna
      EXEC @ValiodationErrors = dbo.RevizijaBilancniObracun_Validacija @DatumIntervalaDO, @DatumStanjaBaze, @DatumIntervalaOD,
        @DatumVeljavnostiPodatkov, @MP_KP_NEMERJENI, @MP_NP_NEMERJENI, @NOErrorsOUT, @VIRT_MERJENI_ODJEM,
        @VIRT_NEMERJEN_ODDAJA, @VIRT_PBI, @VIRT_NEMERJENI_ODJEM, @ErrorHeadXML = @ValidationErrorsXML output,
        @ErrorDetailsXML = @ValidationErrorsDetailXML OUTPUT,@ObracunTipID = @Obracun
	  
      IF ( @ValiodationErrors > 0 ) 
        BEGIN
          SET @NOErrors = @NOErrors + 1
          declare @hdocVTC1 int ;
          declare @xmlpath1 varchar(255) ;
          set @xmlpath1 = '/Root/Napake' ;
          exec sp_xml_preparedocument @hdocVTC1 OUTPUT, @ValidationErrorsXML ;

          insert  into #Errors ( Napaka )
                  select  Napaka
                  from    openxml(@hdocVTC1,@xmlpath1,2) with ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                  order by ErrorID asc     
          exec sp_xml_removedocument @hdocVTC1
				
          set @xmlpath1 = '/Root/ErrorDetail' ;
          exec sp_xml_preparedocument @hdocVTC1 OUTPUT, @ValidationErrorsDetailXML ;

          insert  into #ErrorDetail ( ErrorDetail )
                  select  ErrorDetail
                  from    openxml(@hdocVTC1,@xmlpath1,2) with ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                  order by ErrorID asc     
          exec sp_xml_removedocument @hdocVTC1
		
        END
	  --END VALIODACIJA
    END
  
  --če nimamo napak pri validaciji lahko stopimo v naslednji korak obračuna
  --če imamo količinsko oračun grem kljub napakam dalje. Napake pa shranimo za prikaz.
  IF ( @NOErrors = 0) 
    BEGIN	
    --Pridobitev naslednjega prostega ID-ja
      SELECT  @NewObracunID = ISNULL(MAX(ObracunID), 0) + 1
      FROM    [Obracun]
 
        
	  --še enkrat preverimo vhodne parametre
      IF (
           @NewObracunID > 0
           AND @DatumIntervalaOD IS NOT NULL
           AND @DatumIntervalaDO IS NOT null
         ) 
        BEGIN	--obračun

			--naredimo nov obračun za potrebe sledenja bomo novi ObracunID postavili v vse obračunske tabele.
          INSERT  INTO [Obracun]
            (
              [ObracunID],
              [ObracunskoObdobjeID],
              [ObracunStatusID],
              [DatumVnosa],
              [Avtor],
              [Naziv],
              ObracunTipID
			
            )     Select  @NewObracunID,
                          @ObracunskoObdobjeID,
                          ObracunStatusID,
                          GETDATE(),
                          @Avtor,
                          @Naziv,
                          @Obracun
                  FROM    [ObracunStatus]
                  WHERE   Sifra = 'INF'
			
         
          IF ( @@ERROR <> 0 ) 
            BEGIN
              SET @NOErrors = @NOErrors + 1
              INSERT  INTO [#Errors] ( [Napaka] )
              VALUES  (
                        'Napaka 001: Napaka pri inicilaizaciji obračuna.'
                      ) ;
            END
			
		  print 'Realizacija po dobavteljih'			
		  --REALIZACIAJ PO DOBAVITELJIH
          EXEC dbo.RevizijaBilancniObracun_RealizacijaPoDobaviteljih @BP, @Bs, @DatumIntervalaDO, @DatumIntervalaOD,
            @DatumStanjaBaze, @DatumVeljavnostiPodatkov, @NewObracunID, @NOErrorsOUT OUTPUT, @PI, @UDO_P_IZGUBE,
            @VIRT_ELES_MERITVE, @VIRT_MERJEN_ODDAJA, @VIRT_MERJENI_ODJEM, @VIRT_NEMERJEN_ODDAJA, @VIRT_NEMERJENI_ODJEM,
            @VIRT_REGULACIJA, @ValidationErrorsXML output, @ValidationErrorsDetailXML OUTPUT



          IF ( @NOErrorsOUT <> 0 ) 
            BEGIN
              SET @NOErrors = @NOErrors + 1 ;
              declare @hdocVTC2 int ;
              declare @xmlpath2 varchar(255) ;
              set @xmlpath2 = '/Root/Napake' ;
              exec sp_xml_preparedocument @hdocVTC2 OUTPUT, @ValidationErrorsXML ;

              insert  into #Errors ( Napaka )
                      select  Napaka
                      from    openxml(@hdocVTC2,@xmlpath2,2) with ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                      order by ErrorID asc     
              exec sp_xml_removedocument @hdocVTC2
						
              set @xmlpath2 = '/Root/ErrorDetail' ;
              exec sp_xml_preparedocument @hdocVTC2 OUTPUT, @ValidationErrorsDetailXML ;

              insert  into #ErrorDetail ( ErrorDetail )
                      select  ErrorDetail
                      from    openxml(@hdocVTC2,@xmlpath2,2) with ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                      order by ErrorID asc     
              exec sp_xml_removedocument @hdocVTC2
				
            END
			--END REALIZACIAJ PO DOBAVITELJIH
			

		  --če imamo vsaj en zapis v realizaciji po dobavitejih potem imamo realne možnosti za nadaljevanje obračuna
		  --TO-DO: za še nadlajno optimizacijo lahko vrnemo record_count že iz SP BilanciObracun_RealizacijaPODobaviteljih
          IF ( (
                 SELECT COUNT(*)
                 FROM   [RealizacijaPoDobaviteljih]
                 WHERE  ObracunID = @NewObracunID
               ) > 0 ) 
            BEGIN --imamo podatke za obračun

			
			--Izračun realizacije BPS in BS
			print 'ralizacija BPS in BS'
              EXEC dbo.RevizijaBilancniObracun_RealizacijaBSinBPS @BP, @DatumStanjaBaze, @DatumVeljavnostiPodatkov,
                @NewObracunID, @NOErrorsOUT OUTPUT, @PI, @ValidationErrorsXML output, @ValidationErrorsDetailXML OUTPUT
                

              IF ( @NOErrorsOUT <> 0 ) 
                BEGIN
                  SET @NOErrors = @NOErrors + 1 ;
                  declare @hdocVTC6 int ;
                  declare @xmlpath6 varchar(255) ;
                  set @xmlpath6 = '/Root/Napake' ;
                  exec sp_xml_preparedocument @hdocVTC6 OUTPUT, @ValidationErrorsXML ;

                  insert  into #Errors ( Napaka )
                          select  Napaka
                          from    openxml(@hdocVTC6,@xmlpath6,2) with ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                          order by ErrorID asc     
                  exec sp_xml_removedocument @hdocVTC6
						
                  set @xmlpath6 = '/Root/ErrorDetail' ;
                  exec sp_xml_preparedocument @hdocVTC6 OUTPUT, @ValidationErrorsDetailXML ;

                  insert  into #ErrorDetail ( ErrorDetail )
                          select  ErrorDetail
                          from    openxml(@hdocVTC6,@xmlpath6,2) with ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                          order by ErrorID asc     
                  exec sp_xml_removedocument @hdocVTC6
				
                END
              PRINT 'Critical error ' + CAST(@CriticalError AS VARCHAR)
			 --preverimo če imamo vse podatke za naslednje korake. Tukaj se preverja če imamo za obračun na voljo CSLOEX, TržniPlan,...
              EXEC dbo.RevizijaBilancniObracun_CheckInputSets @CriticalError OUTPUT, @DatumIntervalaDO, @DatumIntervalaOD,
                @DatumStanjaBaze, @DatumVeljavnostiPodatkov, @NOErrorsOUT OUTPUT, @ValidationErrorsXML output,
                @ValidationErrorsDetailXML OUTPUT,@ObracunTipID = @Obracun
              IF ( @NOErrorsOUT <> 0 ) 
                BEGIN
                  SET @NOErrors = @NOErrors + 1 ;
                  declare @hdocVTC7 int ;
                  declare @xmlpath7 varchar(255) ;
                  set @xmlpath7 = '/Root/Napake' ;
                  exec sp_xml_preparedocument @hdocVTC7 OUTPUT, @ValidationErrorsXML ;

                  insert  into #Errors ( Napaka )
                          select  Napaka
                          from    openxml(@hdocVTC7,@xmlpath7,2) with ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                          order by ErrorID asc     
                  exec sp_xml_removedocument @hdocVTC7
						
                  set @xmlpath7 = '/Root/ErrorDetail' ;
                  exec sp_xml_preparedocument @hdocVTC7 OUTPUT, @ValidationErrorsDetailXML ;

                  insert  into #ErrorDetail ( ErrorDetail )
                          select  ErrorDetail
                          from    openxml(@hdocVTC7,@xmlpath7,2) with ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                          order by ErrorID asc     
                  exec sp_xml_removedocument @hdocVTC7
				
                END
									
			 --ZAČASNA tabela za potrebe agregacije navzgor
              if object_id('#KorekcijaTP') is not null 
                drop table #KorekcijaTP
				
    
              CREATE TABLE #KorekcijaTP
              (
                Interval DATETIME NOT NULL,
                OsebaId INT NOT null,
                Nivo INT NOT NULL,
                NadrejenaOsebaID INT NOT NULL,
                VrednostKorekcijeTP DECIMAL(18, 8) NULL,
                Kolicina DECIMAL(18, 8) NOT NULL,
                KoregiranTP DECIMAL(18, 8) NOT null
              )
			 
              CREATE NONCLUSTERED INDEX IX_KorekcijaTP ON #KorekcijaTP ( Interval, OsebaId ) ;

			 
			  --inicializacija Tržnega Plana
              UPDATE  [TrzniPlan]
              SET     KoregiranTP = TP.Kolicina,
                      [JeKorigiran] = 0,
                      VrednostPopravkaTP = 0
              FROM    [TrzniPlan] TP
              WHERE   TP.[Interval] > @DatumIntervalaOD
                      AND TP.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                      AND ( @DatumStanjaBaze between TP.[DatumVnosa]
                                             and     dbo.infinite(TP.DatumSpremembe) )
				
		
--			še sekundarna in tercilana regulacija
              UPDATE  [TrzniPlan]
              SET     [KoregiranTP] = ISNULL([KoregiranTP], 0) - ISNULL(R.[SekRegM] + R.[SekRegP] + R.[TerRegM]
                                                                        + R.[TerRegP], 0),
                      [JeKorigiran] = 1
              FROM    [TrzniPlan] TP
                      JOIN PPM M ON Tp.[OsebaID] = M.Dobavitelj1
                                    and M.[PPMTipID] = @VIRT_REGULACIJA
                      LEFT JOIN [Regulacija] R ON M.[PPMID] = R.PPMID
                                                  AND R.Interval = TP.Interval
              WHERE   TP.[Interval] > @DatumIntervalaOD
                      AND TP.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                      AND ( @DatumStanjaBaze between TP.[DatumVnosa]
                                             and     dbo.infinite(TP.DatumSpremembe) )
                      AND ( @DatumStanjaBaze between R.[DatumVnosa] and dbo.infinite(R.DatumSpremembe) )
                      AND (
                            ( @DatumStanjaBaze between M.DatumVnosa and dbo.infinite(M.DatumSpremembe) )
                            and ( @DatumVeljavnostiPodatkov between M.VeljaOd and dbo.infinite(M.VeljaDo) )
                          )

              IF ( @@ERROR <> 0 ) 
                BEGIN
                  SET @NOErrors = @NOErrors + 1
                  INSERT  INTO [#Errors] ( [Napaka] )
                  VALUES  (
                            'Napaka 008f: Napaka pri izračunu koregiranega tržnega plana.'
                          ) ;
                END 
             
              --Napolnimo polje za ugotavljanje korekcije tržnega plana
              UPDATE  dbo.TrzniPlan
              SET     VrednostPopravkaTP = Kolicina - KoregiranTP
              WHERE   [Interval] > @DatumIntervalaOD
                      AND [Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                      AND ( @DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe) )
              IF ( @@ERROR <> 0 ) 
                BEGIN
                  SET @NOErrors = @NOErrors + 1
                  INSERT  INTO [#Errors] ( [Napaka] )
                  VALUES  (
                            'Napaka 008g: Napaka pri izračunu koregiranega tržnega plana - izračun faktorja korekcije TP.'
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
			  
                )     SELECT  TP.Interval,
                              TP.OsebaID,
                              P.Nivo,
                              P.NadrejenaOsebaID,
                              TP.VrednostPopravkaTP,
                              TP.Kolicina,
                              TP.KoregiranTP
                      FROM    dbo.TrzniPlan TP
                              INNER JOIN [Pogodba] P ON TP.OsebaID = P.[Partner2]
                      WHERE   TP.[Interval] > @DatumIntervalaOD
                              AND TP.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                              AND ( @DatumStanjaBaze between TP.[DatumVnosa]
                                                     and     dbo.infinite(TP.DatumSpremembe) )
                              AND P.Nivo > 0
                              AND (
                                    P.[PogodbaTipID] = @BP
                                    OR P.[PogodbaTipID] = @PI
                                  )
                              AND (
                                    (@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe))
                                    and ( @DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo) )
                                  )
              IF ( @@ERROR <> 0 ) 
                BEGIN
                  SET @NOErrors = @NOErrors + 1
                  INSERT  INTO [#Errors] ( [Napaka] )
                  VALUES  (
                            'Napaka 008h: Napaka pri izračunu koregiranega tržnega plana - izračun faktorja korekcije TP.'
                          ) ;
                END 

              SELECT  SUM(isnull(TPA.VrednostKorekcijeTP, 0)) AS VrednostKorekcijeTP,
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
                      inner JOIN #AgregiranTP ATP ON KTP.OsebaId = ATP.NadrejenaOsebaID
                                                     AND KTP.Interval = ATP.Interval


              UPDATE  dbo.TrzniPlan
              SET     VrednostPopravkaTP = ISNULL(KTP.VrednostKorekcijeTP, 0),
                      KoregiranTP = ISNULL(KTP.KoregiranTP, 0)
              FROM    dbo.TrzniPlan TP
                      LEFT JOIN #KorekcijaTP KTP ON TP.Interval = KTP.Interval
                                                    AND TP.OsebaID = KTP.OsebaID
              WHERE   TP.[Interval] > @DatumIntervalaOD
                      AND TP.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                      AND ( @DatumStanjaBaze between TP.[DatumVnosa]
                                             and     dbo.infinite(TP.DatumSpremembe) )
	
              IF ( @@ERROR <> 0 ) 
                BEGIN
                  SET @NOErrors = @NOErrors + 1
                  INSERT  INTO [#Errors] ( [Napaka] )
                  VALUES  (
                            'Napaka 008k: Napaka pri izračunu koregiranega tržnega plana - zapis agregacije v osnovno tabelo.'
						  
                          ) ;
                END 

              --če do sedaj nismo imeli kritične napake in imamo vse potrebne vhodne podatke, lahko gremo v izračun Količinskih odstopanj
              PRINT 'Critical error ' + CAST(@CriticalError AS VARCHAR)
              IF ( @CriticalError = 0 ) 
                BEGIN
			
				--Odstopanja po BPS
                  INSERT  INTO [KolicinskaOdstopanjaPoBPS]
                    (
                      [Kolicina],
                      [VozniRed],
                      [Odstopanje],
                      [OsebaID],
                      [Interval],
                      [ObracunID]
						
                    )     SELECT  RBPS.Kolicina,
                                  ISNULL(Tp.KoregiranTP, 0),
                                  RBPS.Kolicina - ISNULL(Tp.KoregiranTP, 0),
                                  RBPS.OsebaID,
                                  RBPS.Interval,
                                  @NewObracunID
                          FROM    [RealizacijaPoBPS] RBPS
                                  INNER JOIN [TrzniPlan] TP ON RBPS.[Interval] = TP.[Interval]
                                                               AND Tp.[OsebaID] = RBPS.[OsebaID]
                          WHERE   RBPS.[ObracunID] = @NewObracunID
                                  AND ( @DatumStanjaBaze between TP.[DatumVnosa]
                                                         and     dbo.infinite(TP.DatumSpremembe) )

                  IF ( @@ERROR <> 0 ) 
                    BEGIN 
                      SET @NOErrors = @NOErrors + 1
                      INSERT  INTO [#Errors] ( [Napaka] )
                      VALUES  (
                                'Napaka 009: Napaka pri kalkulaciji količinskega obračuna po bilančnih podskupinah.'
                              ) ;
                    end

--				  Odstopanja po BS
                  INSERT  INTO [KolicinskaOdstopanjaPoBS]
                    (
                      [Kolicina],
                      [VozniRed],
                      [Odstopanje],
                      [OsebaID],
                      [Interval],
                      [ObracunID]
						
                    )     SELECT  RBS.Kolicina,
                                  ISNULL(Tp.KoregiranTP, 0),
                                  RBS.Kolicina - ISNULL(Tp.KoregiranTP, 0),
                                  RBS.OsebaID,
                                  RBS.Interval,
                                  @NewObracunID
                          FROM    [RealizacijaPoBS] RBS
                                  INNER JOIN [TrzniPlan] TP ON RBS.[Interval] = TP.[Interval]
                                                               AND Tp.[OsebaID] = RBS.[OsebaID]
                          WHERE   RBS.[ObracunID] = @NewObracunID
                                  AND ( @DatumStanjaBaze between TP.[DatumVnosa]
                                                         and     dbo.infinite(TP.DatumSpremembe) )

							
            
                  IF ( @@ERROR <> 0 ) 
                    BEGIN
                      SET @NOErrors = @NOErrors + 1
                      INSERT  INTO [#Errors] ( [Napaka] )
                      VALUES  (
                                'Napaka 010: Napaka pri kalkulaciji količinskega obračuna po bilančnih skupinah.'
                              ) ;
                    END 

				  --NOVO KOLIČINSKI OBRAČUN PO SODO IN SOPO
                  INSERT  INTO dbo.ObracunKolicinski
                    (
                      ObracunID,
                      OsebaID,
                      Interval,
                      SODO_SOPO_ID,
                      Realizacija
				  
                    )     SELECT  @NewObracunID,
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
                                'Napaka 010b: Napaka pri kalkulaciji količinskega obračuna po SODO/SOPO.'
                              ) ;
                    END 
					
					print 'prvi if'
					print '@Obraacun-'+cast(@Obracun as varchar)
					print '@Kolicinski_obracun-'+cast(@Kolicinski_obracun as varchar)
				  --glede na tip obračuna se odločimo, če izvedemo še finančni obračun ali se ustavimo pri količinskem
                  IF ( @Obracun <> @Kolicinski_obracun ) 
                    BEGIN -- Tolerančni pas na star in nov način
--							ni samo KOLIČINSKI OBRAČUN
						
--					 TOLERANČNI PAS
                      EXEC dbo.RevizijaBilancniObracun_TolerancniPas @DatumStanjaBaze, @k, @NewObracunID, @NOErrorsOUT OUTPUT,
                        @novk, @RegulacijskoObmocjSR, @TrgovecTipID, @ValidationErrorsXML output,
                        @ValidationErrorsDetailXML OUTPUT
                      IF ( @NOErrorsOUT <> 0 ) 
                        BEGIN
                          SET @NOErrors = @NOErrors + 1 ;
                          declare @hdocVTC8 int ;
                          declare @xmlpath8 varchar(255) ;
                          set @xmlpath8 = '/Root/Napake' ;
                          exec sp_xml_preparedocument @hdocVTC8 OUTPUT, @ValidationErrorsXML ;

                          insert  into #Errors ( Napaka )
                                  select  Napaka
                                  from    openxml(@hdocVTC8,@xmlpath8,2) with ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                                  order by ErrorID asc     
                          exec sp_xml_removedocument @hdocVTC8
						
                          set @xmlpath8 = '/Root/ErrorDetail' ;
                          exec sp_xml_preparedocument @hdocVTC8 OUTPUT, @ValidationErrorsDetailXML ;

                          insert  into #ErrorDetail ( ErrorDetail )
                                  select  ErrorDetail
                                  from    openxml(@hdocVTC8,@xmlpath8,2) with ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                                  order by ErrorID asc     
                          exec sp_xml_removedocument @hdocVTC8
				
                        END
                    END	
				
				print 'drugi if'	
				print '@Obraacun-'+cast(@Obracun as varchar)
				print '@@Kolicinski_obracun-'+cast(@Kolicinski_obracun as varchar)		
				  --glede na tip obračuna se odločimo, če izvedemo še finančni obračun ali se ustavimo pri količinskem
                  IF ( @Obracun <> @Kolicinski_obracun ) 
                    BEGIN
						
					--določanje cene odstopanj
					--ustvarjanje začasne tabele za te namene
                      if object_id('#tmpCena') is not null 
                        drop table #tmpCena

                      CREATE TABLE #tmpCena
                      (
                        Interval DATETIME,
                        Cplus DECIMAL(18, 8), --stara pravila
                        Cminus DECIMAL(18, 8),--stara pravila
                        CplusNov DECIMAL(18, 8),--nova pravila
                        CminusNov DECIMAL(18, 8)--nova pravila
                      )			

													
                      INSERT  INTO #tmpCena
                        (
                          Interval,
                          Cplus,
                          Cminus,
                          CplusNov,
                          CminusNov
									
                        )     SELECT  I.Interval,
                                      ROUND(1.03
                                            * CAST(( CASE WHEN Round(Wp, 0) > 0
                                                          THEN ( CASE WHEN ( Round(Wp, 0) + Round(Wm, 0) ) <> 0
                                                                      then ( CASE WHEN ( ( I.Sp + I.Sm ) / ( Round(Wp, 0) + Round(Wm, 0) ) ) > C.Vrednost
                                                                                  THEN ( I.Sp + I.Sm ) / ( Round(Wp, 0) + Round(Wm, 0) )
                                                                                  ELSE C.Vrednost
                                                                             END )
                                                                      ELSE C.Vrednost
                                                                 END )
                                                          WHEN Round(Wp, 0) + Round(Wm, 0) = 0 THEN C.Vrednost
                                                          WHEN Round(Wp, 0) = 0
                                                               AND Round(Wm, 0) < 0
                                                          THEN ( CASE WHEN ( Sm / Round(Wm, 0) ) < C.Vrednost
                                                                      THEN Sm / Round(Wm, 0)
                                                                      ELSE C.Vrednost
                                                                 END )
                                                          ELSE 0
                                                     END ) AS DECIMAL(18, 8)), 8),
                                      ROUND(0.97
                                            * CAST(( CASE WHEN Round(Wm, 0) < 0
                                                          THEN ( CASE WHEN ( Round(Wp, 0) + Round(Wm, 0) ) <> 0
                                                                      then ( CASE WHEN ( ( I.Sp + I.Sm ) / ( Round(Wp, 0) + Round(Wm, 0) ) ) < C.Vrednost
                                                                                  THEN ( I.Sp + I.Sm ) / ( Round(Wp, 0) + Round(Wm, 0) )
                                                                                  ELSE C.Vrednost
                                                                             END )
                                                                      ELSE C.Vrednost
                                                                 END )
                                                          WHEN Round(Wp, 0) + Round(Wm, 0) = 0 THEN C.Vrednost
                                                          WHEN Round(Wp, 0) > 0
                                                               AND Round(Wm, 0) = 0
                                                          THEN ( CASE WHEN Round(Wp, 0) > 0
                                                                      THEN ( CASE WHEN ( Sp / Round(Wp, 0) ) > C.Vrednost
                                                                                  THEN Sp / Round(Wp, 0)
                                                                                  ELSE C.Vrednost
                                                                             END )
                                                                      ELSE 0
                                                                 END )
                                                          ELSE 0
                                                     END ) AS DECIMAL(18, 8)), 8),
                                      ROUND(CAST(( CASE WHEN Round(Wp, 0) > 0
                                                        THEN ( CASE WHEN ( Sp / Round(Wp, 0) ) > C.Vrednost
                                                                    then ( Sp / Round(Wp, 0) )
                                                                    ELSE C.Vrednost
                                                               END )
                                                        WHEN Round(Wp, 0) = 0
                                                             AND Round(Wm, 0) < 0
                                                        THEN ( CASE WHEN ( Sm / Round(Wm, 0) ) > C.Vrednost
                                                                    then ( Sm / Round(Wm, 0) )
                                                                    ELSE C.Vrednost
                                                               END )
                                                        WHEN Round(Wp, 0) = 0
                                                             AND Round(Wm, 0) = 0 THEN C.Vrednost
                                                        ELSE 0
                                                   END ) AS DECIMAL(18, 8)), 8),
                                      ROUND(CAST(( CASE WHEN Round(Wm, 0) < 0
                                                        THEN ( CASE WHEN ( Sm / Round(Wm, 0) ) < C.Vrednost
                                                                    then ( Sm / Round(Wm, 0) )
                                                                    ELSE C.Vrednost
                                                               END )
                                                        WHEN Round(Wp, 0) > 0
                                                             AND Round(Wm, 0) = 0
                                                        THEN ( CASE WHEN ( Sp / Round(Wp, 0) ) < C.Vrednost
                                                                    then ( Sp / Round(Wp, 0) )
                                                                    ELSE C.Vrednost
                                                               END )
                                                        WHEN Round(Wp, 0) = 0
                                                             AND Round(Wm, 0) = 0 THEN C.Vrednost
                                                        ELSE 0
                                                   END ) AS DECIMAL(18, 8)), 8)
                              FROM    [Izravnava] I
                                      inner JOIN [CSLOEX] C ON I.Interval = C.Interval
                              WHERE   I.Interval > @DatumIntervalaOD AND I.Interval <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                      AND I.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
                                      AND ( @DatumStanjaBaze between I.[DatumVnosa] and dbo.infinite(I.DatumSpremembe) )
                                      AND ( @DatumStanjaBaze between C.[DatumVnosa] and dbo.infinite(C.DatumSpremembe) )
                      
                      IF ( @@ERROR <> 0 ) 
                        BEGIN
                          SET @NOErrors = @NOErrors + 1
                          INSERT  INTO [#Errors] ( [Napaka] )
                          VALUES  (
                                    'Napaka 013: Napaka pri izračunu izhodiščnih cen.'
                                  ) ;
                        END


									
			       	--CENA ODSTOPANJ
                      INSERT  INTO [PodatkiObracuna]
                        (
                          [ObracunID],
                          OsebaID,
                          [Interval],
                          [TolerancniPas],
                          [Odstopanje],
                          [Cplus],--stara pravila
                          [Cminus],--stara pravila
                          CPlusNov,--nova pravila
                          CMinusNov,--nova pravila
                          [Cp],--stara pravila
                          [Cn],--stara pravila
                          [CpNov],--nova pravila
                          [CnNov],--nova pravila
                          Ckplus,--nova pravila
                          Ckminus,--nova pravila
                          Zplus,--stara pravila
                          Zminus,--stara pravila
                          ZplusNov,--nova pravila
                          ZminusNov,--nova pravila
                          [PoravnavaZunajT],--stara pravila
                          [PoravnavaZnotrajT],--stara pravila
                          PoravnavaZnotrajTNova,--nova pravila
                          PoravnavaZunajTNova--nova pravila
									
                        )     SELECT  @NewObracunID,
                                      TP.[OsebaID],
                                      TP.[Interval],
                                      TP.[NormiranT],
                                      K.Odstopanje,
                                      C.CPlus,--stara pravila
                                      C.CMinus,--stara pravila
                                      C.CPlusNov,--nova pravila
                                      C.CMinusNov,--nova pravila
                                      CAST(( CASE WHEN OT.OsebaTipID = @TrgovecTipID
                                                  THEN CAST(2 * C.CPlus AS DECIMAL(24, 8))
                                                  ELSE ( CASE WHEN Izp.Izpad = 1
                                                                   AND Izp.Upostevaj = 1 THEN C.CPlus
                                                              else ( CASE--CP 
                                                                          WHEN K.Odstopanje <= TP.[NormiranT]
                                                                          THEN C.CPlus
                                                                          WHEN TP.[NormiranT] < K.Odstopanje
                                                                               AND K.Odstopanje <= 5 * TP.[NormiranT]
                                                                          THEN CAST(( ( C.CPlus / ( 4 * TP.[NormiranT] ) )
                                                                                      * ( 3 * TP.[NormiranT]
                                                                                          + K.Odstopanje ) ) AS DECIMAL(24, 8))
                                                                          WHEN 5 * TP.[NormiranT] < K.Odstopanje
                                                                          THEN CAST(2 * C.CPlus AS DECIMAL(24, 8))
                                                                     END )
                                                         END )
                                             END ) AS DECIMAL(24, 8)),
                                      CAST(( CASE WHEN OT.OsebaTipID = @TrgovecTipID THEN 0
                                                  ELSE ( CASE WHEN Izp.Izpad = 1
                                                                   AND Izp.Upostevaj = 1 THEN C.CMinus
                                                              else ( CASE --CN
                                                                          WHEN -1 * TP.[NormiranT] <= K.Odstopanje
                                                                          THEN C.CMinus
                                                                          WHEN -5 * TP.[NormiranT] <= K.Odstopanje
                                                                               AND K.Odstopanje < -1 * TP.[NormiranT]
                                                                          THEN CAST(( ( C.CMinus / ( 4 * TP.[NormiranT] ) )
                                                                                      * ( 5 * TP.[NormiranT]
                                                                                          + K.Odstopanje ) ) AS DECIMAL(24, 8))
                                                                          WHEN K.Odstopanje < -5 * TP.[NormiranT] THEN 0
                                                                          ELSE -1
                                                                     END )
                                                         END )
                                             END ) AS DECIMAL(24, 8)),
                                      CAST(( CASE--CpNov
                                                  WHEN CAST(( I.Sp + i.Sm ) AS DECIMAL(24, 8)) <= CAST(C.CPlusNov
                                                       * K.Odstopanje + C.CMinusNov * ( TP.T - ( TP.T - ( Tp.Odjem - Tp.Oddaja ) ) ) AS DECIMAL(24, 8))
                                                  THEN C.CPlusNov --ZA PREVERIT
                                                  ELSE CAST(1.03
                                                       * ( CAST(( ( C.CPlusNov + C.CMinusNov ) / 2 ) AS DECIMAL(24, 8))
                                                           + ( cast(( CAST(( ( C.CPlusNov + C.CMinusNov ) / 2 ) AS DECIMAL(24, 8))
                                                                      + CAST(( ( CAST(( I.[Sm] + I.[Sp] ) AS DECIMAL(24, 8))
                                                                                 - CAST(( C.CPlusNov + C.CMinusNov ) AS DECIMAL(24, 8))
                                                                                 / 2 )
                                                                               * CAST(( TP.[Oddaja] - TP.[Odjem] ) AS DECIMAL(24, 8)) ) AS DECIMAL(24, 8))
                                                                      + ( CAST(( CAST(( C.CPlusNov + C.CMinusNov ) AS DECIMAL(24, 8))
                                                                                 / 2 ) AS DECIMAL(24, 8)) - C.CMinusNov )
                                                                      * TP.Odjem ) AS DECIMAL(24, 8)) / TP.[Oddaja] ) ) AS DECIMAL(24, 8))
                                             END ) AS DECIMAL(24, 8)),
                                      CAST(( CASE--CnNov
                                                  WHEN CAST(( I.Sp + i.Sm ) AS DECIMAL(24, 8)) <= CAST(C.CPlusNov
                                                       * K.Odstopanje + C.CMinusNov * ( TP.T - ( Tp.Odjem - Tp.Oddaja ) ) AS DECIMAL(24, 8))
                                                  THEN C.CMinusNov --ZA PREVERIT
                                                  ELSE CAST(0.97 * ( ( ( C.CPlusNov + C.CMinusNov ) / 2 ) - ( -1 * ( ( ( ( I.[Sm] + I.[Sp] ) - ( C.CPlusNov + C.CMinusNov ) / 2 ) * ( TP.[Oddaja] - TP.[Odjem] ) - ( C.CPlusNov - ( ( C.CPlusNov + C.CMinusNov ) / 2 ) ) * TP.[Oddaja] ) / TP.[Odjem] ) ) ) AS DECIMAL(24, 8))
                                             END ) AS DECIMAL(24, 8)),
                                      ( CASE --CkPlus
                                             WHEN K.Odstopanje <= TP.[NormiranT] THEN 0
                                             WHEN TP.[NormiranT] < K.Odstopanje
                                                  AND K.Odstopanje <= 4 * TP.[NormiranT]
                                             THEN CAST(SQUARE(( ( TP.Oddaja - TP.T ) / ( 3 * Tp.T ) )) * C.CPlusNov AS DECIMAL(24, 8))
                                             WHEN 4 * TP.[NormiranT] < K.Odstopanje THEN C.CPlusNov
                                             ELSE -1
                                        END ),
                                      CAST(( CASE --CkMinus
                                                  WHEN -1 * TP.[NormiranT] <= K.Odstopanje THEN 0
                                                  WHEN -4 * TP.[NormiranT] <= K.Odstopanje
                                                       AND K.Odstopanje < -1 * TP.[NormiranT]
                                                  THEN CAST(SQUARE(( ( TP.Oddaja + TP.T ) / ( 3 * TP.T ) ))
                                                       * C.CMinusNov AS DECIMAL(24, 8))
                                                  WHEN K.Odstopanje < -4 * TP.[NormiranT] THEN C.CMinusNov
                                                  ELSE -1
                                             END ) AS DECIMAL(24, 8)),
                                      CAST(( ( CASE WHEN K.Odstopanje > 0
                                                    THEN CAST(( CASE WHEN OT.OsebaTipID = @TrgovecTipID
                                                                     THEN CAST(2 * C.CPlus AS DECIMAL(24, 8))
                                                                     ELSE ( CASE WHEN Izp.Izpad = 1
                                                                                      AND Izp.Upostevaj = 1 THEN C.CPlus
                                                                                 else ( CASE--CP 
                                                                                             WHEN K.Odstopanje <= TP.[NormiranT]
                                                                                             THEN C.CPlus
                                                                                             WHEN TP.[NormiranT] < K.Odstopanje
                                                                                                  AND K.Odstopanje <= 5
                                                                                                  * TP.[NormiranT]
                                                                                             THEN CAST(( ( C.CPlus / ( 4 * TP.[NormiranT] ) ) * ( 3 * TP.[NormiranT] + K.Odstopanje ) ) AS DECIMAL(24, 8))
                                                                                             WHEN CAST(5
                                                                                                  * TP.[NormiranT] AS DECIMAL(24, 8)) < K.Odstopanje
                                                                                             THEN CAST(2 * C.CPlus AS DECIMAL(24, 8))
                                                                                             ELSE -1
                                                                                        END )
                                                                            END )
                                                                END ) / 1000 AS DECIMAL(24, 8))
                                                    ELSE 0
                                               END ) * K.Odstopanje ) AS DECIMAL(24, 8)),--Zplus
                                      CAST(( CASE WHEN K.Odstopanje < 0
                                                  THEN CAST(( CASE WHEN OT.OsebaTipID = @TrgovecTipID THEN 0
                                                                   ELSE ( CASE WHEN Izp.Izpad = 1
                                                                                    AND Izp.Upostevaj = 1 THEN C.CMinus
                                                                               else ( CASE --CN
                                                                                           WHEN -1 * TP.[NormiranT] <= K.Odstopanje
                                                                                           THEN C.CMinus
                                                                                           WHEN CAST(-5 * TP.[NormiranT] AS DECIMAL(24, 8)) <= K.Odstopanje
                                                                                                AND K.Odstopanje < -1
                                                                                                * TP.[NormiranT]
                                                                                           THEN CAST(( ( C.CMinus / ( 4 * TP.[NormiranT] ) )
                                                                                                       * ( 5 * TP.[NormiranT] + K.Odstopanje ) ) AS DECIMAL(24, 8))
                                                                                           WHEN K.Odstopanje < CAST(-5
                                                                                                * TP.[NormiranT] AS DECIMAL(24, 8))
                                                                                           THEN 0
                                                                                           ELSE -1
                                                                                      END )
                                                                          END )
                                                              END ) / 1000 AS DECIMAL(24, 8))
                                                  ELSE 0
                                             END ) * K.Odstopanje AS DECIMAL(24, 8)),--zMinus
                                      CAST(0 AS DECIMAL(24, 8)),--ZplusNov
                                      CAST(0 AS DECIMAL(24, 8)),--ZMinusNov
                                      CAST(( CASE WHEN OT.OsebaTipID = @TrgovecTipID
                                                  THEN ( CASE WHEN K.Odstopanje > 0
                                                              THEN CAST(K.Odstopanje * 2 * C.CPlus AS DECIMAL(24, 8))
                                                              ELSE 0
                                                         END )
                                                  ELSE ( CASE WHEN ABS(K.Odstopanje) > TP.[NormiranT]
                                                              THEN ( ( CASE WHEN K.Odstopanje > 0
                                                                            THEN CAST(( CASE WHEN OT.OsebaTipID = @TrgovecTipID
                                                                                             THEN CAST(2 * C.CPlus AS DECIMAL(24, 8))
                                                                                             ELSE ( CASE WHEN Izp.Izpad = 1
                                                                                                              AND Izp.Upostevaj = 1 THEN C.CPlus
                                                                                                         else CAST(( CASE--CP 
                                                                                                                          WHEN K.Odstopanje <= TP.[NormiranT] THEN C.CPlus
                                                                                                                          WHEN TP.[NormiranT] < K.Odstopanje
                                                                                                                               AND K.Odstopanje <= CAST(5 * TP.[NormiranT] AS DECIMAL(24, 8)) THEN CAST(( ( C.CPlus / ( 4 * TP.[NormiranT] ) ) * ( 3 * TP.[NormiranT] + K.Odstopanje ) ) AS DECIMAL(24, 8))
                                                                                                                          WHEN CAST(5 * TP.[NormiranT] AS DECIMAL(24, 8)) < K.Odstopanje THEN CAST(2 * C.CPlus AS DECIMAL(24, 8))
                                                                                                                          ELSE -1
                                                                                                                     END ) AS DECIMAL(24, 8))
                                                                                                    END )
                                                                                        END ) / 1000 AS DECIMAL(24, 8))
                                                                            ELSE 0
                                                                       END ) * K.Odstopanje )--Zplus
                                                                   + ( ( CASE WHEN K.Odstopanje < 0
                                                                              THEN cast(( CASE WHEN OT.OsebaTipID = @TrgovecTipID
                                                                                               THEN 0
                                                                                               ELSE ( CASE WHEN Izp.Izpad = 1
                                                                                                                AND Izp.Upostevaj = 1 THEN C.CMinus
                                                                                                           else ( CASE --CN
                                                                                                                       WHEN -1 * TP.[NormiranT] <= K.Odstopanje THEN C.CMinus
                                                                                                                       WHEN CAST(-5 * TP.[NormiranT] AS DECIMAL(24, 8)) <= K.Odstopanje
                                                                                                                            AND K.Odstopanje < -1 * TP.[NormiranT] THEN CAST(( ( C.CMinus / ( 4 * TP.[NormiranT] ) ) * ( 5 * TP.[NormiranT] + K.Odstopanje ) ) AS DECIMAL(24, 8))
                                                                                                                       WHEN K.Odstopanje < CAST(-5 * TP.[NormiranT] AS DECIMAL(24, 8)) THEN 0
                                                                                                                       ELSE -1
                                                                                                                  END )
                                                                                                      END )
                                                                                          END ) / 1000 AS DECIMAL(24, 8))
                                                                              ELSE 0
                                                                         END ) * K.Odstopanje )--Zminus
                                                              ELSE 0
                                                         END )
                                             END ) AS DECIMAL(24, 8)),
                                      CAST(( CASE WHEN OT.OsebaTipID = @TrgovecTipID THEN 0
                                                  ELSE ( CASE WHEN ABS(K.Odstopanje) < TP.[NormiranT]
                                                              THEN ( ( CASE WHEN K.Odstopanje > 0
                                                                            THEN CAST(( CASE WHEN OT.OsebaTipID = @TrgovecTipID
                                                                                             THEN CAST(2 * C.CPlus AS DECIMAL(24, 8))
                                                                                             ELSE ( CASE WHEN Izp.Izpad = 1
                                                                                                              AND Izp.Upostevaj = 1 THEN C.CPlus
                                                                                                         else ( CASE--CP 
                                                                                                                     WHEN K.Odstopanje <= TP.[NormiranT] THEN C.CPlus
                                                                                                                     WHEN TP.[NormiranT] < K.Odstopanje
                                                                                                                          AND K.Odstopanje <= CAST(5 * TP.[NormiranT] AS DECIMAL(24, 8)) THEN CAST(( ( C.CPlus / ( 4 * TP.[NormiranT] ) ) * ( 3 * TP.[NormiranT] + K.Odstopanje ) ) AS DECIMAL(24, 8))
                                                                                                                     WHEN CAST(5 * TP.[NormiranT] AS DECIMAL(24, 8)) < K.Odstopanje THEN CAST(2 * C.CPlus AS DECIMAL(24, 8))
                                                                                                                     ELSE -1
                                                                                                                END )
                                                                                                    END )
                                                                                        END ) / 1000 AS DECIMAL(24, 8))
                                                                            ELSE 0
                                                                       END ) * K.Odstopanje )--Zplus
                                                                   + ( ( CASE WHEN K.Odstopanje < 0
                                                                              THEN CAST(( CASE WHEN OT.OsebaTipID = @TrgovecTipID
                                                                                               THEN 0
                                                                                               ELSE ( CASE WHEN Izp.Izpad = 1
                                                                                                                AND Izp.Upostevaj = 1 THEN C.CMinus
                                                                                                           else ( CASE --CN
                                                                                                                       WHEN -1 * TP.[NormiranT] <= K.Odstopanje THEN C.CMinus
                                                                                                                       WHEN CAST(-5 * TP.[NormiranT] AS DECIMAL(24, 8)) <= K.Odstopanje
                                                                                                                            AND K.Odstopanje < -1 * TP.[NormiranT] THEN CAST(( ( C.CMinus / ( 4 * TP.[NormiranT] ) ) * ( 5 * TP.[NormiranT] + K.Odstopanje ) ) AS DECIMAL(24, 8))
                                                                                                                       WHEN K.Odstopanje < CAST(-5 * TP.[NormiranT] AS DECIMAL(24, 8)) THEN 0
                                                                                                                       ELSE -1
                                                                                                                  END )
                                                                                                      END )
                                                                                          END ) / 1000 AS DECIMAL(24, 8))
                                                                              ELSE 0
                                                                         END ) * K.Odstopanje )--Zminus
                                                              ELSE 0
                                                         END )
                                             END ) AS DECIMAL(24, 8)),
--                          CAST(ISNULL(( CASE WHEN TP.[Odjem] > T.KoregiranTP
--                                           OR TP.[Oddaja] < T.KoregiranTP
--                                      THEN ( CASE--CpNov
--                                                  WHEN ( I.Sp + i.Sm ) <= C.CPlusNov * ( ( Tp.Odjem - Tp.oddaja ) - TP.T )
--                                                       + C.CMinusNov * ( TP.T - ( Tp.Odjem - Tp.Oddaja ) )
--                                                  THEN C.CPlusNov --ZA PREVERIT
--                                                  ELSE 1.03 * ( ( ( C.CPlusNov + C.CMinusNov ) / 2 )
--                                                                + ( ( ( ( C.CPlusNov + C.CMinusNov ) / 2 ) + ( ( I.[Sm] + I.[Sp] ) - ( C.CPlusNov + C.CMinusNov ) / 2 )
--                                                                      * ( TP.[Oddaja] - TP.[Odjem] ) + ( ( ( C.CPlusNov + C.CMinusNov ) / 2 ) - C.CMinusNov )
--                                                                      * TP.Odjem ) / TP.[Oddaja] ) )
--                                             END ) * K.Odstopanje
--                                      ELSE ( ( CASE--CpNov
--                                                    WHEN ( I.Sp + i.Sm ) <= C.CPlusNov * ( ( Tp.Odjem - Tp.oddaja )
--                                                                                           - TP.T ) + C.CMinusNov
--                                                         * ( TP.T - ( Tp.Odjem - Tp.Oddaja ) ) THEN C.CPlusNov --ZA PREVERIT
--                                                    ELSE 1.03 * ( ( ( C.CPlusNov + C.CMinusNov ) / 2 )
--                                                                  + ( ( ( ( C.CPlusNov + C.CMinusNov ) / 2 )
--                                                                        + ( ( I.[Sm] + I.[Sp] ) - ( C.CPlusNov
--                                                                                                    + C.CMinusNov ) / 2 )
--                                                                        * ( TP.[Oddaja] - TP.[Odjem] )
--                                                                        + ( ( ( C.CPlusNov + C.CMinusNov ) / 2 )
--                                                                            - C.CMinusNov ) * TP.Odjem ) / TP.[Oddaja] ) )
--                                               END ) * K.Odstopanje ) + ( K.Odstopanje - ISNULL(TP.T, 0) )
--                                           * ( CASE --CkPlus
--                                                    WHEN K.Odstopanje <= TP.[T] THEN 0
--                                                    WHEN TP.[T] < K.Odstopanje
--                                                         AND K.Odstopanje <= 4 * TP.[T]
--                                                    THEN SQUARE(( TP.Oddaja - TP.T ) / 3 * Tp.T) * C.CPlusNov
--                                                    WHEN 4 * TP.[T] < ( TP.[Oddaja] - TP.[Odjem] ) THEN C.CPlusNov
--                                                    ELSE -1
--                                               END )
--                                 END ),0) AS DECIMAL(24,8)),
--                          CAST(ISNULL(( CASE WHEN TP.[Odjem] < T.KoregiranTP
--                                           OR TP.[Oddaja] > T.KoregiranTP
--                                      THEN ( CASE--CnNov
--                                                  WHEN ( I.Sp + i.Sm ) <= C.CPlusNov * ( ( Tp.Odjem - Tp.oddaja ) - TP.T )
--                                                       + C.CMinusNov * ( TP.T - ( Tp.Odjem - Tp.Oddaja ) )
--                                                  THEN C.CMinusNov --ZA PREVERIT
--                                                  ELSE 0.97 * ( ( ( C.CPlusNov + C.CMinusNov ) / 2 ) - ( -1 * ( ( ( ( I.[Sm] + I.[Sp] ) - ( C.CPlusNov + C.CMinusNov ) / 2 ) * ( TP.[Oddaja] - TP.[Odjem] ) - ( C.CPlusNov - ( ( C.CPlusNov + C.CMinusNov ) / 2 ) ) * TP.[Oddaja] ) / TP.[Odjem] ) ) )
--                                             END ) * K.Odstopanje
--                                      ELSE ( ( CASE--CnNov
--                                                    WHEN ( I.Sp + i.Sm ) <= C.CPlusNov * ( ( Tp.Odjem - Tp.oddaja )
--                                                                                           - TP.T ) + C.CMinusNov
--                                                         * ( TP.T - ( Tp.Odjem - Tp.Oddaja ) ) THEN C.CMinusNov --ZA PREVERIT
--                                                    ELSE 0.97 * ( ( ( C.CPlusNov + C.CMinusNov ) / 2 ) - ( -1 * ( ( ( ( I.[Sm] + I.[Sp] ) - ( C.CPlusNov + C.CMinusNov ) / 2 ) * ( TP.[Oddaja] - TP.[Odjem] ) - ( C.CPlusNov - ( ( C.CPlusNov + C.CMinusNov ) / 2 ) ) * TP.[Oddaja] ) / TP.[Odjem] ) ) )
--                                               END ) * K.Odstopanje ) + ( K.Odstopanje )
--                                           * ( CASE --CkMinus
--                                                    WHEN -1 * TP.[T] <= ( TP.[Oddaja] - TP.[Odjem] ) THEN 0
--                                                    WHEN -4 * TP.[T] <= ( TP.[Oddaja] - TP.[Odjem] )
--                                                         AND ( TP.[Oddaja] - TP.[Odjem] ) < -1 * TP.[T]
--                                                    THEN SQUARE(( TP.Oddaja + TP.T ) / 3 * TP.T) * C.CMinusNov
--                                                    WHEN ( TP.[Oddaja] - TP.[Odjem] ) < -4 * TP.[T] THEN C.CMinusNov
--                                                    ELSE -1
--                                               END )
--                                 END ),0) AS DECIMAL(24,8))
                                      0,
                                      0
                              FROM    [TolerancniPas] TP
                                      INNER JOIN [KolicinskaOdstopanjaPoBS] K ON TP.OsebaID = K.OsebaID
                                                                                 AND TP.Interval = K.Interval
                                      INNER JOIN [TrzniPlan] T ON TP.[OsebaID] = T.OsebaID
                                                                  AND TP.[Interval] = T.[Interval]
                                      left JOIN [Izravnava] I ON (
                                                                   TP.Interval = I.Interval
                                                                   AND TP.OsebaID = I.OsebaID
                                                                   AND ( @DatumStanjaBaze between I.[DatumVnosa] and dbo.infinite(I.DatumSpremembe) )
                                                                 )
                                      INNER JOIN [#tmpCena] C ON T.Interval = C.Interval
                                      LEFT JOIN dbo.Izpadi Izp ON Izp.interval = Tp.interval
                                                                  AND Izp.OsebaID = Tp.osebaID
                                                                  AND ( @DatumStanjaBaze between Izp.[DatumVnosa]
                                                                                         and     dbo.infinite(Izp.DatumSpremembe) )
                                      inner JOIN dbo.OsebaTip OT ON TP.OsebaID = OT.OsebaID
                                                                    AND ( @DatumStanjaBaze between OT.[DatumVnosa]
                                                                                           and     dbo.infinite(OT.DatumSpremembe) )--AND (OT.OsebaTipID = @SodoTipID OR OT.OsebaTipID = @TrgovecTipID)
                              WHERE   TP.[ObracunID] = @NewObracunID
                                      AND K.[ObracunID] = @NewObracunID
                                      AND TP.Interval > @DatumIntervalaOD AND TP.Interval <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                      AND ( @DatumStanjaBaze between T.[DatumVnosa] and dbo.infinite(T.DatumSpremembe) )
                              ORDER BY Tp.[Interval] ASC 
									                      
                      IF ( @@ERROR <> 0 ) 
                        BEGIN
                          SET @NOErrors = @NOErrors + 1
                          INSERT  INTO [#Errors] ( [Napaka] )
                          VALUES  (
                                    'Napaka 014: Napaka pri izvajanju bilančnega obračuna.'
                                  ) ;
                        END
                    END --imamo vse podatke za obračun ..@CriticalError = 0
                  PRINT 'Obracun error ' + CAST(@@ERROR AS varchar) + ' error num ' + CAST(@NOErrors AS varchar)
		
				
                END
            END --imamo podatke za obraun
          ELSE 
            BEGIN
              INSERT  INTO [#Errors] ( [Napaka] )
              VALUES  (
                        'Napaka 000: Ni podatkov za obračun (meritve).'
                      ) ;
              SET @ValidationErrorsXML = (
                                           SELECT *
                                           FROM   #Errors
                                         FOR
                                           XML PATH('Napake'),
                                               ROOT('Root')
                                         )
              SET @NewObracunID = -10
            END
        END--end obračun
      ELSE
        BEGIN
			--error
          INSERT  INTO [#Errors] ( [Napaka] )
          VALUES  (
                    'Napaka 000: Napačni vhodni parametri.'
                  ) ;
          SET @ValidationErrorsXML = (
                                       SELECT *
                                       FROM   #Errors
                                     FOR
                                       XML PATH('Napake'),
                                           ROOT('Root')
                                     )
          SET @NewObracunID = -1
        END

		
                          --REVIZIJA
      EXEC dbo.RevizijaBilancniObracun_RevizijskaSled @DatumIntervalaDO, @DatumIntervalaOD, @DatumStanjaBaze,
        @DatumVeljavnostiPodatkov, @NewObracunID, @NOErrorsOUT OUTPUT, @Obracun, @ObracunskoObdobjeID, @Bs,
        @ValidationErrorsXML, @ValidationErrorsDetailXML 
      IF ( @NOErrorsOUT <> 0 ) 
        BEGIN
          SET @NOErrors = @NOErrors + 1 ;
          declare @hdocVTC3 int ;
          declare @xmlpath3 varchar(255) ;
          set @xmlpath3 = '/Root/Napake' ;
          exec sp_xml_preparedocument @hdocVTC3 OUTPUT, @ValidationErrorsXML ;

          insert  into #Errors ( Napaka )
                  select  Napaka
                  from    openxml(@hdocVTC3,@xmlpath3,2) with ( ErrorID BIGINT, Napaka VARCHAR(8000) )
                  order by ErrorID asc     
          exec sp_xml_removedocument @hdocVTC3
						
          set @xmlpath3 = '/Root/ErrorDetail' ;
          exec sp_xml_preparedocument @hdocVTC3 OUTPUT, @ValidationErrorsDetailXML ;

          insert  into #ErrorDetail ( ErrorDetail )
                  select  ErrorDetail
                  from    openxml(@hdocVTC3,@xmlpath3,2) with ( ErrorID BIGINT, ErrorDetail VARCHAR(8000) )
                  order by ErrorID asc     
          exec sp_xml_removedocument @hdocVTC3
				
        END
		--REVIZIJA END
		
    END --KONTROLA VHODNIH PODATKOV ok


  IF ( @NOErrors <> 0 ) 
    BEGIN
      SET @ValidationErrorsXML = (
                                   SELECT *
                                   FROM   #Errors
                                 FOR
                                   XML PATH('Napake'),
                                       ROOT('Root')
                                 )
      IF (
           SELECT COUNT(*)
           FROM   [#ErrorDetail]
         ) > 0 
        SET @ValidationErrorsDetailXML = (
                                           SELECT *
                                           FROM   [#ErrorDetail]
                                         FOR
                                           XML PATH('ErrorDetail'),
                                               ROOT('Root')
                                         )
      SET @NewObracunID = -3 ;										
    END
  ELSE 
    BEGIN
      DECLARE @PoracunID INT 
      DECLARE @result INT 
	
      EXEC @result = [RevizijaBilnacniObracun_PripravaPoracuna] @ObracunID = @NewObracunID, --  int
        @DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov, --  datetime
        @DatumStanjaBaze = @DatumStanjaBaze, --  datetime
        @Avtor = @Avtor, --  int
        @PoracunID = @PoracunID
      IF @result <> 1 
        BEGIN
          SET @NOErrors = @NOErrors + 1 ;
          INSERT  INTO [#Errors] ( [Napaka] )
          VALUES  (
                    'Napaka 029: Nekritična napaka pri ustvarjanju podatkov za poračun.'
                  ) ;

          SET @ValidationErrorsXML = (
                                       SELECT *
                                       FROM   #Errors
                                     FOR
                                       XML PATH('Napake'),
                                           ROOT('Root')
                                     )
          IF (
               SELECT COUNT(*)
               FROM   [#ErrorDetail]
             ) > 0 
            SET @ValidationErrorsDetailXML = (
                                               SELECT *
                                               FROM   [#ErrorDetail]
                                             FOR
                                               XML PATH('ErrorDetail'),
                                                   ROOT('Root')
                                             )

        end
    end

  if object_id('tempDB..#Errors') is not null 
    drop table #Errors
 

  IF EXISTS ( SELECT  name
              from    sys.indexes
              WHERE   name = N'IX_KorekcijaTP' ) 
    DROP INDEX IX_KorekcijaTP ON #KorekcijaTP ;

  if object_id('#KorekcijaTP') is not null 
    drop table #KorekcijaTP
    

  IF ( @NOErrors = 0 ) 
    BEGIN
      COMMIT TRANSACTION OBRACUN
    end 
  ELSE 
    BEGIN
      ROLLBACK TRANSACTION OBRACUN
    END
  
  RETURN @NewObracunID

END


