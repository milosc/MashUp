/****** Object:  StoredProcedure [dbo].[sp_ReportObracunKolIzpis]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ReportObracunKolIzpis]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_ReportObracunKolIzpis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ReportObracunKolIzpis]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- testno:   
--  exec sp_ReportObracunKolIzpis ''2010-1-1 1:00'', 9, 73, ''2010-1-2 1:00'', ''2012-1-1 1:00''
-- =============================================
CREATE  PROCEDURE [dbo].[sp_ReportObracunKolIzpis]
	@VeljaOd datetime,
	@OsebaID int,
	@ObracunID int,
	@VeljaDo datetime,
	@StanjeNaDan datetime
AS
BEGIN
--za prikaz na reportu za obracun kolicinski

goto najnovejse
goto novo

SELECT DISTINCT o.Naziv, 
CASE WHEN DATEPART(hour , tp.Interval) = 0 THEN CONVERT (varchar(20) , DATEADD(day , - 1 , tp.Interval) , 104) + '' 24''  --z case naredimo da uro 0 zapisemo kot 24,in moramo dati dan nazaj,ker 00:00 je ze nasljedni dan(npr iz 2.1.2008 00:00 v->1.1.2008 24) sevda moramo to pretvorit v string ki pa se se vedno vrne kot spremnljivka Ineterval
WHEN DATEPART(hour , tp.Interval) < 10 THEN CONVERT (varchar(10) , tp.Interval , 104) + '' 0'' + CAST(DATEPART(hour , tp.Interval) AS varchar(5)) --zpisemo 0 spredaj ce je ura <9
ELSE CONVERT (varchar(10) , tp.Interval , 104) + '' '' + CAST(DATEPART(hour , tp.Interval) AS varchar(5)) --ni potrben zapis 0 spredaj kot zgoraj
END AS Interval,
 (tr.VrednostPopravkaTP+tp.VozniRed) as TrzniPlan,-- ta je novo 23.2.09 ,--tp.VozniRed as TrzniPlan v uporabi do 23.2.09,  --tr.Kolicina as TrzniPlan je direktno iz tp ,
 tr.VrednostPopravkaTP AS Regulacija,  
--isnull((rg.SekRegP - rg.SekRegM +rg.TerRegP - rg.TerRegM ) ,0)as Regulacija, --vcasih za regulacijo
 --tr.KoregiranTP, do 5.3.09
 --tp.KoregiranTP, --od 5.3.09 smo dodali v View_KolicinskaOdstopanja(ozirom v ustrezni tabeli v viewju) se  pravilen TP
 tp.VozniRed as KoregiranTP,--od 10.3.09 ker milos prensa koregiranTP v stoplec VozniRed v tabelo KolicinskaOdstopanjaPoBPS in KolicinskaOdstopanjaPoBS
 tp.Kolicina as Realizacija,
 tp.Odstopanje
FROM Kolicina AS tp 
INNER JOIN Oseba AS o ON tp.OsebaID = o.OsebaID 
--and (@StanjeNaDan BETWEEN tr.DatumVnosa AND dbo.infinite(tr.DatumSpremembe)) ----do 1.7.2009 samo po vec obracunih je kar 24 ura zmanjkala zardi tega stavka
--LEFT OUTER JOIN Regulacija rg ON rg.Interval=tr.Interval and rg.DatumSpremembe is null and rg.PPMID=@PPMID
WHERE (@StanjeNaDan BETWEEN o.DatumVnosa AND dbo.infinite(o.DatumSpremembe))
 AND (@StanjeNaDan BETWEEN o.VeljaOd AND dbo.infinite(o.VeljaDo))
  AND (tp.Interval >= @VeljaOd) AND (tp.Interval <= DATEADD(d, 1, @VeljaDo)) 
  AND (tp.OsebaID IN (@OsebaID)) 
  AND (tp.ObracunID = @ObracunID) 
  ORDER BY Interval

novo:


-- Update MTX 1.3. podatki se pobirajo za vse (iz kolicine). 
SELECT DISTINCT o.Naziv, 
CASE WHEN DATEPART(hour , ko.Interval) = 0 THEN CONVERT (varchar(20) , DATEADD(day , - 1 , ko.Interval) , 104) + '' 24''  --z case naredimo da uro 0 zapisemo kot 24,in moramo dati dan nazaj,ker 00:00 je ze nasljedni dan(npr iz 2.1.2008 00:00 v->1.1.2008 24) sevda moramo to pretvorit v string ki pa se se vedno vrne kot spremnljivka Ineterval
WHEN DATEPART(hour , ko.Interval) < 10 THEN CONVERT (varchar(10) , ko.Interval , 104) + '' 0'' + CAST(DATEPART(hour , ko.Interval) AS varchar(5)) --zpisemo 0 spredaj ce je ura <9
ELSE CONVERT (varchar(10) , ko.Interval , 104) + '' '' + CAST(DATEPART(hour , ko.Interval) AS varchar(5)) --ni potrben zapis 0 spredaj kot zgoraj
END AS Interval,
	--MTX: tu so ze prave stvari v pravih fieldih. 
	 ko.TrzniPlan as TrzniPlan,
	 ko.Regulacija, -- AS Regulacija,  
	 ko.korigiranTP as KoregiranTP,
	 ko.Realizacija, -- as Realizacija,
	 ko.Odstopanje
FROM kolicine AS ko 
INNER JOIN Oseba AS o ON ko.OsebaID = o.OsebaID 
WHERE (@StanjeNaDan BETWEEN o.DatumVnosa AND dbo.infinite(o.DatumSpremembe))
 AND (@StanjeNaDan BETWEEN o.VeljaOd AND dbo.infinite(o.VeljaDo))
  AND (ko.Interval >= @VeljaOd) AND (ko.Interval <= DATEADD(d, 1, @VeljaDo)) 
  AND (ko.OsebaID IN (@OsebaID)) 
  AND (ko.ObracunID = @ObracunID) 
  ORDER BY Interval


najnovejse: -- 2010.6.21.

SELECT --DISTINCT  
     dbo.mk24ur(ko.interval) AS Interval,
	--MTX: tu so ze prave stvari v pravih fieldih. 
	 ko.TrzniPlan,  --as TrzniPlan,
	 ko.Regulacija, -- AS Regulacija,  
	 ko.korigiranTP as KoregiranTP,
	 ko.Realizacija, -- as Realizacija,
	 ko.Odstopanje
FROM kolicine ko 
WHERE ko.OsebaID=@osebaId AND ko.ObracunID = @ObracunID 
ORDER BY Interval asc

ende:

END

' 
END
GO
