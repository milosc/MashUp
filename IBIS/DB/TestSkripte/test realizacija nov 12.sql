SELECT R.Interval, r.Kolicina,r.Oddaja,r.Odjem,o2.Naziv AS osEBA,o.nAZIV AS oMREŽJE 
FROM RealizacijaPoDobaviteljih r JOIN Oseba o ON R.SistemskiOperaterID=o.OsebaID AND O.DatumSpremembe IS NULL and GETDATE() between O.VeljaOd and isnull(O.VeljaDo,DATEADD(year,10,getdate()))
JOIN Oseba O2 ON o2.OsebaID = R.oSEBAid AND O2.DatumSpremembe IS NULL and GETDATE() between O2.VeljaOd and isnull(O2.VeljaDo,DATEADD(year,10,getdate()))
WHERE ObracunID = 11  AND   R.OsebaID=3 and Interval='2012-11-01 01:00:00'
order by Interval,o2.Naziv

SELECT R.Interval, r.Kolicina,r.Oddaja,r.Odjem,o2.Naziv AS osEBA,o.nAZIV AS oMREŽJE 
FROM RealizacijaPoDobaviteljih r JOIN Oseba o ON R.SistemskiOperaterID=o.OsebaID AND O.DatumSpremembe IS NULL and GETDATE() between O.VeljaOd and isnull(O.VeljaDo,DATEADD(year,10,getdate()))
JOIN Oseba O2 ON o2.OsebaID = R.oSEBAid AND O2.DatumSpremembe IS NULL and GETDATE() between O2.VeljaOd and isnull(O2.VeljaDo,DATEADD(year,10,getdate()))
WHERE ObracunID = 11  AND   R.OsebaID in (select distinct Partner2  from Pogodba where ClanBSID=3) and Interval='2012-11-01 01:00:00'
order by Interval,o2.Naziv


select distinct Partner2  from Pogodba where ClanBSID=3

select * from oseba where OsebaID in (select distinct Partner2  from Pogodba where ClanBSID=3
)
