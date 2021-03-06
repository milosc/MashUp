EXEC [dbo].[DropPRCorUDF] @ObjectName = '[usp_SelectPPMs]' -- varchar(max)
GO 

CREATE PROCEDURE [dbo].[usp_SelectPPMs]
	@stanje datetime,
	@ppmid int
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT
top (1)
	[ID],
	EIC,
	[PPMID],
	[STOD],
	[SMM],
	[Naziv],
	[PlacnikID],
	[DatumVnosa],
	[SistemskiOperater1],
	[SistemskiOperater2],
	[Dobavitelj1],
	[Dobavitelj2],
	[PPMTipID],
	[MerilnaNapravaID],
	[DatumSpremembe],
	NazivExcel,
	NazivPorocila,
	PlacnikID,
	PPMJeOddaja,
	VrstniRed
FROM
	[dbo].[PPM]
WHERE
	DatumVnosa <= @stanje 
	and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje	
	--and PPMID=@ppmid


--endregion

GO
