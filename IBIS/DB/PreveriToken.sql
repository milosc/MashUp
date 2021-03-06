/****** Object:  StoredProcedure [dbo].[PreveriToken]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PreveriToken]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PreveriToken]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PreveriToken]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[PreveriToken] 
( @Token varchar(255))
 AS

declare @err int
set @err = 0
declare @num int

begin tran

select @num=count(*) from Token 
where Token = @Token

if @num > 0
begin
	set @err = 0
	delete from Token where Token = @Token
end
else
	set @err = 1


if (@err = 0)
begin
commit tran
return 1
end
else
begin
rollback tran
return 0
end

' 
END
GO
