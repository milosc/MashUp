/****** Object:  StoredProcedure [dbo].[Podatki_PoracunMeritveZlistajPoracune]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_PoracunMeritveZlistajPoracune]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Podatki_PoracunMeritveZlistajPoracune]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_PoracunMeritveZlistajPoracune]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE PROCEDURE [dbo].[Podatki_PoracunMeritveZlistajPoracune]
	@stanje datetime
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Select PO.PoracunskoObdobjeId,convert(varchar,DatePart(Day,VeljaOd))+ ''.'' + convert(varchar,DatePart(Month,VeljaOd))+ ''.'' + convert(varchar,DatePart(Year,VeljaOd)) + '' - '' + convert(varchar,DatePart(Day,VeljaDo))+ ''.'' + convert(varchar,DatePart(Month,VeljaDo))+ ''.'' + convert(varchar,DatePart(Year,VeljaDo)) as PoracunInterval,PO.Naziv
from Poracun PO
INNER JOIN ObracunskoObdobje OO ON OO.ObracunskoObdobjeId=PO.PoracunskoObdobjeId and OO.ObracunskoObdobjeTipID=2 and OO.DatumVnosa <= @stanje and ISNULL(OO.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
where 
PO.DatumVnosa <= @stanje and ISNULL(PO.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
ORDER BY OO.VeljaOd DESC






' 
END
GO
