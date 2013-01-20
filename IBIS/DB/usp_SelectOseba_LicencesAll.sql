/****** Object:  StoredProcedure [dbo].[usp_SelectOseba_LicencesAll]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectOseba_LicencesAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectOseba_LicencesAll]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectOseba_LicencesAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_SelectOseba_LicencesAll]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_SelectOseba_LicencesAll]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_SelectOseba_LicencesAll]
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT
	[ID],
	[OsebaID],
	[LicencaID],
	[VeljaOd],
	[VeljaDo],
	[DatumVnosa],
	[Avtor]
FROM
	[dbo].[Oseba_Licence]

--endregion

' 
END
GO
