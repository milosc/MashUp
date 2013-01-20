/****** Object:  StoredProcedure [dbo].[usp_SelectObracunskoObdobjesAll]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectObracunskoObdobjesAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectObracunskoObdobjesAll]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectObracunskoObdobjesAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


--region [dbo].[usp_SelectObracunskoObdobjesAll]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_SelectObracunskoObdobjesAll]
-- Date Generated: 16. januar 2008
--   MT: modificiran output datuma / zaradi problema sortiranja.
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_SelectObracunskoObdobjesAll]
	@stanje datetime
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT
	[ObracunskoObdobjeID],
	[Naziv],
	--cast(convert(char(10),[VeljaOd],104) as varchar) as VeljaOd, --nam vrne shordate obliko, 104 je sql koda za shortdateformat
	--cast(convert(char(10),[VeljaDo],104) as varchar) as VeljaDo
	VeljaOd,
	VeljaDo
FROM
	[dbo].[ObracunskoObdobje]
WHERE
	ObracunskoObdobjeTipID=1
	and DatumVnosa <= @stanje 
	and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje	
	order by [ObracunskoObdobjeID] DESC

--ObracunskoObdobjeTipID:
--1=obracun, 2=poracun

--endregion



' 
END
GO
