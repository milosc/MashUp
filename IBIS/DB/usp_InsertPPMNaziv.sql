/****** Object:  StoredProcedure [dbo].[usp_InsertPPMNaziv]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPPMNaziv]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertPPMNaziv]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPPMNaziv]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_InsertPPMNaziv]
	@Naziv varchar(50)
	
AS

SET NOCOUNT ON

INSERT INTO [dbo].[PPM] (
	[Naziv]
) VALUES (
	@Naziv
)



--endregion

' 
END
GO
