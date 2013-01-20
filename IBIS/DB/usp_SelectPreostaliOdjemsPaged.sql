/****** Object:  StoredProcedure [dbo].[usp_SelectPreostaliOdjemsPaged]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectPreostaliOdjemsPaged]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectPreostaliOdjemsPaged]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectPreostaliOdjemsPaged]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_SelectPreostaliOdjemsPaged]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_SelectPreostaliOdjemsPaged]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_SelectPreostaliOdjemsPaged]
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT
	[ID],
	[Interval],
	[Kolicina],
	[UdelezenecTrga],
	[SistemskiOperater],
	[DatumVnosa]
FROM
	[dbo].[PreostaliOdjem]

--endregion

' 
END
GO
