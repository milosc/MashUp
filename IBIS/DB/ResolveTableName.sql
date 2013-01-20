EXEC dbo.DropPRCorUDF @ObjectName = 'ResolveTableName' 
GO

CREATE FUNCTION ResolveTableName ( @DatumOD DATETIME,@DatumDo DATETIME )
RETURNS VARCHAR(100)
AS BEGIN
    DECLARE @OutString VARCHAR(100) ;
    IF @DatumOD IS NULL SET @DatumOD = GETDATE();
	IF @DatumDo IS NULL SET @DatumDo = @DatumOD
	
	
	IF (MONTH(@DatumDo)=MONTH(@DatumOD) AND YEAR(@DatumOD) = YEAR(@DatumDo))
	BEGIN
	--Imamo opravka z obraèunskim obdobjem enega meseca, zato lahko preskoèimo view_Meritve in pridobimo podatke neposredno iz tabele za dan mesec	
		SET @OutString = 'Meritve_' ;
		SET @OutString = @OutString
			+ ( CASE WHEN DATEPART(MONTH, @DatumOD) = 1 THEN 'JAN'
					 WHEN DATEPART(MONTH, @DatumOD) = 2 THEN 'FEB'
					 WHEN DATEPART(MONTH, @DatumOD) = 3 THEN 'MAR'
					 WHEN DATEPART(MONTH, @DatumOD) = 4 THEN 'APR'
					 WHEN DATEPART(MONTH, @DatumOD) = 5 THEN 'MAJ'
					 WHEN DATEPART(MONTH, @DatumOD) = 6 THEN 'JUN'
					 WHEN DATEPART(MONTH, @DatumOD) = 7 THEN 'JUL'
					 WHEN DATEPART(MONTH, @DatumOD) = 8 THEN 'AVG'
					 WHEN DATEPART(MONTH, @DatumOD) = 9 THEN 'SEP'
					 WHEN DATEPART(MONTH, @DatumOD) = 10 THEN 'OKT'
					 WHEN DATEPART(MONTH, @DatumOD) = 11 THEN 'NOV'
					 WHEN DATEPART(MONTH, @DatumOD) = 12 THEN 'DEC'
				END ) + '_'+RIGHT(CAST(DATEPART(YEAR, @DatumOD) AS VARCHAR(4)), 2)
	END
	ELSE
		SET @OutString = 'view_Meritve'
	
    RETURN @OutString
	
	
   END

