/****** Object:  StoredProcedure [dbo].[BilancniObracun_EnakTip]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilancniObracun_EnakTip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilancniObracun_EnakTip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilancniObracun_EnakTip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilancniObracun_EnakTip] 
	-- Add the parameters for the stored procedure here
	@Obracun1 int,
	@Obracun2 int,
	@stanje datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @financni int
	declare @tmp int 
	set @financni = 1

	select @tmp=ObracunTipID from Obracun where ObracunID=@Obracun1 and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
	if (@tmp = 4)
	begin
		set @financni = 0
	end
	select @tmp=ObracunTipID from Obracun where ObracunID=@Obracun1 and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
	if (@tmp = 4)
	begin
		set @financni = 0
	end

	if (@financni =0)
	begin
		return 0
	end
return 1
END

' 
END
GO
