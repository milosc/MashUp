/****** Object:  StoredProcedure [dbo].[usp_SelectOsebaZgodovina]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectOsebaZgodovina]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectOsebaZgodovina]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectOsebaZgodovina]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[usp_SelectOsebaZgodovina]
	@OsebaID int
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT
	[ID],
	[OsebaID],
	[OsebaTipID],
	[EIC],
	[VeljaOd],
	[VeljaDo],
	[Naziv],
	[Ime],
	[Priimek],
	[Naslov],
	[Stevilka],
	[PostaID],
	[Avtor],
	[DatumVnosa],
	[Aktivno]
FROM
	[dbo].[Oseba]
WHERE
	[OsebaID] = @OsebaID

--endregion

' 
END
GO
