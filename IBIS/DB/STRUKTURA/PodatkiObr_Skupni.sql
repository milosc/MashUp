EXEC [dbo].[DropConstraint]
	@TableName = 'PodatkiObracuna_Skupni', --  varchar(max)
	@ConstraintName = 'DF_PodatkiObracuna_Skupni_Korekcija' --  varchar(max)
go

EXEC dbo.[AlterColumn]
	@TableName = 'PodatkiObracuna_Skupni', --  varchar(max)
	@ColumnName = 'Korekcija', --  varchar(max)
	@ColumnType = 'varchar(4)', --  varchar(max)
	@ColumnNull = 'NOT NULL', --  varchar(max)
	@ColumnDefault = '''N''' --  varchar(max)
GO

EXEC [dbo].[DropConstraint]
	@TableName = 'PodatkiObracuna_Skupni', --  varchar(max)
	@ConstraintName = 'DV_PodatkiObracuna_Skupni_Korekcija' --  varchar(max)
go

EXEC dbo.[AlterColumn]
	@TableName = 'PodatkiObracuna_Skupni', --  varchar(max)
	@ColumnName = 'Korekcija', --  varchar(max)
	@ColumnType = 'varchar(4)', --  varchar(max)
	@ColumnNull = 'NOT NULL', --  varchar(max)
	@ColumnDefault = '''9999''' --  varchar(max)
GO
