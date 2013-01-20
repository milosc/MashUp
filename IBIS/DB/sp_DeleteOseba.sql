/****** Object:  StoredProcedure [dbo].[sp_DeleteOseba]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DeleteOseba]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DeleteOseba]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DeleteOseba]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_DeleteOseba]
	@ID int
AS
BEGIN
--namesto da dejansko izbrisemo zapisamo samo datumSpremembe za izbra zapis
--ki nam bo ptem sluzil za detekcijo "izbrisanega" zapisa

update Oseba set DatumSpremembe=getdate() 
		where ID=@ID

END' 
END
GO
