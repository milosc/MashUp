/****** Object:  StoredProcedure [dbo].[usp_InsertLicenca]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertLicenca]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertLicenca]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertLicenca]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_InsertLicenca]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_InsertLicenca]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_InsertLicenca]
	@Naziv varchar(50),
	@LicencaID int OUTPUT
AS

SET NOCOUNT ON

INSERT INTO [dbo].[Licenca] (
	[Naziv]
) VALUES (
	@Naziv
)

SET @LicencaID = SCOPE_IDENTITY()

--endregion

' 
END
GO
