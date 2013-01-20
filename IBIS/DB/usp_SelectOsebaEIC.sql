EXEC dbo.DropPRCorUDF
	@ObjectName = 'usp_SelectOsebaEIC' --  varchar(max)
GO

CREATE PROCEDURE [dbo].[usp_SelectOsebaEIC]
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED


SELECT
	o.[Naziv] + ' | EIC: '+ISNULL(O.[EIC],'') AS Naziv,
	o.[OsebaID],
	ISNULL(O.[EIC],'') AS EIC
FROM
	[dbo].[Oseba] o, [dbo].[OsebaTip] t
WHERE
o.OsebaID = t.OsebaID 
and GETDATE() BETWEEN O.[DatumVnosa] AND dbo.[infinite](o.DatumSpremembe)
and GETDATE() BETWEEN O.[VeljaOd] AND dbo.[infinite](o.[VeljaDo])
and t.OsebaTipID not in (6)
AND LEN(O.EIC) > 5
GROUP BY [Naziv],O.OsebaID	,O.EIC
ORDER BY [Naziv] asc


GO