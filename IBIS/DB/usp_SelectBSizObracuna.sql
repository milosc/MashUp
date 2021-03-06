/****** Object:  StoredProcedure [dbo].[usp_SelectBSizObracuna]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectBSizObracuna]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectBSizObracuna]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectBSizObracuna]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SelectBSizObracuna]
	-- Add the parameters for the stored procedure here
	@ObracunID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
--DECLARE @ObracunID int
--select @ObracunID = [ObracunID] from Obracun where ID = @ID;

	select OsebaID, Naziv from [dbo].[Oseba] o
where o.OsebaID in (select distinct OsebaID from [dbo].[PodatkiObracuna] where ObracunID=@ObracunID)
and o.ID = (select max(ID) from Oseba o1 where o1.OsebaID = o.OsebaID);
END


' 
END
GO
