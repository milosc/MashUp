EXEC [dbo].[DropPRCorUDF] @ObjectName = 'BilnacniObracun_PrikazKolicinski'
 --  varchar(max)
GO


CREATE PROCEDURE [dbo].[BilnacniObracun_PrikazKolicinski]
    @ID INT,
    @stanje DATETIME
AS 
    BEGIN
        SET nocount ON
        DECLARE @dt DATETIME

        DECLARE @tVelja DATETIME
        SELECT  @dt = datumvnosa,
                @tVelja = velja
        FROM    Obracun
        WHERE   ObracunID = @ID

        SELECT  o.Naziv AS bs,
                P.OsebaID AS BilancnaSkupina,
                CAST(SUM(P.[Odstopanje]) AS DECIMAL(18, 3)) AS odstopanje
        FROM    [dbo].[PodatkiObracuna] P
                JOIN [dbo].[Oseba] O ON P.[OsebaID] = O.[OsebaID]
                JOIN [dbo].[Pogodba] D ON D.[Partner2] = O.[OsebaID]
                                          AND D.[Nivo] = 1
        WHERE   P.ObracunID = @ID
                AND ( @tVelja BETWEEN o.VeljaOd
                              AND     ISNULL(o.VeljaDo,
                                             DATEADD(YEAR, 1000, GETDATE())) )
                AND ( @dt BETWEEN o.[DatumVnosa]
                          AND     ISNULL(o.DatumSpremembe,
                                         DATEADD(YEAR, 1000, GETDATE())) )
                AND ( @tVelja BETWEEN D.VeljaOd
                              AND     ISNULL(D.VeljaDo,
                                             DATEADD(YEAR, 1000, GETDATE())) )
                AND ( @dt BETWEEN D.[DatumVnosa]
                          AND     ISNULL(D.DatumSpremembe,
                                         DATEADD(YEAR, 1000, GETDATE())) )
        GROUP BY p.OsebaID,
                o.Naziv
        ORDER BY bs ASC

    END






GO