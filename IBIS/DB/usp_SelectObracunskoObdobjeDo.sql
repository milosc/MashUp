/****** Object:  StoredProcedure [dbo].[usp_SelectObracunskoObdobjeDo]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectObracunskoObdobjeDo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectObracunskoObdobjeDo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectObracunskoObdobjeDo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SelectObracunskoObdobjeDo]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
	[ObracunskoObdobjeID],
	[VeljaDo]
FROM
	[dbo].[ObracunskoObdobje]

END
' 
END
GO
