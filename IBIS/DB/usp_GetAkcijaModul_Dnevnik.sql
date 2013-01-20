EXEC dbo.DropPRCorUDF	@ObjectName = 'usp_GetAkcijaModul_Dnevnik' 
GO

CREATE PROCEDURE [dbo].[usp_GetAkcijaModul_Dnevnik] 
AS 
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	

    SELECT L.Modul,
		   L.Modul AS Naziv
    FROM dbo.LogAkcija L
    GROUP BY L.Modul
	ORDER BY 1 asc


GO