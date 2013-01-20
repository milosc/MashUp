
EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_UpdateData_DW'
GO 


CREATE PROCEDURE [dbo].[BilancniObracun_UpdateData_DW]
    (
      @DatumIntervalaDO AS DATETIME ,
      @DatumIntervalaOD AS DATETIME ,
      @DatumStanjaBaze AS DATETIME ,
      @DatumVeljavnostiPodatkov AS DATETIME ,
      @ObracunID AS INT
    )
AS 
    BEGIN


	 DECLARE @BP INT
        DECLARE @PI INT
		DECLARE @VIRT_REGULACIJA INT 
		DECLARE @PO_SIS INT
    
	SELECT  @BP = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'B_POG';
  
        SELECT  @PI = [PogodbaTipID]
        FROM    [PogodbaTip]
        WHERE   Sifra = 'P_IZR';    
		
		SELECT  @VIRT_REGULACIJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(REG) VIRT_REGULACIJA';  

		SELECT  @PO_SIS = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = 'PO_SIS';  

		

		/*Update BS*/
        UPDATE  P
        SET     Odjem = R.Odjem ,
                Oddaja = R.Oddaja ,
                Realizacija = R.Kolicina ,
				VozniRed = ISNULL(T.Kolicina,0) ,
                KoregiranVozniRed = ISNULL(T.KoregiranTP,0)
        FROM    dbo.PodatkiObracuna P
                JOIN [RealizacijaPoBS] R ON P.ObracunID = R.ObracunID
                                            AND P.OsebaID = R.OsebaID
                                            AND P.Interval = R.Interval
                LEFT JOIN dbo.TrzniPlan T ON P.OsebaID = T.OsebaID
                                        AND P.Interval = T.Interval
                                        AND @DatumStanjaBaze BETWEEN T.[DatumVnosa]
                                                             AND
                                                              ISNULL(T.DatumSpremembe,
                                                              DATEADD(YEAR,
                                                              100, GETDATE()))
        WHERE   P.ObracunID = @ObracunID
		 
		/*END - Update BS*/

		/*Update BPS*/
        UPDATE  P
        SET     Odjem = R.Odjem ,
                Oddaja = R.Oddaja ,
                Realizacija = R.Kolicina ,
                VozniRed = ISNULL(T.Kolicina,0) ,
                KoregiranVozniRed = ISNULL(T.KoregiranTP,0)
        FROM    dbo.PodatkiObracuna P
                JOIN [dbo].[RealizacijaPoBPS] R ON P.ObracunID = R.ObracunID
                                                   AND P.OsebaID = R.OsebaID
                                                   AND P.Interval = R.Interval
                LEFT JOIN  dbo.TrzniPlan T ON P.OsebaID = T.OsebaID
                                        AND P.Interval = T.Interval
                                        AND @DatumStanjaBaze BETWEEN T.[DatumVnosa]
                                                             AND
                                                              ISNULL(T.DatumSpremembe,
                                                              DATEADD(YEAR,
                                                              100, GETDATE()))
        WHERE   P.ObracunID = @ObracunID
		 
		/*END - Update BPS*/


		/*Update Regulacija BPS*/
		UPDATE 	P
        SET     SekundarnaRegSm = R.SekRegSm,
				SekundarnaRegSp = R.SekRegSp,
				SekundarnaRegWm = R.SekRegM,
				SekundarnaRegWp = R.SekRegP,
				TercialnaRegSm = R.TerRegSm,
				TercialnaRegSp = R.TerRegSp,
				TercialnaRegWm = R.TerRegM,
				TercialnaRegWp = R.TerRegP
        FROM    dbo.PodatkiObracuna P
				JOIN Pogodba PG ON P.OsebaID = PG.Partner2 AND PG.PogodbaTipID = @PI
				JOIN PPM M ON M.Dobavitelj1 = PG.Partner2 AND M.PPMTipID = @VIRT_REGULACIJA
				JOIN dbo.Regulacija R ON R.PPMID = M.PPMID AND R.Interval = P.Interval  
		WHERE
			P.ObracunID = @ObracunID
		AND  @DatumStanjaBaze BETWEEN PG.[DatumVnosa] AND dbo.infinite(PG.DatumSpremembe) 
        AND  @DatumVeljavnostiPodatkov BETWEEN PG.VeljaOd AND dbo.infinite(PG.VeljaDo)        
		AND  @DatumStanjaBaze BETWEEN M.DatumVnosa AND dbo.infinite(M.DatumSpremembe) 
        AND  @DatumVeljavnostiPodatkov BETWEEN M.VeljaOd AND dbo.infinite(M.VeljaDo) 
		AND  @DatumStanjaBaze BETWEEN R.[DatumVnosa] AND dbo.infinite(R.DatumSpremembe) 
		/*END Update Regulacija BPS*/


		/*Update Regulacija BS*/
		UPDATE 	P
        SET     SekundarnaRegSm = R.SekRegSm,
				SekundarnaRegSp = R.SekRegSp,
				SekundarnaRegWm = R.SekRegM,
				SekundarnaRegWp = R.SekRegP,
				TercialnaRegSm = R.TerRegSm,
				TercialnaRegSp = R.TerRegSp,
				TercialnaRegWm = R.TerRegM,
				TercialnaRegWp = R.TerRegP
        FROM    dbo.PodatkiObracuna P
				JOIN Pogodba PG ON P.OsebaID = PG.Partner2 AND PG.PogodbaTipID = @BP
				JOIN PPM M ON M.Dobavitelj1 = PG.Partner2 AND M.PPMTipID = @VIRT_REGULACIJA
				JOIN dbo.Regulacija R ON R.PPMID = M.PPMID AND R.Interval = P.Interval  
		WHERE
			P.ObracunID = @ObracunID
		AND  @DatumStanjaBaze BETWEEN PG.[DatumVnosa] AND dbo.infinite(PG.DatumSpremembe) 
        AND  @DatumVeljavnostiPodatkov BETWEEN PG.VeljaOd AND dbo.infinite(PG.VeljaDo)        
		AND  @DatumStanjaBaze BETWEEN M.DatumVnosa AND dbo.infinite(M.DatumSpremembe) 
        AND  @DatumVeljavnostiPodatkov BETWEEN M.VeljaOd AND dbo.infinite(M.VeljaDo) 
		AND  @DatumStanjaBaze BETWEEN R.[DatumVnosa] AND dbo.infinite(R.DatumSpremembe) 
		
		/*END Update Regulacija BS*/

	
		/*Update Izravnava BPS*/
		UPDATE 	P
        SET     SistemskaIzravnavaSm = R.Sm,
				SistemskaIzravnavaSp = R.Sp,
				SistemskaIzravnavaWm = R.Wm,
				SistemskaIzravnavaWp = R.Wp
        FROM    dbo.PodatkiObracuna P
				JOIN Pogodba PG ON P.OsebaID = PG.Partner2 AND PG.PogodbaTipID = @PI
				JOIN PPM M ON M.Dobavitelj1 = PG.Partner2 AND M.PPMTipID = @PO_SIS
				JOIN dbo.Izravnava R ON R.OsebaID = M.PPMID AND R.Interval = P.Interval  
		WHERE
			P.ObracunID = @ObracunID
		AND  @DatumStanjaBaze BETWEEN PG.[DatumVnosa] AND dbo.infinite(PG.DatumSpremembe) 
        AND  @DatumVeljavnostiPodatkov BETWEEN PG.VeljaOd AND dbo.infinite(PG.VeljaDo)        
		AND  @DatumStanjaBaze BETWEEN M.DatumVnosa AND dbo.infinite(M.DatumSpremembe) 
        AND  @DatumVeljavnostiPodatkov BETWEEN M.VeljaOd AND dbo.infinite(M.VeljaDo) 
		AND  @DatumStanjaBaze BETWEEN R.[DatumVnosa] AND dbo.infinite(R.DatumSpremembe) 
		/*END Update Regulacija BPS*/


		/*Update Izravnava BS*/
		UPDATE 	P
        SET     SistemskaIzravnavaSm = R.Sm,
				SistemskaIzravnavaSp = R.Sp,
				SistemskaIzravnavaWm = R.Wm,
				SistemskaIzravnavaWp = R.Wp
        FROM    dbo.PodatkiObracuna P
				JOIN Pogodba PG ON P.OsebaID = PG.Partner2 AND PG.PogodbaTipID = @BP
				JOIN PPM M ON M.Dobavitelj1 = PG.Partner2 AND M.PPMTipID = @PO_SIS
				JOIN dbo.Izravnava R ON R.OsebaID = M.PPMID AND R.Interval = P.Interval  
		WHERE
			P.ObracunID = @ObracunID
		AND  @DatumStanjaBaze BETWEEN PG.[DatumVnosa] AND dbo.infinite(PG.DatumSpremembe) 
        AND  @DatumVeljavnostiPodatkov BETWEEN PG.VeljaOd AND dbo.infinite(PG.VeljaDo)        
		AND  @DatumStanjaBaze BETWEEN M.DatumVnosa AND dbo.infinite(M.DatumSpremembe) 
        AND  @DatumVeljavnostiPodatkov BETWEEN M.VeljaOd AND dbo.infinite(M.VeljaDo) 
		AND  @DatumStanjaBaze BETWEEN R.[DatumVnosa] AND dbo.infinite(R.DatumSpremembe) 
		
		
		/*END Update Izravnava BS*/

		/*AGREGIRAJ UP*/
		UPDATE 	P
        SET     P.SistemskaIzravnavaSm = P.SistemskaIzravnavaSm+P2.SistemskaIzravnavaSm,
				P.SistemskaIzravnavaSp = P.SistemskaIzravnavaSp+P2.SistemskaIzravnavaSp,
				P.SistemskaIzravnavaWm = P.SistemskaIzravnavaWm+P2.SistemskaIzravnavaWm,
				P.SistemskaIzravnavaWp = P.SistemskaIzravnavaWp+P2.SistemskaIzravnavaWp,
				P.SekundarnaRegSm = P.SekundarnaRegSm+P2.SekundarnaRegSm,
				P.SekundarnaRegSp = P.SekundarnaRegSp+P2.SekundarnaRegSp,
				P.SekundarnaRegWm = P.SekundarnaRegWm+P2.SekundarnaRegWm,
				P.SekundarnaRegWp = P.SekundarnaRegWp+P2.SekundarnaRegWp,
				P.TercialnaRegSm = P.TercialnaRegSm+P2.TercialnaRegSm,
				P.TercialnaRegSp = P.TercialnaRegSp+P2.TercialnaRegSp,
				P.TercialnaRegWm = P.TercialnaRegWm+P2.TercialnaRegWm,
				P.TercialnaRegWp = P.TercialnaRegWp+P2.TercialnaRegWp
        FROM    dbo.PodatkiObracuna P
				JOIN Pogodba PG ON P.OsebaID = PG.Partner2 AND PG.PogodbaTipID = @BP
				JOIN dbo.PodatkiObracuna P2 ON P.Interval = P2.Interval 
				JOIN Pogodba PG2 ON P2.OsebaID = PG2.Partner2 AND PG2.PogodbaTipID = @PI AND PG2.ClanBSID = P.OsebaID
		WHERE
			 P.ObracunID = @ObracunID
		AND  @DatumStanjaBaze BETWEEN PG.[DatumVnosa] AND dbo.infinite(PG.DatumSpremembe) 
        AND  @DatumVeljavnostiPodatkov BETWEEN PG.VeljaOd AND dbo.infinite(PG.VeljaDo)        
		AND  @DatumStanjaBaze BETWEEN PG2.[DatumVnosa] AND dbo.infinite(PG2.DatumSpremembe) 
        AND  @DatumVeljavnostiPodatkov BETWEEN PG2.VeljaOd AND dbo.infinite(PG2.VeljaDo)  
		/*END Agregiraj UP*/

    
    END    