/****** Object:  StoredProcedure [dbo].[Podatki_TrzniPlanPregled]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_TrzniPlanPregled]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Podatki_TrzniPlanPregled]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_TrzniPlanPregled]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE PROCEDURE [dbo].[Podatki_TrzniPlanPregled]
	@OsebaID varchar(255),
	@OdDatum datetime,
	@DoDatum datetime,
	@stanje datetime
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT OsebaID,Interval,Kolicina,JeKorigiran from TrzniPlan 
WHERE
OsebaId IN (@OsebaID)
and Interval >= @OdDatum
and Interval <= @DoDatum
and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
ORDER BY Interval ASC




' 
END
GO
