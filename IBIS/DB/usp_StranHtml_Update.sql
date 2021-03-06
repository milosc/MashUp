/****** Object:  StoredProcedure [dbo].[usp_StranHtml_Update]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_StranHtml_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_StranHtml_Update]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_StranHtml_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_StranHtml_Update]
	-- Add the parameters for the stored procedure here
	@stran varchar(50),
	@vsebina text
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @StranID int
DECLARE @ID int
DECLARE @Avtor int
	SELECT @ID=id, @StranID=StranID,@Avtor=avtor  from StranHtml where Stran = @stran and DatumSpremembe IS NULL;

	UPDATE StranHtml SET
		DatumSpremembe = GETDATE() where ID = @ID;
    -- Insert statements for procedure here
	INSERT INTO StranHtml (StranID,Stran, Vsebina, DatumVnosa, Avtor) values
	(@StranID,@stran, @vsebina,GETDATE(),@Avtor);
	
END

' 
END
GO
