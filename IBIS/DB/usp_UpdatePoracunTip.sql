/****** Object:  StoredProcedure [dbo].[usp_UpdatePoracunTip]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePoracunTip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdatePoracunTip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePoracunTip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[usp_UpdatePoracunTip]
	@PoracunTipID int,
	@Naziv varchar(50)
AS

SET NOCOUNT ON

UPDATE [dbo].[PoracunTip] SET
	[Naziv] = @Naziv
WHERE
	[PoracunTipID] = @PoracunTipID

--endregion

' 
END
GO
