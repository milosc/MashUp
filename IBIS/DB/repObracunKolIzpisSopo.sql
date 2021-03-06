EXEC [dbo].[DropPRCorUDF] @ObjectName = 'repObracunKolIzpisSopo' 
GO

--exec repObracunKolIzpisSopo 254, 9, '2012-10-29', '2012-01-01', '2012-01-31'
--exec repObracunKolIzpisSopo 254, 48, '2012-10-29', '2012-01-01', '2012-01-31'

CREATE PROCEDURE [dbo].[repObracunKolIzpisSopo]
    (
      @ObracunId INT,
      @osebaId INT,
      @StanjeNaDan DATETIME,
      @VeljaOd DATETIME,
      @VeljaDo DATETIME
    )
AS 
    BEGIN
        DECLARE @VIRT_ELES_MERITVE INT ;
    
        SELECT  @VIRT_ELES_MERITVE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SOPO) VIRT_ELES_MERITVE' ;

        SET nocount ON
        DECLARE @dvp DATETIME 
        
        SELECT  @dvp = velja
        FROM    Obracun
        WHERE   ObracunID = @ObracunId

        DECLARE @velja DATETIME
        SET @velja = @dvp  -- predpostavka, da je ta datum znotraj intervala, raba za filter ppm.

        DECLARE @tPoint DATETIME 
        SET @tPoint = @StanjeNaDan

        DECLARE @vseOsebe TABLE ( id INT ) 
                


        INSERT  INTO @vseOsebe ( id )
                SELECT  P.Partner2
                FROM    dbo.Pogodba P
                        JOIN dbo.Oseba O ON P.Partner2 = O.OsebaID
                WHERE   P.NadrejenaOsebaID = @osebaId
                        AND @tPoint BETWEEN P.DatumVnosa
                                    AND     dbo.infinite(P.DatumSpremembe)
                        AND @tPoint BETWEEN P.VeljaOd
                                    AND     dbo.infinite(P.VeljaDo)
                        AND @tPoint BETWEEN O.DatumVnosa
                                    AND     dbo.infinite(O.DatumSpremembe)
                        AND @tPoint BETWEEN O.VeljaOd
                                    AND     dbo.infinite(O.VeljaDo)

	
        DECLARE @fInterval DATETIME
        SELECT  @fInterval = veljaOd
        FROM    obracunskoObdobje
        WHERE   obracunskoObdobjeId = ( SELECT  ObracunskoObdobjeId
                                        FROM    Obracun
                                        WHERE   ObracunID = @obracunid
                                      )
        SET @fInterval = DATEADD(hour, 1, @fInterval)

-- poiscemo vse veljavne PPM za to obdobje v meritvah. 
        DECLARE @ppmMer TABLE ( id INT )
        INSERT  INTO @ppmMer
                SELECT DISTINCT
                        ppmid AS ppmidVmer
                FROM    view_Meritve
                WHERE   @tPoint BETWEEN DatumVnosa
                                AND     dbo.infinite(DatumSpremembe)
                        AND Interval = @fInterval
                        AND PPMID IN ( SELECT   ppmid
                                       FROM     PPM
                                       WHERE    PPMTipID = @VIRT_ELES_MERITVE )


        DECLARE @tppm TABLE
            (
              id INT,
              naziv VARCHAR(50),
              jeOddaja BIT
            )
        INSERT  INTO @tppm
                SELECT  PPMID,
                        NazivPorocila,
                        PPMJeOddaja
                FROM    ppm
                WHERE   ppmid IN ( SELECT   *
                                   FROM     @ppmMer )
                        AND Dobavitelj1 IN ( SELECT *
                                             FROM   @vseOsebe )
                        AND @tPoint BETWEEN DatumVnosa
                                    AND     dbo.infinite(datumSpremembe)
                        AND @velja BETWEEN veljaOd AND dbo.infinite(veljaDo)

        SELECT  p.naziv AS Naziv,
                vm.interval AS Interval,
                CASE WHEN p.jeOddaja = 1 THEN -vm.kolicina
                     ELSE vm.Kolicina
                END AS Realizacija
        FROM    @tppm p
                INNER JOIN ( SELECT *
                             FROM   view_meritve
                             WHERE  @tPoint BETWEEN DatumVnosa
                                            AND     dbo.infinite(DatumSpremembe)
                                    AND Interval BETWEEN @VeljaOd AND @VeljaDo
                           ) vm ON p.id = vm.PPMID
        ORDER BY vm.Interval ASC

    END

GO