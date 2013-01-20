EXEC dbo.DropPRCorUDF
	@ObjectName = 'usp_SelectPPMEIC' --  varchar(max)
GO

CREATE PROCEDURE [dbo].[usp_SelectPPMEIC]
	
	
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED


SELECT
	[Naziv] + ' | EIC: '+ISNULL([EIC],'') AS Naziv,
	[PPMID],
	ISNULL([EIC],'') AS EIC
FROM
	[dbo].[PPM]
WHERE
DatumSpremembe IS NULL
GROUP BY 	[PPMID],[Naziv],EIC
ORDER BY [Naziv] asc


GO