EXEC dbo.DropPRCorUDF	@ObjectName = 'usp_GetAkcijaTip_Dnevnik' 
GO

CREATE PROCEDURE [dbo].[usp_GetAkcijaTip_Dnevnik] 
AS 
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    SELECT L.LogID,
		   L.Akcija
    FROM dbo.LogAkcija L
	ORDER BY Akcija asc


GO