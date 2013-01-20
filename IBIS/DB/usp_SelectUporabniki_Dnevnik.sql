EXEC dbo.DropPRCorUDF	@ObjectName = 'usp_SelectUporabniki_Dnevnik' --  varchar(max)
GO

CREATE PROCEDURE [dbo].[usp_SelectUporabniki_Dnevnik] @stanje DATETIME
AS 
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    SELECT  
            u.UporabnikID,
            '(' + ISNULL(u.UporabniskoIme, '/') + ')' + ' ' + ISNULL(u.Ime, '')
            + ISNULL(u.Priimek, '') AS naziv
    FROM    Uporabnik u
            INNER JOIN Oseba o ON u.OsebaID = o.OsebaID
    WHERE   U.DatumSpremembe IS NULL
            AND O.DatumSpremembe IS NULL


GO