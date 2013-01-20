
EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_Kontrola_Omrezji'
GO 

CREATE PROCEDURE [dbo].[BilancniObracun_Kontrola_Omrezji]
    (
      @DatumStanjaBaze AS DATETIME,
      @ObracunID AS INT
    )
AS 
    BEGIN
     
        DECLARE @SQLString NVARCHAR(MAX) ;
        DECLARE @ParmDefinition NVARCHAR(4000) ;
        
        
        DECLARE @DatumVeljavnostiPodatkov DATETIME
        DECLARE @DatumIntervalaDO DATETIME
        DECLARE @DatumIntervalaOD DATETIME
        DECLARE @ObdobjeId INT
     
          
        SELECT  @ObdobjeId = ObracunskoObdobjeID,
                @DatumVeljavnostiPodatkov = DatumVnosa,
				@DatumStanjaBaze= DatumVnosa
        FROM    Obracun
        WHERE   ObracunID = @ObracunID
      
        SELECT  @DatumIntervalaDO = VeljaDo,
                @DatumIntervalaOD = VeljaOd
        FROM    ObracunskoObdobje
        WHERE   ObracunskoObdobjeID = @ObdobjeId 
                                           
        SET @SQLString = '
        SELECT   [EL PR], [EL CE], [EL LJ], [EL GO], [EL MB]
        FROM    ( SELECT    M.Interval,
                            SUM(( CASE WHEN T.Naziv IN (
                                            ''(SODO) VIRT_MERJENI_ODJEM'',
                                            ''(SODO) VIRT_NEMERJENI_ODJEM'',
                                            ''(SODO) UDO_P_IZGUBE'' )
                                       THEN isnull(M.Kolicina,0)
                                       WHEN T.Naziv IN (
                                            ''(SODO) VIRT_MERJEN_ODDAJA'',
                                            ''(SODO) VIRT_NEMERJEN_ODDAJA'',
                                            ''(SODO) ND_EL_CE'',
                                            ''(SODO) ND_EL_GO'',
                                            ''(SODO) ND_EL_LJ'',
                                            ''(SODO) ND_EL_MB'',
                                            ''(SODO) ND_EL_PR'',
                                            '' VIRT_ELES_ODJEM'' )
                                       THEN -1 * isnull(M.Kolicina,0)
                                       ELSE 0
                                  END )) AS Kolicina,
                            O.[Kratica]
                  FROM     '+ [dbo].[ResolveTableName](@DatumIntervalaDO,
                                                     @DatumIntervalaOD)
							 +' M
                            JOIN [dbo].[PPM] P ON M.[PPMID] = P.[PPMID]
                            JOIN [dbo].[PPMTip] T ON P.[PPMTipID] = T.PPMTIPID
                            JOIN [dbo].[Oseba] O ON P.[SistemskiOperater1] = O.OsebaID
                            JOIN [dbo].[OsebaTip] OT ON [O].[OsebaID] = [OT].[OsebaID] AND OT.[OsebaTipID]=1 
                            JOIN [dbo].[Pogodba] Pg ON Pg.[Partner2] = P.[SistemskiOperater1]
                  WHERE     M.[Interval] >= @DatumIntervalaOD
                            AND M.[Interval] <= DATEADD(DAY, 1,@DatumIntervalaDO)
                            AND M.[DatumVnosa] <= @DatumStanjaBaze
							AND M.DatumSpremembe IS NULL
                            AND P.[DatumSpremembe] IS NULL
                            AND ( ( @DatumStanjaBaze BETWEEN O.DatumVnosa
                                              AND     dbo.infinite(O.DatumSpremembe) )
                                  AND (  @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd
                                                  AND     dbo.infinite(O.VeljaDo) )
                                )
                            AND ( ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                              AND     dbo.infinite(P.DatumSpremembe) )
                                  AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                  AND     dbo.infinite(P.VeljaDo) )
                                )
                            AND ( ( @DatumStanjaBaze BETWEEN Pg.DatumVnosa
                                              AND     dbo.infinite(P.DatumSpremembe) )
                                  AND ( @DatumVeljavnostiPodatkov BETWEEN Pg.VeljaOd
                                                  AND     dbo.infinite(PG.VeljaDo) )
                                )
                             AND ( ( @DatumStanjaBaze BETWEEN OT.DatumVnosa
                                              AND     dbo.infinite(OT.DatumSpremembe) ))
                  GROUP BY  M.Interval,
                            O.Kratica
                ) p PIVOT ( SUM(Kolicina) FOR Kratica IN ( [EL PR], [EL CE],
                                                           [EL LJ], [EL GO],
                                                           [EL MB] ) ) AS pvt
				ORDER BY 
				DATEPART(month,pvt.interval) ASC,
				DATEPART(day,pvt.interval) ASC,
                (CASE WHEN DATEPART(HH,pvt.interval) = 0 THEN 24
                       ELSE DATEPART(HH,pvt.interval)
                 END) ASC;'
			

        SET @ParmDefinition = N'@DatumIntervalaDO datetime,
										@DatumIntervalaOD datetime,
										@DatumStanjaBaze datetime,
										@DatumVeljavnostiPodatkov datetime' ;

        PRINT @SQLString

        EXECUTE sp_executesql @SQLString, @ParmDefinition,
            @DatumIntervalaDO = @DatumIntervalaDO,
            @DatumIntervalaOD = @DatumIntervalaOD,
            @DatumStanjaBaze = @DatumStanjaBaze,
            @DatumVeljavnostiPodatkov = @DatumVeljavnostiPodatkov;

    END


GO