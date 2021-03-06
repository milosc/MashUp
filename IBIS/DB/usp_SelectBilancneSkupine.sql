/****** Object:  StoredProcedure [dbo].[usp_SelectBilancneSkupine]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectBilancneSkupine]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectBilancneSkupine]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectBilancneSkupine]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SelectBilancneSkupine]
	-- Add the parameters for the stored procedure here
	@stanje DATETIME = GETDATE
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select distinct OsebaID,Naziv from Oseba where OsebaID in (select distinct Partner2 from Pogodba where TipPogodbeID=1 and @stanje < VeljaDo and @stanje > VeljaOd and Nivo=1);
END

' 
END
GO
