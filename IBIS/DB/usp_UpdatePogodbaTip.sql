/****** Object:  StoredProcedure [dbo].[usp_UpdatePogodbaTip]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePogodbaTip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdatePogodbaTip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePogodbaTip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_UpdatePogodbaTip]
	@PogodbaTipID int,
	@Naziv varchar(50)
AS

SET NOCOUNT ON

UPDATE [dbo].[PogodbaTip] SET
	[Naziv] = @Naziv
WHERE
	[PogodbaTipID] = @PogodbaTipID

--endregion


' 
END
GO
