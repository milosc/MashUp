/****** Object:  StoredProcedure [dbo].[usp_SelectPogodbaPodrobno]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectPogodbaPodrobno]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectPogodbaPodrobno]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectPogodbaPodrobno]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Jan Kraljič
-- Create date: 27.2.2008
-- Description:	Za podorben prikaz pogodbe
-- =============================================
CREATE PROCEDURE [dbo].[usp_SelectPogodbaPodrobno]
	@PogodbaID int
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT
	p.[ID],
	p.[PogodbaID],
	[t].[Naziv] as TipPogodbeID,
	t.TipPogodbeID as TipPgdID,
	[o1].[Naziv] as Partner1,
	p.partner1 as PartnerID1,
	[o2].[Naziv] as Partner2,
	p.partner2 as PartnerID2,
	p.[VeljaOd],
	p.[VeljaDo],
	[IzvrsilniDan],
	[Opis],
	[Opombe],
	p.[Avtor],
	p.[DatumVnosa],
	p.[Aktivno]
FROM
	[dbo].[Pogodba] p, [dbo].[TipPogodbe] t, [dbo].[Oseba] o1, [dbo].[Oseba] o2
where
	t.TipPogodbeID = p.TipPogodbeID and
	p.partner1 = o1.OsebaID and o1.Aktivno = 1 and
	p.partner2 = o2.OsebaID and o2.Aktivno = 1 and
	p.ID = @PogodbaID
' 
END
GO
