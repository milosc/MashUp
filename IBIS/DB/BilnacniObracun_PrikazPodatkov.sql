/****** Object:  StoredProcedure [dbo].[BilnacniObracun_PrikazPodatkov]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PrikazPodatkov]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_PrikazPodatkov]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PrikazPodatkov]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracun_PrikazPodatkov]
	-- Add the parameters for the stored procedure here
	@ObracunID INT,
	@stanje DATETIME = GETDATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select cast(convert(char(10),[VeljaOd],104) as varchar) + '' - '' + cast(convert(char(10),[VeljaDo],104) as varchar) as obdobje, 
Obr.Naziv as naziv, Obr.DatumVnosa datum, cast(Obr.ObracunStatusID as varchar) as status, Komentar, ObracunTipID, isnull(objavljen,0) as objavljen,
  isnull(korekcijaCen,0) as korekcijaCen
from Obracun Obr, ObracunskoObdobje dob 
where Obr.ObracunID = @ObracunID and Obr.ObracunskoObdobjeID = dob.ObracunskoObdobjeID and 
Obr.DatumVnosa <= @stanje and ISNULL(Obr.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje;
END
' 
END
GO
