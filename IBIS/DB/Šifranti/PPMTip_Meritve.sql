DECLARE @MaxID INT;
SELECT @MaxID = MAX(PPMTipID)+1 FROM dbo.PPMTip


INSERT INTO dbo.PPMTip (
	PPMTipID,
	Naziv,
	Virtualen,
	VrstniRedExcelUvoz
) VALUES ( 
	@MaxID,
	'MEJE',
	1,
	0 ) 
