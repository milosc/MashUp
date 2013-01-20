
select * from obracun

select * from RealizacijaPoBS where ObracunID = 6
and Interval = '2012-11-01 03:00:00' AND OsebaID=49

--SELECT * FROM Oseba WHERE Naziv LIKE '%ACRONI%'
SELECT * FROM Meritve_NOV_12 WHERE PPMID = 597 AND  Interval = '2012-11-01 03:00:00'
SELECT * FROM Meritve_NOV_12 WHERE PPMID = 721 AND  Interval = '2012-11-01 03:00:00'

SELECT * FROM Meritve_NOV_12 WHERE PPMID = 721 AND  Interval = '2012-11-01 08:00:00'

SELECT * FROM PPM WHERE PPMID = 721
SELECT * FROM PPM WHERE PPMID = 597

SELECT R.Interval, r.Kolicina,r.Oddaja,r.Odjem,o2.Naziv AS osEBA,o.nAZIV AS oMREŽJE 
FROM RealizacijaPoDobaviteljih r JOIN Oseba o ON R.SistemskiOperaterID=o.OsebaID AND O.DatumSpremembe IS NULL
JOIN Oseba O2 ON o2.OsebaID = R.oSEBAid AND O2.DatumSpremembe IS NULL
WHERE ObracunID = 10  AND  Interval = '2012-11-01 04:00:00' AND R.OsebaID=49

select * from PodatkiObracuna where ObracunID=10 and OsebaID in (49,34)  AND  Interval = '2012-11-01 04:00:00'

select * from RealizacijaPoBPS where ObracunID=10 and OsebaID in (58,34)  AND  Interval = '2012-11-01 04:00:00'
select * from RealizacijaPoBS where ObracunID=10 and OsebaID in (49)  AND  Interval = '2012-11-01 04:00:00'




SELECT R.Interval, r.Kolicina,r.Oddaja,r.Odjem,o2.Naziv AS osEBA,o.nAZIV AS oMREŽJE 
FROM RealizacijaPoDobaviteljih r JOIN Oseba o ON R.SistemskiOperaterID=o.OsebaID AND O.DatumSpremembe IS NULL and GETDATE() between O.VeljaOd and isnull(O.VeljaDo,DATEADD(year,10,getdate()))
JOIN Oseba O2 ON o2.OsebaID = R.oSEBAid AND O2.DatumSpremembe IS NULL and GETDATE() between O2.VeljaOd and isnull(O2.VeljaDo,DATEADD(year,10,getdate()))
WHERE ObracunID = 10  AND  Interval < '2012-11-01 10:00:00'-- AND R.OsebaID=34
order by Interval,o2.Naziv

