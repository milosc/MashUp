/****** Object:  StoredProcedure [dbo].[BilnacniObracun_PrikazFinancniToleranciPas]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PrikazFinancniToleranciPas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_PrikazFinancniToleranciPas]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PrikazFinancniToleranciPas]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracun_PrikazFinancniToleranciPas]
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
	

select Interval,Odjem,Oddaja,T  as TolerancniPas from TolerancniPas 
where Interval = @Interval and OsebaID = @OsebaID and ObracunID = @ObracunID;

END





' 
END
GO
