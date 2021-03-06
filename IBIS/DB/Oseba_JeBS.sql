/****** Object:  StoredProcedure [dbo].[Oseba_JeBS]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Oseba_JeBS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Oseba_JeBS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Oseba_JeBS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





CREATE PROCEDURE [dbo].[Oseba_JeBS]
	@OsebaID INT,
	@stanje datetime
AS
BEGIN
	DECLARE @isOsebaBS int
	--Pogledamo ali je izbrana oseba Bilancna skupina
	Select @isOsebaBS=count(PogodbaID) from Pogodba 
	where 
	Partner2=@OsebaID 
	and nivo=1
	and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje

	IF @isOsebaBS > 0
	BEGIN
		SET @isOsebaBS=1
	END
	ELSE
    BEGIN

		SET @isOsebaBS=0	
     END


	return @isOsebaBS
END









' 
END
GO
