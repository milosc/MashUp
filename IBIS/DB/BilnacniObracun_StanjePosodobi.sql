/****** Object:  StoredProcedure [dbo].[BilnacniObracun_StanjePosodobi]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_StanjePosodobi]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_StanjePosodobi]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_StanjePosodobi]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracun_StanjePosodobi]
	-- Add the parameters for the stored procedure here
	@ObracunID INT,
	@ObracunStatusID INT,
	@Komentar varchar(100),
	@Avtor INT,
	@Naziv varchar(50),
	@Admin int,
	@stanje DATETIME = GETDATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
DECLARE @OldNaziv varchar(50)
DECLARE @Obdobje int
--DECLARE @ObracunID int
DECLARE @OldStatus int
DECLARE @Tip int
DECLARE @OldKomentar varchar(100)
--print ''start''
-- Preberem preostale podatke
SELECT @Tip=ObracunTipID, @OldNaziv=[o].[Naziv], @Obdobje = [o].[ObracunskoObdobjeID], @OldStatus = [o].[ObracunStatusID], @ObracunID = [o].[ObracunID],  @OldKomentar=isnull([o].[Komentar],'''')
from Obracun o 
where o.ObracunID = @ObracunID and
o.DatumVnosa <= @stanje and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje;

if (@OldStatus <> @ObracunStatusID) OR (@OldKomentar <> @Komentar) OR (@OldNaziv <> @Naziv)
BEGIN
-- Vstavim nov vnos
if(@ObracunStatusID = 2)
begin
	DECLARE @ImaKon int
	-- preverim da se koncni status ne prekriva s kakim drugim v istem intevalu
	select @ImaKon=count(ObracunID) from Obracun where ObracunskoObdobjeID=@Obdobje and ObracunStatusID = 2

	if (@ImaKon > 0)
		begin
			if (@Admin = 0) begin
			   return 1 -- napaka, ker imammo ze nek koncni obracun za obdobje
			end
			else begin
			   -- [WARN:] vse ostale obracune v tem obdobju damo na koncno neveljavno stanje!!!!
			   update Obracun set ObracunStatusID = 3,DatumSpremembe = GETDATE() where ObracunskoObdobjeID=@Obdobje and ObracunStatusID = 2
		       INSERT into Obracun (ObracunID, ObracunStatusID, ObracunskoObdobjeID, Avtor, Naziv, DatumVnosa, Komentar, ObracunTipID) values
			      (@ObracunID, @ObracunStatusID, @Obdobje, @Avtor, @Naziv, GETDATE(),@Komentar,@Tip );
			   return 0   
			end			  
		end
	else
	begin
		update Obracun set DatumSpremembe = GETDATE() where ObracunID = @ObracunID and  DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje;
		INSERT into Obracun (ObracunID, ObracunStatusID, ObracunskoObdobjeID, Avtor, Naziv, DatumVnosa, Komentar, ObracunTipID) values
			(@ObracunID, @ObracunStatusID, @Obdobje, @Avtor, @Naziv, GETDATE(),@Komentar,@Tip );
		return 0;
	end

end
else
	begin
		--print @ObracunStatusID
		--print @OldStatus
		--print @Admin
		if(@ObracunStatusID >= @OldStatus or @Admin=1)
		begin
			update Obracun set DatumSpremembe = GETDATE() where ObracunID = @ObracunID and  DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje;
			INSERT into Obracun (ObracunID, ObracunStatusID, ObracunskoObdobjeID, Avtor, Naziv, DatumVnosa, Komentar, ObracunTipID) values
			(@ObracunID, @ObracunStatusID, @Obdobje, @Avtor, @Naziv, GETDATE(),@Komentar,@Tip );
		end
	else
	begin
		return 2;
	end
	return 0;
end

END

END







' 
END
GO
