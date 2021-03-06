/****** Object:  StoredProcedure [dbo].[BilnacniObracun_PrikazPoBS_bkup]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PrikazPoBS_bkup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_PrikazPoBS_bkup]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PrikazPoBS_bkup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[BilnacniObracun_PrikazPoBS_bkup]
	-- Add the parameters for the stored procedure here
	@ObracunID INT,
	@stanje DateTime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
--	DECLARE @ObracunID int
--select @ObracunID = [ObracunID] from Obracun where ID = @ID;

select s.Naziv as bs,o.OsebaID as BilancnaSkupina, cast(sum(Odstopanje)/1000 as decimal(18,3))as odstopanje, cast(sum(o.PoravnavaZunajT+o.PoravnavaZnotrajT) as decimal(18,2))  as stroski from PodatkiObracuna o, Oseba s 
where s.OsebaID = o.OsebaID and ObracunID= @ObracunID and 
@stanje BETWEEN s.DatumVnosa AND dbo.infinite(s.DatumSpremembe) 
group by o.OsebaID, s.Naziv;

END






' 
END
GO
