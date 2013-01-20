--update PPM SET  VeljaOd = '2012-07-25' where ID=1092
update PPM SET  VeljaOd = '2011-12-30' where ID=1092
update PPM SET  VeljaOd = '2012-01-01', VeljaDo='2012-07-24' where ID=1091


update Pogodba SET VeljaDo=NULL where ID=8817
update Pogodba SET VeljaDo='2012-07-24' where ID in (8797,8668)