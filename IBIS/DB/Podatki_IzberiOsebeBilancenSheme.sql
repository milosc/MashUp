/****** Object:  StoredProcedure [dbo].[Podatki_IzberiOsebeBilancenSheme]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_IzberiOsebeBilancenSheme]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Podatki_IzberiOsebeBilancenSheme]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_IzberiOsebeBilancenSheme]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE PROCEDURE [dbo].[Podatki_IzberiOsebeBilancenSheme]
	@stanje datetime
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT 
OsebaID,
CASE (Select count(PogodbaID) from Pogodba 
	where Partner2=OsebaID and nivo=1
	AND (@stanje BETWEEN DatumVnosa AND dbo.infinite(DatumSpremembe)))

	WHEN 0 THEN '' '' + Naziv
	ELSE Naziv
END AS Naziv

from Oseba 
WHERE
(@stanje BETWEEN DatumVnosa AND dbo.infinite(DatumSpremembe)) 
AND (@stanje BETWEEN VeljaOd AND dbo.infinite(VeljaDo))
ORDER BY Naziv ASC




' 
END
GO
