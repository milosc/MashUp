EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"


SELECT * FROM PPM ORDER BY 1 asc

TRUNCATE TABLE PPM

INSERT INTO [dbo].[PPM] (
	[ID],
	[PPMID],
	[STOD],
	[SMM],
	[Naziv],
	[VrstniRed],
	[NazivExcel],
	[NazivPorocila],
	[PlacnikID],
	[LastnikID],
	[SistemskiOperater1],
	[SistemskiOperater2],
	[Dobavitelj1],
	[Dobavitelj2],
	[PPMTipID],
	[MerilnaNapravaID],
	[PPMJeOddaja],
	[VeljaOd],
	[VeljaDo],
	[DatumVnosa],
	[DatumSpremembe]
) 
SELECT
[ID],
	[PPMID],
	[STOD],
	[SMM],
	[Naziv],
	[VrstniRed],
	[NazivExcel],
	[NazivPorocila],
	[PlacnikID],
	[LastnikID],
	[SistemskiOperater1],
	[SistemskiOperater2],
	[Dobavitelj1],
	[Dobavitelj2],
	[PPMTipID],
	[MerilnaNapravaID],
	[PPMJeOddaja],
	[VeljaOd],
	[VeljaDo],
	[DatumVnosa],
	[DatumSpremembe]
	FROM PPMNEW

SELECT * FROM PPM ORDER BY 1 ASC


exec sp_msforeachtable @command1="print '?'", @command2="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"



update PPM SET DatumSpremembe = '20120726' where ID =1181

