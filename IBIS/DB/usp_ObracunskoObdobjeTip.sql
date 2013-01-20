/****** Object:  StoredProcedure [dbo].[usp_ObracunskoObdobjeTip]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ObracunskoObdobjeTip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_ObracunskoObdobjeTip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ObracunskoObdobjeTip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[usp_ObracunskoObdobjeTip]
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT
	[ObracunskoObdobjeTipID],
	[Naziv]
FROM
	[dbo].[ObracunskoObdobjeTip]

--endregion


' 
END
GO
