/****** Object:  StoredProcedure [dbo].[InsertToken]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertToken]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertToken]
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertToken]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE PROCEDURE [dbo].[InsertToken] 
( @Token varchar(255))
 AS

insert into Token (Token) values (@Token)

return 1

' 
END
GO
