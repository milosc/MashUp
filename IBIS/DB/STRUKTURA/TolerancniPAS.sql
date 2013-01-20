EXEC [dbo].[AddColumn]
	@TableName = 'TolerancniPas', 
	@ColumnName = 'KoregiranT', 
	@ColumnType = 'decimal(19,8)', 
	@ColumnNull = 'NOT NULL', 
	@ColumnDefault = '(0)' 
GO