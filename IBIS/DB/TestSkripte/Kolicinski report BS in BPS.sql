select K.Interval,O.Naziv,K.Kolicina as Realizacija, K.Odstopanje, K.VozniRed,K.KoregiranTP as KoregiranVozniRed,K.Odjem,K.Oddaja
 from KolicinskaOdstopanjaPoBS K join Oseba O on K.OsebaID=O.OsebaID and O.DatumSpremembe is null and getdate() between o.VeljaOD and isnull(O.VeljaDo,dateadd(year,10,Getdate()))
where ObracunID= 11 order by K.OsebaId asc,Interval asc

select K.Interval,O.Naziv,K.Kolicina as Realizacija, K.Odstopanje, K.VozniRed,K.KoregiranTP as KoregiranVozniRed,K.Odjem,K.Oddaja
 from KolicinskaOdstopanjaPoBPS K join Oseba O on K.OsebaID=O.OsebaID and O.DatumSpremembe is null and getdate() between o.VeljaOD and isnull(O.VeljaDo,dateadd(year,10,Getdate()))
where ObracunID= 11 order by K.OsebaId asc,Interval asc