EXEC [dbo].[DropPRCorUDF] @ObjectName = 'BilnacniObracun_PrikazPoBS'
GO



CREATE PROCEDURE [dbo].[BilnacniObracun_PrikazPoBS]
	-- Add the parameters for the stored procedure here
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
                    AND    ISNULL(s.DatumSpremembe,  DATEADD(YEAR, 1000, GETDATE())) 
                AND ISNULL(@tVelja,GETDATE()) BETWEEN s.VeljaOd
                            AND    ISNULL(s.VeljaDo,  DATEADD(YEAR, 1000, GETDATE())) 
                AND s.OsebaId <> 46
                AND s.OsebaID IN ( SELECT 
                                            OsebaID
                                   FROM     PodatkiObracuna
                                   WHERE    ObracunID = @ObracunID
											AND DATEPART(DAY,[Interval]) = 01 AND DATEPART(HOUR,Interval) = 01
                                   GROUP BY [OsebaID]
                                   )



        SELECT  s.Naziv AS bs,
                o.OsebaID AS BilancnaSkupina,
                CAST(SUM(Odstopanje) AS DECIMAL(18, 3)) AS odstopanje,
                CAST(SUM(isnull(o.PoravnavaZunajT,0) + ISNULL(o.PoravnavaZnotrajT,0)) AS DECIMAL(18, 2)) AS stroski
        FROM    PodatkiObracuna o JOIN #tOseba s ON s.osebaid = o.osebaId
        WHERE   o.ObracunID = @ObracunID
        GROUP BY o.OsebaID, s.Naziv
        ORDER BY s.Naziv ASC

    END


GO