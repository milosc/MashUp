/****** Object:  StoredProcedure [dbo].[BilnacniObracun_SeznamIzdelanihVobdobju]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_SeznamIzdelanihVobdobju]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_SeznamIzdelanihVobdobju]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_SeznamIzdelanihVobdobju]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracun_SeznamIzdelanihVobdobju]
	-- Add the parameters for the stored procedure here
	@ObdobjeID int, 
	@Tip int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if (@Tip = 4)
	begin
    -- Insert statements for procedure here
		SELECT ObracunID, Naziv from Obracun where ObracunskoObdobjeID=@ObdobjeID ;
	end
	else
	begin
		SELECT ObracunID, Naziv from Obracun where ObracunskoObdobjeID=@ObdobjeID and ObracunTipID != 4;
	end
END

' 
END
GO
