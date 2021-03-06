EXEC dbo.DropPRCorUDF
	@ObjectName = 'sp_SelectPPMIzbran' --  varchar(max)
GO

CREATE PROCEDURE [dbo].[sp_SelectPPMIzbran]
  @stanje  datetime,
  @ID int	
AS
BEGIN

-- dodan start
IF OBJECT_ID('tempdb..#tmp1') IS NOT NULL  drop table #tmp1
SELECT distinct OSS.OsebaID,
OSS.Naziv + ' (' + OSTI.Naziv + ')' as Naziv
into #tmp1
from Oseba OSS
INNER JOIN OsebaTip OST ON OST.OsebaID=OSS.OsebaID  AND OST.DatumVnosa <= @stanje and ISNULL(OST.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
INNER JOIN OsebaTipID OSTI ON OSTI.OsebaTipID=OST.OsebaTipID 
WHERE
(OST.OsebaTipID=1 OR OST.OsebaTipID=2)
AND OSS.DatumVnosa <= @stanje and ISNULL(OSS.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
ORDER BY Naziv ASC

IF OBJECT_ID('tempdb..#tmp2') IS NOT NULL  drop table #tmp2
SELECT o.ID,o.OsebaID, o.Naziv into #tmp2 from Oseba o 
where o.id = (select max(id) from oseba o1 where o1.osebaid = o.osebaid and
o1.DatumVnosa <= @stanje and dbo.infinite(o1.DatumSpremembe) >= @stanje )
Order by o.OsebaID ASC,o.VeljaOd desc

--dodan end.

Select 
    p.ID,
	p.PPMID,
	P.EIC,
	p.STOD,
	p.SMM,
	p.Naziv,
	p.PlacnikID,
	p.DatumVnosa,
	p.SistemskiOperater1,
	p.SistemskiOperater2,
	p.Dobavitelj1,
	p.Dobavitelj2,
	p.PPMTipID,
	p.MerilnaNapravaID,
	p.DatumSpremembe,
	p.NazivExcel,
	p.NazivPorocila,
	p.PlacnikID,
	p.PPMJeOddaja,
	p.VrstniRed,
	p.VeljaOd,
	p.VeljaDo,
	o.Naziv as nazivSOPO,
	d.Naziv as nazivDobav,
	tip.Naziv as tipPPM
from PPM p, #tmp1 o, #tmp2 d, PPMTip tip
WHERE
p.ID = @ID and
 p.DatumVnosa <= @stanje 
	and ISNULL(p.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
 and p.SistemskiOperater1 = o.OsebaID
 and p.Dobavitelj1 = d.OsebaID 
 and p.PPMTipID = tip.PPMTipID

end

GO
