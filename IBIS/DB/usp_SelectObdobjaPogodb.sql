/****** Object:  StoredProcedure [dbo].[usp_SelectObdobjaPogodb]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectObdobjaPogodb]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectObdobjaPogodb]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectObdobjaPogodb]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[usp_SelectObdobjaPogodb]
	@PogodbaID int,
	@stanje DATETIME
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT * from Pogodba where PogodbaID = @PogodbaID and 
DatumVnosa <= @stanje and dbo.infinite(DatumSpremembe) >= @stanje
order by VeljaOd desc
' 
END
GO
