/****** Object:  StoredProcedure [dbo].[BilancniPoracun_SkupniPrikaz]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilancniPoracun_SkupniPrikaz]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilancniPoracun_SkupniPrikaz]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilancniPoracun_SkupniPrikaz]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'









CREATE PROCEDURE [dbo].[BilancniPoracun_SkupniPrikaz]
	@PoracunID INT,
	@OsebaID INT,
	@stanje datetime
AS
BEGIN

DECLARE @PoracunFromDate datetime
DECLARE @PoracunToDate datetime
DECLARE @PoracunskoObdobjeID int

if object_id(''tempDB..#PodatkiSkupniPoracun'') is not null
   drop table #PodatkiSkupniPoracun
        
CREATE TABLE #PodatkiSkupniPoracun
(
	ObracunskoObdobjeID INT,
	TipPodatka			INT,
	Kolicina			decimal(19, 6)
)

if object_id(''tempDB..#TipiPodatkiSkupniPoracun'') is not null
   drop table #TipiPodatkiSkupniPoracun
        
CREATE TABLE #TipiPodatkiSkupniPoracun
(
	TipPodatka			INT,
	Naziv				varchar(255)
)

if object_id(''tempDB..#PodatkiBPSzaBS'') is not null
   drop table #PodatkiBPSzaBS
        
CREATE TABLE #PodatkiBPSzaBS
(
	OsebaID			INT,
	Naziv			varchar(255)
)

Select @PoracunskoObdobjeID=PR.PoracunskoObdobjeID, @PoracunFromDate=OO.VeljaOd, @PoracunToDate=OO.VeljaDo from Poracun PR 
INNER JOIN ObracunskoObdobje OO ON OO.ObracunskoObdobjeID=PR.PoracunskoObdobjeId and OO.ObracunskoObdobjeTipID=2
where 
PR.PoracunID=@PoracunID
and PR.DatumVnosa <= @stanje and ISNULL(PR.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje

DECLARE @OsebaNaziv varchar(255)
SELECT @OsebaNaziv=Kratica from Oseba where OsebaID=@OsebaID and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje AND (@stanje BETWEEN VeljaOd AND dbo.infinite(VeljaDo))

DECLARE @isOsebaBS int
exec @isOsebaBS= Oseba_JeBS @OsebaID,@stanje
--Pogledamo ali je izbrana oseba Bilancna skupina
/*Select @isOsebaBS=count(PogodbaID) from Pogodba 
where 
Partner2=@OsebaID 
and nivo=1
and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
*/
DECLARE @isOsebaSODO int
exec @isOsebaSODO= Oseba_JeSODO @OsebaID,@stanje
/*--Pogledamo ali je izbrana oseba SODO
Select @isOsebaSODO=count(OsebaID) from OsebaTip
where
OsebaID=@OsebaID
and OsebaTipID=1
and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
*/
--select @isOsebaSODO

--ce je oseba bilancna skupin zlistamo vse njene BPS
If @isOsebaBS>0
BEGIN
    -- izbor childs v bilancni shemi
	INSERT INTO #PodatkiBPSzaBS
	(OsebaID,Naziv)
	select distinct p.partner2 as vrednost,  o.Kratica as naziv  from Pogodba p, Oseba o 
	where o.OsebaID=p.partner2 and p.Partner1 = @OsebaId and p.nivo=2 and p.PogodbaTipID < 100 and
	p.DatumVnosa <= @stanje and ISNULL(p.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje AND (@stanje BETWEEN p.VeljaOd AND dbo.infinite(p.VeljaDo)) AND
	o.DatumVnosa <= @stanje and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje AND (@stanje BETWEEN o.VeljaOd AND dbo.infinite(o.VeljaDo));

END

--v primeru, da je izbrana oseba SODO and BPS
IF (@isOsebaSODO>0) and (@isOsebaBS=0)
BEGIN
	IF (@isOsebaSODO>0) 
	BEGIN
		INSERT INTO #PodatkiSkupniPoracun
		(ObracunskoObdobjeID,TipPodatka,Kolicina)
		(SELECT
			ObracunskoObdobjeID,
			1,
			LastnaRealizacija as Kolicina
		FROM PoracunKolicinskiVrsticaPoBPS
		WHERE 
			PoracunID=@PoracunID
			and OsebaID=@OsebaID
		)
	END
	
	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		2,
		RealizacijaDrugje as Kolicina
	FROM PoracunKolicinskiVrsticaPoBPS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		3,
		RealizacijaPoracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBPS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		4,
		RealizacijaObracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBPS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		5,
		RazlikaPoracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBPS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)
	
	--določimo opise posameznih tipov, ki se bodo videli v porocilu
	IF (@isOsebaSODO>0) 
	BEGIN	
		INSERT INTO #TipiPodatkiSkupniPoracun
		(TipPodatka,Naziv)
		VALUES
		(1,''Lastna REALIZACIJA v svojem omrežju'')
	END
	
	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(2,''REALIZACIJA v drugih omrežjih '')

	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(3,''REALIZACIJA PORAČUN [kWh]'')

	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(4,''REALIZACIJA OBRAČUN [kWh]'')

	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(5,''RAZLIKA PORAČUN [kWh]'')
END

--v primeru, da je izbrana oseba SODO in BS
IF (@isOsebaSODO>0) or (@isOsebaBS>0)
BEGIN
	IF (@isOsebaSODO>0) 
	BEGIN
		INSERT INTO #PodatkiSkupniPoracun
		(ObracunskoObdobjeID,TipPodatka,Kolicina)
		(SELECT
			ObracunskoObdobjeID,
			1,
			LastnaRealizacija as Kolicina
		FROM PoracunKolicinskiVrsticaPoBS
		WHERE 
			PoracunID=@PoracunID
			and OsebaID=@OsebaID
		)
	END
	
	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		2,
		RealizacijaDrugje as Kolicina
	FROM PoracunKolicinskiVrsticaPoBS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		3,
		RealizacijaPoracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		4,
		RealizacijaObracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		5,
		RazlikaPoracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)
	
	--določimo opise posameznih tipov, ki se bodo videli v porocilu
	IF (@isOsebaSODO>0) 
	BEGIN	
		INSERT INTO #TipiPodatkiSkupniPoracun
		(TipPodatka,Naziv)
		VALUES
		(1,''Lastna REALIZACIJA v svojem omrežju'')
	END
	
	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(2,''REALIZACIJA v drugih omrežjih '')

	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(3,''REALIZACIJA PORAČUN [kWh]'')

	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(4,''REALIZACIJA OBRAČUN [kWh]'')

	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(5,''RAZLIKA PORAČUN [kWh]'')
END

--v primeru, da je izbrana oseba BS in ni SODO
IF (@isOsebaSODO=0) and (@isOsebaBS>0)
BEGIN
	
	DECLARE @BPSOsebaID int
	DECLARE @BPSOsebaNaziv varchar(255)
	DECLARE @TipPodatkaId int
	SET @TipPodatkaId=1

	DECLARE cursorBPS CURSOR FOR 
	SELECT OsebaID,Naziv
	FROM #PodatkiBPSzaBS
	ORDER BY OsebaID

	OPEN cursorBPS

	FETCH NEXT FROM cursorBPS 
	INTO @BPSOsebaID, @BPSOsebaNaziv
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--print @BPSOsebaNaziv		
		INSERT INTO #PodatkiSkupniPoracun
		(ObracunskoObdobjeID,TipPodatka,Kolicina)
		(SELECT
			ObracunskoObdobjeID,
			@TipPodatkaId,
			RealizacijaPoracun as Kolicina
		FROM PoracunKolicinskiVrsticaPoBPS
		WHERE 
			PoracunID=@PoracunID
			and OsebaID=@BPSOsebaID
		)
		INSERT INTO #TipiPodatkiSkupniPoracun
		(TipPodatka,Naziv)
		VALUES
		(@TipPodatkaId,''REALIZACIJA ''+@BPSOsebaNaziv)
		
		SET @TipPodatkaId=@TipPodatkaId+1		

		FETCH NEXT FROM cursorBPS 
		INTO @BPSOsebaID, @BPSOsebaNaziv
	END

	CLOSE cursorBPS
	DEALLOCATE cursorBPS


	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		@TipPodatkaId,
		RealizacijaPoracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)
	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(@TipPodatkaId,''REALIZACIJA '' + @OsebaNaziv + '' PORAČUN [kWh]'')
	SET @TipPodatkaId=@TipPodatkaId+1
	

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		@TipPodatkaId,
		RealizacijaObracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)
	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(@TipPodatkaId,''REALIZACIJA '' + @OsebaNaziv + '' OBRAČUN [kWh]'')
	SET @TipPodatkaId=@TipPodatkaId+1

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		@TipPodatkaId,
		RazlikaPoracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)
	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(@TipPodatkaId,''RAZLIKA '' + @OsebaNaziv + '' PORAČUN [kWh]'')
	SET @TipPodatkaId=@TipPodatkaId+1
	
	
END


--Prikaz podatkov
Select 
	OO.ObracunskoObdobjeID,
	OO.VeljaOd,
	OO.VeljaDo,
	PSP.Kolicina, 
	PSP.TipPodatka,
	TPSP.Naziv as TipNaziv
from #PodatkiSkupniPoracun PSP
INNER JOIN ObracunskoObdobje OO ON OO.ObracunskoObdobjeID=PSP.ObracunskoObdobjeID and OO.ObracunskoObdobjeTipID=1 and OO.DatumVnosa <= @stanje and ISNULL(OO.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
INNER JOIN #TipiPodatkiSkupniPoracun TPSP ON TPSP.TipPodatka=PSP.TipPodatka
ORDER BY PSP.TipPodatka

if object_id(''tempDB..#PodatkiSkupniPoracun'') is not null
    drop table #PodatkiSkupniPoracun

if object_id(''tempDB..#TipiPodatkiSkupniPoracun'') is not null
    drop table #TipiPodatkiSkupniPoracun

if object_id(''tempDB..#PodatkiBPSzaBS'') is not null
    drop table #PodatkiBPSzaBS

END

/*
DECLARE @PoracunFromDate datetime
DECLARE @PoracunToDate datetime
DECLARE @PoracunskoObdobjeID int

if object_id(''tempDB..#PodatkiSkupniPoracun'') is not null
   drop table #PodatkiSkupniPoracun
        
CREATE TABLE #PodatkiSkupniPoracun
(
	ObracunskoObdobjeID INT,
	TipPodatka			INT,
	Kolicina			decimal(19, 6)
)

if object_id(''tempDB..#TipiPodatkiSkupniPoracun'') is not null
   drop table #TipiPodatkiSkupniPoracun
        
CREATE TABLE #TipiPodatkiSkupniPoracun
(
	TipPodatka			INT,
	Naziv				varchar(255)
)

if object_id(''tempDB..#PodatkiBPSzaBS'') is not null
   drop table #PodatkiBPSzaBS
        
CREATE TABLE #PodatkiBPSzaBS
(
	OsebaID			INT,
	Naziv			varchar(255)
)

Select @PoracunskoObdobjeID=PR.PoracunskoObdobjeID, @PoracunFromDate=OO.VeljaOd, @PoracunToDate=OO.VeljaDo from Poracun PR 
INNER JOIN ObracunskoObdobje OO ON OO.ObracunskoObdobjeID=PR.PoracunskoObdobjeId and OO.ObracunskoObdobjeTipID=2
where 
PR.PoracunID=@PoracunID
and PR.DatumVnosa <= @stanje and ISNULL(PR.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje

DECLARE @OsebaNaziv varchar(255)
SELECT @OsebaNaziv=Kratica from Oseba where OsebaID=@OsebaID and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje AND (@stanje BETWEEN VeljaOd AND dbo.infinite(VeljaDo))

DECLARE @isOsebaBS int
exec @isOsebaBS= Oseba_JeBS @OsebaID,@stanje
--Pogledamo ali je izbrana oseba Bilancna skupina
/*Select @isOsebaBS=count(PogodbaID) from Pogodba 
where 
Partner2=@OsebaID 
and nivo=1
and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
*/
DECLARE @isOsebaSODO int
exec @isOsebaSODO= Oseba_JeSODO @OsebaID,@stanje
/*--Pogledamo ali je izbrana oseba SODO
Select @isOsebaSODO=count(OsebaID) from OsebaTip
where
OsebaID=@OsebaID
and OsebaTipID=1
and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
*/
--select @isOsebaSODO

--ce je oseba bilancna skupin zlistamo vse njene BPS
If @isOsebaBS>0
BEGIN
    -- izbor childs v bilancni shemi
	INSERT INTO #PodatkiBPSzaBS
	(OsebaID,Naziv)
	select distinct p.partner2 as vrednost,  o.Kratica as naziv  from Pogodba p, Oseba o 
	where o.OsebaID=p.partner2 and p.Partner1 = @OsebaId and p.nivo=2 and p.PogodbaTipID < 100 and
	p.DatumVnosa <= @stanje and ISNULL(p.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje AND (@stanje BETWEEN p.VeljaOd AND dbo.infinite(p.VeljaDo)) AND
	o.DatumVnosa <= @stanje and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje AND (@stanje BETWEEN o.VeljaOd AND dbo.infinite(o.VeljaDo));

END

--v primeru, da je izbrana oseba SODO ali BPS
IF (@isOsebaSODO>0) or (@isOsebaBS=0)
BEGIN
	IF (@isOsebaSODO>0) 
	BEGIN
		INSERT INTO #PodatkiSkupniPoracun
		(ObracunskoObdobjeID,TipPodatka,Kolicina)
		(SELECT
			ObracunskoObdobjeID,
			1,
			LastnaRealizacija as Kolicina
		FROM PoracunKolicinskiVrsticaPoBPS
		WHERE 
			PoracunID=@PoracunID
			and OsebaID=@OsebaID
		)
	END
	
	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		2,
		RealizacijaDrugje as Kolicina
	FROM PoracunKolicinskiVrsticaPoBPS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		3,
		RealizacijaPoracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBPS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		4,
		RealizacijaObracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBPS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		5,
		RazlikaPoracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBPS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)
	
	--določimo opise posameznih tipov, ki se bodo videli v porocilu
	IF (@isOsebaSODO>0) 
	BEGIN	
		INSERT INTO #TipiPodatkiSkupniPoracun
		(TipPodatka,Naziv)
		VALUES
		(1,''Lastna REALIZACIJA v svojem omrežju'')
	END
	
	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(2,''REALIZACIJA v drugih omrežjih '')

	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(3,''REALIZACIJA PORAČUN [kWh]'')

	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(4,''REALIZACIJA OBRAČUN [kWh]'')

	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(5,''RAZLIKA PORAČUN [kWh]'')
END

--v primeru, da je izbrana oseba BS in ni SODO
IF (@isOsebaSODO=0) and (@isOsebaBS>0)
BEGIN
	
	DECLARE @BPSOsebaID int
	DECLARE @BPSOsebaNaziv varchar(255)
	DECLARE @TipPodatkaId int
	SET @TipPodatkaId=1

	DECLARE cursorBPS CURSOR FOR 
	SELECT OsebaID,Naziv
	FROM #PodatkiBPSzaBS
	ORDER BY OsebaID

	OPEN cursorBPS

	FETCH NEXT FROM cursorBPS 
	INTO @BPSOsebaID, @BPSOsebaNaziv
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--print @BPSOsebaNaziv		
		INSERT INTO #PodatkiSkupniPoracun
		(ObracunskoObdobjeID,TipPodatka,Kolicina)
		(SELECT
			ObracunskoObdobjeID,
			@TipPodatkaId,
			RealizacijaPoracun as Kolicina
		FROM PoracunKolicinskiVrsticaPoBPS
		WHERE 
			PoracunID=@PoracunID
			and OsebaID=@BPSOsebaID
		)
		INSERT INTO #TipiPodatkiSkupniPoracun
		(TipPodatka,Naziv)
		VALUES
		(@TipPodatkaId,''REALIZACIJA ''+@BPSOsebaNaziv)
		
		SET @TipPodatkaId=@TipPodatkaId+1		

		FETCH NEXT FROM cursorBPS 
		INTO @BPSOsebaID, @BPSOsebaNaziv
	END

	CLOSE cursorBPS
	DEALLOCATE cursorBPS


	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		@TipPodatkaId,
		RealizacijaPoracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)
	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(@TipPodatkaId,''REALIZACIJA '' + @OsebaNaziv + '' PORAČUN [kWh]'')
	SET @TipPodatkaId=@TipPodatkaId+1
	

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		@TipPodatkaId,
		RealizacijaObracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)
	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(@TipPodatkaId,''REALIZACIJA '' + @OsebaNaziv + '' OBRAČUN [kWh]'')
	SET @TipPodatkaId=@TipPodatkaId+1

	INSERT INTO #PodatkiSkupniPoracun
	(ObracunskoObdobjeID,TipPodatka,Kolicina)
	(SELECT
		ObracunskoObdobjeID,
		@TipPodatkaId,
		RazlikaPoracun as Kolicina
	FROM PoracunKolicinskiVrsticaPoBS
	WHERE 
		PoracunID=@PoracunID
		and OsebaID=@OsebaID
	)
	INSERT INTO #TipiPodatkiSkupniPoracun
	(TipPodatka,Naziv)
	VALUES
	(@TipPodatkaId,''RAZLIKA '' + @OsebaNaziv + '' PORAČUN [kWh]'')
	SET @TipPodatkaId=@TipPodatkaId+1
	
	
END


--Prikaz podatkov
Select 
	OO.ObracunskoObdobjeID,
	OO.VeljaOd,
	OO.VeljaDo,
	PSP.Kolicina, 
	PSP.TipPodatka,
	TPSP.Naziv as TipNaziv
from #PodatkiSkupniPoracun PSP
INNER JOIN ObracunskoObdobje OO ON OO.ObracunskoObdobjeID=PSP.ObracunskoObdobjeID and OO.ObracunskoObdobjeTipID=1 and OO.DatumVnosa <= @stanje and ISNULL(OO.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
INNER JOIN #TipiPodatkiSkupniPoracun TPSP ON TPSP.TipPodatka=PSP.TipPodatka
ORDER BY PSP.TipPodatka

if object_id(''tempDB..#PodatkiSkupniPoracun'') is not null
    drop table #PodatkiSkupniPoracun

if object_id(''tempDB..#TipiPodatkiSkupniPoracun'') is not null
    drop table #TipiPodatkiSkupniPoracun

if object_id(''tempDB..#PodatkiBPSzaBS'') is not null
    drop table #PodatkiBPSzaBS

*/

















' 
END
GO
