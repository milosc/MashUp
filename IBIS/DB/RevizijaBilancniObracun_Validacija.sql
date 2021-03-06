
EXEC dbo.DropPRCorUDF @ObjectName = 'RevizijaBilancniObracun_Validacija'
GO

CREATE PROCEDURE [dbo].[RevizijaBilancniObracun_Validacija]
    (
      @DatumIntervalaDO AS DATETIME,
      @DatumStanjaBaze AS DATETIME,
      @DatumIntervalaOD AS DATETIME,
      @DatumVeljavnostiPodatkov AS DATETIME,
      @MP_KP_NEMERJENI AS INT,
      @MP_NP_NEMERJENI AS INT,
      @NOErrors AS INT,
      @VIRT_MERJENI_ODJEM AS INT,
      @VIRT_NEMERJEN_ODDAJA AS INT,
      @VIRT_PBI AS INT,
      @VIRT_NEMERJENI_ODJEM AS INT,
      @ErrorHeadXML XML OUTPUT,
      @ErrorDetailsXML XML OUTPUT,
      @ObracunTipID AS INT
    )
AS 
    BEGIN
    
		DECLARE @PO_SIS INT
    
    	SELECT  @PO_SIS = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = 'PO_SIS' ;
        
        DECLARE @Kolicinski_obracun INT
  
        SELECT  @Kolicinski_obracun = [ObracunTipID]
        FROM    [ObracunTip]
        WHERE   [Sifra] = 'K'
  
        DECLARE @ErrorID BIGINT ;
        IF OBJECT_ID('#Errors') IS NOT NULL 
            DROP TABLE #Errors
        
        CREATE TABLE #Errors
            (
              ErrorID BIGINT IDENTITY(1, 1)
                             NOT NULL,
              Napaka VARCHAR(255) NOT NULL
            )

        IF OBJECT_ID('#ErrorDetail') IS NOT NULL 
            DROP TABLE #ErrorDetail
        
        CREATE TABLE #ErrorDetail
            (
              ErrorID BIGINT,
              ErrorDetail VARCHAR(900) NOT NULL
            )



        IF OBJECT_ID('#Validacija') IS NOT NULL 
            DROP TABLE #Validacija

        CREATE TABLE #Validacija
            (
              OsebaID INT,
              Interval DATETIME,
              PreostaliDiagramODJEM DECIMAL(18, 6),
              NormiranPreostaliDiagramODJEMA DECIMAL(18, 6),
              PreostaliDiagramODDAJE DECIMAL(18, 6),
              NormiranPreostaliDiagramODDAJE DECIMAL(18, 6),
              KontrolaPDP DECIMAL(18, 6),
              KontrolaPDO DECIMAL(18, 6)
            )



        IF OBJECT_ID('#SumaValidacija') IS NOT NULL 
            DROP TABLE #SumaValidacija

        CREATE TABLE #SumaValidacija
            (
              OsebaID INT,
              NormiranPPP DECIMAL(18, 6),
              NormiranPPo DECIMAL(18, 6)
            )

			/*TRŽNI PLAN*/
        INSERT  INTO [#Errors] ( [Napaka] )
        VALUES  (
                  'Napaka 00100: Nepopolna sekvenca intervalov za Tržni plan.'
                                
                ) ;
        SET @ErrorID = SCOPE_IDENTITY() ;

        INSERT  INTO [#ErrorDetail]
                (
                  [ErrorID],
                  [ErrorDetail]
                )
                SELECT  @ErrorID,
                        'Oseba ' + O.[Naziv]
                        + ' nima polne časovne sekvence intervalov v tržnem planu. Manjka(jo) intervali od '
                        + CAST(CONVERT(DATETIME, LastValidInterval, 112) AS VARCHAR(24))
                        + ' do '
                        + CAST(CONVERT(DATETIME, NextValidInterval, 112) AS VARCHAR(24))
                        + ' ('
                        + CAST(DATEDIFF(hour,
                                        DATEADD(hour, 1, LastValidInterval),
                                        NextValidInterval) AS VARCHAR(3))
                        + ').'
--			  LastValidInterval
--			, NextValidInterval
--			, FirstMissingInterval = DATEADD(hour, 1, LastValidInterval)
--			, LastMissingInterval = DATEADD(hour, -1, NextValidInterval)
--			, NumIntervalsMissing = datediff(hour,DATEADD(hour, 1, LastValidInterval),NextValidInterval)
--			, O.Naziv
                FROM    ( SELECT    LastValidInterval = ( SELECT    ISNULL(MAX(Seq2.interval), 0) AS SeqNumber
                                                          FROM      TrzniPlan Seq2
                                                          WHERE     Seq2.interval < Seq1.interval
                                                                    AND Seq2.OsebaID = Seq1.OsebaID
                                                                    AND Seq2.[Interval] > @DatumIntervalaOD
                                                                    AND Seq2.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                                                    AND ( @DatumStanjaBaze BETWEEN Seq2.[DatumVnosa]
                                                                                           AND     dbo.infinite(Seq2.DatumSpremembe) )
                                                        ),
                                    NextValidInterval = interval,
                                    Osebaid
                          FROM      TrzniPlan Seq1
                          WHERE     Seq1.[Interval] > @DatumIntervalaOD
                                    AND Seq1.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                    AND ( @DatumStanjaBaze BETWEEN Seq1.[DatumVnosa]
                                                           AND     dbo.infinite(Seq1.DatumSpremembe) )
                        ) AS A
                        INNER JOIN dbo.Oseba O ON A.Osebaid = O.OsebaID
                WHERE   DATEDIFF(hour, LastValidInterval, NextValidInterval) > 1
                        AND LastValidInterval > @DatumIntervalaOD
                        AND LastValidInterval <= DATEADD(DAY, 1,
                                                         @DatumIntervalaDO)
                        AND NextValidInterval > @DatumIntervalaOD
                        AND NextValidInterval <= DATEADD(DAY, 1,
                                                         @DatumIntervalaDO)
                        AND ( ( @DatumStanjaBaze BETWEEN O.[DatumVnosa]
                                                 AND     dbo.infinite(O.DatumSpremembe) )
                              AND ( @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd
                                                              AND     dbo.infinite(O.VeljaDo) )
                            )
                ORDER BY LastValidInterval
        IF ( @@ROWCOUNT = 0 ) 
            DELETE  FROM #Errors
            WHERE   ErrorID = @ErrorID
        ELSE 
            SET @NOErrors = @NOErrors + 1
		/*TRŽNI PLAN - KONEC*/
		
        IF ( @ObracunTipID <> @Kolicinski_obracun ) 
            BEGIN
				/*SIPX*/
                INSERT  INTO [#Errors] ( [Napaka] )
                VALUES  (
                          'Napaka 00100: Nepopolna sekvenca intervalov za SIPX.'
                                
                        ) ;
                SET @ErrorID = SCOPE_IDENTITY() ;

                INSERT  INTO [#ErrorDetail]
                        (
                          [ErrorID],
                          [ErrorDetail]
                        )
                        SELECT  @ErrorID,
                                'SIPX nima popolne sekvence intervlov. Manjka(jo) intervali od '
                                + CAST(CONVERT(DATETIME, LastValidInterval, 112) AS VARCHAR(24))
                                + ' do '
                                + CAST(CONVERT(DATETIME, NextValidInterval, 112) AS VARCHAR(24))
                                + ' ('
                                + CAST(DATEDIFF(hour,
                                                DATEADD(hour, 1,
                                                        LastValidInterval),
                                                NextValidInterval) AS VARCHAR(3))
                                + ').'
                        FROM    ( SELECT    LastValidInterval = ( SELECT    ISNULL(MAX(Seq2.interval), 0) AS SeqNumber
                                                                  FROM      SIPX Seq2
                                                                  WHERE     Seq2.interval < Seq1.interval
                                                                            AND Seq2.[Interval] > @DatumIntervalaOD
                                                                            AND Seq2.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                                                            AND ( @DatumStanjaBaze BETWEEN Seq2.[DatumVnosa]
                                                                                                   AND     dbo.infinite(Seq2.DatumSpremembe) )
                                                                ),
                                            NextValidInterval = interval
                                  FROM      dbo.SIPX Seq1
                                  WHERE     Seq1.[Interval] > @DatumIntervalaOD
                                            AND Seq1.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                            AND ( @DatumStanjaBaze BETWEEN Seq1.[DatumVnosa]
                                                                   AND     dbo.infinite(Seq1.DatumSpremembe) )
                                ) AS A
                        WHERE   DATEDIFF(hour, LastValidInterval,
                                         NextValidInterval) > 1
                                AND LastValidInterval > @DatumIntervalaOD
                                AND LastValidInterval <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                AND NextValidInterval > @DatumIntervalaOD
                                AND NextValidInterval <= DATEADD(DAY, 1, @DatumIntervalaDO)
                        ORDER BY LastValidInterval
                
                IF ( @@ROWCOUNT = 0 ) 
                    DELETE  FROM #Errors
                    WHERE   ErrorID = @ErrorID
                ELSE 
                    SET @NOErrors = @NOErrors + 1
				/*SIPX- KONEC*/
            END	

		
        IF ( @ObracunTipID <> @Kolicinski_obracun ) 
            BEGIN
		
		/*IZRAVNAVA*/
                INSERT  INTO [#Errors] ( [Napaka] )
                VALUES  (
                          'Napaka 00100: Nepopolna sekvenca intervalov za izravnavo.'
                                
                        ) ;
                SET @ErrorID = SCOPE_IDENTITY() ;

                INSERT  INTO [#ErrorDetail]
                        (
                          [ErrorID],
                          [ErrorDetail]
                        )
                        SELECT  @ErrorID,
                                'Oseba ' + O.[Naziv]
                                + ' nima polne časovne sekvence intervalov v tabeli Izravnava. Manjka(jo) intervali od '
                                + CAST(CONVERT(DATETIME, LastValidInterval, 112) AS VARCHAR(24))
                                + ' do '
                                + CAST(CONVERT(DATETIME, NextValidInterval, 112) AS VARCHAR(24))
                                + ' ('
                                + CAST(DATEDIFF(hour,
                                                DATEADD(hour, 1,
                                                        LastValidInterval),
                                                NextValidInterval) AS VARCHAR(3))
                                + ').'
                        FROM    ( SELECT    LastValidInterval = ( SELECT    ISNULL(MAX(Seq2.interval), 0) AS SeqNumber
                                                                  FROM      Izravnava Seq2
                                                                  WHERE     Seq2.interval < Seq1.interval
                                                                            AND Seq2.OsebaID = Seq1.OsebaID
                                                                            AND Seq2.[Interval] > @DatumIntervalaOD
                                                                            AND Seq2.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                                                            AND ( @DatumStanjaBaze BETWEEN Seq2.[DatumVnosa]
                                                                                                   AND     dbo.infinite(Seq2.DatumSpremembe) )
                                                                ),
                                            NextValidInterval = interval,
                                            Osebaid
                                  FROM      Izravnava Seq1
                                  WHERE     Seq1.[Interval] > @DatumIntervalaOD
                                            AND Seq1.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                            AND ( @DatumStanjaBaze BETWEEN Seq1.[DatumVnosa]
                                                                   AND     dbo.infinite(Seq1.DatumSpremembe) )
                                ) AS A
                                INNER JOIN PPM P ON A.OSebaID = P.PPMID  AND P.PPMTipID = @PO_SIS 
                                INNER JOIN dbo.Oseba O ON P.Dobavitelj1 = O.OsebaID
                        WHERE		DATEDIFF(hour, LastValidInterval,NextValidInterval) > 1
                                AND LastValidInterval > @DatumIntervalaOD
                                AND LastValidInterval <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                AND NextValidInterval > @DatumIntervalaOD
                                AND NextValidInterval <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                AND ( (@DatumStanjaBaze BETWEEN O.[DatumVnosa] AND dbo.infinite(O.DatumSpremembe))
                                AND ( @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd AND dbo.infinite(O.VeljaDo) ))
                                AND ( (@DatumStanjaBaze BETWEEN P.[DatumVnosa] AND dbo.infinite(P.DatumSpremembe))
                                AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd AND dbo.infinite(P.VeljaDo) ))
                        ORDER BY LastValidInterval
                        
                IF ( @@ROWCOUNT = 0 ) 
                    DELETE  FROM #Errors
                    WHERE   ErrorID = @ErrorID
                ELSE 
                    SET @NOErrors = @NOErrors + 1
			/*IZRAVNAVA - KONEC*/
		
            END 

		/*REGULACIJA*/
        INSERT  INTO [#Errors] ( [Napaka] )
        VALUES  (
                  'Napaka 00100: Nepopolna sekvenca intervalov za regulacijo.'
                                
                ) ;
        SET @ErrorID = SCOPE_IDENTITY() ;

        INSERT  INTO [#ErrorDetail]
                (
                  [ErrorID],
                  [ErrorDetail]
                )
                SELECT  @ErrorID,
                        'PPM ' + O.[Naziv]
                        + ' nima polne časovne sekvence intervalov v tabeli Izravnava. Manjka(jo) intervali od '
                        + CAST(CONVERT(DATETIME, LastValidInterval, 112) AS VARCHAR(24))
                        + ' do '
                        + CAST(CONVERT(DATETIME, NextValidInterval, 112) AS VARCHAR(24))
                        + ' ('
                        + CAST(DATEDIFF(hour,
                                        DATEADD(hour, 1, LastValidInterval),
                                        NextValidInterval) AS VARCHAR(3))
                        + ').'
                FROM    ( SELECT    LastValidInterval = ( SELECT    ISNULL(MAX(Seq2.interval), 0) AS SeqNumber
                                                          FROM      Regulacija Seq2
                                                          WHERE     Seq2.interval < Seq1.interval
                                                                    AND Seq2.PPMID = Seq1.PPMID
                                                                    AND Seq2.[Interval] > @DatumIntervalaOD
                                                                    AND Seq2.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                                                    AND ( @DatumStanjaBaze BETWEEN Seq2.[DatumVnosa]
                                                                                           AND     dbo.infinite(Seq2.DatumSpremembe) )
                                                        ),
                                    NextValidInterval = interval,
                                    PPMID
                          FROM      Regulacija Seq1
                          WHERE     Seq1.[Interval] > @DatumIntervalaOD
                                    AND Seq1.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                    AND ( @DatumStanjaBaze BETWEEN Seq1.[DatumVnosa]
                                                           AND     dbo.infinite(Seq1.DatumSpremembe) )
                        ) AS A
                        INNER JOIN dbo.PPM O ON A.PPMID = O.PPMID
                WHERE   DATEDIFF(hour, LastValidInterval, NextValidInterval) > 1
                        AND LastValidInterval > @DatumIntervalaOD
                        AND LastValidInterval <= DATEADD(DAY, 1,
                                                         @DatumIntervalaDO)
                        AND NextValidInterval > @DatumIntervalaOD
                        AND NextValidInterval <= DATEADD(DAY, 1,
                                                         @DatumIntervalaDO)
                        AND ( ( @DatumStanjaBaze BETWEEN O.[DatumVnosa]
                                                 AND     dbo.infinite(O.DatumSpremembe) )
                              AND ( @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd
                                                              AND     dbo.infinite(O.VeljaDo) )
                            )
                ORDER BY LastValidInterval
        IF ( @@ROWCOUNT = 0 ) 
            DELETE  FROM #Errors
            WHERE   ErrorID = @ErrorID
        ELSE 
            SET @NOErrors = @NOErrors + 1
		/*REGULACIJA - KONEC*/

			/*MERITVE*/
        INSERT  INTO [#Errors] ( [Napaka] )
        VALUES  (
                  'Napaka 00100: Nepopolna sekvenca intervalov za meritve.'
                                
                ) ;
        SET @ErrorID = SCOPE_IDENTITY() ;

        INSERT  INTO [#ErrorDetail]
                (
                  [ErrorID],
                  [ErrorDetail]
                )
                SELECT  @ErrorID,
                        'PPM ' + O.[Naziv]
                        + ' nima polne časovne sekvence intervalov v meritvah. Manjka(jo) intervali od '
                        + CAST(CONVERT(DATETIME, LastValidInterval, 112) AS VARCHAR(24))
                        + ' do '
                        + CAST(CONVERT(DATETIME, NextValidInterval, 112) AS VARCHAR(24))
                        + ' ('
                        + CAST(DATEDIFF(hour,
                                        DATEADD(hour, 1, LastValidInterval),
                                        NextValidInterval) AS VARCHAR(3))
                        + ').'
                FROM    ( SELECT    LastValidInterval = ( SELECT    ISNULL(MAX(Seq2.interval), 0) AS SeqNumber
                                                          FROM      view_Meritve Seq2
                                                          WHERE     Seq2.interval < Seq1.interval
                                                                    AND Seq2.PPMID = Seq1.PPMID
                                                                    AND Seq2.[Interval] > @DatumIntervalaOD
                                                                    AND Seq2.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                                                    AND ( @DatumStanjaBaze BETWEEN Seq2.[DatumVnosa]
                                                                                           AND     dbo.infinite(Seq2.DatumSpremembe) )
                                                        ),
                                    NextValidInterval = interval,
                                    PPMID
                          FROM      view_Meritve Seq1
                          WHERE     Seq1.[Interval] > @DatumIntervalaOD
                                    AND Seq1.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                                    AND ( @DatumStanjaBaze BETWEEN Seq1.[DatumVnosa]
                                                           AND     dbo.infinite(Seq1.DatumSpremembe) )
                        ) AS A
                        INNER JOIN dbo.PPM O ON A.PPMID = O.PPMID
                WHERE   DATEDIFF(hour, LastValidInterval, NextValidInterval) > 1
                        AND LastValidInterval > @DatumIntervalaOD
                        AND LastValidInterval <= DATEADD(DAY, 1,
                                                         @DatumIntervalaDO)
                        AND NextValidInterval > @DatumIntervalaOD
                        AND NextValidInterval <= DATEADD(DAY, 1,
                                                         @DatumIntervalaDO)
                        AND ( ( @DatumStanjaBaze BETWEEN O.[DatumVnosa]
                                                 AND     dbo.infinite(O.DatumSpremembe) )
                              AND ( @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd
                                                              AND     dbo.infinite(O.VeljaDo) )
                            )
                ORDER BY LastValidInterval
        IF ( @@ROWCOUNT = 0 ) 
            DELETE  FROM #Errors
            WHERE   ErrorID = @ErrorID
        ELSE 
            SET @NOErrors = @NOErrors + 1
		/*MERITVE - KONEC*/

		
		--VALIDACIJA
        INSERT  INTO [#Validacija]
                (
                  [OsebaID],
                  [Interval],
                  [PreostaliDiagramODJEM],
                  [NormiranPreostaliDiagramODJEMA],
                  [PreostaliDiagramODDAJE],
                  [NormiranPreostaliDiagramODDAJE],
                  [KontrolaPDP],
                  [KontrolaPDO]
                )
                SELECT  PPM.[Dobavitelj1],
                        M.[Interval],
                        SUM(( CASE WHEN PPM.PPMTipID = @VIRT_PBI
                                   THEN M.Kolicina
                                   WHEN PPM.PPMTipID = @VIRT_MERJENI_ODJEM
                                   THEN -1 * M.Kolicina
                                   ELSE 0
                              END )) AS 'Preostali diagram odjem (kW)',
                        0,
                        SUM(( CASE WHEN PPM.PPMTipID = @MP_KP_NEMERJENI
                                   THEN M.Kolicina
                                   WHEN PPM.PPMTipID = @MP_NP_NEMERJENI
                                   THEN M.Kolicina
                                   ELSE 0
                              END )) AS 'Preostali diagram proizvodnje (kW)',
                        0,
                        SUM(( CASE WHEN PPM.PPMTipID = @VIRT_NEMERJEN_ODDAJA
                                   THEN -1 * M.Kolicina
                                   ELSE 0
                              END )) AS 'PDP',
                        SUM(( CASE WHEN PPM.PPMTipID = @VIRT_NEMERJENI_ODJEM
                                   THEN -1 * M.Kolicina
                                   ELSE 0
                              END )) AS 'PDO'
                FROM    [view_Meritve] M
                        INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
                        INNER JOIN Oseba O ON PPM.[Dobavitelj1] = O.[OsebaID]
                WHERE   M.[Interval] > @DatumIntervalaOD
                        AND M.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
                        AND M.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
                        AND PPM.[PPMTipID] IS NOT NULL
                        AND ( ( @DatumStanjaBaze BETWEEN PPM.DatumVnosa
                                                 AND     dbo.infinite(PPM.DatumSpremembe) )
                              AND ( @DatumVeljavnostiPodatkov BETWEEN PPM.VeljaOd
                                                              AND     dbo.infinite(PPM.VeljaDo) )
                            )
                        AND ( @DatumStanjaBaze BETWEEN M.[DatumVnosa]
                                               AND     dbo.infinite(M.DatumSpremembe) )
                        AND ( ( @DatumStanjaBaze BETWEEN O.[DatumVnosa]
                                                 AND     dbo.infinite(O.DatumSpremembe) )
                              AND ( @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd
                                                              AND     dbo.infinite(O.VeljaDo) )
                            )
                GROUP BY M.[Interval],
                        PPM.[Dobavitelj1]
        OPTION  ( MAXDOP 1 )



				   
        INSERT  INTO #SumaValidacija
                (
                  NormiranPPP,
                  NormiranPPo,
                  OsebaID
                )
                SELECT  SUM(PreostaliDiagramODDAJE) AS NormiranPPP,
                        SUM(PreostaliDiagramODJEM) AS NormiranPPo,
                        OsebaID
                FROM    #Validacija
                GROUP BY [OsebaID]
	
        UPDATE  [#Validacija]
        SET     NormiranPreostaliDiagramODDAJE = ( CASE WHEN ISNULL([#SumaValidacija].NormiranPPP, 0) = 0
                                                        THEN -1
                                                        ELSE PreostaliDiagramODDAJE
                                                             / ISNULL([#SumaValidacija].NormiranPPP, 0)
                                                   END ),
                NormiranPreostaliDiagramODJEMA = ( CASE WHEN ISNULL([#SumaValidacija].NormiranPPO, 0) = 0
                                                        THEN -1
                                                        ELSE PreostaliDiagramODJEM
                                                             / ISNULL([#SumaValidacija].NormiranPPO, 0)
                                                   END )
        FROM    #Validacija
                INNER JOIN [#SumaValidacija] ON [#Validacija].[OsebaID] = [#SumaValidacija].[OsebaID]


        IF ( SELECT COUNT(*)
             FROM   [#Validacija]
             WHERE  [KontrolaPDP] <> 0
                    OR [KontrolaPDO] <> 0
           ) > 0 
            BEGIN
		    --SET @NOErrors = @NOErrors +  1
                IF ( @NOErrors > 0 ) 
                    BEGIN
                        INSERT  INTO [#Errors] ( [Napaka] )
                        VALUES  (
                                  'Napaka 001: Napaka na vhodnih podatkih (KontorlaPDP ali KontrolaPDO).'
                                ) ;
                        SET @ErrorID = SCOPE_IDENTITY() ;

                        INSERT  INTO [#ErrorDetail]
                                (
                                  [ErrorID],
                                  [ErrorDetail]
		                    )
                                SELECT  @ErrorID,
                                        'Napaka dne '
                                        + CAST(CONVERT(DATETIME, V.[Interval], 112) AS VARCHAR(20))
                                        + ' za osebo ' + ISNULL(O.[Naziv], '/')
                                        + '. Preostali diagram odjem (kW): '
                                        + CAST(V.[PreostaliDiagramODJEM] AS VARCHAR(18))
                                        + ' Normiran preostali diagram odjema (kW): '
                                        + CAST(V.[NormiranPreostaliDiagramODJEMA] AS VARCHAR(18))
                                        + ' Preostali diagram proizvodnje (kW): '
                                        + CAST(V.[PreostaliDiagramODDAJE] AS VARCHAR(18))
                                        + ' Normiran preostali diagram proizvodnje (kW): '
                                        + CAST(V.[NormiranPreostaliDiagramODDAJE] AS VARCHAR(18))
                                        + +' KontorlaPDP '
                                        + CAST(V.[KontrolaPDP] AS VARCHAR(18))
                                        + +' KontorlaPDO '
                                        + CAST(V.[KontrolaPDO] AS VARCHAR(18))
                                        + '.'
                                FROM    [#Validacija] V
                                        LEFT JOIN [Oseba] O ON V.[OsebaID] = O.[OsebaID]
                                WHERE   [KontrolaPDP] <> 0
                                        OR [KontrolaPDO] <> 0
                                        AND ( ( @DatumStanjaBaze BETWEEN O.[DatumVnosa]
                                                                 AND     dbo.infinite(O.DatumSpremembe) )
                                              AND ( @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd
                                                                              AND     dbo.infinite(O.VeljaDo) )
                                            )
			
		
                    END
            END
        IF ( @NOErrors > 0 ) 
            BEGIN

                SET @ErrorHeadXML = ( SELECT TOP 20
                                                *
                                      FROM      #Errors
                                    FOR
                                      XML PATH('Napake'),
                                          ROOT('Root')
                                    )		
                SET @ErrorDetailsXML = ( SELECT TOP 50
                                                *
                                         FROM   #ErrorDetail
                                       FOR
                                         XML PATH('ErrorDetail'),
                                             ROOT('Root')
                                       )
            END
        ELSE 
            BEGIN
                SET @ErrorHeadXML = NULL
                SET @ErrorDetailsXML = NULL
            END

        RETURN @NOErrors
    END


