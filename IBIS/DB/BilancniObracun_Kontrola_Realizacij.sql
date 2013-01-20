

EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_Kontrola_Realizaciji'
GO 

CREATE PROCEDURE [dbo].[BilancniObracun_Kontrola_Realizaciji]
    (
      @DatumStanjaBaze AS DATETIME,
      @ObracunID AS INT
    )
AS 
    BEGIN
    

    declare @DareString varchar(40)
    SET @DareString = convert(VARCHAR(30),@DatumStanjaBaze,120)
  
    DECLARE @SelectStatement VARCHAR(8000)
    
    SET @SelectStatement = 'SELECT R.[Interval],(case when Z.[Sifra] = ''ME'' then R.[Kolicina]  else R.[Kolicina] end ) as Kolicina ,O.Naziv
		FROM [dbo].[RealizacijaPoBS] R JOIN [dbo].[Oseba] O ON R.[OsebaID] = O.[OsebaID] 
		JOIN [dbo].[OsebaZCalc] OZ ON O.OsebaID = Oz.OsebaID AND OZ.[DatumSpremembe] IS null
		JOIN [dbo].[OsebaZId] Z ON OZ.[OsebaZID] = Z.[OsebaZId]
		WHERE R.[ObracunID] = '+ CAST(@ObracunID  AS VARCHAR(30)) +'
		AND '''+ @DareString +''' BETWEEN O.VeljaOD AND dbo.[infinite](O.VeljaDo)
		AND '''+ @DareString +''' BETWEEN O.DatumVnosa AND dbo.[infinite](O.DatumSpremembe) '
	
	EXEC CrossTab
		@SelectStatement,
		'naziv',
		'sum(Kolicina)[]',
		'interval',
		NULL,
		' ORDER BY 
		DATEPART(month,[Interval]) asc,
		DATEPART(day,[Interval]) asc,
		(CASE WHEN DATEPART(HH,[Interval]) = 0 THEN 24 ELSE DATEPART(HH,[Interval]) end) asc '


	END
     
	 