
IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_DownloadALL]')
                    AND type IN ( N'P', N'PC' ) ) 
    DROP PROCEDURE [dbo].[BilnacniObracun_DownloadALL]
GO


CREATE PROCEDURE [dbo].[BilnacniObracun_DownloadALL]
    @ObracunID INT,
    @stanje DATETIME
AS 
    BEGIN
        SET nocount ON 

        DECLARE @dt DATETIME
        DECLARE @tVelja DATETIME
        SELECT  @dt = datumvnosa,
                @tVelja = velja
        FROM    Obracun
        WHERE   ObracunID = @ObracunID

-- dobimo vse nazive in id-e.
        IF OBJECT_ID('tempdb..#tOseba') IS NOT NULL 
            DROP TABLE #tOseba            
        SELECT  s.naziv,
                s.osebaid
        INTO    #tOseba
        FROM    Oseba s
        WHERE   @dt BETWEEN s.DatumVnosa
                    AND     dbo.infinite(s.DatumSpremembe)
                AND @tVelja BETWEEN s.VeljaOd
                            AND     dbo.infinite(s.VeljaDo)
                AND s.OsebaID IN ( SELECT DISTINCT
                                            OsebaID
                                   FROM     podatkiObracuna
                                   WHERE    ObracunID = @ObracunID )
-- dobimo vse nazive in id-e.
        IF OBJECT_ID('tempdb..#tOseba2') IS NOT NULL 
            DROP TABLE #tOseba            
        SELECT  s.naziv,
                s.osebaid
        INTO    #tOseba2
        FROM    Oseba s
        WHERE   @dt BETWEEN s.DatumVnosa
                    AND     dbo.infinite(s.DatumSpremembe)
                AND @tVelja BETWEEN s.VeljaOd
                            AND     dbo.infinite(s.VeljaDo)
                AND s.OsebaID IN ( SELECT DISTINCT
                                            OsebaID
                                   FROM     podatkiObracuna
                                   WHERE    ObracunID = @ObracunID )
   
 -- dobimo vse nazive in id-e.
        IF OBJECT_ID('tempdb..#tOseba3') IS NOT NULL 
            DROP TABLE #tOseba            
        SELECT  s.naziv,
                s.osebaid
        INTO    #tOseba3
        FROM    Oseba s
        WHERE   @dt BETWEEN s.DatumVnosa
                    AND     dbo.infinite(s.DatumSpremembe)
                AND @tVelja BETWEEN s.VeljaOd
                            AND     dbo.infinite(s.VeljaDo)
                AND s.OsebaID IN ( SELECT DISTINCT
                                            OsebaID
                                   FROM     [dbo].[KolicinskaOdstopanjaPoBPS]
                                   WHERE    ObracunID = @ObracunID )
   
        SELECT  s.Naziv AS bs,
                o.OsebaID,
                '1' AS Tip
        FROM    PodatkiObracuna o,
                #tOseba s
        WHERE   ObracunID = @ObracunID
                AND s.osebaid = o.osebaId
        GROUP BY o.OsebaID,
                s.Naziv
        ORDER BY s.Naziv ASC


        SELECT  s.Naziv AS bs,
                o.OsebaID,
                '2' AS Tip
        FROM    [dbo].[KolicinskaOdstopanjaPoBS] o,
                #tOseba2 s
        WHERE   s.OsebaID = o.OsebaID
                AND ObracunID = @ObracunID
                
        GROUP BY o.OsebaID,
                s.Naziv
        ORDER BY s.naziv ASC
    

        SELECT  s.Naziv AS bs,
                o.OsebaID,
                '3' AS Tip
        FROM    KolicinskaOdstopanjaPoBPS o,
                #tOseba3 s
        WHERE   s.OsebaID = o.OsebaID
                AND ObracunID = @ObracunID
                
        GROUP BY o.OsebaID,
                s.Naziv
        ORDER BY s.naziv ASC
  

    END






GO
