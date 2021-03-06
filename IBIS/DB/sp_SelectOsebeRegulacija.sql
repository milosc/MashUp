/****** Object:  StoredProcedure [dbo].[sp_SelectOsebeRegulacija]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SelectOsebeRegulacija]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_SelectOsebeRegulacija]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SelectOsebeRegulacija]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_SelectOsebeRegulacija]
	@stanje datetime,
	@obdobjeOd datetime,
	@obdobjeDo datetime 
AS
BEGIN
select PPMID,Naziv,NazivExcel,PPMTipID,SistemskiOperater1,Dobavitelj1,Dobavitelj2,VrstniRed from PPM 
	WHERE PPMTipID =6	and
	 DatumVnosa <= @stanje and
	 ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
	and
dbo.intersects(@obdobjeOd , @obdobjeDo, VeljaOd, VeljaDo) = 1 AND 
DatumSpremembe is null


END



' 
END
GO
