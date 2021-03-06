EXEC dbo.DropPRCorUDF @ObjectName = '[usp_InsertVloga]' -- varchar(max)
GO

CREATE PROCEDURE [dbo].[usp_InsertVloga]
	@VlogaID int,
	@Naziv varchar(50),
	@NadVloga int = null,
	@AdminVloga int = null
	--@ID int OUTPUT
AS
begin 
SET NOCOUNT ON

DECLARE @nivo int
DECLARE @AdminNivo int
DECLARE @NadNivo int


-- preveril ali sem v administratorski veji
if( @NadVloga = 0)
begin
	-- ali imam slicajno glavno skupino
	if(@AdminVloga = 0)
	begin
		INSERT INTO [dbo].[Vloga] (
			[VlogaID],
			[Naziv],
			[Admin],
			[Nivo],
			[Globina],
			[DatumVnosa]
		) VALUES (
			@VlogaID,
			@Naziv,
			1,
			-1,
			100,
			GETDATE()
		)		
	end
	else
	begin
	-- vse preostale admin skupine
		select @AdminNivo = nivo from Vloga where VlogaID=@AdminVloga;
	SET @nivo = @AdminNivo+1
		INSERT INTO [dbo].[Vloga] (
			[VlogaID],
			[Naziv],
			[Admin],
			[Nivo],
			[Globina],
			[DatumVnosa]
		) VALUES (
			@VlogaID,
			@Naziv,
			1,
			@nivo,
			2,
			GETDATE()
		)
	-- preklicem vse prednike
		UPDATE VlogaPrednik SET DatumSpremembe=GETDATE() where VlogaID = @VlogaID;
	--Vnesem prednike
		INSERT INTO [dbo].[VlogaPrednik] (
			[VlogaID],
			[PrednikID],
			[Nivo]
		) 
			select @VlogaID, PrednikID, @nivo from VlogaPrednik where VlogaID=@AdminVloga
			
		
		--	sam svoj prednik
		INSERT INTO [dbo].[VlogaPrednik] (
			[VlogaID],
			[PrednikID],
			[Nivo]
		) VALUES (
			@VlogaID,
			@VlogaID,
			@nivo
		)
	end

end
else
begin
-- imam navadne Vloga

	select @AdminNivo = nivo from Vloga where VlogaID=@AdminVloga;
	select @NadNivo = nivo from Vloga where VlogaID=@NadVloga;
	
	--dodano // je OK ?
	set @AdminNivo = ISNULL(@adminNivo,0) 
	set @NadNivo = ISNULL(@NadNivo,0)
	
	if(@AdminNivo <> @NadNivo)
	begin
		return 1
	end
	SET @nivo = @AdminNivo+1


	INSERT INTO [dbo].[Vloga] (
			[VlogaID],
			[Naziv],
			[Admin],
			[Nivo],
			[Globina],
			[DatumVnosa]
		) VALUES (
			@VlogaID,
			@Naziv,
			0,
			@nivo,
			1,
			GETDATE()
		)

	-- preklicem vse prednike
		UPDATE VlogaPrednik SET DatumSpremembe=GETDATE() where VlogaID = @VlogaID;
	--Vnesem prednike
		INSERT INTO [dbo].[VlogaPrednik] (
			[VlogaID],
			[PrednikID],
			[Nivo]
		) select @VlogaID, PrednikID, @nivo from VlogaPrednik where VlogaID=@AdminVloga

		INSERT INTO [dbo].[VlogaPrednik] (
			[VlogaID],
			[PrednikID],
			[Nivo]
		) select @VlogaID, PrednikID, @nivo from VlogaPrednik where VlogaID=@NadVloga
		--	sam svoj prednik
		INSERT INTO [dbo].[VlogaPrednik] (
			[VlogaID],
			[PrednikID],
			[Nivo]
		) VALUES (
			@VlogaID,
			@VlogaID,
			@nivo
		)

end

return 0
end

GO