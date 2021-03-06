/****** Object:  StoredProcedure [dbo].[BO_PrikazFinancni]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BO_PrikazFinancni]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BO_PrikazFinancni]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BO_PrikazFinancni]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- exec BO_PrikazFinancni ''2010-1-1'',3,91,''2010-1-5'', ''2020-1-1''
CREATE procedure [dbo].[BO_PrikazFinancni](
  @VeljaOd datetime,
  @OsebaID int,
  @ObracunID int,
  @VeljaDo datetime,
  @StanjeNaDan datetime  
) as 
begin

declare @tip int
select @tip = osebaZId from osebaZCalc
where osebaid= @OsebaID
 and @StanjeNaDan between datumVnosa and dbo.infinite(datumSpremembe)

goto novo

--select @tip 

if (@tip =1) begin
   SELECT DISTINCT  o.Naziv, 
         CASE WHEN DATEPART(hour , po.Interval) = 0 THEN CONVERT (varchar(20) , 
         DATEADD(day , - 1 , po.Interval) , 104) + '' 24''  
                 WHEN DATEPART(hour,po.Interval)<10 THEN  convert(varchar(10),po.Interval,104)+'' 0''+cast(DATEPART(hour,po.Interval) as varchar(5)) 
                  ELSE CONVERT (varchar(10) , po.Interval , 104) + '' '' + CAST(DATEPART(hour , po.Interval) AS varchar(5)) END AS Interval, 
         po.TolerancniPas, po.Odstopanje, po.Cplus , po.Cminus, po.CPlusNov, po.CMinusNov, po.Cp, po.Cn, po.CpNov, po.CnNov, po.Ckplus, 
         po.Ckminus, po.PoravnavaZnotrajT, po.PoravnavaZunajT, po.PoravnavaZnotrajTNova, po.PoravnavaZunajTNova, ob.Naziv AS ObracuNaziv 
         FROM PodatkiObracuna AS po 
         INNER JOIN Oseba AS o ON po.OsebaID = o.OsebaID 
         INNER JOIN Obracun AS ob ON po.ObracunID = ob.ObracunID 
         WHERE (po.Interval > @VeljaOd) AND (po.OsebaID IN (@OsebaID)) AND (po.ObracunID = @ObracunID) 
         AND (po.Interval <= DATEADD(d, 1, @VeljaDo)) 
         AND (@StanjeNaDan BETWEEN o.DatumVnosa AND dbo.infinite(o.DatumSpremembe)) 
         AND (@StanjeNaDan BETWEEN o.VeljaOd AND dbo.infinite(o.VeljaDo)) 
         AND (@StanjeNaDan BETWEEN ob.DatumVnosa AND dbo.infinite(ob.DatumSpremembe)) ORDER BY Interval
end

if (@tip = 3) begin -- gjs 
    SELECT DISTINCT  o.Naziv, 
         CASE WHEN DATEPART(hour , po.Interval) = 0 THEN CONVERT (varchar(20) , 
         DATEADD(day , - 1 , po.Interval) , 104) + '' 24''  
                 WHEN DATEPART(hour,po.Interval)<10 THEN  convert(varchar(10),po.Interval,104)+'' 0''+cast(DATEPART(hour,po.Interval) as varchar(5)) 
                  ELSE CONVERT (varchar(10) , po.Interval , 104) + '' '' + CAST(DATEPART(hour , po.Interval) AS varchar(5)) END AS Interval, 
         po.Odstopanje, po.Cplus, po.Cminus, cast(po.Cplus/1.03 as decimal (18,2)) as Cpc, cast(po.Cminus/0.97  as decimal (18,2)) as Cmc,
         --po.CPlusNov, po.CMinusNov, po.Cp, po.Cn, po.CpNov, po.CnNov, po.Ckplus, 
         po.Ckminus, po.PoravnavaZnotrajT, ob.Naziv AS ObracuNaziv          

         FROM PodatkiObracuna AS po 
         INNER JOIN Oseba AS o ON po.OsebaID = o.OsebaID 
         INNER JOIN Obracun AS ob ON po.ObracunID = ob.ObracunID 
         WHERE (po.Interval > @VeljaOd) AND (po.OsebaID IN (@OsebaID)) AND (po.ObracunID = @ObracunID) 
         AND (po.Interval <= DATEADD(d, 1, @VeljaDo)) 
         AND (@StanjeNaDan BETWEEN o.DatumVnosa AND dbo.infinite(o.DatumSpremembe)) 
         AND (@StanjeNaDan BETWEEN o.VeljaOd AND dbo.infinite(o.VeljaDo)) 
         AND (@StanjeNaDan BETWEEN ob.DatumVnosa AND dbo.infinite(ob.DatumSpremembe)) ORDER BY Interval
end  
if (@tip in (2,4)) begin -- Trgoved
    SELECT DISTINCT  o.Naziv, 
         CASE WHEN DATEPART(hour , po.Interval) = 0 THEN CONVERT (varchar(20) , 
         DATEADD(day , - 1 , po.Interval) , 104) + '' 24''  
                 WHEN DATEPART(hour,po.Interval)<10 THEN  convert(varchar(10),po.Interval,104)+'' 0''+cast(DATEPART(hour,po.Interval) as varchar(5)) 
                  ELSE CONVERT (varchar(10) , po.Interval , 104) + '' '' + CAST(DATEPART(hour , po.Interval) AS varchar(5)) END AS Interval, 
         po.Odstopanje, po.Cplus, po.Cminus, po.Cp, po.Cn,
         --po.CPlusNov, po.CMinusNov, po.Cp, po.Cn, po.CpNov, po.CnNov, po.Ckplus,   po.Ckminus,
         po.PoravnavaZnotrajT, ob.Naziv AS ObracuNaziv          

         FROM PodatkiObracuna AS po 
         INNER JOIN Oseba AS o ON po.OsebaID = o.OsebaID 
         INNER JOIN Obracun AS ob ON po.ObracunID = ob.ObracunID 
         WHERE (po.Interval > @VeljaOd) AND (po.OsebaID IN (@OsebaID)) AND (po.ObracunID = @ObracunID) 
         AND (po.Interval <= DATEADD(d, 1, @VeljaDo)) 
         AND (@StanjeNaDan BETWEEN o.DatumVnosa AND dbo.infinite(o.DatumSpremembe)) 
         AND (@StanjeNaDan BETWEEN o.VeljaOd AND dbo.infinite(o.VeljaDo)) 
         AND (@StanjeNaDan BETWEEN ob.DatumVnosa AND dbo.infinite(ob.DatumSpremembe)) ORDER BY Interval

end  

if (@tip = 5) begin--meja
    SELECT DISTINCT  o.Naziv, 
         CASE WHEN DATEPART(hour , po.Interval) = 0 THEN CONVERT (varchar(20) , 
         DATEADD(day , - 1 , po.Interval) , 104) + '' 24''  
                 WHEN DATEPART(hour,po.Interval)<10 THEN  convert(varchar(10),po.Interval,104)+'' 0''+cast(DATEPART(hour,po.Interval) as varchar(5)) 
                  ELSE CONVERT (varchar(10), po.Interval , 104) + '' '' + CAST(DATEPART(hour , po.Interval) AS varchar(5)) END AS Interval, 
         po.Odstopanje, po.Cplus, po.Cminus,po.Ckminus, PoravnavaZnotrajT,
         ob.Naziv AS ObracuNaziv              
                  
         FROM PodatkiObracuna AS po 
         INNER JOIN Oseba AS o ON po.OsebaID = o.OsebaID 
         INNER JOIN Obracun AS ob ON po.ObracunID = ob.ObracunID 
         WHERE (po.Interval > @VeljaOd) AND (po.OsebaID IN (@OsebaID)) AND (po.ObracunID = @ObracunID) 
         AND (po.Interval <= DATEADD(d, 1, @VeljaDo)) 
         AND (@StanjeNaDan BETWEEN o.DatumVnosa AND dbo.infinite(o.DatumSpremembe)) 
         AND (@StanjeNaDan BETWEEN o.VeljaOd AND dbo.infinite(o.VeljaDo)) 
         AND (@StanjeNaDan BETWEEN ob.DatumVnosa AND dbo.infinite(ob.DatumSpremembe)) ORDER BY Interval
end         
goto ende

novo: -- 2010-6-21
if (@tip =1) begin
   SELECT --DISTINCT  o.Naziv, 
         dbo.mk24ur(po.interval) as Interval,         
         po.TolerancniPas, po.Odstopanje, po.Cplus , po.Cminus, po.CPlusNov, po.CMinusNov, po.Cp, po.Cn, po.CpNov, po.CnNov, po.Ckplus, 
         po.Ckminus, po.PoravnavaZnotrajT, po.PoravnavaZunajT, po.PoravnavaZnotrajTNova, po.PoravnavaZunajTNova --, ob.Naziv AS ObracuNaziv 
         FROM PodatkiObracuna po 
         where po.OsebaID = @OsebaID AND po.ObracunID = @ObracunID ORDER BY Interval asc
end
if (@tip = 3) begin -- gjs 
    SELECT --DISTINCT  o.Naziv, 
         dbo.mk24ur(po.interval) as Interval,  
         po.Odstopanje, po.Cplus, po.Cminus, cast(po.Cplus/1.03 as decimal (18,2)) as Cpc, cast(po.Cminus/0.97  as decimal (18,2)) as Cmc,
         --po.CPlusNov, po.CMinusNov, po.Cp, po.Cn, po.CpNov, po.CnNov, po.Ckplus, 
         po.Ckminus, po.PoravnavaZnotrajT --, ob.Naziv AS ObracuNaziv          
         FROM PodatkiObracuna po 
         where po.OsebaID = @OsebaID AND po.ObracunID = @ObracunID ORDER BY Interval asc
end
if (@tip in (2,4)) begin -- Trgovec
    SELECT --DISTINCT  o.Naziv, 
         dbo.mk24ur(po.interval) as Interval,
         po.Odstopanje, po.Cplus, po.Cminus, po.Cp, po.Cn,
         --po.CPlusNov, po.CMinusNov, po.Cp, po.Cn, po.CpNov, po.CnNov, po.Ckplus,   po.Ckminus,
         po.PoravnavaZnotrajT --, ob.Naziv AS ObracuNaziv          
         FROM PodatkiObracuna po 
         where po.OsebaID = @OsebaID AND po.ObracunID = @ObracunID ORDER BY Interval asc
end  
if (@tip = 5) begin--meja
    SELECT --DISTINCT  o.Naziv, 
         dbo.mk24ur(po.interval) as Interval,
         po.Odstopanje, po.Cplus, po.Cminus,po.Ckminus, PoravnavaZnotrajT --, ob.Naziv AS ObracuNaziv                                       
         FROM PodatkiObracuna po 
         where po.OsebaID = @OsebaID AND po.ObracunID = @ObracunID ORDER BY Interval asc
end         

ende:

end' 
END
GO
