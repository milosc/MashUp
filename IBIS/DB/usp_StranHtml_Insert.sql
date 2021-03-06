/****** Object:  StoredProcedure [dbo].[usp_StranHtml_Insert]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_StranHtml_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_StranHtml_Insert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_StranHtml_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_StranHtml_Insert]
	-- Add the parameters for the stored procedure here
	@stran varchar(50),
	@vsebina text
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO StranHtml (Stran, Vsebina, DatumVnosa) values
	(@stran, @vsebina,GETDATE());
	--SELECT vsebina from StranHtml where Stran = @stran and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje;
END
' 
END
GO
