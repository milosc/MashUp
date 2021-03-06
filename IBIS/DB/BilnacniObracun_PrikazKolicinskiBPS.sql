EXEC [dbo].[DropPRCorUDF] @ObjectName = 'BilnacniObracun_PrikazKolicinskiBPS'
 --  varchar(max)
GO




CREATE PROCEDURE [dbo].[BilnacniObracun_PrikazKolicinskiBPS]
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
        FROM    [dbo].[KolicinskaOdstopanjaPoBPS] P
                 JOIN [dbo].[Oseba] O ON P.[OsebaID] = O.[OsebaID]
                 JOIN [dbo].[Pogodba] D ON D.[Partner2] = O.[OsebaID] AND d.[Nivo] > 1
        WHERE   P.ObracunID = @ID
                AND ( ISNULL(@tVelja,GETDATE()) BETWEEN o.VeljaOd
                              AND     dbo.infinite(o.VeljaDo) )
                AND ( ISNULL(@dt,GETDATE()) BETWEEN o.[DatumVnosa]
                          AND     dbo.infinite(o.DatumSpremembe) )
                AND ( ISNULL(@tVelja,GETDATE()) BETWEEN D.VeljaOd
                              AND     dbo.infinite(D.VeljaDo) )
                AND ( ISNULL(@dt,GETDATE()) BETWEEN D.[DatumVnosa]
                          AND     dbo.infinite(D.DatumSpremembe) )
        GROUP BY p.OsebaID,
                o.Naziv
        ORDER BY o.naziv ASC

    END








GO