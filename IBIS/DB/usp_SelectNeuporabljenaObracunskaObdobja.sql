/****** Object:  StoredProcedure [dbo].[usp_SelectNeuporabljenaObracunskaObdobja]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectNeuporabljenaObracunskaObdobja]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectNeuporabljenaObracunskaObdobja]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectNeuporabljenaObracunskaObdobja]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





--izbre vsa zakljucna obracunska obdobja, ki se ne nestopajo v nobenem poracunu

CREATE PROCEDURE [dbo].[usp_SelectNeuporabljenaObracunskaObdobja]
	@OdDatum datetime,
	@DoDatum datetime,
	@stanje datetime
AS


Select  OO.ObracunskoObdobjeID as ObracunskoObdobjeID,
		cast(convert(char(10),OO.VeljaOd,104) as varchar) as VeljaOd,
		cast(convert(char(10),OO.VeljaOd,104) as varchar) as VeljaDo,
		PO.ObracunskoObdobjeID as PoracunskoObdobjeID,
		cast(convert(char(10),PO.VeljaOd,104) as varchar) as PoracunVeljaOd,
		cast(convert(char(10),PO.VeljaDo,104) as varchar) as PoracunVeljaDo
from ObracunskoObdobje OO
LEFT OUTER JOIN ObracunskoObdobje PO ON PO.VeljaOd<=OO.VeljaOd and PO.VeljaDo>=OO.VeljaDo and PO.ObracunskoObdobjeTipID=2 and PO.DatumVnosa <= @stanje and ISNULL(PO.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
where
	OO.ObracunskoObdobjeTipID=1
	and OO.VeljaOd >= @OdDatum
	and OO.VeljaDo <= @DoDatum
	and OO.DatumVnosa <= @stanje and ISNULL(OO.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
ORDER BY OO.VeljaOd	

/*Select  OO.ObracunskoObdobjeID as ObracunskoObdobjeID,
		OO.VeljaOd,
		OO.VeljaDo,
		PO.ObracunskoObdobjeID as PoracunskoObdobjeID,
		PO.VeljaOd as PoracunVeljaOd,
		PO.VeljaDo as PoracunVeljaDo
from ObracunskoObdobje OO
INNER JOIN Obracun OB ON OB.ObracunskoObdobjeID=OO.ObracunskoObdobjeID and OB.DatumVnosa <= @stanje and ISNULL(OB.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
LEFT OUTER JOIN ObracunskoObdobje PO ON PO.VeljaOd<=OO.VeljaOd and PO.VeljaDo>=OO.VeljaDo and PO.ObracunskoObdobjeTipID=2 and PO.DatumVnosa <= @stanje and ISNULL(PO.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
where
	OO.ObracunskoObdobjeTipID=1
	and OB.ObracunStatusID=2
	and OO.VeljaOd > @OdDatum
	and OO.VeljaDo < @DoDatum
	and OO.DatumVnosa <= @stanje and ISNULL(OO.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
ORDER BY OO.VeljaOd	*/







' 
END
GO
