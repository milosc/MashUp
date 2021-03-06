/****** Object:  StoredProcedure [dbo].[Podatki_PoracunMeritvePregled]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_PoracunMeritvePregled]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Podatki_PoracunMeritvePregled]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_PoracunMeritvePregled]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE PROCEDURE [dbo].[Podatki_PoracunMeritvePregled]
	@PoracunskoObdobjeID int,
	@OsebaID int,
	@MeritvePoracunTipID int,
	@stanje datetime
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT 
 MP.PoracunskoObdobjeID
 ,MP.ObracunskoObdobjeID
 ,OO.VeljaOd
 ,OO.VeljaDo
 ,MP.OsebaID
 ,MP.SistemskiOperater
 ,OS.Naziv as SistemskiOperaterNaziv
 ,MP.Kolicina
FROM MeritvePoracun MP
LEFT OUTER JOIN ObracunskoObdobje OO ON OO.ObracunskoObdobjeID=MP.ObracunskoObdobjeID and OO.ObracunskoObdobjeTipID=1
LEFT OUTER JOIN Oseba OS ON OS.OsebaID=MP.SistemskiOperater and OS.DatumVnosa <= @stanje and ISNULL(OS.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
WHERE 
 MP.OsebaID=@OsebaID
 AND MP.MeritvePoracunTipID=@MeritvePoracunTipID
 AND MP.PoracunskoObdobjeID=@PoracunskoObdobjeID
 AND MP.DatumVnosa <= @stanje and ISNULL(MP.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
ORDER BY OO.VeljaOd,MP.SistemskiOperater






' 
END
GO
