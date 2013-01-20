

/****** Object:  Index [IDX_Meritve_Jan_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_17]') AND name = N'IDX_Meritve_Jan_17_Content')
DROP INDEX [IDX_Meritve_Jan_17_Content] ON [dbo].[Meritve_JAN_17] WITH ( ONLINE = OFF )
GO



GO

/****** Object:  Index [IDX_Meritve_FEB_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_17]') AND name = N'IDX_Meritve_FEB_17_Content')
DROP INDEX [IDX_Meritve_FEB_17_Content] ON [dbo].[Meritve_FEB_17] WITH ( ONLINE = OFF )
GO




/****** Object:  Index [IDX_Meritve_MAR_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_17]') AND name = N'IDX_Meritve_MAR_17_Content')
DROP INDEX [IDX_Meritve_MAR_17_Content] ON [dbo].[Meritve_MAR_17] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_APR_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_17]') AND name = N'IDX_Meritve_APR_17_Content')
DROP INDEX [IDX_Meritve_APR_17_Content] ON [dbo].[Meritve_APR_17] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_MAJ_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_17]') AND name = N'IDX_Meritve_MAJ_17_Content')
DROP INDEX [IDX_Meritve_MAJ_17_Content] ON [dbo].[Meritve_MAJ_17] WITH ( ONLINE = OFF )
GO





GO

/****** Object:  Index [IDX_Meritve_JUN_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_17]') AND name = N'IDX_Meritve_JUN_17_Content')
DROP INDEX [IDX_Meritve_JUN_17_Content] ON [dbo].[Meritve_JUN_17] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_JUL_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_17]') AND name = N'IDX_Meritve_JUL_17_Content')
DROP INDEX [IDX_Meritve_JUL_17_Content] ON [dbo].[Meritve_JUL_17] WITH ( ONLINE = OFF )
GO




/****** Object:  Index [IDX_Meritve_AVG_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_17]') AND name = N'IDX_Meritve_AVG_17_Content')
DROP INDEX [IDX_Meritve_AVG_17_Content] ON [dbo].[Meritve_AVG_17] WITH ( ONLINE = OFF )
GO


GO



/****** Object:  Index [IDX_Meritve_SEP_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_17]') AND name = N'IDX_Meritve_SEP_17_Content')
DROP INDEX [IDX_Meritve_SEP_17_Content] ON [dbo].[Meritve_SEP_17] WITH ( ONLINE = OFF )
GO



GO

/****** Object:  Index [IDX_Meritve_OKT_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_17]') AND name = N'IDX_Meritve_OKT_17_Content')
DROP INDEX [IDX_Meritve_OKT_17_Content] ON [dbo].[Meritve_OKT_17] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_NOV_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_17]') AND name = N'IDX_Meritve_NOV_17_Content')
DROP INDEX [IDX_Meritve_NOV_17_Content] ON [dbo].[Meritve_NOV_17] WITH ( ONLINE = OFF )
GO




GO

/****** Object:  Index [IDX_Meritve_DEC_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_17]') AND name = N'IDX_Meritve_DEC_17_Content')
DROP INDEX [IDX_Meritve_DEC_17_Content] ON [dbo].[Meritve_DEC_17] WITH ( ONLINE = OFF )
GO





EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JAN_17', @ConstraintName = 'DV_Meritve_JAN_17_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_FEB_17', @ConstraintName = 'DV_Meritve_FEB_17_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_MAR_17', @ConstraintName = 'DV_Meritve_MAR_17_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_MAJ_17', @ConstraintName = 'DV_Meritve_MAJ_17_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JUN_17', @ConstraintName = 'DV_Meritve_JUN_17_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_JUL_17', @ConstraintName = 'DV_Meritve_JUL_17_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_AVG_17', @ConstraintName = 'DV_Meritve_AVG_17_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_SEP_17', @ConstraintName = 'DV_Meritve_SEP_17_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_OKT_17', @ConstraintName = 'DV_Meritve_OKT_17_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_NOV_17', @ConstraintName = 'DV_Meritve_NOV_17_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_DEC_17', @ConstraintName = 'DV_Meritve_DEC_17_Kolicina'
GO
EXEC dbo.[DropConstraint]	@TableName = 'Meritve_APR_17', @ConstraintName = 'DV_Meritve_APR_17_Kolicina'
GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JAN_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO

EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_FEB_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_MAR_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_APR_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_MAJ_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JUN_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO



EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_JUL_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_AVG_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_SEP_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_OKT_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_NOV_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO


EXEC dbo.[AlterColumn]
	@TableName = 'Meritve_DEC_17', --  varchar(max)
	@ColumnName = 'Kolicina', --  varchar(max)
	@ColumnType = 'float', --  varchar(max)
	@ColumnNull = 'NOT NULL'
	GO





GO

/****** Object:  Index [IDX_Meritve_Jan_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_17]') AND name = N'IDX_Meritve_Jan_17_Content')
DROP INDEX [IDX_Meritve_Jan_17_Content] ON [dbo].[Meritve_JAN_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_Jan_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_Jan_17_Content] ON [dbo].[Meritve_JAN_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_FEB_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_17]') AND name = N'IDX_Meritve_FEB_17_Content')
DROP INDEX [IDX_Meritve_FEB_17_Content] ON [dbo].[Meritve_FEB_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_FEB_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_FEB_17_Content] ON [dbo].[Meritve_FEB_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_MAR_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_17]') AND name = N'IDX_Meritve_MAR_17_Content')
DROP INDEX [IDX_Meritve_MAR_17_Content] ON [dbo].[Meritve_MAR_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_MAR_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAR_17_Content] ON [dbo].[Meritve_MAR_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_APR_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_17]') AND name = N'IDX_Meritve_APR_17_Content')
DROP INDEX [IDX_Meritve_APR_17_Content] ON [dbo].[Meritve_APR_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_APR_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_APR_17_Content] ON [dbo].[Meritve_APR_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_MAJ_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_17]') AND name = N'IDX_Meritve_MAJ_17_Content')
DROP INDEX [IDX_Meritve_MAJ_17_Content] ON [dbo].[Meritve_MAJ_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_MAJ_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAJ_17_Content] ON [dbo].[Meritve_MAJ_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_JUN_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_17]') AND name = N'IDX_Meritve_JUN_17_Content')
DROP INDEX [IDX_Meritve_JUN_17_Content] ON [dbo].[Meritve_JUN_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_JUN_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUN_17_Content] ON [dbo].[Meritve_JUN_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_JUL_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_17]') AND name = N'IDX_Meritve_JUL_17_Content')
DROP INDEX [IDX_Meritve_JUL_17_Content] ON [dbo].[Meritve_JUL_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_JUL_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUL_17_Content] ON [dbo].[Meritve_JUL_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_AVG_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_17]') AND name = N'IDX_Meritve_AVG_17_Content')
DROP INDEX [IDX_Meritve_AVG_17_Content] ON [dbo].[Meritve_AVG_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_AVG_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_AVG_17_Content] ON [dbo].[Meritve_AVG_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_SEP_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_17]') AND name = N'IDX_Meritve_SEP_17_Content')
DROP INDEX [IDX_Meritve_SEP_17_Content] ON [dbo].[Meritve_SEP_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_SEP_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_SEP_17_Content] ON [dbo].[Meritve_SEP_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_OKT_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_17]') AND name = N'IDX_Meritve_OKT_17_Content')
DROP INDEX [IDX_Meritve_OKT_17_Content] ON [dbo].[Meritve_OKT_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_OKT_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_OKT_17_Content] ON [dbo].[Meritve_OKT_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_NOV_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_17]') AND name = N'IDX_Meritve_NOV_17_Content')
DROP INDEX [IDX_Meritve_NOV_17_Content] ON [dbo].[Meritve_NOV_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_NOV_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_NOV_17_Content] ON [dbo].[Meritve_NOV_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_DEC_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_17]') AND name = N'IDX_Meritve_DEC_17_Content')
DROP INDEX [IDX_Meritve_DEC_17_Content] ON [dbo].[Meritve_DEC_17] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_DEC_17_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_DEC_17_Content] ON [dbo].[Meritve_DEC_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


