/****** Object:  StoredProcedure [dbo].[UporabnikCertifikatPrijava]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UporabnikCertifikatPrijava]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UporabnikCertifikatPrijava]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UporabnikCertifikatPrijava]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



-- =============================================
-- Author:		Jan Kraljič
-- Create date: 1.4.2008
-- Description:	Vrne podatke, ki jih potrebujem hranit za uporabnika
-- =============================================
CREATE PROCEDURE [dbo].[UporabnikCertifikatPrijava]
	@issuer varchar(255),
	@serial varchar(255),
	@thumbprint varchar(255),
	@username varchar(255) output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @Stevilo int
    -- Insert statements for procedure here
	SELECT @Stevilo=count(UporabnikID), @username = UporabniskoIme from Uporabnik where Cissuer = @issuer and Cserial=@serial and Cthumbprint = @thumbprint and
		DatumSpremembe IS NULL and VeljaOd <= GETDATE() and ISNULL(VeljaDo,DATEADD(yy, 50, GETDATE())) >= GETDATE() group by UporabniskoIme;

if(@Stevilo > 0)
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
