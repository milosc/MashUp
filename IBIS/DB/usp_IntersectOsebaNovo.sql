/****** Object:  StoredProcedure [dbo].[usp_IntersectOsebaNovo]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_IntersectOsebaNovo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_IntersectOsebaNovo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_IntersectOsebaNovo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_IntersectOsebaNovo]
	@OsebaID int,
	@VeljaOd datetime,
	@VeljaDo datetime
AS

SET NOCOUNT ON

IF EXISTS

(SELECT * 
FROM Oseba 
WHERE dbo.intersects(@VeljaOd , @VeljaDo, VeljaOd, VeljaDo) = 1 AND 
	OsebaID = @OsebaID AND DatumSpremembe IS NULL)

	RETURN 1
ELSE 
	RETURN 0


--endregion

' 
END
GO
