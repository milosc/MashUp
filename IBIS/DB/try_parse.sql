EXEC [dbo].[DropPRCorUDF]	@ObjectName = 'try_parse'
GO


create function dbo.try_parse(@v nvarchar(30))
returns float
with schemabinding, returns null on null input
as
begin
  if isnumeric(@v) = 1
    return cast(@v as float);

  return null;
end;