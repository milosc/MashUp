/****** Object:  StoredProcedure [dbo].[Podatki_Realizacija]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_Realizacija]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Podatki_Realizacija]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_Realizacija]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'







CREATE PROCEDURE [dbo].[Podatki_Realizacija]
	@VeljaOd datetime,
	@VeljaDo datetime,
	@OsebaID int,
	@stanje datetime
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED



SELECT 
 vM.Interval
 ,vM.Kolicina
 ,vM.PPMID
FROM view_Meritve vM
LEFT OUTER JOIN PPM ON PPM.PPMID=vM.PPMID and PPM.DatumVnosa <= @stanje and ISNULL(PPM.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
WHERE 
 vM.PPMID IN (91,92,93)
 AND vM.Interval >=@VeljaOd
 AND vM.Interval <=@VeljaDo
 AND vM.DatumVnosa <= @stanje and ISNULL(vM.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
ORDER BY vM.Interval,vM.PPMID








' 
END
GO
