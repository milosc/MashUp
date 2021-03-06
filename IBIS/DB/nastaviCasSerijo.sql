/****** Object:  StoredProcedure [dbo].[nastaviCasSerijo]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nastaviCasSerijo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[nastaviCasSerijo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nastaviCasSerijo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--=======================================
-- au: mt (4.2.10)
-- skreira casovno serijo (nanovo!!)
-- postavi tipicne dneve po tipu (uposteva praznike)
--    
-- usage: exec nastaviCasSerijo ''2009-10-1'', ''2010-12-31'', 1
-- select * from casSerija
--=======================================
CREATE procedure [dbo].[nastaviCasSerijo] (
  @tstart datetime,
  @tEnd datetime, --vkljucno zadnji dan.
  @clear int -- 1: prej pobrise obstojeco!
) 
as 
begin

set nocount on
set @tEnd= DATEADD(day,1,@tEnd) 

if(@clear=1) -- brisanje
  truncate table casSerija
else
  delete from casSerija where dt >= @tStart and dt < @tEnd


declare @ct datetime
set @ct=@tStart
declare @tip int
while @ct < @tEnd 
begin
  select @tip=case datepart(dw,@ct)
     when 1 then 3 -- sun
     when 7 then 2 -- sat
     else 1 
     end 
  insert into casSerija (dt,dtBorzen,tip)
      values (@ct,DATEADD(HOUR,1,@ct),@tip)    
  set @ct = DATEADD(HOUR,1,@ct)
end
  
-- update se glede na praznike.  

IF OBJECT_ID(''tempdb..#tdt'') IS NOT NULL  drop table #tdt
select d into #tdt from praznik

declare @n int
select @n=COUNT(*) from #tdt
while @n > 0 begin
  select top 1 @ct=d from #tdt
  print @ct
  update casSerija set tip=3 
      where  dt>=@ct and dt < dateadd(day,1,@ct)
  
  delete from #tdt where d=@ct
  set @n=@n-1
end


  
end --end proc
' 
END
GO
