/****** Object:  StoredProcedure [dbo].[usp_SelectOsebaPPM]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectOsebaPPM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectOsebaPPM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectOsebaPPM]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_SelectOsebaPPM]
	
	
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT
	o.[Naziv],
	o.[OsebaID]
	
FROM
	[dbo].[Oseba] o, [dbo].[OsebaTip] t
WHERE
o.OsebaID = t.OsebaID 
and o.DatumSpremembe IS NULL
and t.OsebaTipID not in (6)

--endregion





' 
END
GO
