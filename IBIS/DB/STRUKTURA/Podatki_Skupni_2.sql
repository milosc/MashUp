EXEC [dbo].[AddColumn]
	@TableName = 'PodatkiObracuna_Skupni',
	@ColumnName = 'Wgjs_p', --  varchar(max)
	@ColumnType = 'decimal(24,8)', --  varchar(max)
	@ColumnNull = 'NOT NULL', --  varchar(max)
	@ColumnDefault = '(0)' --  varchar(max)
GO

EXEC [dbo].[AddColumn]
	@TableName = 'PodatkiObracuna_Skupni',
	@ColumnName = 'Wgjs_m', --  varchar(max)
	@ColumnType = 'decimal(24,8)', --  varchar(max)
	@ColumnNull = 'NOT NULL', --  varchar(max)
	@ColumnDefault = '(0)' --  varchar(max)
GO

EXEC [dbo].[AddColumn]
	@TableName = 'PodatkiObracuna_Skupni',
	@ColumnName = 'PreostalaVrednost', --  varchar(max)
	@ColumnType = 'decimal(24,8)', --  varchar(max)
	@ColumnNull = 'NOT NULL', --  varchar(max)
	@ColumnDefault = '(0)' --  varchar(max)
GO