EXEC dbo.DropPRCorUDF
	@ObjectName = 'usp_SelectOsebaPPMFilter' --  varchar(max)
GO

CREATE PROCEDURE [dbo].[usp_SelectOsebaPPMFilter]
	
	
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED


SELECT
	o.[Naziv],
	o.[OsebaID]
	
FROM
	[dbo].[Oseba] o, [dbo].[OsebaTip] t
WHERE
o.OsebaID = t.OsebaID 
and o.DatumSpremembe IS NULL
and t.OsebaTipID not in (6)
GROUP BY [Naziv],O.OsebaID	
ORDER BY [Naziv] asc


GO