/****** Object:  StoredProcedure [dbo].[sp_UpdateEnPPM]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_UpdateEnPPM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_UpdateEnPPM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_UpdateEnPPM]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_UpdateEnPPM]
	@PPMID int,
	@Interval datetime,
	@Kolicina decimal(18,8)
AS
BEGIN
	
update Meritve set DatumSpremembe=getdate()	
	where PPMID=@PPMID and
	Interval = @Interval and 
	DatumSpremembe is null


END' 
END
GO
