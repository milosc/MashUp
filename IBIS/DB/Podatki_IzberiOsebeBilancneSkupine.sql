/****** Object:  StoredProcedure [dbo].[Podatki_IzberiOsebeBilancneSkupine]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_IzberiOsebeBilancneSkupine]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Podatki_IzberiOsebeBilancneSkupine]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_IzberiOsebeBilancneSkupine]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'








CREATE PROCEDURE [dbo].[Podatki_IzberiOsebeBilancneSkupine]
	@stanje datetime
	
AS
BEGIN
	SET NOCOUNT ON;

-- izbor BS v bilancni shemi
select distinct p.partner2 as vrednost,  o.naziv as naziv  from Pogodba p, Oseba o 
where o.OsebaID=p.partner2 and p.Partner1 = 1 and p.nivo=1 and p.PogodbaTipID < 100 and
p.DatumVnosa <= @stanje and ISNULL(p.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and 
o.DatumVnosa <= @stanje and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and
p.VeljaOd <= @stanje and ISNULL(p.VeljaDo,DATEADD(yy, 50, GETDATE())) >= @stanje;
END









' 
END
GO
