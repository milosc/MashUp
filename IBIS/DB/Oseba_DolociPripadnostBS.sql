/****** Object:  StoredProcedure [dbo].[Oseba_DolociPripadnostBS]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Oseba_DolociPripadnostBS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Oseba_DolociPripadnostBS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Oseba_DolociPripadnostBS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


--Rekurzivno iskanje BS glede na vpisano BPS in BS


CREATE PROCEDURE [dbo].[Oseba_DolociPripadnostBS]
	@OsebaID INT,
	@stanje datetime
AS
BEGIN
	
	DECLARE @isOsebaBS int
	DECLARE @nivo int
	DECLARE @OsebaBSID int

	exec @isOsebaBS=Oseba_JeBS @OsebaID,@stanje
	IF(@isOsebaBS=1)
	BEGIN
		SET @OsebaBSID=@OsebaID
	END

	WHILE @isOsebaBS=0
	BEGIN
		
		Select @nivo=nivo,@OsebaID=Partner1,@OsebaBSID=Partner2 from Pogodba
		where Partner2=@OsebaID
		and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
		
		IF @nivo=1
		BEGIN
			SET @isOsebaBS=1
			SET @OsebaBSID=@OsebaBSID
		END
		
		/*Select @isOsebaBS=count(PogodbaID) from Pogodba 
		where 
		Partner2=@OsebaID 
		and nivo=1
		and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje

		IF @isOsebaBS > 0
		BEGIN
			SET @isOsebaBS=1
		END*/
	END

	

	return @OsebaBSID
END









' 
END
GO
