EXEC [dbo].[DropPRCorUDF] @ObjectName = 'sp_OsebaPoglejCeObstajajoPodatki'
 --  varchar(max)
GO

CREATE PROCEDURE [dbo].[sp_OsebaPoglejCeObstajajoPodatki]
    @OsebaID INT,
    @stanje DATETIME
AS 
    BEGIN
--potrebno je pogledat ce obstajajo podatki za izbrano osebo oz. 
--ce je ze narajen obracun za osebo
-- ce DA potem ne smemo dovolit birsanja za osebo
        DECLARE @skupaj INT
        DECLARE @ret INT
        SET @ret = 0 

        DECLARE @st1 INT
        DECLARE @st2 INT
        DECLARE @st3 INT
        DECLARE @st4 INT
        DECLARE @st5 INT
        DECLARE @st6 INT
        DECLARE @st7 INT
        DECLARE @st8 INT
        DECLARE @st9 INT
        DECLARE @st10 INT
        DECLARE @stPodzaPPM INT
        DECLARE @stIzpadi INT
        DECLARE @stIzravnava INT
        DECLARE @stTrzniPlan INT
        DECLARE @stRegulacija INT

        SELECT TOP 10
                OsebaID
        FROM    View_KolicinskaOdstopanja
        WHERE   OsebaID = @OsebaID

        SELECT  @st1 = @@ROWCOUNT

        SELECT TOP 10
                OsebaID
        FROM    Obracun_PodatkiPoracuna
        WHERE   OsebaID = @OsebaID

        SELECT  @st2 = @@ROWCOUNT

        SELECT TOP 10
                OsebaID
        FROM    Obracun_PodatkiPoracunaVrstice
        WHERE   OsebaID = @OsebaID

        SELECT  @st3 = @@ROWCOUNT

        SELECT TOP 10
                OsebaID
        FROM    PodatkiObracuna
        WHERE   OsebaID = @OsebaID

        SELECT  @st4 = @@ROWCOUNT

        SELECT TOP 10
                OsebaID
        FROM    PreostaliOdjem
        WHERE   OsebaID = @OsebaID

        SELECT  @st5 = @@ROWCOUNT

        SELECT TOP 10
                OsebaID
        FROM    RealizacijaPoBPS
        WHERE   OsebaID = @OsebaID

        SELECT  @st6 = @@ROWCOUNT

        SELECT TOP 10
                OsebaID
        FROM    RealizacijaPoBS
        WHERE   OsebaID = @OsebaID

        SELECT  @st7 = @@ROWCOUNT

        SELECT TOP 10
                OsebaID
        FROM    RealizacijaPoDobaviteljih
        WHERE   OsebaID = @OsebaID

        SELECT  @st8 = @@ROWCOUNT

        SELECT TOP 10
                OsebaID
        FROM    RealizacijaPoSo
        WHERE   OsebaID = @OsebaID

        SELECT  @st9 = @@ROWCOUNT

        SELECT TOP 10
                OsebaID
        FROM    TolerancniPas
        WHERE   OsebaID = @OsebaID

        SELECT  @st10 = @@ROWCOUNT

        SELECT TOP 10
                OsebaID
        FROM    Izpadi
        WHERE   OsebaID = @OsebaID

        SELECT  @stIzpadi = @@ROWCOUNT
		
        DECLARE @PPMTIPPOS_SIS INT ;
        SELECT  @PPMTIPPOS_SIS = PPMTIPID
        FROM    dbo.PPMTip
        WHERE   Naziv = 'PO_SIS'

        SELECT TOP 10
                OsebaID
        FROM    Izravnava
        WHERE   OsebaID IN (
                SELECT DISTINCT
                        PPMID
                FROM    Oseba o
                        INNER JOIN PPM p ON o.OsebaID = p.Dobavitelj1
                                            AND p.PPMTipID = @PPMTIPPOS_SIS
                WHERE   o.OsebaID = @OsebaID )	
        
        --= @OsebaID

        SELECT  @stIzravnava = @@ROWCOUNT

        SELECT TOP 10
                OsebaID
        FROM    TrzniPlan
        WHERE   OsebaID = @OsebaID

        SELECT  @stTrzniPlan = @@ROWCOUNT

--tu preverimo ce izbrano osebo za dane PPMje so ze bili narejeni uvozi podatkov
        SELECT  @stPodzaPPM = COUNT(PPMID)
        FROM    view_Meritve
        WHERE   PPMID IN (
                SELECT DISTINCT
                        PPMID
                FROM    Oseba o
                        INNER JOIN PPM p ON o.OsebaID = p.SistemskiOperater1
                                            OR o.OsebaID = p.Dobavitelj1
                WHERE   o.OsebaID = @OsebaID )

        SELECT  @stRegulacija = COUNT(PPMID)
        FROM    Regulacija
        WHERE   PPMID IN (
                SELECT DISTINCT
                        PPMID
                FROM    Oseba o
                        INNER JOIN PPM p ON o.OsebaID = p.SistemskiOperater1
                                            OR o.OsebaID = p.Dobavitelj1
                        INNER JOIN PPMTip pt ON p.PPMTipID = pt.PPMTipID
                WHERE   o.OsebaID = @OsebaID
                        AND pt.PPMTipID = 6 --tip 6 je za regulacijo
	)

        SET @skupaj = @st1 + @st2 + @st3 + @st3 + @st4 + @st5 + @st6 + @st7
            + @st8 + @st9 + @st10 + @stPodzaPPM + @stIzpadi + @stIzravnava
            + @stTrzniPlan + @stRegulacija

        IF ( @skupaj > 0 ) 
            BEGIN
				--neki podatki obstajajo za osebo
                SET @ret = 1
                RETURN @ret
            END
        ELSE 
            BEGIN
				--zanekrat ne obstajajo nobeni podatki  za osebo bomo dovolili brisanje
                SET @ret = 0
                RETURN @ret
            END


    END
GO
