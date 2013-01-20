

/****** Object:  Index [IDX_Meritve_Jan_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_14]') AND name = N'IDX_Meritve_Jan_14_Content')
DROP INDEX [IDX_Meritve_Jan_14_Content] ON [dbo].[Meritve_JAN_14] WITH ( ONLINE = OFF )
GO



GO

/****** Object:  Index [IDX_Meritve_FEB_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_14]') AND name = N'IDX_Meritve_FEB_14_Content')
DROP INDEX [IDX_Meritve_FEB_14_Content] ON [dbo].[Meritve_FEB_14] WITH ( ONLINE = OFF )
GO




/****** Object:  Index [IDX_Meritve_MAR_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_14]') AND name = N'IDX_Meritve_MAR_14_Content')
DROP INDEX [IDX_Meritve_MAR_14_Content] ON [dbo].[Meritve_MAR_14] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_APR_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_14]') AND name = N'IDX_Meritve_APR_14_Content')
DROP INDEX [IDX_Meritve_APR_14_Content] ON [dbo].[Meritve_APR_14] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_MAJ_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_14]') AND name = N'IDX_Meritve_MAJ_14_Content')
DROP INDEX [IDX_Meritve_MAJ_14_Content] ON [dbo].[Meritve_MAJ_14] WITH ( ONLINE = OFF )
GO





GO

/****** Object:  Index [IDX_Meritve_JUN_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_14]') AND name = N'IDX_Meritve_JUN_14_Content')
DROP INDEX [IDX_Meritve_JUN_14_Content] ON [dbo].[Meritve_JUN_14] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_JUL_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_14]') AND name = N'IDX_Meritve_JUL_14_Content')
DROP INDEX [IDX_Meritve_JUL_14_Content] ON [dbo].[Meritve_JUL_14] WITH ( ONLINE = OFF )
GO




/****** Object:  Index [IDX_Meritve_AVG_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_14]') AND name = N'IDX_Meritve_AVG_14_Content')
DROP INDEX [IDX_Meritve_AVG_14_Content] ON [dbo].[Meritve_AVG_14] WITH ( ONLINE = OFF )
GO


GO



/****** Object:  Index [IDX_Meritve_SEP_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_14]') AND name = N'IDX_Meritve_SEP_14_Content')
DROP INDEX [IDX_Meritve_SEP_14_Content] ON [dbo].[Meritve_SEP_14] WITH ( ONLINE = OFF )
GO



GO

/****** Object:  Index [IDX_Meritve_OKT_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_14]') AND name = N'IDX_Meritve_OKT_14_Content')
DROP INDEX [IDX_Meritve_OKT_14_Content] ON [dbo].[Meritve_OKT_14] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_NOV_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_14]') AND name = N'IDX_Meritve_NOV_14_Content')
DROP INDEX [IDX_Meritve_NOV_14_Content] ON [dbo].[Meritve_NOV_14] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_DEC_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_14]') AND name = N'IDX_Meritve_DEC_14_Content')
DROP INDEX [IDX_Meritve_DEC_14_Content] ON [dbo].[Meritve_DEC_14] WITH ( ONLINE = OFF )
GO





EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JAN_14', @ConstraintName = 'DV_Meritve_JAN_14_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_FEB_14', @ConstraintName = 'DV_Meritve_FEB_14_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_MAR_14', @ConstraintName = 'DV_Meritve_MAR_14_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_MAJ_14', @ConstraintName = 'DV_Meritve_MAJ_14_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JUN_14', @ConstraintName = 'DV_Meritve_JUN_14_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JUL_14', @ConstraintName = 'DV_Meritve_JUL_14_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_AVG_14', @ConstraintName = 'DV_Meritve_AVG_14_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_SEP_14', @ConstraintName = 'DV_Meritve_SEP_14_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_OKT_14', @ConstraintName = 'DV_Meritve_OKT_14_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_NOV_14', @ConstraintName = 'DV_Meritve_NOV_14_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_DEC_14', @ConstraintName = 'DV_Meritve_DEC_14_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_APR_14', @ConstraintName = 'DV_Meritve_APR_14_Kolicina'
GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JAN_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO

EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_FEB_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_MAR_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_APR_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_MAJ_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JUN_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JUL_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_AVG_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_SEP_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_OKT_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_NOV_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_DEC_14', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO





GO

/****** Object:  Index [IDX_Meritve_Jan_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_14]') AND name = N'IDX_Meritve_Jan_14_Content')
DROP INDEX [IDX_Meritve_Jan_14_Content] ON [dbo].[Meritve_JAN_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_Jan_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_Jan_14_Content] ON [dbo].[Meritve_JAN_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_FEB_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_14]') AND name = N'IDX_Meritve_FEB_14_Content')
DROP INDEX [IDX_Meritve_FEB_14_Content] ON [dbo].[Meritve_FEB_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_FEB_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_FEB_14_Content] ON [dbo].[Meritve_FEB_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_MAR_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_14]') AND name = N'IDX_Meritve_MAR_14_Content')
DROP INDEX [IDX_Meritve_MAR_14_Content] ON [dbo].[Meritve_MAR_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_MAR_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAR_14_Content] ON [dbo].[Meritve_MAR_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_APR_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_14]') AND name = N'IDX_Meritve_APR_14_Content')
DROP INDEX [IDX_Meritve_APR_14_Content] ON [dbo].[Meritve_APR_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_APR_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_APR_14_Content] ON [dbo].[Meritve_APR_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_MAJ_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_14]') AND name = N'IDX_Meritve_MAJ_14_Content')
DROP INDEX [IDX_Meritve_MAJ_14_Content] ON [dbo].[Meritve_MAJ_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_MAJ_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAJ_14_Content] ON [dbo].[Meritve_MAJ_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_JUN_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_14]') AND name = N'IDX_Meritve_JUN_14_Content')
DROP INDEX [IDX_Meritve_JUN_14_Content] ON [dbo].[Meritve_JUN_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_JUN_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUN_14_Content] ON [dbo].[Meritve_JUN_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_JUL_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_14]') AND name = N'IDX_Meritve_JUL_14_Content')
DROP INDEX [IDX_Meritve_JUL_14_Content] ON [dbo].[Meritve_JUL_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_JUL_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUL_14_Content] ON [dbo].[Meritve_JUL_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_AVG_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_14]') AND name = N'IDX_Meritve_AVG_14_Content')
DROP INDEX [IDX_Meritve_AVG_14_Content] ON [dbo].[Meritve_AVG_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_AVG_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_AVG_14_Content] ON [dbo].[Meritve_AVG_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_SEP_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_14]') AND name = N'IDX_Meritve_SEP_14_Content')
DROP INDEX [IDX_Meritve_SEP_14_Content] ON [dbo].[Meritve_SEP_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_SEP_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_SEP_14_Content] ON [dbo].[Meritve_SEP_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_OKT_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_14]') AND name = N'IDX_Meritve_OKT_14_Content')
DROP INDEX [IDX_Meritve_OKT_14_Content] ON [dbo].[Meritve_OKT_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_OKT_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_OKT_14_Content] ON [dbo].[Meritve_OKT_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_NOV_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_14]') AND name = N'IDX_Meritve_NOV_14_Content')
DROP INDEX [IDX_Meritve_NOV_14_Content] ON [dbo].[Meritve_NOV_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_NOV_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_NOV_14_Content] ON [dbo].[Meritve_NOV_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_DEC_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_14]') AND name = N'IDX_Meritve_DEC_14_Content')
DROP INDEX [IDX_Meritve_DEC_14_Content] ON [dbo].[Meritve_DEC_14] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_DEC_14_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_DEC_14_Content] ON [dbo].[Meritve_DEC_14] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


