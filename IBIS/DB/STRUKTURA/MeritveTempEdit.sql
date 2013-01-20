EXEC [dbo].[AlterColumn]
	@TableName = 'MeritveTemp', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'decimal(24,8)', --  varchar(max)
	@ColumnNull = 'NOT NULL', --  varchar(max)
	@ColumnDefault = '(0)' --  varchar(max)
GO