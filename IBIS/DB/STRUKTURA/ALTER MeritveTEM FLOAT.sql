EXEC dbo.[DropConstraint]
	@TableName = 'MeritveTemp', --  varchar(max)
	@ConstraintName = 'DV_MeritveTemp_Kolicina' --  varchar(max)
GO

EXEC dbo.[AlterColumn]
	@TableName = 'MeritveTemp', --  varchar(max)
	@ColumnName = 'kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL', --  varchar(max)
	@ColumnDefault = '0' --  varchar(max)
	GO

