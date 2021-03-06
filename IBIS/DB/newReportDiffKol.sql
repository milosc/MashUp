/****** Object:  StoredProcedure [dbo].[newReportDiffKol]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[newReportDiffKol]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[newReportDiffKol]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[newReportDiffKol]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- exec newReportDiffKol 9, 91, 92, 1
create procedure [dbo].[newReportDiffKol](
  @oseba int,
  @ob1 int,   -- obracun1
  @ob2 int,   -- obracun2   
  @kaj int   -- 0:datum ,1: vrednosti za obracun1
             -- 2:vrednosti za obracun2 , 3: diference med obema.
)as
begin


if(@kaj=0) begin
   select dbo.mk24ur(Interval) as Interval from Kolicine where ObracunID=@ob1 and OsebaID=@oseba
   order by Interval asc
end

if(@kaj=1) begin
select dbo.mk24ur(Interval) as Interval, 
  Realizacija as Realizacija, 
  Odstopanje as Odstopanje, 
  TrzniPlan as [Tržni plan]
  from Kolicine where ObracunID=@ob1 and OsebaID=@oseba
  order by Interval asc
end

if(@kaj=2) begin
select dbo.mk24ur(Interval) as Interval, 
  Realizacija as Realizacija, 
  Odstopanje as Odstopanje, 
  TrzniPlan as [Tržni plan]
  from Kolicine where ObracunID=@ob2 and OsebaID=@oseba
  order by Interval asc
end

if(@kaj=3) begin
select dbo.mk24ur(a.Interval) as Interval, 
       (b.Realizacija-a.Realizacija) as [Realizacija], 
       (b.Odstopanje-a.Odstopanje) as   [Odstopanje],
       (b.TrzniPlan-a.TrzniPlan) as     [Tržni plan]
  from (select * from Kolicine where ObracunID=@ob1 and OsebaID=@oseba)  a
  inner join (select * from Kolicine where ObracunID=@ob2 and OsebaID=@oseba)  b
  on a.Interval=b.Interval
  order by a.Interval asc
 end
  
end
' 
END
GO
