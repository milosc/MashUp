/****** Object:  StoredProcedure [dbo].[usp_SelectObracun]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectObracun]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectObracun]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectObracun]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_SelectObracun]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_SelectObracun]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_SelectObracun]
	@ID int
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT
	[ID],
	[ObracunID],
	[ObdobjeOd],
	[ObdobjeDo],
	[ObracunStatusID],
	[DatumVnosa]
FROM
	[dbo].[Obracun]
WHERE
	[ID] = @ID

--endregion

' 
END
GO
