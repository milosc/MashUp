EXEC dbo.DropPRCorUDF @ObjectName = 'usp_SelectLog' 
GO

CREATE  PROCEDURE [dbo].[usp_SelectLog]
    @UserID INT,
    @LogActionID INT,
    @OsebaID INT,
    @Modul VARCHAR(100),
    @DatumOd DATE,
    @DatumDo DATE,
    @Dostop VARCHAR(1) = NULL
AS 
    BEGIN

        SET NOCOUNT ON
        SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

        SELECT TOP 5000
                L.ID,
                L.LogID,
                L.naslov,
                a.Modul,
                a.Akcija,
                a.LogID,
                L.UporabnikID,
                u.UporabniskoIme,
                L.DatumVnosa,
                o.Naziv,
                L.opis,
                o.OsebaID
        FROM    dbo.[Log] L
                LEFT JOIN dbo.Uporabnik u ON u.UporabnikID = L.UporabnikID
                                             AND u.DatumSpremembe IS NULL
                LEFT JOIN dbo.Oseba o ON u.OsebaID = o.OsebaID
                                         AND o.DatumSpremembe IS NULL
                LEFT JOIN dbo.LogAkcija a ON L.LogID = a.LogID
        WHERE   ( @UserID = 0
                  OR L.UporabnikID = @UserID
                )
                AND ( @LogActionID = '0'
                      OR L.LogId = @LogActionID
                    )
                 AND ( @OsebaID = '0'
                      OR u.OsebaID = @OsebaID
                    )
                  AND ( @Modul = '0'
                      OR a.Modul = @Modul
                    )
                 AND (@DatumOd IS NULL OR CAST(L.DatumVnosa AS date) >=@DatumOd)
                 AND (@DatumDo IS NULL OR CAST(L.DatumVnosa AS date) <= @DatumDo)
                 AND (@Dostop = 'V' OR L.Opis LIKE '%Dovoljenjo: '+@Dostop+'%')
        ORDER BY L.DatumVnosa DESC 

    END


GO