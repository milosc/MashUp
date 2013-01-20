EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JAN_12', @ConstraintName = 'DV_Meritve_JAN_12_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_FEB_12', @ConstraintName = 'DV_Meritve_FEB_12_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_MAR_12', @ConstraintName = 'DV_Meritve_MAR_12_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_MAJ_12', @ConstraintName = 'DV_Meritve_MAJ_12_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JUN_12', @ConstraintName = 'DV_Meritve_JUN_12_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JUL_12', @ConstraintName = 'DV_Meritve_JUL_12_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_AVG_12', @ConstraintName = 'DV_Meritve_AVG_12_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_SEP_12', @ConstraintName = 'DV_Meritve_SEP_12_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_OKT_12', @ConstraintName = 'DV_Meritve_OKT_12_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_NOV_12', @ConstraintName = 'DV_Meritve_NOV_12_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_DEC_12', @ConstraintName = 'DV_Meritve_DEC_12_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_APR_12', @ConstraintName = 'DV_Meritve_APR_12_Kolicina'
GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JAN_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO

EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_FEB_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_MAR_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_APR_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_MAJ_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JUN_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JUL_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_AVG_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_SEP_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_OKT_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_NOV_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_DEC_12', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


