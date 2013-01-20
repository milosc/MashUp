/****** Object:  StoredProcedure [dbo].[usp_UpdatePravice]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePravice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdatePravice]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePravice]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_UpdatePravice]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdatePravice]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_UpdatePravice]
	@PraviceID int,
	@Modul varchar(50),
	@Akcija varchar(50)
AS

SET NOCOUNT ON

UPDATE [dbo].[Pravice] SET
	[Modul] = @Modul,
	[Akcija] = @Akcija
WHERE
	[PraviceID] = @PraviceID

--endregion

' 
END
GO
