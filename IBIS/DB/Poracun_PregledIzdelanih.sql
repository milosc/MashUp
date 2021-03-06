/****** Object:  StoredProcedure [dbo].[Poracun_PregledIzdelanih]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Poracun_PregledIzdelanih]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Poracun_PregledIzdelanih]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Poracun_PregledIzdelanih]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Poracun_PregledIzdelanih]
	-- Add the parameters for the stored procedure here
	@DatumStart DateTime,
	@DatumStop DateTime,
	@stanje DateTime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    select distinct cast(convert(char(10),[d].[VeljaOd],104) as varchar) + '' - '' + cast(convert(char(10),[d].[VeljaDo],104) as varchar) as obdobje ,
		p.Naziv,
		p.DatumIzdaje,
		p.SrednjaCena, 
		p.ZnesekPoracuna,
		p.OsebaID,
		o.Naziv as OsebaNaziv,
		p.Razlika_Dejanski_Odjem_Poracunski_Odjem,
		(select min(DatumVnosa) from Poracun where PoracunID = p.PoracunID)  as DatumVnosa,
		p.PoracunID,
		p.ID
	from Poracun p, ObracunskoObdobje d, Oseba o
	where 
	d.ObracunskoObdobjeID = p.PoracunskoObdobjeID and d.ObracunskoObdobjeTipID=2
	and d.VeljaOd >= @DatumStart and d.VeljaDo <= @DatumStop 
	and p.DatumVnosa <= @stanje and ISNULL(p.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
	and o.OsebaID=p.OsebaID and o.DatumVnosa <= @stanje and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje

END





' 
END
GO
