

/****** Object:  Index [IDX_Meritve_Jan_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_13]') AND name = N'IDX_Meritve_Jan_13_Content')
DROP INDEX [IDX_Meritve_Jan_13_Content] ON [dbo].[Meritve_JAN_13] WITH ( ONLINE = OFF )
GO



GO

/****** Object:  Index [IDX_Meritve_FEB_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_13]') AND name = N'IDX_Meritve_FEB_13_Content')
DROP INDEX [IDX_Meritve_FEB_13_Content] ON [dbo].[Meritve_FEB_13] WITH ( ONLINE = OFF )
GO




/****** Object:  Index [IDX_Meritve_MAR_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_13]') AND name = N'IDX_Meritve_MAR_13_Content')
DROP INDEX [IDX_Meritve_MAR_13_Content] ON [dbo].[Meritve_MAR_13] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_APR_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_13]') AND name = N'IDX_Meritve_APR_13_Content')
DROP INDEX [IDX_Meritve_APR_13_Content] ON [dbo].[Meritve_APR_13] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_MAJ_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_13]') AND name = N'IDX_Meritve_MAJ_13_Content')
DROP INDEX [IDX_Meritve_MAJ_13_Content] ON [dbo].[Meritve_MAJ_13] WITH ( ONLINE = OFF )
GO





GO

/****** Object:  Index [IDX_Meritve_JUN_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_13]') AND name = N'IDX_Meritve_JUN_13_Content')
DROP INDEX [IDX_Meritve_JUN_13_Content] ON [dbo].[Meritve_JUN_13] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_JUL_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_13]') AND name = N'IDX_Meritve_JUL_13_Content')
DROP INDEX [IDX_Meritve_JUL_13_Content] ON [dbo].[Meritve_JUL_13] WITH ( ONLINE = OFF )
GO




/****** Object:  Index [IDX_Meritve_AVG_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_13]') AND name = N'IDX_Meritve_AVG_13_Content')
DROP INDEX [IDX_Meritve_AVG_13_Content] ON [dbo].[Meritve_AVG_13] WITH ( ONLINE = OFF )
GO


GO



/****** Object:  Index [IDX_Meritve_SEP_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_13]') AND name = N'IDX_Meritve_SEP_13_Content')
DROP INDEX [IDX_Meritve_SEP_13_Content] ON [dbo].[Meritve_SEP_13] WITH ( ONLINE = OFF )
GO



GO

/****** Object:  Index [IDX_Meritve_OKT_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_13]') AND name = N'IDX_Meritve_OKT_13_Content')
DROP INDEX [IDX_Meritve_OKT_13_Content] ON [dbo].[Meritve_OKT_13] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_NOV_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_13]') AND name = N'IDX_Meritve_NOV_13_Content')
DROP INDEX [IDX_Meritve_NOV_13_Content] ON [dbo].[Meritve_NOV_13] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_DEC_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_13]') AND name = N'IDX_Meritve_DEC_13_Content')
DROP INDEX [IDX_Meritve_DEC_13_Content] ON [dbo].[Meritve_DEC_13] WITH ( ONLINE = OFF )
GO





EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JAN_13', @ConstraintName = 'DV_Meritve_JAN_13_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_FEB_13', @ConstraintName = 'DV_Meritve_FEB_13_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_MAR_13', @ConstraintName = 'DV_Meritve_MAR_13_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_MAJ_13', @ConstraintName = 'DV_Meritve_MAJ_13_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JUN_13', @ConstraintName = 'DV_Meritve_JUN_13_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JUL_13', @ConstraintName = 'DV_Meritve_JUL_13_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_AVG_13', @ConstraintName = 'DV_Meritve_AVG_13_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_SEP_13', @ConstraintName = 'DV_Meritve_SEP_13_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_OKT_13', @ConstraintName = 'DV_Meritve_OKT_13_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_NOV_13', @ConstraintName = 'DV_Meritve_NOV_13_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_DEC_13', @ConstraintName = 'DV_Meritve_DEC_13_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_APR_13', @ConstraintName = 'DV_Meritve_APR_13_Kolicina'
GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JAN_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO

EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_FEB_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_MAR_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_APR_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_MAJ_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JUN_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JUL_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_AVG_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_SEP_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_OKT_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_NOV_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_DEC_13', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO





GO

/****** Object:  Index [IDX_Meritve_Jan_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_13]') AND name = N'IDX_Meritve_Jan_13_Content')
DROP INDEX [IDX_Meritve_Jan_13_Content] ON [dbo].[Meritve_JAN_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_Jan_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_Jan_13_Content] ON [dbo].[Meritve_JAN_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_FEB_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_13]') AND name = N'IDX_Meritve_FEB_13_Content')
DROP INDEX [IDX_Meritve_FEB_13_Content] ON [dbo].[Meritve_FEB_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_FEB_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_FEB_13_Content] ON [dbo].[Meritve_FEB_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_MAR_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_13]') AND name = N'IDX_Meritve_MAR_13_Content')
DROP INDEX [IDX_Meritve_MAR_13_Content] ON [dbo].[Meritve_MAR_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_MAR_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAR_13_Content] ON [dbo].[Meritve_MAR_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_APR_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_13]') AND name = N'IDX_Meritve_APR_13_Content')
DROP INDEX [IDX_Meritve_APR_13_Content] ON [dbo].[Meritve_APR_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_APR_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_APR_13_Content] ON [dbo].[Meritve_APR_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_MAJ_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_13]') AND name = N'IDX_Meritve_MAJ_13_Content')
DROP INDEX [IDX_Meritve_MAJ_13_Content] ON [dbo].[Meritve_MAJ_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_MAJ_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAJ_13_Content] ON [dbo].[Meritve_MAJ_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_JUN_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_13]') AND name = N'IDX_Meritve_JUN_13_Content')
DROP INDEX [IDX_Meritve_JUN_13_Content] ON [dbo].[Meritve_JUN_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_JUN_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUN_13_Content] ON [dbo].[Meritve_JUN_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_JUL_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_13]') AND name = N'IDX_Meritve_JUL_13_Content')
DROP INDEX [IDX_Meritve_JUL_13_Content] ON [dbo].[Meritve_JUL_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_JUL_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUL_13_Content] ON [dbo].[Meritve_JUL_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_AVG_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_13]') AND name = N'IDX_Meritve_AVG_13_Content')
DROP INDEX [IDX_Meritve_AVG_13_Content] ON [dbo].[Meritve_AVG_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_AVG_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_AVG_13_Content] ON [dbo].[Meritve_AVG_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_SEP_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_13]') AND name = N'IDX_Meritve_SEP_13_Content')
DROP INDEX [IDX_Meritve_SEP_13_Content] ON [dbo].[Meritve_SEP_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_SEP_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_SEP_13_Content] ON [dbo].[Meritve_SEP_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_OKT_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_13]') AND name = N'IDX_Meritve_OKT_13_Content')
DROP INDEX [IDX_Meritve_OKT_13_Content] ON [dbo].[Meritve_OKT_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_OKT_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_OKT_13_Content] ON [dbo].[Meritve_OKT_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_NOV_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_13]') AND name = N'IDX_Meritve_NOV_13_Content')
DROP INDEX [IDX_Meritve_NOV_13_Content] ON [dbo].[Meritve_NOV_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_NOV_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_NOV_13_Content] ON [dbo].[Meritve_NOV_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_DEC_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_13]') AND name = N'IDX_Meritve_DEC_13_Content')
DROP INDEX [IDX_Meritve_DEC_13_Content] ON [dbo].[Meritve_DEC_13] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_DEC_13_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_DEC_13_Content] ON [dbo].[Meritve_DEC_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


