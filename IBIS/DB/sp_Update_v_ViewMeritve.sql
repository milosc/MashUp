/****** Object:  StoredProcedure [dbo].[sp_Update_v_ViewMeritve]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Update_v_ViewMeritve]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_Update_v_ViewMeritve]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Update_v_ViewMeritve]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_Update_v_ViewMeritve]
	@PPMID int,
	@Interval datetime
AS
BEGIN

update view_Meritve set DatumSpremembe=getdate()
where PPMID=@PPMID and
		Interval=@Interval and
	DatumSpremembe is null


END
' 
END
GO
