/****** Object:  StoredProcedure [dbo].[TreeViewOSSNodeRootOsebe]    Script Date: 03/11/2012 21:58:16 ******/
IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'[dbo].[TreeViewOSSNodeRootOsebe]')
                    AND type IN ( N'P', N'PC' ) ) 
    DROP PROCEDURE [dbo].[TreeViewOSSNodeRootOsebe]
GO


CREATE PROCEDURE [dbo].[TreeViewOSSNodeRootOsebe]
    @OsebaID INT,
    @OsebaTip INT,
    @stanje DATETIME
AS 
    BEGIN
        SET NOCOUNT ON ;

        SELECT  o.OsebaID AS vrednost,
                o.kratica AS naziv
        FROM    Oseba o
        WHERE   o.DatumVnosa <= @stanje
                AND ISNULL(o.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje
                AND CAST(@stanje AS DATE) BETWEEN CAST(o.VeljaOd AS DATE)
                                          AND     CAST(ISNULL(o.VeljaDo, DATEADD(year, 100, GETDATE())) AS DATE)
                AND o.OsebaID IN ( SELECT   OsebaID
                                   FROM     OsebaTip
                                   WHERE    OsebaTipID = @OsebaTip ) ;
    END


GO
