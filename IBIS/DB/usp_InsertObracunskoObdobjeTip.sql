/****** Object:  StoredProcedure [dbo].[usp_InsertObracunskoObdobjeTip]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertObracunskoObdobjeTip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertObracunskoObdobjeTip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertObracunskoObdobjeTip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_InsertObracunskoObdobjeTip]
	@Naziv varchar(50),
	@ObracunskoObdobjeTipID int 
AS

SET NOCOUNT ON

INSERT INTO [dbo].[ObracunskoObdobjeTip] (
	ObracunskoObdobjeTipID, Naziv
) VALUES (
	@ObracunskoObdobjeTipID, @Naziv
)



--endregion


' 
END
GO
