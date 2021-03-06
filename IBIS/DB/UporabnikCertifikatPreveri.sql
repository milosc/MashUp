/****** Object:  StoredProcedure [dbo].[UporabnikCertifikatPreveri]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UporabnikCertifikatPreveri]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UporabnikCertifikatPreveri]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UporabnikCertifikatPreveri]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




-- =============================================
-- Author:		Jan Kraljič
-- Create date: 1.4.2008
-- Description:	Preverjam ali lahko prijavim uporabnika
-- =============================================
CREATE PROCEDURE [dbo].[UporabnikCertifikatPreveri]
	@uporabnik varchar(50),
	@geslo varchar(50),
	@issuer varchar(255),
	@serial varchar(255),
	@thumbprint varchar(255)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @Prijava int
    -- Insert statements for procedure here
	SELECT @Prijava=count(UporabnikID) from Uporabnik where Geslo = @geslo and UporabniskoIme=@uporabnik and
		DatumSpremembe IS NULL and 
Cissuer = @issuer and Cserial=@serial and Cthumbprint = @thumbprint and
		VeljaOd <= GETDATE() and ISNULL(VeljaDo,DATEADD(yy, 50, GETDATE())) >= GETDATE();
	
	if(@Prijava > 0)
	begin
		return 1
	end
	else
	begin
		return 0
	end

END





' 
END
GO
