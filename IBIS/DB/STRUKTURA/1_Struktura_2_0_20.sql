EXEC dbo.AddColumn	@TableName = 'Regulacija',	@ColumnName = 'SekRegSp', 	@ColumnType = 'decimal(22,8)', 	@ColumnNull = 'not null', 	@ColumnDefault = '0'
GO

EXEC dbo.AddColumn	@TableName = 'Regulacija',	@ColumnName = 'SekRegSm', 	@ColumnType = 'decimal(22,8)', 	@ColumnNull = 'not null', 	@ColumnDefault = '0'
GO

EXEC dbo.AddColumn	@TableName = 'Regulacija',	@ColumnName = 'TerRegSp', 	@ColumnType = 'decimal(22,8)', 	@ColumnNull = 'not null', 	@ColumnDefault = '0'
GO

EXEC dbo.AddColumn	@TableName = 'Regulacija',	@ColumnName = 'TerRegSm', 	@ColumnType = 'decimal(22,8)', 	@ColumnNull = 'not null', 	@ColumnDefault = '0'
GO


EXEC dbo.AddColumn	@TableName = 'RegulacijaEIP',	@ColumnName = 'SekRegSp', 	@ColumnType = 'decimal(22,8)', 	@ColumnNull = 'not null', 	@ColumnDefault = '0'
GO

EXEC dbo.AddColumn	@TableName = 'RegulacijaEIP',	@ColumnName = 'SekRegSm', 	@ColumnType = 'decimal(22,8)', 	@ColumnNull = 'not null', 	@ColumnDefault = '0'
GO

EXEC dbo.AddColumn	@TableName = 'RegulacijaEIP',	@ColumnName = 'TerRegSp', 	@ColumnType = 'decimal(22,8)', 	@ColumnNull = 'not null', 	@ColumnDefault = '0'
GO

EXEC dbo.AddColumn	@TableName = 'RegulacijaEIP',	@ColumnName = 'TerRegSm', 	@ColumnType = 'decimal(22,8)', 	@ColumnNull = 'not null', 	@ColumnDefault = '0'
GO