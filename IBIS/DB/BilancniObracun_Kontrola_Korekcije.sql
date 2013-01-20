
EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_Kontrola_Korekcije'
GO 

CREATE PROCEDURE [dbo].[BilancniObracun_Kontrola_Korekcije]
    (
      @DatumStanjaBaze AS DATETIME,
      @ObracunID AS INT
    )
AS 
    BEGIN
     
        SELECT 
			P.[Interval] AS ds,
			convert(VARCHAR(24), P.[Interval] , 104)+ ' '+cast(datepart(hour,P.[Interval]) AS VARCHAR(2))  AS [Interval],
			P.[S+],
			P.[S-],
			P.[W+],
			P.[W-],
			P.[SroskiIzravnave] AS  [Stroški izravnave],
			P.[SaldoStroskiObracunov] AS  [Saldo BO],
			P.[SkupnaOdstopanja] AS  [Skupna odstopanja],
			P.[Razlika] ,
			P.[SIPXurni] AS [SiPIX urni],
			P.[C+],
			P.[C-],
			P.[q+],
			P.[q-],
			P.[C+'],
			P.[C-'],
			P.[C+GJS] AS [C+' GJS],
			P.[C-GJS] AS [C-' GJS],
			P.[PreostalaVrednost] AS [preostala vrednost],
			P.[Korekcija] AS [Izvedena korekcija ?]
		FROM [dbo].[PodatkiObracuna_Skupni] P
		WHERE p.[ObracunID] = @ObracunID
		ORDER BY CAST(P.Korekcija  AS INT) asc
 
 
    END





GO