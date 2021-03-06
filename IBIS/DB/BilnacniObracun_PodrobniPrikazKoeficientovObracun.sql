/****** Object:  StoredProcedure [dbo].[BilnacniObracun_PodrobniPrikazKoeficientovObracun]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PodrobniPrikazKoeficientovObracun]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_PodrobniPrikazKoeficientovObracun]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PodrobniPrikazKoeficientovObracun]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracun_PodrobniPrikazKoeficientovObracun]
	-- Add the parameters for the stored procedure here
	@ObracunID INT,
	@Datum DateTime,
	@Bs INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT distinct Interval, TolerancniPas, Odstopanje, Cplus, Cminus, Cp,Cn, PoravnavaZnotrajT, PoravnavaZunajT from PodatkiObracuna where ObracunID=@ObracunID and BilancnaSkupina=@Bs and Interval = @Datum;
END

' 
END
GO
