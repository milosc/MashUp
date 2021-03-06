/****** Object:  StoredProcedure [dbo].[usp_SelectPogodbaPregled]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectPogodbaPregled]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectPogodbaPregled]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectPogodbaPregled]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SelectPogodbaPregled]
	@Od DateTime,
	@Do DateTime,
	@Tip int,
	@stanje DateTime
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT
	p.[ID],
	p.[PogodbaID],
	[t].[Naziv] as TipPogodbeID,
	[o1].[Naziv] as Partner1,
	[o2].[Naziv] as Partner2,
	convert(varchar,p.VeljaOd,104) as VeljaOd,
	convert(varchar,p.VeljaDo,104) as VeljaDo,
	[IzvrsilniDan],
	[Opis],
	[Opombe],
	p.[Avtor],
	p.[DatumVnosa],
	p.[Aktivno]
FROM
	[dbo].[Pogodba] p, [dbo].[TipPogodbe] t, [dbo].[Oseba] o1, [dbo].[Oseba] o2
where
	[p].[TipPogodbeID] = @Tip and 
	p.[VeljaOd] <= @Od and 
	p.[VeljaDo] >= @Do and 
	t.TipPogodbeID = p.TipPogodbeID and
	p.partner1 = o1.OsebaID and o1.DatumVnosa <= @stanje and ISNULL(o1.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and
	p.partner2 = o2.OsebaID and o2.DatumVnosa <= @stanje and ISNULL(o2.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and
	p.DatumVnosa <= @stanje and ISNULL(p.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje' 
END
GO
