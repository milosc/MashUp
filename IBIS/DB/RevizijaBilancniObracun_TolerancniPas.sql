/****** Object:  StoredProcedure [dbo].[RevizijaBilancniObracun_TolerancniPas]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevizijaBilancniObracun_TolerancniPas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[RevizijaBilancniObracun_TolerancniPas]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevizijaBilancniObracun_TolerancniPas]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[RevizijaBilancniObracun_TolerancniPas]
(
  @DatumStanjaBaze AS DATETIME,
  @k AS DECIMAL(18, 6),
  @NewObracunID AS INT,
  @NOErrors AS INT OUTPUT,
  @novk AS DECIMAL(18, 6),
  @RegulacijskoObmocjSR AS DECIMAL(18, 8),
  @TrgovecTipID AS INT,
  @ErrorHeadXML XML OUTPUT,
  @ErrorDetailsXML XML output
)
AS 
BEGIN


  if object_id(''#Errors'') is not null 
    drop table #Errors
        
  CREATE TABLE #Errors
  (
    ErrorID BIGINT IDENTITY(1, 1)
                   NOT NULL,
    Napaka VARCHAR(255) NOT NULL
  )

  if object_id(''#ErrorDetail'') is not null 
    drop table #ErrorDetail
        
  CREATE TABLE #ErrorDetail
  (
    ErrorID BIGINT,
    ErrorDetail VARCHAR(900) NOT NULL
  )
  
  				
  if object_id(''#tmpTolerancniPas'') is not null 
    drop table #tmpTolerancniPas

  CREATE TABLE #tmpTolerancniPas
  (
    Interval DATETIME,
    Suma DECIMAL(18, 6),
    SumaNovT DECIMAL(18, 6),
    RegulacijskoObmocjSR DECIMAL(18, 6)
  )			
		
  
  DECLARE @VsotaNewT DECIMAL(18, 6) ;

  INSERT INTO
    [TolerancniPas]
    (
      [ObracunID],
      [OsebaID],
      [Interval],
      [Odjem],
      [Oddaja],
      [T],
      [normiranT],
      novT,
      normiranNovT
									
                        
    )
    SELECT
      @NewObracunID,
      RBS.[OsebaID],
      [Interval],
      Odjem,
      Oddaja,
      ISNULL(( CASE WHEN OT.OsebaTipID = @TrgovecTipID THEN 0
             ELSE ( CASE WHEN ( CASE WHEN ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) < 0 THEN 0 --VPRAŠAJ KAJ JE TEM PRIMERU!!!! VSEBINSKO
                                     WHEN ABS(RBS.Odjem) > ABS(RBS.Oddaja)
                                     THEN @k * SQRT(( ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) * ABS(RBS.Odjem) ))
                                     ELSE @k * SQRT(( ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) * ABS(RBS.Oddaja) ))
                                END ) > @RegulacijskoObmocjSR THEN @RegulacijskoObmocjSR
                         else ( CASE WHEN ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) < 0 THEN 0 --VPRAŠAJ KAJ JE TEM PRIMERU!!!! VSEBINSKO
                                     WHEN ABS(RBS.Odjem) > ABS(RBS.Oddaja)
                                     THEN @k * SQRT(( ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) * ABS(RBS.Odjem) ))
                                     ELSE @k * SQRT(( ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) * ABS(RBS.Oddaja) ))
                                END )
                    END )
        END ),0),
--      ISNULL(( CASE WHEN ( CASE WHEN ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) < 0 THEN 0 --VPRAŠAJ KAJ JE TEM PRIMERU!!!! VSEBINSKO
--                                     WHEN ABS(RBS.Odjem) > ABS(RBS.Oddaja)
--                                     THEN @k * SQRT(( ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) * ABS(RBS.Odjem) ))
--                                     ELSE @k * SQRT(( ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) * ABS(RBS.Oddaja) ))
--                                END ) > @RegulacijskoObmocjSR THEN @RegulacijskoObmocjSR
--                         else ( CASE WHEN ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) < 0 THEN 0 --VPRAŠAJ KAJ JE TEM PRIMERU!!!! VSEBINSKO
--                                     WHEN ABS(RBS.Odjem) > ABS(RBS.Oddaja)
--                                     THEN @k * SQRT(( ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) * ABS(RBS.Odjem) ))
--                                     ELSE @k * SQRT(( ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ) * ABS(RBS.Oddaja) ))
--                                END )
--                END ),0) ,
      0,
      @novK * ( ABS(RBS.Oddaja) + ABS(RBS.Odjem) ),
      0
    FROM
      [RealizacijaPoBS] RBS
      INNER JOIN dbo.OsebaTip OT ON RBS.OsebaID = OT.osebaID
    WHERE
      RBS.[ObracunID] = @NewObracunID
      AND ( @DatumStanjaBaze between OT.[DatumVnosa]
                             and     dbo.infinite(OT.DatumSpremembe) )
										
  SET @NOErrors = @NOErrors + @@ERROR
  IF ( @NOErrors > 0 ) 
    INSERT INTO
      [#Errors] ( [Napaka] )
    VALUES
      (
        ''Napaka 011: Napaka pri izračunu tolerančnega pasa.''
                          
      ) ;

									
					
  INSERT INTO
    [#tmpTolerancniPas]
    (
      [Interval],
      [Suma],
      [SumaNovT],
      [RegulacijskoObmocjSR]
									
                        
    )
    SELECT
      Interval,
      SUM(T),
      SUM(novT),
      @RegulacijskoObmocjSR
    FROM
      [TolerancniPas]
    WHERE
      [ObracunID] = @NewObracunID
    GROUP BY
      [Interval]
  SET @NOErrors = @NOErrors + @@ERROR
									
--									normiranje Tolerančnega pasu
								
  UPDATE
    [TolerancniPas]
  SET
    normiranT = ( CASE WHEN tmpT.[Suma] > @RegulacijskoObmocjSR then @RegulacijskoObmocjSR / tmpT.[Suma] * T
                       ELSE T
                  END )
  FROM
    [TolerancniPas] TP
    INNER JOIN [#tmpTolerancniPas] tmpT ON TP.[Interval] = tmpT.[Interval]
  WHERE
    [ObracunID] = @NewObracunID
  SET @NOErrors = @NOErrors + @@ERROR
  IF ( @NOErrors > 0 ) 
    INSERT INTO
      [#Errors] ( [Napaka] )
    VALUES
      (
        ''Napaka 012: Napaka pri izračunu tolerančnega pasa - normiranje.''
                          
      ) ;

									
--									normiranje novega Tolerančnega pasu
  IF ( @VsotaNewT > @RegulacijskoObmocjSR ) 
    BEGIN
      UPDATE
        [TolerancniPas]
      SET
        normiranNovT = @RegulacijskoObmocjSR / @VsotaNewT * novT
      WHERE
        [ObracunID] = @NewObracunID
      SET @NOErrors = @NOErrors + @@ERROR
      IF ( @NOErrors > 0 ) 
        INSERT INTO
          [#Errors] ( [Napaka] )
        VALUES
          (
            ''Napaka 013: Napaka pri izračunu tolerančnega pasa - normiranje.''
                              
          ) ;

    END
           

  IF ( @NOErrors <> 0 ) 
    BEGIN
      SET @ErrorHeadXML = (
                            SELECT
                              TOP 20 *
                            FROM
                              #Errors
                          FOR
                            XML PATH(''Napake''),
                                ROOT(''Root'')
                          )		
      SET @ErrorDetailsXML = (
                               SELECT
                                TOP 50 *
                               FROM
                                #ErrorDetail
                             FOR
                               XML PATH(''ErrorDetail''),
                                   ROOT(''Root'')
                             )
    END
  ELSE 
    BEGIN
      SET @ErrorHeadXML = NULL
      SET @ErrorDetailsXML = NULL
    END

END



' 
END
GO
