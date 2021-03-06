/****** Object:  StoredProcedure [dbo].[usp_InsertPoracunTip]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPoracunTip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertPoracunTip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPoracunTip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_InsertPoracunTip]
	@Naziv varchar(50),
	@PoracunTipID int 
AS

SET NOCOUNT ON

INSERT INTO [dbo].[PoracunTip] (
	PoracunTipID, [Naziv]
) VALUES (
	@PoracunTipID, @Naziv
)



--endregion

' 
END
GO
