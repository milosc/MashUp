/****** Object:  StoredProcedure [dbo].[PreveriObstajaOsebaTip]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PreveriObstajaOsebaTip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PreveriObstajaOsebaTip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PreveriObstajaOsebaTip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Matevž
-- Create date: 9.7.2008
-- Description:	Preveri ali že obstaja OsebaTip 
-- npr. za Organizator trga ali SOPO, saj ima lahko ta tip le ena oseba
-- Pri dodajanju nove osebe OsebaID=-1, pri urejanju pa OsebaID osebe, ki jo urejaš
-- =============================================

CREATE PROCEDURE [dbo].[PreveriObstajaOsebaTip]
	@OsebaTipID int,
	@OsebaID int = -1,
	@stanje DATETIME = GETDATE 
AS
BEGIN

if EXISTS
	(SELECT OsebaID FROM OsebaTip
	WHERE OsebaTipID = @OsebaTipID
	AND (@stanje BETWEEN DatumVnosa AND dbo.infinite(DatumSpremembe))
	AND OsebaID <> @OsebaID)

	return 1
ELSE
	return 0

END



' 
END
GO
