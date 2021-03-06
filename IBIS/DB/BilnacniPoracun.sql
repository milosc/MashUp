/****** Object:  StoredProcedure [dbo].[BilnacniPoracun]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniPoracun]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniPoracun]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniPoracun]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniPoracun]
	@ObracunskoObdobjeID INT,
	@DatumStanjaBaze DATETIME,
	@DatumVeljavnostiPodatkov DATETIME,
	@Avtor INT,
	@Naziv VARCHAR(50),
	@Komentar VARCHAR(255),
	@PoracunID INT OUTPUT,
	@DatumIzdaje DATETIME,
	@SrednjaCena DECIMAL(18,8),
    @ValidationErrorsXML XML='''' OUTPUT,
    @ValidationErrorsDetailXML xml=''''  output
AS
BEGIN

DECLARE @NewPoracunID INT
DECLARE @DatumIntervalaOD DATETIME
DECLARE @DatumIntervalaDO DATETIME

DECLARE @ErrorID BIGINT

DECLARE @NOErrors INT
DECLARE @ObjektID INT
	

SET @NOErrors = 0;
SET @NewPoracunID = -1;

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
DECLARE @NMER INT
DECLARE @MER INT


SELECT	@VIRT_ELES_MERITVE = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_ELES_MERITVE''
SELECT	@VIRT_MERJENI_ODJEM = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_MERJENI_ODJEM''
SELECT	@VIRT_NEMERJENI_ODJEM = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_NEMERJENI_ODJEM''
SELECT	@VIRT_MERJEN_ODDAJA = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_MERJEN_ODDAJA''
SELECT	@VIRT_NEMERJEN_ODDAJA = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_NEMERJEN_ODDAJA''
SELECT	@VIRT_REGULACIJA = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_REGULACIJA''
SELECT	@VIRT_ELES_ODJEM = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_ELES_ODJEM''
SELECT	@VIRT_ELES_ODDAJA = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_ELES_ODDAJA''
SELECT	@VIRT_PBI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_PBI''
SELECT	@VIRT_DSP = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_DSP''
SELECT	@UDO_P_MERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''UDO_P_MERJENI''
SELECT	@UDO_P_NEMERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''UDO_P_NEMERJENI''
SELECT	@UDO_P_IZGUBE = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''UDO_P_IZGUBE''
SELECT	@MP_SKUPAJ = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''MP_SKUPAJ''
SELECT	@MP_ND_NEMERJENI= [PPMTipID] FROM [PPMTip] WHERE Naziv = ''MP_ND_NEMERJENI''
SELECT	@MP_ND_MERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''MP_ND_MERJENI''
SELECT	@MP_NP_NEMERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''MP_NP_NEMERJENI''
SELECT	@MP_NP_MERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''MP_NP_MERJENI''
SELECT	@MP_KP_NEMERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''MP_KP_NEMERJENI''
SELECT	@MP_KP_MERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''MP_KP_MERJENI''

SELECT	@NMER = [MeritvePoracunTipID] FROM [MeritvePoracunTip] WHERE Sifra = ''NMER''
SELECT	@MER = [MeritvePoracunTipID] FROM [MeritvePoracunTip] WHERE Sifra = ''MER''

--TIP OBRAČUNA
DECLARE @Obracun_Po_Novih_in_starih_pravilih INT
DECLARE @Obracun_Po_obstojecih_pravilih INT
DECLARE @Obracun_Po_Novih_pravilih INT
DECLARE @Kolicinski_obracun INT

SELECT @Obracun_Po_Novih_in_starih_pravilih=[ObracunTipID] FROM [ObracunTip] WHERE [Sifra]=''NIS''
SELECT @Obracun_Po_obstojecih_pravilih=[ObracunTipID] FROM [ObracunTip] WHERE [Sifra]=''S''
SELECT @Obracun_Po_Novih_pravilih=[ObracunTipID] FROM [ObracunTip] WHERE [Sifra]=''N''
SELECT @Kolicinski_obracun=[ObracunTipID] FROM [ObracunTip] WHERE [Sifra]=''K''

--TIP POGDBE
DECLARE @BP INT
DECLARE @PI INT
DECLARE @SSOPOBS INT
DECLARE @PSEKREG INT
DECLARE @PTERREG INT
DECLARE @PDOB INT
DECLARE @PDSODOSOPO INT
DECLARE @PDOBSODO INT

SELECT @BP=[PogodbaTipID] FROM [PogodbaTip] WHERE Sifra=''B_POG''
SELECT @PI=[PogodbaTipID] FROM [PogodbaTip] WHERE Sifra=''P_IZR''
SELECT @SSOPOBS=[PogodbaTipID] FROM [PogodbaTip] WHERE Sifra=''S_SOPO_BS''
SELECT @PDOB=[PogodbaTipID] FROM [PogodbaTip] WHERE Sifra=''P_DOB''

DECLARE @SodoTipID INT
SELECT @SodoTipID = OsebaTipID FROM OsebaTipID WHERE Sifra=''SODO''
DECLARE @SOPOTipID INT
SELECT @SOPOTipID = OsebaTipID FROM OsebaTipID WHERE Sifra=''SOPO''
DECLARE @TrgovecTipID INT
SELECT @TrgovecTipID = OsebaTipID FROM OsebaTipID WHERE Sifra=''TRG''
DECLARE @RegulacijaTipID INT
SELECT @RegulacijaTipID = OsebaTipID FROM OsebaTipID WHERE Sifra=''REG''
DECLARE @SRegulacijaTipID INT
SELECT @SRegulacijaTipID = OsebaTipID FROM OsebaTipID WHERE Sifra=''SREG''
DECLARE @TRegulacijaTipID INT
SELECT @TRegulacijaTipID = OsebaTipID FROM OsebaTipID WHERE Sifra=''TREG''
DECLARE @OTTipID INT
SELECT @SodoTipID = OsebaTipID FROM OsebaTipID WHERE Sifra=''OT''

SELECT @NewPoracunID=ISNULL(MAX([PoracunID]),0)+1 FROM [Poracun]
SELECT @DatumIntervalaOD=[VeljaOd],@DatumIntervalaDO=[VeljaDo] FROM [ObracunskoObdobje] WHERE [ObracunskoObdobjeID] = @ObracunskoObdobjeID

if object_id(''#Errors'') is not null
   drop table #Errors
        
CREATE TABLE #Errors
(
	ErrorID BIGINT IDENTITY(1,1) NOT NULL,
	Napaka VARCHAR(255) NOT NULL
)

if object_id(''#ErrorDetail'') is not null
   drop table #ErrorDetail
        
CREATE TABLE #ErrorDetail
(
    ErrorID BIGINT,
	ErrorDetail VARCHAR(900) NOT NULL
)

if object_id(''#PoracunskiPodatkiTemp'') is not null
        drop table #PoracunskiPodatkiPoSodo

CREATE TABLE #PoracunskiPodatkiPoSodo 
(
    OsebaID INT,
    SodoID INT,
    ObracunskoObdobjeID INT,
	PREVZEM_ELES DECIMAL(18,8),
	REAL_ostalih_v_svojem_omr_PORAC DECIMAL(18,8),
	REAL_ostalih_v_svojem_omr_OBRAC DECIMAL(18,8)
)


if object_id(''#PoracunskiPodatkiTemp'') is not null
        drop table #PoracunskiPodatkiTemp

CREATE TABLE #PoracunskiPodatkiTemp 
(
    SodoID INT,
    ObracunskoObdobjeID INT,
	PREVZEM_ELES DECIMAL(18,8),
	REAL_ostalih_v_svojem_omr_PORAC DECIMAL(18,8),
	REAL_ostalih_v_svojem_omr_OBRAC DECIMAL(18,8)
)

if object_id(''#RealizacijeObracunov'') is not null
        drop table #RealizacijeObracunov

CREATE TABLE #RealizacijeObracunov 
(
    SodoID INT,
    ObracunskoObdobjeID INT,
	RealizacijaObracuna DECIMAL(18,8),
	BSID int
)


if object_id(''#Validacija'') is not null
        drop table #Validacija

CREATE TABLE #Validacija 
(
    OsebaID INT,
    Interval DATETIME,
    PreostaliDiagramODJEM DECIMAL(18,8),
    NormiranPreostaliDiagramODJEMA DECIMAL(18,8),
    PreostaliDiagramODDAJE DECIMAL(18,8),
    NormiranPreostaliDiagramODDAJE DECIMAL(18,8),
    KontrolaPDP DECIMAL(18,8),
    KontrolaPDO DECIMAL(18,8)
)

if object_id(''#seznamObracunov'') is not null
   drop table #seznamObracunov

if object_id(''#seznamOsebinObdobji'') is not null
   drop table #seznamOsebinObdobji


IF (@NOErrors = 0)
BEGIN
	--pridobimo obracunska obdobja nato pridobimo osebe
	SELECT DISTINCT O.[ObracunID],O.[ObracunskoObdobjeID],O.[Naziv]
	INTO #seznamObracunov
	FROM  [ObracunskoObdobje] OO INNER JOIN dbo.ObracunskoObdobjeTip OOT ON OO.ObracunskoObdobjeTipID = OOT.ObracunskoObdobjeTipID
	LEFT JOIN [Obracun] O ON O.[ObracunskoObdobjeID] <> OO.[ObracunskoObdobjeID]
	INNER JOIN [ObracunskoObdobje] O1 ON O.[ObracunskoObdobjeID] = O1.[ObracunskoObdobjeID]
	INNER JOIN [ObracunskoObdobjeTip] O1T ON O1T.[ObracunskoObdobjeTipID] = O1.[ObracunskoObdobjeTipID]
	LEFT JOIN [ObracunStatus] OS ON O.ObracunStatusID = OS.[ObracunStatusID]
	WHERE 
		OS.[Sifra]=''KON''
	AND OOT.Sifra=''POR''
	AND O1T.Sifra = ''OBR''
	AND OO.[ObracunskoObdobjeID] = @ObracunskoObdobjeID 
	AND O1.[VeljaOd] >= OO.[VeljaOd]
	AND O1.[VeljaDo] <= OO.[VeljaDo]
	ORDER BY O.[ObracunID],O.[ObracunskoObdobjeID],O.[Naziv]

	IF (@@ROWCOUNT <> 12)
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 001: Izbrano poračunso obdobje ne vsebuje 12 obračunskih obdobji. Preverite intervale poračunskega obdobja IN status obračunov'' ) 
	set @NOErrors=@NOErrors+1
	END	

	SELECT O.[OsebaID],S.[ObracunskoObdobjeID]
	INTO #seznamOsebinObdobji
	FROM [Oseba] O LEFT JOIN [Pogodba] P ON P.[Partner2]=O.[OsebaID]
	LEFT JOIN [Pogodba] p2 ON p2.[Partner2] = O.[OsebaID]
	,#seznamObracunov S
	WHERE 
	    ((@DatumStanjaBaze between O.[DatumVnosa] and dbo.infinite(O.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between O.VeljaOd and dbo.infinite(O.VeljaDo)))
	AND ((@DatumStanjaBaze between P.[DatumVnosa] and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
	AND	(P.[PogodbaTipID] = @BP OR P2.[PogodbaTipID] = @PI)
	GROUP BY O.[OsebaID],S.[ObracunskoObdobjeID]
	



	Update [Poracun] Set DatumSpremembe=getdate() WHERE PoracunID < @NewPoracunID
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 002: Napaka pri označevanju preteklih poračunov.'' ) 
	set @NOErrors=@NOErrors+1
	END	

	Update [PoracunFinancniVrstica] Set DatumSpremembe=getdate() WHERE PoracunID < @NewPoracunID
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 003: Napaka pri označevanju preteklih poračunov - finančne vrstice'' ) 
	set @NOErrors=@NOErrors+1
	END	
	Update [dbo].[PoracunKolicinskiVrsticaPoBPS]  Set DatumSpremembe=getdate() WHERE PoracunID < @NewPoracunID
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 004: Napaka pri označevanju preteklih poračunov - količinski poračun BPS'' ) 
	set @NOErrors=@NOErrors+1
	END	

	Update [dbo].[PoracunKolicinskiVrsticaPoBS]  Set DatumSpremembe=getdate() WHERE PoracunID < @NewPoracunID
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 005: Napaka pri označevanju preteklih poračunov - količinski poračun BPS'' ) 
	set @NOErrors=@NOErrors+1
	END	
	
--	delete from Poracun
--	delete from [PoracunFinancniVrstica]
--	delete from [PoracunKolicinskiVrsticaPoBPS]
--	delete from [PoracunKolicinskiVrsticaPoBS]

	INSERT INTO [Poracun] (
		[PoracunID],
		[PoracunskoObdobjeId],
		[OsebaID],
		[Naziv],
		[Komentar],
		[DatumIzdaje],
		[Razlika_Dejanski_Odjem_Poracunski_Odjem],
		[ZnesekPoracuna],
		[SrednjaCena],
		[UporabnikID],
		[DatumVnosa],
		[DatumSpremembe]
	)
	SELECT
	 @NewPoracunID,
	 @ObracunskoObdobjeID,
	 S.[OsebaID],
	 @Naziv + '' - ''+MIN(O.[Naziv]),
	 @Komentar,
	 GETDATE(),
	 0,
	 0,
	 @SrednjaCena,
	 @Avtor,
	 GETDATE(),
	 NULL
	FROM #seznamOsebinObdobji S INNER JOIN Oseba O ON S.[OsebaID] = O.[OsebaID]
	WHERE     
	((@DatumStanjaBaze between O.[DatumVnosa] and dbo.infinite(O.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between O.VeljaOd and dbo.infinite(O.VeljaDo)))
	GROUP BY S.[OsebaID]
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 006: Napaka pri vnosu novega poračuna.'' ) 
	set @NOErrors=@NOErrors+1
	END	

  
--    REALIZACIJA OBRAČUN
	INSERT INTO #RealizacijeObracunov
	(
	RealizacijaObracuna,
	SodoID,
	ObracunskoObdobjeID,
	BSID
	)
    SELECT
		SUM(realizacija) AS RealizacijaObracuna,
		Oppv.SODOID,
		OB.ObracunskoObdobjeID,
		0
    FROM dbo.Obracun_PodatkiPoracunaVrstice OPPV 
	    INNER JOIN dbo.Obracun OB ON OPPV.ObracunID = OB.ObracunID
		INNER JOIN dbo.Oseba O ON OPPV.OsebaID = O.OsebaID 
		LEFT JOIN dbo.OsebaTip OT ON O.OsebaID = OT.OsebaID
    WHERE 
		OT.OsebaTipID = @SodoTipID
    AND ((@DatumStanjaBaze between O.[DatumVnosa] and dbo.infinite(O.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between O.VeljaOd and dbo.infinite(O.VeljaDo)))
    AND (@DatumStanjaBaze between OT.[DatumVnosa] and dbo.infinite(OT.DatumSpremembe))
    GROUP BY OB.ObracunskoObdobjeID,Oppv.SODOID
    
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 007: Napaka pri izračunu realizaciji obračunov'' ) 
	set @NOErrors=@NOErrors+1
	END	

    INSERT INTO #RealizacijeObracunov
	(
	RealizacijaObracuna,
	SodoID,
	ObracunskoObdobjeID,
	BSID
	)
	SELECT
		SUM(realizacija) AS RealizacijaObracuna,
		Oppv.OsebaID,
		OB.ObracunskoObdobjeID,
		0
    FROM dbo.Obracun_PodatkiPoracunaVrstice OPPV 
	    INNER JOIN dbo.Obracun OB ON OPPV.ObracunID = OB.ObracunID
		INNER JOIN dbo.Oseba O ON OPPV.OsebaID = O.OsebaID 
		LEFT JOIN dbo.OsebaTip OT ON O.OsebaID = OT.OsebaID
    WHERE 
		OT.OsebaTipID <> @SodoTipID
    AND ((@DatumStanjaBaze between O.[DatumVnosa] and dbo.infinite(O.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between O.VeljaOd and dbo.infinite(O.VeljaDo)))
    AND (@DatumStanjaBaze between OT.[DatumVnosa] and dbo.infinite(OT.DatumSpremembe))
	GROUP BY OB.ObracunskoObdobjeID,Oppv.OsebaID
   
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 008: Napaka pri izračunu realizaciji obračunov'' ) 
	set @NOErrors=@NOErrors+1
	END	
    
    UPDATE #RealizacijeObracunov
    SET BSID = P.ClanBSID
    FROM #RealizacijeObracunov RO INNER JOIN dbo.Pogodba P ON P.Partner2 = RO.SODOID
    WHERE 
		((@DatumStanjaBaze between P.[DatumVnosa] and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
	AND (P.PogodbaTipID = @BP OR P.PogodbaTipID = @PI)
    IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 009: Napaka pri izračunu realizaciji obračunov'' ) 
	set @NOErrors=@NOErrors+1
	END	
    

    
      INSERT INTO [PoracunFinancniVrstica] (
		[PoracunID],
		[ObracunskoObdobjeId],
		[OsebaID],
		SodoID,
		[Analiticno_M_ODJEM],
		[Analiticno_NM_ODJEM],
		[Analiticno_M_ODDAJA],
		[Analiticno_NM_ODDAJA],
		[Poracun_M_ODJEM],
		[Poracun_NM_ODJEM]
	) 
	SELECT 
		@NewPoracunID,
		O.[ObracunskoObdobjeID],
		PPV.[OsebaID],
		PPV.SODOID,
		SUM(PPV.[Merjen_Odjem]),
		SUM(PPV.[Nemerjen_Odjem]),
		SUM(PPV.[Merjena_Oddaja]),
		SUM(PPV.[Nemerjena_Oddaja]),
		0,
		0
	FROM 
		[Obracun_PodatkiPoracunaVrstice] PPV 
		INNER JOIN [Obracun] O ON PPV.[ObracunID] = O.[ObracunID]
		INNER JOIN [#seznamObracunov] SO ON O.[ObracunID]=SO.[ObracunID]
	GROUP BY PPv.[OsebaID],PPV.SODOID,O.[ObracunskoObdobjeID]
	ORDER BY [ObracunskoObdobjeID] ASC,[OsebaID] ASC
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 010: Napaka pri finančnem izračunu.'' ) 
	set @NOErrors=@NOErrors+1
	END	

	UPDATE dbo.PoracunFinancniVrstica 
	SET Poracun_M_ODJEM = MP.Kolicina,
		Poracun_NM_ODJEM = NMER.Kolicina
	FROM PoracunFinancniVrstica PFV inner JOIN [MeritvePoracun] MP ON MP.ObracunskoObdobjeID = PFV.[ObracunskoObdobjeID] AND mp.SistemskiOperater=PFV.SODOID AND MP.OsebaID = PFV.OsebaID AND MP.MeritvePoracunTipID = @MER
								 inner JOIN [MeritvePoracun]  NMER ON NMER.ObracunskoObdobjeID = PFV.[ObracunskoObdobjeID] AND NMER.SistemskiOperater=PFV.SODOID AND NMER.OsebaID = PFV.OsebaID AND NMER.MeritvePoracunTipID = @NMER 
	
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 011: Napaka pri finančnem izračunu.'' ) 
	set @NOErrors=@NOErrors+1
	END	

    INSERT INTO #PoracunskiPodatkiPoSodo (
		OsebaID,
		SodoID,
		ObracunskoObdobjeID,
		PREVZEM_ELES,
		REAL_ostalih_v_svojem_omr_OBRAC,
		REAL_ostalih_v_svojem_omr_PORAC
	) 
	SELECT
		PFV.OsebaID,
		PFV.SodoID,
		O.ObracunskoObdobjeID,
		0,
		SUM(CASE WHEN PFV.SodoID <> PFV.OsebaID THEN (CASE WHEN OT.OsebaTipID = @SodoTipID THEN PFV.Analiticno_M_ODJEM+PFV.Analiticno_NM_ODJEM 
				ELSE PFV.Analiticno_M_ODJEM+PFV.Analiticno_NM_ODJEM - PFV.Analiticno_M_ODDAJA - PFV.Analiticno_NM_ODDAJA END) 
			ELSE 0 END),
		SUM(CASE WHEN PFV.SodoID <> PFV.OsebaID 
		THEN (CASE WHEN OT.OsebaTipID = @SodoTipID then	PFV.Poracun_M_ODJEM+PFV.Poracun_NM_ODJEM 
		ELSE PFV.Poracun_M_ODJEM+PFV.Poracun_NM_ODJEM - PFV.Analiticno_M_ODDAJA - PFV.Analiticno_NM_ODDAJA
		 END )
		ELSE 0 end) 
	FROM 
		[PoracunFinancniVrstica] PFV INNER JOIN dbo.Obracun_PodatkiPoracuna OP ON PFV.OsebaID = OP.OsebaID
									 INNER JOIN dbo.Obracun O ON OP.ObracunID = O.ObracunID
									 INNER JOIN dbo.Oseba OS ON oS.OsebaID=PFV.OsebaID
									 left JOIN dbo.OsebaTip OT ON OS.OsebaID = OT.OsebaID --AND (OT.OsebaTipID = @SodoTipID OR OT.OsebaTipID = @TrgovecTipID)
	WHERE 
		PFV.ObracunskoObdobjeId = O.ObracunskoObdobjeID
	AND PFV.SodoID <> PFV.OsebaID
	AND ((@DatumStanjaBaze between OS.[DatumVnosa] and dbo.infinite(OS.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between OS.VeljaOd and dbo.infinite(OS.VeljaDo)))
	AND ((@DatumStanjaBaze between OT.[DatumVnosa] and dbo.infinite(OT.DatumSpremembe)))
	GROUP BY O.ObracunskoObdobjeID,Pfv.SodoID,Pfv.OsebaID
	
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 012: Napaka pri pripravi poračunskih podatkov po SODO.'' ) 
	set @NOErrors=@NOErrors+1
	END	

	INSERT INTO #PoracunskiPodatkiTemp (
		SodoID,
		ObracunskoObdobjeID,
		PREVZEM_ELES,
		REAL_ostalih_v_svojem_omr_OBRAC,
		REAL_ostalih_v_svojem_omr_PORAC
	) 
	SELECT
		SodoID,
		ObracunskoObdobjeID,
		0,
		SUM(REAL_ostalih_v_svojem_omr_OBRAC),
		SUM(REAL_ostalih_v_svojem_omr_PORAC)
	FROM #PoracunskiPodatkiPoSodo 
	GROUP BY ObracunskoObdobjeID,SodoID	

	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 013: Napaka pri pripravi poračunskih podatkov po SODO.'' )
	set @NOErrors=@NOErrors+1
	END	


	UPDATE #PoracunskiPodatkiTemp 
	SET PREVZEM_ELES = OP.SOPO
	FROM #PoracunskiPodatkiTemp PPT INNER JOIN Obracun_PodatkiPoracuna OP ON PPT.SodoID = OP.OsebaID 
									INNER JOIN Obracun O ON OP.ObracunID = O.ObracunID
	WHERE							
		PPT.ObracunskoObdobjeID=O.ObracunskoObdobjeID
	
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 014: Napaka pri pripravi poračunskih podatkov po SODO.'' )
	set @NOErrors=@NOErrors+1
	END	
	
	--SODO PORAČUN BPS
	--NI BPS HSE ...extra dodamo TISTE Osebe, ki niso SODO ampak so BPS v Bilančni Shemi
	INSERT INTO [PoracunKolicinskiVrsticaPoBPS] (
		[PoracunID],
		[ObracunskoObdobjeId],
		[OsebaID],
		[LastnaRealizacija],
		[RealizacijaDrugje],
		[RealizacijaPoracun],
		[RealizacijaObracun],
		[RazlikaPoracun]
	) 
	SELECT
	@NewPoracunID,
	PFV.[ObracunskoObdobjeId],
	PFV.OsebaID,
	SUM(CASE WHEN PFV.OsebaID = PFV.SODOID then PPT.PREVZEM_ELES-PPT.REAL_ostalih_v_svojem_omr_PORAC ELSE 0 end),
	SUM(CASE WHEN PFV.OsebaID <> PFV.SODOID then PFV.Poracun_M_ODJEM+PFV.Analiticno_NM_ODJEM ELSE 0 end),
	0,
	0,
	0
	FROM [PoracunFinancniVrstica] PFV left JOIN #PoracunskiPodatkiTemp PPT ON PFV.SodoID = PPT.SodoID AND PFV.ObracunskoObdobjeId = PPT.ObracunskoObdobjeID
									--  left JOIN #RealizacijeObracunov RO ON PFV.SodoID = RO.SODOID AND PFV.O0bracunskoObdobjeId = RO.ObracunskoObdobjeID
									  INNER JOIN dbo.OsebaTip OT ON PFV.OsebaID = OT.OsebaID AND OT.OsebaTipID=@SodoTipID
									  INNER JOIN dbo.Pogodba P ON PFV.OsebaID = P.Partner2 AND P.PogodbaTipID = @PI
	WHERE 
		PFV.PoracunID = @NewPoracunID
	AND ((@DatumStanjaBaze between P.[DatumVnosa] and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
	GROUP BY PFV.[ObracunskoObdobjeId],PFV.OsebaID

	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 015: Napaka pri pripravi količinskih poračunskih podatkov po BPS - SODO.'' )
	set @NOErrors=@NOErrors+1
	END	

	
	--Poračun trgovci
	INSERT INTO [PoracunKolicinskiVrsticaPoBPS] (
		[PoracunID],
		[ObracunskoObdobjeId],
		[OsebaID],
		[LastnaRealizacija],
		[RealizacijaDrugje],
		[RealizacijaPoracun],
		[RealizacijaObracun],
		[RazlikaPoracun]
	) 
	SELECT
	@NewPoracunID,
	PFV.[ObracunskoObdobjeId],
	PFV.OsebaID,
	0,
	SUM(PFV.Poracun_M_ODJEM+PFV.Analiticno_NM_ODJEM-PFV.Analiticno_M_ODDAJA-PFV.Analiticno_NM_ODDAJA),
	SUM(PFV.Poracun_M_ODJEM+PFV.Analiticno_NM_ODJEM-PFV.Analiticno_M_ODDAJA-PFV.Analiticno_NM_ODDAJA),
--	SUM(CASE WHEN PFV.OsebaID = RO.SODOID then RO.[RealizacijaObracuna] ELSE 0 end),
	0,
	0
	FROM [PoracunFinancniVrstica] PFV left JOIN #PoracunskiPodatkiTemp PPT ON PFV.SodoID = PPT.SodoID AND PFV.ObracunskoObdobjeId = PPT.ObracunskoObdobjeID
									 -- inner JOIN #RealizacijeObracunov RO ON PFV.OsebaID = RO.SODOID AND PFV.ObracunskoObdobjeId = RO.ObracunskoObdobjeID
									  INNER JOIN dbo.OsebaTip OT ON PFV.OsebaID = OT.OsebaID AND OT.OsebaTipID<>@SodoTipID --MOGOČE TUKAJ OT.OsebaTipID=@SodoTipID ali pa OsebaTipID <> TRGOVEC
									  INNER JOIN dbo.Pogodba P ON PFV.OsebaID = P.Partner2 AND P.PogodbaTipID = @PI
	WHERE 
		PFV.PoracunID = @NewPoracunID
	AND ((@DatumStanjaBaze between P.[DatumVnosa] and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
	GROUP BY PFV.[ObracunskoObdobjeId],PFV.OsebaID


	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 016: Napaka pri pripravi količinskih poračunskih podatkov po BPS - trgovci.'' )
	set @NOErrors=@NOErrors+1
	END	
	
	UPDATE 
		dbo.PoracunKolicinskiVrsticaPoBPS 
	SET 
		RealizacijaObracun = RO.[RealizacijaObracuna],
		RealizacijaPoracun =(PKVBPS.LastnaRealizacija+PKVBPS.RealizacijaDrugje),
		RazlikaPoracun =  (PKVBPS.LastnaRealizacija+PKVBPS.RealizacijaDrugje)-RO.[RealizacijaObracuna]
	FROM PoracunKolicinskiVrsticaPoBPS PKVBPS INNER JOIN #RealizacijeObracunov RO ON PKVBPS.OsebaID = Ro.SodoID AND PKVBPS.ObracunskoObdobjeId = RO.ObracunskoObdobjeID
	WHERE 
		PoracunID = @NewPoracunID
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 017: Napaka pri pripravi količinskih poračunskih podatkov.'' )
	set @NOErrors=@NOErrors+1
	END	



	INSERT INTO dbo.PoracunKolicinskiVrsticaPoBS (
		PoracunID,
		ObracunskoObdobjeId,
		OsebaID,
		LastnaRealizacija,
		RealizacijaDrugje,
		RealizacijaPoracun,
		RealizacijaObracun,
		RazlikaPoracun
	)
	SELECT
	@NewPoracunID,
	PFV.[ObracunskoObdobjeId],
	P.ClanBSID,
	SUM(CASE WHEN PFV.OsebaID = PFV.SODOID then PPT.PREVZEM_ELES-PPT.REAL_ostalih_v_svojem_omr_PORAC ELSE 0 end),
	SUM(CASE WHEN PFV.OsebaID <> PFV.SODOID then PFV.Poracun_M_ODJEM+PFV.Analiticno_NM_ODJEM ELSE 0 end),
	0,
	0,
	0	
	from
	[PoracunFinancniVrstica] PFV LEFT JOIN #PoracunskiPodatkiTemp PPT ON PFV.OsebaID = PPT.SodoID AND PFV.ObracunskoObdobjeId = PPT.ObracunskoObdobjeID
								 INNER JOIN dbo.Pogodba P ON PFV.OsebaID = P.Partner2
	WHERE 
		PFV.PoracunID = @NewPoracunID
	AND ((@DatumStanjaBaze between P.[DatumVnosa] and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
	GROUP BY PFV.[ObracunskoObdobjeId],P.ClanBSID
	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 018: Napaka pri pripravi količinskih poračunskih podatkov po BS.'' )
	set @NOErrors=@NOErrors+1
	END	

	UPDATE 
		dbo.PoracunKolicinskiVrsticaPoBS 
	SET 
		RealizacijaObracun =  R.Suma
	FROM PoracunKolicinskiVrsticaPoBS RKBS INNER JOIN (SELECT SUM(RO.[RealizacijaObracuna]) AS Suma,RO.BSID,RO.ObracunskoObdobjeID FROM #RealizacijeObracunov RO GROUP BY RO.BSID,RO.ObracunskoObdobjeID) R ON R.BSID = RKBS.OsebaID AND R.ObracunskoObdobjeID = RKBS.ObracunskoObdobjeId
	WHERE 
		PoracunID = @NewPoracunID

   IF (@@ERROR <> 0)
	begin 
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 019: Napaka pri pripravi količinskih poračunskih podatkov po BS.'' )
	set @NOErrors=@NOErrors+1
	END	
		
	UPDATE 
		dbo.PoracunKolicinskiVrsticaPoBS 
	SET 
		RealizacijaPoracun = LastnaRealizacija+RealizacijaDrugje,
		RazlikaPoracun =  (LastnaRealizacija+RealizacijaDrugje)-RealizacijaObracun
	WHERE 
		PoracunID = @NewPoracunID

	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 020: Napaka pri pripravi količinskih poračunskih podatkov po BS.'' )
	set @NOErrors=@NOErrors+1
	END	
		
	
	UPDATE dbo.Poracun
	SET Razlika_Dejanski_Odjem_Poracunski_Odjem = BPS.Suma
	FROM dbo.Poracun P inner JOIN (SELECT SUM(PK.RazlikaPoracun) AS Suma,PK.OsebaID FROM dbo.PoracunKolicinskiVrsticaPoBPS PK GROUP BY Pk.OsebaID) BPS ON BPS.OsebaID = P.OsebaID
	where P.PoracunID = @NewPoracunID

	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 021: Napaka pri pripravi kalkulaciji poračuna.'' )
	set @NOErrors=@NOErrors+1
	END	
	
	UPDATE dbo.Poracun
	SET Razlika_Dejanski_Odjem_Poracunski_Odjem = BS.Suma
	FROM dbo.Poracun P inner JOIN (SELECT SUM(PK.RazlikaPoracun) AS Suma,PK.OsebaID FROM dbo.PoracunKolicinskiVrsticaPoBS PK GROUP BY Pk.OsebaID) BS ON BS.OsebaID = P.OsebaID
	where P.PoracunID = @NewPoracunID

	IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 022: Napaka pri pripravi kalkulaciji poračuna.'' )
	set @NOErrors=@NOErrors+1
	END	

	UPDATE dbo.Poracun
	SET ZnesekPoracuna = ROUND(Razlika_Dejanski_Odjem_Poracunski_Odjem*SrednjaCena/1000,2)
	where PoracunID = @NewPoracunID
    IF (@@ERROR <> 0) 
	begin
		INSERT INTO [#Errors] (
			[Napaka]
		) VALUES (
			''Napaka 023: Napaka pri pripravi kalkulaciji poračuna.'' )
	set @NOErrors=@NOErrors+1
	END	
	
					 
	
END -- PORAČUN


IF (@NOErrors <> 0)
BEGIN
	SET @ValidationErrorsXML = (SELECT * FROM #Errors FOR XML PATH (''Napake''), ROOT (''Root''))
	IF (SELECT COUNT(*) FROM [#ErrorDetail])  > 0
	SET @ValidationErrorsDetailXML = (SELECT * FROM [#ErrorDetail] FOR XML PATH (''ErrorDetail''), ROOT (''Root''))
END

if object_id(''tempDB..#Errors'') is not null
    drop table #Errors

RETURN @NewPoracunID

END


















' 
END
GO
