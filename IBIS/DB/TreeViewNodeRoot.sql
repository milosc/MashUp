/****** Object:  StoredProcedure [dbo].[TreeViewNodeRoot]    Script Date: 03/11/2012 21:58:16 ******/
IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'[dbo].[TreeViewNodeRoot]')
                    AND type IN ( N'P', N'PC' ) ) 
    DROP PROCEDURE [dbo].[TreeViewNodeRoot]
GO


CREATE PROCEDURE [dbo].[TreeViewNodeRoot]
	-- Add the parameters for the stored procedure here
    @stanje DATETIME
AS 
    BEGIN
        SET NOCOUNT ON ;

    -- izbor childs v bilancni shemi
        SELECT DISTINCT
                p.partner1 AS vrednost,
                o.kratica AS naziv
        FROM    Pogodba p,
                Oseba o
        WHERE   o.OsebaID = p.partner1
                AND p.nivo = 1
                AND p.DatumVnosa <= @stanje
                AND ISNULL(p.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje
                AND o.DatumVnosa <= @stanje
                AND ISNULL(o.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje
                AND CAST(@stanje AS DATE) BETWEEN CAST(o.VeljaOd AS DATE)
                                          AND     CAST(ISNULL(o.VeljaDo, DATEADD(year, 100, GETDATE())) AS DATE)
                AND CAST(@stanje AS DATE) BETWEEN CAST(p.VeljaOd AS DATE)
                                          AND     CAST(ISNULL(p.VeljaDo, DATEADD(year, 100, GETDATE())) AS DATE)
    END





GO
