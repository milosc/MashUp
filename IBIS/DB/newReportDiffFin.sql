/****** Object:  StoredProcedure [dbo].[newReportDiffFin]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[newReportDiffFin]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[newReportDiffFin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[newReportDiffFin]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- exec [newReportDiffFin] 9, 91, 92, 3
create procedure [dbo].[newReportDiffFin](
  @oseba int,
  @ob1 int,   -- obracun1
  @ob2 int,   -- obracun2   
  @kaj int   -- 0:datum ,1: vrednosti za obracun1
             -- 2:vrednosti za obracun2 , 3: diference med obema.
)as
begin

--declare @kaj int
--declare @oseba int 
--declare @ob1 int
--declare @ob2 int
--set @oseba=9
--set @ob1=91
--set @ob2=92
--set @kaj=1


--select top 2 * from Kolicine

if(@kaj=0) begin
   select dbo.mk24ur(Interval) as Interval from PodatkiObracuna where ObracunID=@ob1 and OsebaID=@oseba
   order by Interval asc
end

if(@kaj=1) begin
select dbo.mk24ur(Interval) as Interval, 
  TolerancniPas/1000 as [Tolerančni pas], 
  Odstopanje/1000 as Odstopanje, 
  Cplus as [C+],
  Cminus as [C-],
  ckplus+ckminus as [Ck],
  PoravnavaZnotrajT+PoravnavaZunajT as [Poravnava]
  from PodatkiObracuna where ObracunID=@ob1 and OsebaID=@oseba
  order by Interval asc
end

if(@kaj=2) begin
select dbo.mk24ur(Interval) as Interval, 
  TolerancniPas/1000 as [Tolerančni pas], 
  Odstopanje/1000 as Odstopanje, 
  Cplus as [C+],
  Cminus as [C-],
  ckplus+ckminus as [Ck],
  PoravnavaZnotrajT+PoravnavaZunajT as [Poravnava]
  from PodatkiObracuna where ObracunID=@ob2 and OsebaID=@oseba
end

if(@kaj=3) begin
select dbo.mk24ur(a.Interval) as Interval, 
  (b.TolerancniPas-a.TolerancniPas)/1000 as [Tolerančni pas], 
  (b.Odstopanje-a.Odstopanje)/1000 as Odstopanje, 
  (b.Cplus-a.Cplus) as [C+],
  (b.Cminus-a.Cminus) as [C-],
  (b.ckplus+b.ckminus) - (a.ckplus+a.ckminus) as [Ck],  
  (b.PoravnavaZnotrajT+b.PoravnavaZunajT) - (a.PoravnavaZnotrajT+a.PoravnavaZunajT) as [Poravnava]       
  from (select *       from PodatkiObracuna where ObracunID=@ob1 and OsebaID=@oseba)  a
  inner join (select * from PodatkiObracuna where ObracunID=@ob2 and OsebaID=@oseba)  b
  on a.Interval=b.Interval
  order by a.Interval asc
 end
  
end
' 
END
GO
