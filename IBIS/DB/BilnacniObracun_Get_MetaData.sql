exec DropPRCorUDF 'dbo.BilnacniObracun_Get_MetaData'
GO

CREATE PROCEDURE dbo.BilnacniObracun_Get_MetaData 
(
  @OsebaID AS INT,
  @ObracunID AS INT,
  @Tip AS INT
)
AS 
BEGIN

if (@Tip=1)
begin
	select
	  isnull(OS.EIC,'-') as PartnerID,
	  isnull(OS.Naziv,'-') as Partner_naziv,
	  '/' as Stevilka_dokumenta,
	  convert(varchar, cast(OO.VeljaOd as date), 104)+' - '+convert(varchar, cast(OO.VeljaDo as date), 104) as Obdobje_obracuna,
	  isnull(S.Naziv,'-')  as Status_obracuna,
	  cast(sum(P.Odstopanje) as decimal(19,3)) as Skupaj_odstopanja,
	  cast(sum(P.PoravnavaZnotrajT) as decimal(19,2)) as Skupaj_znesek_osnovnega_obracuna,
	  cast(sum(P.PoravnavaZunajT) as decimal(19,2)) as Skupaj_znesek_penalizacije,
	  cast( sum(P.PoravnavaZunajT+P.PoravnavaZnotrajT) as decimal(19,2)) as Skupaj_obracun
	from Obracun O 
		JOIN PodatkiObracuna P on O.ObracunID = P.ObracunID
		join ObracunskoObdobje OO on O.ObracunskoObdobjeID=OO.ObracunskoObdobjeID
		join ObracunStatus S on O.ObracunStatusID=S.ObracunStatusID
		join Oseba OS on P.OsebaID= OS.OsebaID and OS.OsebaID=@OsebaID and GETDATE() between OS.VeljaOd and isnull(OS.VeljaDo,dateadd(year,100,getdate()))
		and GETDATE() between OS.DatumVnosa and isnull(OS.DatumSpremembe,dateadd(year,100,getdate()))
	WHERE O.ObracunID = @ObracunID
	group by  OS.EIC, OS.Naziv,S.Naziv,convert(varchar, cast(OO.VeljaOd as date), 104)+' - '+convert(varchar, cast(OO.VeljaDo as date), 104)
END
else
if (@Tip=2)
begin
	select
	  isnull(OS.EIC,'-') as PartnerID,
	  isnull(OS.Naziv,'-') as Partner_naziv,
	  '/' as Stevilka_dokumenta,
	  convert(varchar, cast(OO.VeljaOd as date), 104)+' - '+convert(varchar, cast(OO.VeljaDo as date), 104) as Obdobje_obracuna,
	  isnull(S.Naziv,'-')  as Status_obracuna,
	  cast(sum(P.Odstopanje) as decimal(19,3)) as Skupaj_odstopanja,
	  cast(sum(P.PoravnavaZnotrajT) as decimal(19,2)) as Skupaj_znesek_osnovnega_obracuna,
	  cast(sum(P.PoravnavaZunajT) as decimal(19,2)) as Skupaj_znesek_penalizacije,
	  cast( sum(P.PoravnavaZunajT+P.PoravnavaZnotrajT) as decimal(19,2)) as Skupaj_obracun
	from Obracun O 
		JOIN PodatkiObracuna P on O.ObracunID = P.ObracunID
		join ObracunskoObdobje OO on O.ObracunskoObdobjeID=OO.ObracunskoObdobjeID
		join ObracunStatus S on O.ObracunStatusID=S.ObracunStatusID
		join Oseba OS on P.OsebaID= OS.OsebaID and OS.OsebaID=@OsebaID and GETDATE() between OS.VeljaOd and isnull(OS.VeljaDo,dateadd(year,100,getdate()))
		and GETDATE() between OS.DatumVnosa and isnull(OS.DatumSpremembe,dateadd(year,100,getdate()))
	WHERE O.ObracunID = @ObracunID
	group by  OS.EIC, OS.Naziv,S.Naziv,convert(varchar, cast(OO.VeljaOd as date), 104)+' - '+convert(varchar, cast(OO.VeljaDo as date), 104)
END
else
if (@Tip=3)
begin
	select
	  isnull(OS.EIC,'-') as PartnerID,
	  isnull(OS.Naziv,'-') as Partner_naziv,
	  '/' as Stevilka_dokumenta,
	  convert(varchar, cast(OO.VeljaOd as date), 104)+' - '+convert(varchar, cast(OO.VeljaDo as date), 104) as Obdobje_obracuna,
	  isnull(S.Naziv,'-')  as Status_obracuna,
	  cast(sum(P.Odstopanje) as decimal(19,3)) as Skupaj_odstopanja,
	  cast(0 as decimal(19,2)) as Skupaj_znesek_osnovnega_obracuna,
	  cast(0 as decimal(19,2)) as Skupaj_znesek_penalizacije,
	  cast(0 as decimal(19,2)) as Skupaj_obracun
	from Obracun O 
		JOIN KolicinskaOdstopanjaPoBPS P on O.ObracunID = P.ObracunID
		join ObracunskoObdobje OO on O.ObracunskoObdobjeID=OO.ObracunskoObdobjeID
		join ObracunStatus S on O.ObracunStatusID=S.ObracunStatusID
		join Oseba OS on P.OsebaID= OS.OsebaID and OS.OsebaID=@OsebaID and GETDATE() between OS.VeljaOd and isnull(OS.VeljaDo,dateadd(year,100,getdate()))
		and GETDATE() between OS.DatumVnosa and isnull(OS.DatumSpremembe,dateadd(year,100,getdate()))
	WHERE O.ObracunID = @ObracunID
	group by  OS.EIC, OS.Naziv,S.Naziv,convert(varchar, cast(OO.VeljaOd as date), 104)+' - '+convert(varchar, cast(OO.VeljaDo as date), 104)
END

END