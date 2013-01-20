/****** Object:  StoredProcedure [dbo].[usp_InsertPPMTip]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPPMTip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertPPMTip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPPMTip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_InsertPPMTip]
	@Naziv varchar(50),
	@PPMTipID int 
AS

SET NOCOUNT ON

INSERT INTO [dbo].[PPMTip] (
	PPMTipID, [Naziv]
) VALUES (
	@PPMTipID, @Naziv
)



--endregion


' 
END
GO
