/****** Object:  StoredProcedure [dbo].[BilnacniObracun_PrikazFinancni]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PrikazFinancni]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_PrikazFinancni]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PrikazFinancni]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracun_PrikazFinancni]
	-- Add the parameters for the stored procedure here
	@ID INT,
	@Bs INT = 0,
	@stanje DateTime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--DECLARE @ObracunID int

	--select @ObracunID = [ObracunID] from Obracun where ID = @ID;

if @Bs <> 0
begin
	SELECT o.ID, o.Interval, o.TolerancniPas, o.Odstopanje, o.Cplus, o.Cminus, o.Cp,o.Cn, o.PoravnavaZnotrajT, o.PoravnavaZunajT, s.Naziv as bs, o.OsebaID AS BilancnaSkupina
	from PodatkiObracuna o, Oseba s
	where s.OsebaID = o.OsebaID and ObracunID=@ID AND 
	(@stanje BETWEEN s.DatumVnosa AND dbo.infinite(s.DatumSpremembe)) and
	o.OsebaID=@Bs;
end
else
begin
	SELECT o.ID, o.Interval, o.TolerancniPas, o.Odstopanje, o.Cplus, o.Cminus, o.Cp,o.Cn, o.PoravnavaZnotrajT, o.PoravnavaZunajT, s.Naziv as bs, o.OsebaID AS BilancnaSkupina
	from PodatkiObracuna o, Oseba s
	where s.OsebaID = o.OsebaID and ObracunID=@ID and 
	(@stanje BETWEEN s.DatumVnosa AND dbo.infinite(s.DatumSpremembe))
end
END


' 
END
GO
