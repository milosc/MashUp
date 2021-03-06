EXEC [dbo].[DropPRCorUDF] @ObjectName = 'BilancniObracun_TolerancniPas' 
GO

CREATE PROCEDURE [dbo].[BilancniObracun_TolerancniPas]
    (
      @DatumStanjaBaze AS DATETIME,
      @k AS DECIMAL(18, 6),
      @NewObracunID AS INT,
      @NOErrors AS INT OUTPUT,
      @novk AS DECIMAL(18, 6),
      @RegulacijskoObmocjSR AS DECIMAL(18, 8),
      @TrgovecTipID AS INT,
      @ErrorHeadXML XML OUTPUT,
      @ErrorDetailsXML XML OUTPUT
    )
AS 
    BEGIN


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
  
  				
        IF OBJECT_ID('#tmpTolerancniPas') IS NOT NULL 
            DROP TABLE #tmpTolerancniPas

        CREATE TABLE #tmpTolerancniPas
            (
              Interval DATETIME,
              Suma DECIMAL(18, 6),
              SumaNovT DECIMAL(18, 6),
              RegulacijskoObmocjSR DECIMAL(18, 6)
            )			
		
  
        DECLARE @VsotaNewT DECIMAL(18, 6) ;

        INSERT  INTO [TolerancniPas]
                (
                  [ObracunID],
                  [OsebaID],
                  [Interval],
                  [Odjem],
                  [Oddaja],
                  [T],
                  [normiranT],
                  novT,
                  normiranNovT,
                  [KoregiranT]
                )
                SELECT  @NewObracunID,
                        RBS.[OsebaID],
                        RBS.[Interval],
                        RBS.[Odjem],
                        RBS.[Oddaja],
                        (CASE WHEN @k*RBS.[Odjem] < 1 THEN 1 ELSE  ROUND(@k*RBS.[Odjem],3) END),
                        0,
                        0,
                        0,
                        (CASE WHEN @k*RBS.[Odjem] < 1 THEN 1 ELSE  ROUND(@k*RBS.[Odjem],3) END)+(CASE WHEN Izp.Upostevaj = 1 then ISNULL(Izp.[value],0) ELSE 0 END)
                FROM    [RealizacijaPoBS] RBS
                        INNER JOIN dbo.OsebaTip OT ON RBS.OsebaID = OT.osebaID
                        LEFT JOIN dbo.Izpadi Izp ON Izp.interval = RBS.interval
                                                                  AND Izp.OsebaID = RBS.osebaID
                                                                  AND ( @DatumStanjaBaze between Izp.[DatumVnosa]
                                                                                         and     dbo.infinite(Izp.DatumSpremembe) )
                WHERE   RBS.[ObracunID] = @NewObracunID
                        AND ( @DatumStanjaBaze BETWEEN OT.[DatumVnosa]
                                               AND     dbo.infinite(OT.DatumSpremembe) )
										
        SET @NOErrors = @NOErrors + @@ERROR
        IF ( @NOErrors > 0 ) 
            INSERT  INTO [#Errors] ( [Napaka] )
            VALUES  (
                      'Napaka 011: Napaka pri izračunu tolerančnega pasa.'
                          
                    ) ;

									
					
								
           
        IF ( @NOErrors <> 0 ) 
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

    END




GO