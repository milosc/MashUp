/****** Object:  StoredProcedure [dbo].[BilnacniObracun_PrikazKolicinskiPodrobno]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PrikazKolicinskiPodrobno]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_PrikazKolicinskiPodrobno]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PrikazKolicinskiPodrobno]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracun_PrikazKolicinskiPodrobno]
	-- Add the parameters for the stored procedure here
	@ObracunID INT,
	@OsebaID INT, 
	@Interval DateTime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select s.Naziv as bs, o.OsebaID as BilancnaSkupina, o.odstopanje, o.Interval, o.ID, o.Kolicina as kolicina, o.VozniRed as voznired
from View_KolicinskaOdstopanja o, Oseba s 
where s.OsebaID = o.OsebaID and o.ObracunID= @ObracunID and s.DatumSpremembe IS NULL and
	o.Interval = @Interval and o.OsebaID = @OsebaID;

END





' 
END
GO
