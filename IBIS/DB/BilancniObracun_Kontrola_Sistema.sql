

EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_Kontrola_Sistema'
GO 


CREATE PROCEDURE [dbo].[BilancniObracun_Kontrola_Sistema]
    (
      @DatumStanjaBaze AS DATETIME,
      @ObracunID AS INT
    )
AS 
    BEGIN

        DECLARE @DatumVeljavnostiPodatkov DATETIME
        DECLARE @DatumIntervalaDO DATETIME
        DECLARE @DatumIntervalaOD DATETIME
        DECLARE @ObdobjeId INT
          
        SELECT  @ObdobjeId = ObracunskoObdobjeID,
                @DatumVeljavnostiPodatkov = DatumVnosa,
				@DatumStanjaBaze = DatumVnosa
        FROM    Obracun
        WHERE   ObracunID = @ObracunID
      
        SELECT  @DatumIntervalaDO = VeljaDo,
                @DatumIntervalaOD = VeljaOd
        FROM    ObracunskoObdobje
        WHERE   ObracunskoObdobjeID = @ObdobjeId 
       
 
      
        DECLARE @VIRT_ELES_MERITVE_PREVZEM_SODO INT ;
      
        DECLARE @PPMTI_MEJE INT ;
        DECLARE @VIRT_ELES_MERITVE INT ;
		
        DECLARE @SQLString NVARCHAR(MAX) ;
        DECLARE @ParmDefinition NVARCHAR(4000) ;
        
        
        SELECT  @PPMTI_MEJE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = 'MEJE' ;
		
        SELECT  @VIRT_ELES_MERITVE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SOPO) VIRT_ELES_MERITVE' ;
		
        SELECT  @VIRT_ELES_MERITVE_PREVZEM_SODO = [PPMTipID]
        FROM    [PPMTip]
        WHERE   Naziv = '(SOPO) VIRT_ELES_MERITVE_PREVZEM_SODO' ;
		
		create table #Kontrola_Sistema
		(
		[ObracunID] int null,
								[Interval] datetime null,
								[Oddaja] decimal(28,8) null,
								[Odjem] decimal(28,8) null,
								[Meje] decimal(28,8) null,
								[Izgube] decimal(28,8) NULL,
								[Skupaj] decimal(28,8) null
		)
		
        SET @SQLString = '
                INSERT  INTO #Kontrola_Sistema
                        (
                          		[ObracunID],
								[Interval],
								[Oddaja],
								[Odjem],
								[Meje],
								[Izgube]
				       )
                        SELECT  
								@ObracunID,
								M.[Interval],
                                 SUM(( CASE WHEN PPMJeOddaja = 1
                                                AND M.Kolicina > 0
                                                AND PPM.[PPMTipID] = @VIRT_ELES_MERITVE
                                                AND Z.[Sifra] <>  ''ME'' AND PATINDEX(''%_izgube%'',PPM.[Naziv]) = 0
                                           THEN M.Kolicina
                                           WHEN PPMJeOddaja = 0
                                                AND M.Kolicina < 0
                                                AND PPM.[PPMTipID] = @VIRT_ELES_MERITVE
                                                AND Z.[Sifra] <>  ''ME'' AND PATINDEX(''%_izgube%'',PPM.[Naziv]) = 0
                                           THEN -1 * M.Kolicina
                                           ELSE 0
                                      END )),
					--odjem
                                SUM(( CASE WHEN PPMJeOddaja = 1
                                                AND M.Kolicina < 0
                                                AND PPM.[PPMTipID] IN  (@VIRT_ELES_MERITVE)
                                                AND Z.[Sifra] <>  ''ME'' AND PATINDEX(''%_izgube%'',PPM.[Naziv]) = 0
                                           THEN -1 * M.Kolicina
                                           WHEN PPMJeOddaja = 0
                                                AND M.Kolicina >= 0
                                                AND PPM.[PPMTipID] IN  (@VIRT_ELES_MERITVE,@VIRT_ELES_MERITVE_PREVZEM_SODO)
                                                AND Z.[Sifra] <>  ''ME'' AND PATINDEX(''%_izgube%'',PPM.[Naziv]) = 0
                                           THEN M.Kolicina
                                           ELSE 0
                                      END )),
                                SUM(CASE WHEN Z.[Sifra] = ''ME'' THEN M.[Kolicina] ELSE 0 end),
                                SUM(CASE WHEN PATINDEX(''%_izgube%'',PPM.[Naziv]) > 0  THEN M.[Kolicina] ELSE 0 end)
                                
                        FROM    
                        ' + [dbo].[ResolveTableName](@DatumIntervalaDO,
                                                     @DatumIntervalaOD)
            + ' M 
                                INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
                                JOIN [dbo].[OsebaZCalc] OZ ON PPM.Dobavitelj1 = Oz.OsebaID AND OZ.[DatumSpremembe] IS null
								JOIN [dbo].[OsebaZId] Z ON OZ.[OsebaZID] = Z.[OsebaZId]
                        WHERE   M.[Interval] >= @DatumIntervalaOD
                                AND M.[Interval] <= DATEADD(DAY, 1,@DatumIntervalaDO)
                                AND M.[DatumVnosa] <= @DatumStanjaBaze
                                AND ( PPM.[PPMTipID] in (@VIRT_ELES_MERITVE,@VIRT_ELES_MERITVE_PREVZEM_SODO) )
                                AND PPM.[PPMTipID] IS NOT NULL
                                AND ( ( @DatumStanjaBaze BETWEEN PPM.DatumVnosa
                                                         AND     dbo.infinite(PPM.DatumSpremembe) )
                                      AND ( @DatumVeljavnostiPodatkov BETWEEN PPM.VeljaOd
                                                                      AND     dbo.infinite(PPM.VeljaDo) )
                                    )
                                AND ( @DatumStanjaBaze BETWEEN M.[DatumVnosa]
                                                       AND     dbo.infinite(M.[DatumSpremembe]) )
                                                       
                               AND ( @DatumStanjaBaze BETWEEN OZ.DatumVnosa
                                                         AND     dbo.infinite(OZ.DatumSpremembe) )
                             GROUP BY M.[Interval]  OPTION  ( MAXDOP 1 )'
				

        SET @ParmDefinition = N'@DatumIntervalaDO datetime,
										@DatumIntervalaOD datetime,
										@DatumStanjaBaze datetime,
										@VIRT_ELES_MERITVE INT,
										@VIRT_ELES_MERITVE_PREVZEM_SODO INT, 
										@DatumVeljavnostiPodatkov datetime,
										@ObracunID int' ;

        PRINT @SQLString

        EXECUTE sp_executesql @SQLString, @ParmDefinition,
            @DatumIntervalaDO = @DatumIntervalaDO,
            @DatumIntervalaOD = @DatumIntervalaOD,
            @DatumStanjaBaze = @DatumStanjaBaze,
            @VIRT_ELES_MERITVE = @VIRT_ELES_MERITVE,
            @VIRT_ELES_MERITVE_PREVZEM_SODO = @VIRT_ELES_MERITVE_PREVZEM_SODO,
            @DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov,
            @ObracunID = @ObracunID ;
										
        UPDATE  #Kontrola_Sistema
        SET     Skupaj = Oddaja - Odjem - Izgube - Meje
        WHERE   ObracunID = @ObracunID
										
        SELECT  interval,
                [Oddaja],
                [Odjem],
                [Meje],
                [Izgube],
                [Skupaj]
        FROM    #Kontrola_Sistema
        WHERE   [ObracunID] = @ObracunID
        ORDER BY 
        DATEPART(month, [Interval]) ASC,
        DATEPART(day, [Interval]) ASC,
                ( CASE WHEN DATEPART(HH, [Interval]) = 0 THEN 24
                       ELSE DATEPART(HH, [Interval])
                  END ) ASC
    END



GO