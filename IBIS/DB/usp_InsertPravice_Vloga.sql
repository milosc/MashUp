/****** Object:  StoredProcedure [dbo].[usp_InsertPravice_Vloga]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPravice_Vloga]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertPravice_Vloga]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPravice_Vloga]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_InsertPravice_Vloga]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_InsertPravice_Vloga]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_InsertPravice_Vloga]
	@PraviceID int,	
	@VlogaID int
AS

SET NOCOUNT ON

IF NOT EXISTS (SELECT * FROM Pravice_Vloga WHERE PraviceID=@PraviceID AND VlogaID=@VlogaID)

INSERT INTO [dbo].[Pravice_Vloga] (
	[PraviceID],
	[VlogaID]
) VALUES (
	@PraviceID,
	@VlogaID
)


--endregion

' 
END
GO
