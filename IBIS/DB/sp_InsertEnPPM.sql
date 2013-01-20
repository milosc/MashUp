/****** Object:  StoredProcedure [dbo].[sp_InsertEnPPM]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_InsertEnPPM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_InsertEnPPM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_InsertEnPPM]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_InsertEnPPM]
	@PPMID int,
	@Interval datetime,
	@Kolicina decimal(18,8)
AS
BEGIN
	
insert into Meritve (PPMID,Interval,Kolicina) 
	values(@PPMID,@Interval,@Kolicina)	


END
' 
END
GO
