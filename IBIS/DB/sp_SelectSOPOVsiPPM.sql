/****** Object:  StoredProcedure [dbo].[sp_SelectSOPOVsiPPM]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SelectSOPOVsiPPM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_SelectSOPOVsiPPM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SelectSOPOVsiPPM]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_SelectSOPOVsiPPM]
	@obdobjeOd datetime,
	 @obdobjeDo datetime,
	@stanje datetime
AS
BEGIN
--dobim vse ppmje za sopo (eles)
--ppmtip za sopo else je 21 razen izjem je 5 distrbuterjev kipa imajo ppmtipid=23 ->zaradi drugacne obtavnave v obracunu
select distinct PPMID,Naziv,PPMTipID,SistemskiOperater1 as SistOp1,PPMJeOddaja,VrstniRed,NazivExcel from PPM
where (PPMTipID=21 or PPMTipID=23)
and
dbo.intersects(@obdobjeOd , @obdobjeDo, VeljaOd, VeljaDo) = 1 AND 
DatumSpremembe is null
and
DatumVnosa <= @stanje and dbo.infinite(DatumSpremembe) >= @stanje
ORDER BY VrstniRed  ASC

END


/*
(VeljaOd between @obdobjeOd and @obdobjeDo and 
isnull(VeljaDo,@obdobjeDo) between @obdobjeOd and @obdobjeDo) and
*/


' 
END
GO
