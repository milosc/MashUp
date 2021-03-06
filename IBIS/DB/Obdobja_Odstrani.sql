/****** Object:  StoredProcedure [dbo].[Obdobja_Odstrani]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Obdobja_Odstrani]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Obdobja_Odstrani]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Obdobja_Odstrani]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[Obdobja_Odstrani]
	@ObracunskoObdobjeTipID INT,
	@ObracunskoObdobjeID INT, 
	@stanje DateTime
AS
BEGIN
	
	DECLARE @IzbraniVeljaOd datetime
	DECLARE @IzbraniVeljaDo datetime
	DECLARE @CntStarejsaObdobja int
	SET @CntStarejsaObdobja=0

	DECLARE @CntPripadaPoracunskemuObdobju int
	SET @CntPripadaPoracunskemuObdobju=0

	Select @IzbraniVeljaOd=VeljaOd,@IzbraniVeljaDo=VeljaDo from ObracunskoObdobje 
	Where 
		ObracunskoObdobjeID=@ObracunskoObdobjeID
		and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje

	Select @CntStarejsaObdobja=count(ObracunskoObdobjeID) from ObracunskoObdobje 
	where
		ObracunskoObdobjeTipID=@ObracunskoObdobjeTipID
		and VeljaOd>@IzbraniVeljaOd
		and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
	
	if (@CntStarejsaObdobja>0)
	begin
		--ce obdobje ni zadnje ne smemo pustiti brisanje obdobja
		print ''1''
		return 1
	end

	if (@ObracunskoObdobjeTipID=1)
	begin
		--v primeru obracunskega obdobja se preverjamo da mogoce ne pripada ze kaksnemu aktivnemu poracunskemu obdobju
		Select @CntPripadaPoracunskemuObdobju=count(ObracunskoObdobjeID) from  ObracunskoObdobje
		WHERE
		ObracunskoObdobjeTipID=2
		and VeljaOd<=@IzbraniVeljaOd and VeljaDo>=@IzbraniVeljaDo
		and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
		if(@CntPripadaPoracunskemuObdobju>0)
		begin
			--najprej je potrebno brisati poracunsko obdobje sele nato lahko brisemo obracunsko obdobje
			print ''2''
			return 2
		end
	end

	--ce je obdobje res zadnje in v primeru obracunskega ne pripada nobenemu poracunu potem ga lahko zbrisemo
	Update ObracunskoObdobje SET DatumSpremembe=GETDATE() 
	WHERE 
		ObracunskoObdobjeID=@ObracunskoObdobjeID
		and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
	
	print ''0''
	return 0

END



' 
END
GO
