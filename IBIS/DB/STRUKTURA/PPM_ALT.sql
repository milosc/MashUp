EXEC [dbo].[AddColumn]
	@TableName = 'PPM', 
	@ColumnName = 'EIC', 
	@ColumnType = 'varchar(50)', 
	@ColumnNull = 'NULL'
GO