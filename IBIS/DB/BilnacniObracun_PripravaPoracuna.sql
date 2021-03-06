/****** Object:  StoredProcedure [dbo].[BilnacniObracun_PripravaPoracuna]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PripravaPoracuna]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_PripravaPoracuna]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PripravaPoracuna]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'











CREATE PROCEDURE [dbo].[BilnacniObracun_PripravaPoracuna]
	@ObracunID INT,
	@DatumVeljavnostiPodatkov  DATETIME = GETDATE,
	@DatumStanjaBaze DATETIME = GETDATE,
	@Avtor INT,
	@PoracunID INT OUTPUT
AS
BEGIN

	DECLARE @NewPoracunID INT
	DECLARE @DatumIntervalaOD DATETIME
	DECLARE @DatumIntervalaDO DATETIME

	DECLARE @NormiranPPP DECIMAL(18,8) 
	DECLARE @NormiranPPO DECIMAL(18,8) 
	DECLARE @ErrorID BIGINT

	DECLARE @NOErrors INT
	--DECLARE @ObracunTipID INT
	DECLARE @ObjektID INT
		

	SET @NOErrors = 0;


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

	SELECT	@VIRT_MERJENI_ODJEM = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) VIRT_MERJENI_ODJEM''
	SELECT	@VIRT_NEMERJENI_ODJEM = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) VIRT_NEMERJENI_ODJEM''
	SELECT	@VIRT_MERJEN_ODDAJA = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) VIRT_MERJEN_ODDAJA''
	SELECT	@VIRT_NEMERJEN_ODDAJA = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) VIRT_NEMERJEN_ODDAJA''
	SELECT	@VIRT_REGULACIJA = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(REG) VIRT_REGULACIJA''
	SELECT	@VIRT_ELES_ODJEM = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_ELES_ODJEM''
	SELECT	@VIRT_ELES_ODDAJA = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''VIRT_ELES_ODDAJA''
	SELECT	@VIRT_PBI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) VIRT_PBI''
	SELECT	@VIRT_DSP = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) VIRT_DSP''
	SELECT	@UDO_P_MERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) UDO_P_MERJENI''
	SELECT	@UDO_P_NEMERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) UDO_P_NEMERJENI''
	SELECT	@UDO_P_IZGUBE = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) UDO_P_IZGUBE''
	SELECT	@MP_SKUPAJ = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) MP_SKUPAJ''
	SELECT	@MP_ND_NEMERJENI= [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) MP_ND_NEMERJENI''
	SELECT	@MP_ND_MERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) MP_ND_MERJENI''
	SELECT	@MP_NP_NEMERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) MP_NP_NEMERJENI''
	SELECT	@MP_NP_MERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) MP_NP_MERJENI''
	SELECT	@MP_KP_NEMERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) MP_KP_NEMERJENI''
	SELECT	@MP_KP_MERJENI = [PPMTipID] FROM [PPMTip] WHERE Naziv = ''(SODO) MP_KP_MERJENI''

	--TIP OBRAČUNA
	DECLARE @Obracun_Po_Novih_in_starih_pravilih INT
	DECLARE @Obracun_Po_obstojecih_pravilih INT
	DECLARE @Obracun_Po_Novih_pravilih INT
	DECLARE @Kolicinski_obracun INT
	
	SELECT @Obracun_Po_Novih_in_starih_pravilih=[ObracunTipID] FROM [ObracunTip] WHERE [Sifra]=''NIS''
	SELECT @Obracun_Po_obstojecih_pravilih=[ObracunTipID] FROM [ObracunTip] WHERE [Sifra]=''S''
	SELECT @Obracun_Po_Novih_pravilih=[ObracunTipID] FROM [ObracunTip] WHERE [Sifra]=''N''
	SELECT @Kolicinski_obracun=[ObracunTipID] FROM [ObracunTip] WHERE [Sifra]=''K''

	--TIP POGODBE
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
	SELECT @PSEKREG=[PogodbaTipID] FROM [PogodbaTip] WHERE Sifra=''P_SEK_REG''
	SELECT @PTERREG=[PogodbaTipID] FROM [PogodbaTip] WHERE Sifra=''P_TER_REG''
	SELECT @PDOB=[PogodbaTipID] FROM [PogodbaTip] WHERE Sifra=''P_DOB''
	SELECT @PDSODOSOPO=[PogodbaTipID] FROM [PogodbaTip] WHERE Sifra=''P_DOB_SODO_SOPO''
	SELECT @PDOBSODO=[PogodbaTipID] FROM [PogodbaTip] WHERE Sifra=''P_DOB_SODO''

	DECLARE @SodoTipID INT
	SELECT @SodoTipID = OsebaTipID FROM OsebaTipID WHERE Sifra=''SODO''

	SELECT @DatumIntervalaOD=[VeljaOd],@DatumIntervalaDO=[VeljaDo]
    FROM [ObracunskoObdobje] OO INNER JOIN [Obracun] O ON O.[ObracunskoObdobjeID]=OO.[ObracunskoObdobjeID]
    WHERE O.[ObracunID] = @ObracunID

	DELETE FROM [Obracun_PodatkiPoracunaVrstice] 
	FROM [Obracun_PodatkiPoracunaVrstice] P INNER JOIN Obracun O ON P. [ObracunID] = O.[ObracunID]
	INNER JOIN [ObracunskoObdobje] OD ON O.[ObracunskoObdobjeID] = OD.[ObracunskoObdobjeID]
	INNER JOIN [ObracunStatus] Os ON O.[ObracunStatusID]=Os.[ObracunStatusID]
	WHERE 
		OD.[VeljaOd]=@DatumIntervalaOD
	AND OD.[VeljaDo]=@DatumIntervalaDO
	AND OS.[Sifra]=''INF''

	DELETE FROM [Obracun_PodatkiPoracuna] 
	FROM [Obracun_PodatkiPoracuna] P INNER JOIN Obracun O ON P. [ObracunID] = O.[ObracunID]
	INNER JOIN [ObracunskoObdobje] OD ON O.[ObracunskoObdobjeID] = OD.[ObracunskoObdobjeID]
	INNER JOIN [ObracunStatus] Os ON O.[ObracunStatusID]=Os.[ObracunStatusID]
	WHERE 
		OD.[VeljaOd]=@DatumIntervalaOD
	AND OD.[VeljaDo]=@DatumIntervalaDO
	AND OS.[Sifra]=''INF''

	--VALIDACIJA
	IF (@NOErrors=0)
	BEGIN	
		
		INSERT INTO [Obracun_PodatkiPoracuna] (
			[ObracunID],
			[OsebaID],
			[SOPO],
			[KP_Merjeni_Skupaj],
			[KP_Nemerjeni_Skupaj],
			[NKP_Merjeni_Skupaj],
			[NKP_Nemerjeni_Skupaj],
			[ND_merjeni_Skupaj],
			[ND_Nemerjeni_Skupaj],
			[Skupen_Prevzem],
			[Izgube_Omrezja_Skupaj],
			[Prevzem_Brez_Izgub_Skupaj],
			[Avtor]
		) 
		SELECT
			@ObracunID,
			Os.[OsebaID],
			SUM((CASE WHEN P.[PPMTipID] = @VIRT_ELES_ODJEM THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @MP_KP_MERJENI THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @MP_KP_NEMERJENI THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @MP_NP_MERJENI THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @MP_NP_NEMERJENI THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @MP_ND_MERJENI THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @MP_ND_NEMERJENI THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @MP_SKUPAJ THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @UDO_P_IZGUBE THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @VIRT_PBI THEN M.[Kolicina] ELSE 0 end)),
			@Avtor	
		FROM
			[view_Meritve] M INNER JOIN [PPM] P ON M.[PPMID] = P.[PPMID]
			INNER JOIN Oseba Os ON P.[Dobavitelj1] = OS.[OsebaID]
			
		WHERE
			M.[Interval] > @DatumIntervalaOD
		AND	M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
		AND	M.[DatumVnosa] <= @DatumVeljavnostiPodatkov
		AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
		AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
		AND	((@DatumStanjaBaze between Os.[DatumVnosa] and dbo.infinite(Os.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between Os.VeljaOd and dbo.infinite(Os.VeljaDo)))
		GROUP BY Os.[OsebaID]
		
		INSERT INTO [Obracun_PodatkiPoracunaVrstice] (
			[ObracunID],
			[OsebaID],
			[SODOID],
			[Merjena_Oddaja],
			[Nemerjena_Oddaja],
			[Merjen_Odjem],
			[Nemerjen_Odjem],
			Realizacija,
			[Avtor]
		) 
		SELECT
			@ObracunID,
			P.[Dobavitelj1],
			P.[SistemskiOperater1],
			SUM((CASE WHEN P.[PPMTipID] = @VIRT_MERJEN_ODDAJA THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @VIRT_NEMERJEN_ODDAJA THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @VIRT_MERJENI_ODJEM THEN M.[Kolicina] ELSE 0 end)),
			SUM((CASE WHEN P.[PPMTipID] = @VIRT_NEMERJENI_ODJEM THEN M.[Kolicina] ELSE 0 end)),
			SUM( (CASE WHEN P.[PPMTipID] = @VIRT_MERJENI_ODJEM OR P.[PPMTipID] = @VIRT_NEMERJENI_ODJEM THEN M.Kolicina
				       WHEN  P.[PPMTipID] = @UDO_P_IZGUBE THEN M.Kolicina
				       WHEN (P.[PPMTipID] = @VIRT_MERJEN_ODDAJA OR P.[PPMTipID] = @VIRT_NEMERJEN_ODDAJA) AND P.[Dobavitelj1] = P.[SistemskiOperater1] THEN -1*M.Kolicina
				       ELSE 0
				  END) ) AS Realizacija,
			@Avtor
		FROM 
			[view_Meritve] M INNER JOIN [PPM] P ON M.[PPMID] = P.[PPMID]
			INNER JOIN Oseba Os ON P.[Dobavitelj1] = OS.[OsebaID]
		--	left JOIN dbo.OsebaTip OT ON os.OsebaID = OT.OsebaID
		WHERE
			M.[Interval] > @DatumIntervalaOD
		AND	M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
		AND	M.[DatumVnosa] <= @DatumVeljavnostiPodatkov
		--AND OT.OsebaTipID = @SodoTipID
		AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
		AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))

		--AND (@DatumStanjaBaze between OT.[DatumVnosa] and dbo.infinite(OT.DatumSpremembe))
		AND	((@DatumStanjaBaze between Os.[DatumVnosa] and dbo.infinite(Os.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between Os.VeljaOd and dbo.infinite(Os.VeljaDo)))
		GROUP BY P.[Dobavitelj1],P.[SistemskiOperater1]
				
	END --KONTROLA VHODNIH PODATKOV ok


	IF (@NOErrors <> 0)
	BEGIN
	    
		RETURN 0
	END
	ELSE
	BEGIN
		
--		UPDATE [Obracun]
--			SET [ObracunStatusID] = O.[ObracunStatusID]
--		FROM [ObracunStatus] O
--		WHERE O.Sifra=''KON''
		
		RETURN 1
	END

END















' 
END
GO
