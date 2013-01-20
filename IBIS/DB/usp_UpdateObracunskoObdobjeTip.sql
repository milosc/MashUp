/****** Object:  StoredProcedure [dbo].[usp_UpdateObracunskoObdobjeTip]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateObracunskoObdobjeTip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdateObracunskoObdobjeTip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateObracunskoObdobjeTip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_UpdateObracunskoObdobjeTip]
	@ObracunskoObdobjeTipID int,
	@Naziv varchar(50)
AS

SET NOCOUNT ON

UPDATE [dbo].[ObracunskoObdobjeTip] SET
	[Naziv] = @Naziv
WHERE
	[ObracunskoObdobjeTipID] = @ObracunskoObdobjeTipID

--endregion


' 
END
GO
