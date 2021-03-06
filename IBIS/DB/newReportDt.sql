/****** Object:  StoredProcedure [dbo].[newReportDt]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[newReportDt]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[newReportDt]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[newReportDt]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--  exec newReportDt 91 
CREATE procedure [dbo].[newReportDt](
  @obracunID int
)as
begin

set nocount on
--return;
--declare @obdobjeId int 
--declare @dtOd datetime
--declare @dtDo datetime

--select @obdobjeId=ObracunskoObdobjeID from Obracun where obracunId=@obracunID 
--select @dtOd=dateadd(hour,1,veljaod), @dtDo=dateadd(day,1,veljaDo) 
--       from ObracunskoObdobje where ObracunskoObdobjeID=@obdobjeId

declare @osebaid int
select top 1 @osebaid= osebaid from PodatkiObracuna where obracunid=@obracunid

select dbo.mk24ur(interval) as Datum 
     from PodatkiObracuna
     where OsebaID=@osebaid and ObracunID=@obracunid
     order by Datum asc

end
' 
END
GO
