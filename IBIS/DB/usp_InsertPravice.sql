/****** Object:  StoredProcedure [dbo].[usp_InsertPravice]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPravice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertPravice]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPravice]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_InsertPravice]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_InsertPravice]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_InsertPravice]
	@Modul varchar(50),
	@Akcija varchar(50),
	@PraviceID int OUTPUT
AS

SET NOCOUNT ON

INSERT INTO [dbo].[Pravice] (
	[Modul],
	[Akcija]
) VALUES (
	@Modul,
	@Akcija
)

SET @PraviceID = SCOPE_IDENTITY()

--endregion

' 
END
GO
