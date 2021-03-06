/****** Object:  StoredProcedure [dbo].[usp_SelectOsebePoTipu]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectOsebePoTipu]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectOsebePoTipu]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectOsebePoTipu]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

--region [dbo].[usp_SelectOseba]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_SelectOseba]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_SelectOsebePoTipu]
	@stanje  DATETIME = ''2008-10-15'',
	@Tip INT
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT distinct(OsebaID), Naziv
from Oseba o 
where o.DatumVnosa <= @stanje and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
and (OsebaID IN (SELECT OsebaID FROM OsebaTip WHERE (OsebaTipID = @Tip))) ;

--endregion


' 
END
GO
