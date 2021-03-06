/****** Object:  StoredProcedure [dbo].[usp_SelectPogodbaShemaPregled]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectPogodbaShemaPregled]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectPogodbaShemaPregled]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectPogodbaShemaPregled]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SelectPogodbaShemaPregled]
	-- Add the parameters for the stored procedure here
	@partner int, 
	@stanje DateTime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
goto v2;
    -- Insert statements for procedure here
	(select ''~/img/Gor.png'' as smer, p.ID, t.Naziv as TipPogodbe, convert(varchar,p.VeljaOd,104) as VeljaOd, convert(varchar,p.VeljaDo,104) as VeljaDo, o.Naziv as Podjetje 
	from Pogodba p, Oseba o, PogodbaTip t  
	where p.PogodbaTipID=t.PogodbaTipID and o.OsebaID=Partner1 and Partner2=@partner and p.Nivo > 0 and
		p.DatumVnosa <= @stanje and ISNULL(p.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and
		o.DatumVnosa <= @stanje and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and 
		p.VeljaOd <= @stanje and ISNULL(p.VeljaDo,DATEADD(yy, 50, GETDATE())) >= @stanje)
	union
	(select ''~/img/Dol.png'' as smer,p.ID, t.Naziv as TipPogodbe, convert(varchar,p.VeljaOd,104) as VeljaOd, convert(varchar,p.VeljaDo,104) as VeljaDo, o.Naziv as Podjetje 
	from Pogodba p, Oseba o, PogodbaTip t 
	where p.PogodbaTipID=t.PogodbaTipID and o.OsebaID=Partner2 and Partner1=@partner and 
		p.DatumVnosa <= @stanje and ISNULL(p.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and
		o.DatumVnosa <= @stanje and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and
		p.VeljaOd <= @stanje and ISNULL(p.VeljaDo,DATEADD(yy, 50, GETDATE())) >= @stanje)

v2:
    -- Insert statements for procedure here
	(select ''~/img/Gor.png'' as smer, p.ID,p.veljaOD as veljaOd2,p.veljaDo as veljaDo2, t.Naziv as TipPogodbe, convert(varchar,p.VeljaOd,104) as VeljaOd, convert(varchar,p.VeljaDo,104) as VeljaDo, o.Naziv as Podjetje 
	from Pogodba p, Oseba o, PogodbaTip t  
	where p.PogodbaTipID=t.PogodbaTipID and o.OsebaID=Partner1 and Partner2=@partner and p.Nivo > 0 and
		p.DatumVnosa <= @stanje and ISNULL(p.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and
		o.DatumVnosa <= @stanje and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and 
		p.VeljaOd <= @stanje and ISNULL(p.VeljaDo,DATEADD(yy, 50, GETDATE())) >= @stanje)
	union
	(select ''~/img/Dol.png'' as smer,p.ID,p.veljaOD as veljaOd2,p.veljaDo as veljaDo2, t.Naziv as TipPogodbe, convert(varchar,p.VeljaOd,104) as VeljaOd, convert(varchar,p.VeljaDo,104) as VeljaDo, o.Naziv as Podjetje 
	from Pogodba p, Oseba o, PogodbaTip t 
	where p.PogodbaTipID=t.PogodbaTipID and o.OsebaID=Partner2 and Partner1=@partner and 
		p.DatumVnosa <= @stanje and ISNULL(p.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and
		o.DatumVnosa <= @stanje and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and
		p.VeljaOd <= @stanje and ISNULL(p.VeljaDo,DATEADD(yy, 50, GETDATE())) >= @stanje)


END





' 
END
GO
