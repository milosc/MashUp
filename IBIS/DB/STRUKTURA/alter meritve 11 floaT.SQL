EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JAN_11', @ConstraintName = 'DV_Meritve_JAN_11_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_FEB_11', @ConstraintName = 'DV_Meritve_FEB_11_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_MAR_11', @ConstraintName = 'DV_Meritve_MAR_11_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_MAJ_11', @ConstraintName = 'DV_Meritve_MAJ_11_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JUN_11', @ConstraintName = 'DV_Meritve_JUN_11_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JUL_11', @ConstraintName = 'DV_Meritve_JUL_11_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_AVG_11', @ConstraintName = 'DV_Meritve_AVG_11_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_SEP_11', @ConstraintName = 'DV_Meritve_SEP_11_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_OKT_11', @ConstraintName = 'DV_Meritve_OKT_11_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_NOV_11', @ConstraintName = 'DV_Meritve_NOV_11_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_DEC_11', @ConstraintName = 'DV_Meritve_DEC_11_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_APR_11', @ConstraintName = 'DV_Meritve_APR_11_Kolicina'
GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JAN_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO

EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_FEB_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_MAR_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_APR_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_MAJ_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JUN_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JUL_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_AVG_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_SEP_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_OKT_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_NOV_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_DEC_11', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


