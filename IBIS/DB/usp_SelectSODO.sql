/****** Object:  StoredProcedure [dbo].[usp_SelectSODO]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectSODO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectSODO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectSODO]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_SelectSODO]
	@stanje datetime
AS
BEGIN
	select OsebaID,Naziv,Kratica from Oseba
	WHERE OsebaID in 
	(
	select OsebaID from OsebaTip
	where OsebaTipID=1
	)
	and 
	DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje;
END
' 
END
GO
