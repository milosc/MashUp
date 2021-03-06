exec dbo.DropPRCorUDF	@ObjectName = 'RevizijaBilancniObracun_CheckInputSets'
GO


CREATE PROCEDURE [dbo].[RevizijaBilancniObracun_CheckInputSets]
(
  @CriticalError AS INT OUTPUT,
  @DatumIntervalaDO AS DATETIME,
  @DatumIntervalaOD AS DATETIME,
  @DatumStanjaBaze AS DATETIME,
  @DatumVeljavnostiPodatkov AS DATETIME,
  @NOErrors AS INT OUTPUT,
  @ErrorHeadXML XML OUTPUT,
  @ErrorDetailsXML XML output,
  @ObracunTipID AS INT
)
AS 
BEGIN

   DECLARE @Kolicinski_obracun INT
  
   SELECT  @Kolicinski_obracun = [ObracunTipID]
   FROM    [ObracunTip]
   WHERE   [Sifra] = 'K'
  
  if object_id('#Errors') is not null 
    drop table #Errors
        
  CREATE TABLE #Errors
  (
    ErrorID BIGINT IDENTITY(1, 1)
                   NOT NULL,
    Napaka VARCHAR(255) NOT NULL
  )

  if object_id('#ErrorDetail') is not null 
    drop table #ErrorDetail
        
  CREATE TABLE #ErrorDetail
  (
    ErrorID BIGINT,
    ErrorDetail VARCHAR(900) NOT NULL
  )


  IF ( (
         SELECT
          COUNT(*)
         FROM
          [TrzniPlan]
         WHERE
          [Interval] > @DatumIntervalaOD
          AND [Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
          AND ( @DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe) )
       ) = 0 ) 
    BEGIN
      INSERT INTO
        [#Errors] ( [Napaka] )
      VALUES
        (
          'Napaka 008a: Ni podatkov za vozni red. Obračun bo prekinjen.'
                    
        ) ;
      SET @CriticalError = 1
      SET @NOErrors = @NOErrors + 1
    END

  
   IF (@ObracunTipID <> @Kolicinski_obracun)
   BEGIN			
    IF ( (
         SELECT
          COUNT(*)
         FROM
          [CSLOEX]
         WHERE
          Interval > @DatumIntervalaOD AND Interval <= DATEADD(DAY, 1, @DatumIntervalaDO)
          AND [DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
          AND ( @DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe) )
       ) = 0 ) 
    BEGIN
      INSERT INTO
        [#Errors] ( [Napaka] )
      VALUES
        (
          'Napaka 008b: Ni podatkov za CSloEx . Obračun bo prekinjen.'
                    
        ) ;
      SET @CriticalError = 1
      SET @NOErrors = @NOErrors + 1
    END		
  END			
  
  IF ( (
         SELECT
          COUNT(*)
         FROM
          Regulacija
         WHERE
          Interval > @DatumIntervalaOD AND Interval <= DATEADD(DAY, 1, @DatumIntervalaDO)
          AND [DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
          AND ( @DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe) )
       ) = 0 ) 
    BEGIN
      INSERT INTO
        [#Errors] ( [Napaka] )
      VALUES
        (
          'Napaka 008c: Ni podatkov za Regulacijo . Obračun bo prekinjen.'
                    
        ) ;
      SET @CriticalError = 1
      SET @NOErrors = @NOErrors + 1
    END	

IF (@ObracunTipID <> @Kolicinski_obracun)
BEGIN			
  IF ( (
         SELECT
          COUNT(*)
         FROM
          [Izravnava]
         WHERE
          Interval > @DatumIntervalaOD AND Interval <= DATEADD(DAY, 1, @DatumIntervalaDO)
          AND [DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
          AND ( @DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe) )
       ) = 0 ) 
    BEGIN
      INSERT INTO
        [#Errors] ( [Napaka] )
      VALUES
        (
          'Napaka 008d: Ni podatkov za Izravnavo . Obračun bo prekinjen.'
                    
        ) ;
      SET @CriticalError = 1
      SET @NOErrors = @NOErrors + 1
    END
END 

  IF ( @NOErrors <> 0 ) 
    BEGIN
      SET @ErrorHeadXML = (
                            SELECT
                              TOP 20  *
                            FROM
                              #Errors
                          FOR
                            XML PATH('Napake'),
                                ROOT('Root')
                          )		
      SET @ErrorDetailsXML = (
                               SELECT
                                TOP 50 *
                               FROM
                                #ErrorDetail
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

