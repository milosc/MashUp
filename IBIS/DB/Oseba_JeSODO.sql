/****** Object:  StoredProcedure [dbo].[Oseba_JeSODO]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Oseba_JeSODO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Oseba_JeSODO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Oseba_JeSODO]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE PROCEDURE [dbo].[Oseba_JeSODO]
	@OsebaID INT,
	@stanje datetime
AS
BEGIN
	DECLARE @isOsebaSODO int		
	--Pogledamo ali je izbrana oseba SODO
	Select @isOsebaSODO=count(OsebaID) from OsebaTip
	where
	OsebaID=@OsebaID
	and OsebaTipID=1
	and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
	
	IF @isOsebaSODO > 0
	BEGIN
		SET @isOsebaSODO=1
	END

	return @isOsebaSODO
END








' 
END
GO
