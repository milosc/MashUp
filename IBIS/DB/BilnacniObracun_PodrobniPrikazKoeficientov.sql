/****** Object:  StoredProcedure [dbo].[BilnacniObracun_PodrobniPrikazKoeficientov]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PodrobniPrikazKoeficientov]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_PodrobniPrikazKoeficientov]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PodrobniPrikazKoeficientov]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracun_PodrobniPrikazKoeficientov]
	-- Add the parameters for the stored procedure here
	@ID INT,
	@Datum DateTime,
	@Bs INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @ObracunID INT

select @ObracunID = [ObracunID] from Obracun where ID = @ID;
    -- Insert statements for procedure here
	SELECT distinct Interval, TolerancniPas, Odstopanje, Cplus, Cminus, Cp,Cn, PoravnavaZnotrajT, PoravnavaZunajT from PodatkiObracuna where ObracunID=@ObracunID and BilancnaSkupina=@Bs and Interval >= @Datum AND Interval < DATEADD(Day, DATEDIFF(Day, 0, @Datum), 1);
END
' 
END
GO
