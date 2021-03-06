/****** Object:  StoredProcedure [dbo].[BilnacniObracun_PodrobniPrikaz]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PodrobniPrikaz]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_PodrobniPrikaz]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PodrobniPrikaz]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracun_PodrobniPrikaz]
	-- Add the parameters for the stored procedure here
	@ObracunID INT,
	@Bs INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--DECLARE @ObracunID INT
--select @ObracunID = [ObracunID] from Obracun where ID = @ID;

	select convert(char(10),[Interval],104) as datum, sum(Odstopanje)/1000 as odstopanje, sum(PoravnavaZnotrajT+PoravnavaZunajT) as stroski from PodatkiObracuna where ObracunID = @ObracunID and OsebaID = @Bs group by convert(char(10),[Interval],104) order by convert(char(10),[Interval],104) ASC
END



' 
END
GO
