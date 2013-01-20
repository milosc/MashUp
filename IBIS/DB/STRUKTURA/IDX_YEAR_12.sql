
GO

/****** Object:  Index [IDX_Meritve_Jan_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_12]') AND name = N'IDX_Meritve_Jan_12_Content')
DROP INDEX [IDX_Meritve_Jan_12_Content] ON [dbo].[Meritve_JAN_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_Jan_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_Jan_12_Content] ON [dbo].[Meritve_JAN_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_FEB_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_12]') AND name = N'IDX_Meritve_FEB_12_Content')
DROP INDEX [IDX_Meritve_FEB_12_Content] ON [dbo].[Meritve_FEB_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_FEB_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_FEB_12_Content] ON [dbo].[Meritve_FEB_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_MAR_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_12]') AND name = N'IDX_Meritve_MAR_12_Content')
DROP INDEX [IDX_Meritve_MAR_12_Content] ON [dbo].[Meritve_MAR_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_MAR_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAR_12_Content] ON [dbo].[Meritve_MAR_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_APR_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_12]') AND name = N'IDX_Meritve_APR_12_Content')
DROP INDEX [IDX_Meritve_APR_12_Content] ON [dbo].[Meritve_APR_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_APR_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_APR_12_Content] ON [dbo].[Meritve_APR_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_MAJ_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_12]') AND name = N'IDX_Meritve_MAJ_12_Content')
DROP INDEX [IDX_Meritve_MAJ_12_Content] ON [dbo].[Meritve_MAJ_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_MAJ_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAJ_12_Content] ON [dbo].[Meritve_MAJ_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_JUN_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_12]') AND name = N'IDX_Meritve_JUN_12_Content')
DROP INDEX [IDX_Meritve_JUN_12_Content] ON [dbo].[Meritve_JUN_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_JUN_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUN_12_Content] ON [dbo].[Meritve_JUN_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_JUL_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_12]') AND name = N'IDX_Meritve_JUL_12_Content')
DROP INDEX [IDX_Meritve_JUL_12_Content] ON [dbo].[Meritve_JUL_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_JUL_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUL_12_Content] ON [dbo].[Meritve_JUL_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_AVG_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_12]') AND name = N'IDX_Meritve_AVG_12_Content')
DROP INDEX [IDX_Meritve_AVG_12_Content] ON [dbo].[Meritve_AVG_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_AVG_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_AVG_12_Content] ON [dbo].[Meritve_AVG_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_SEP_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_12]') AND name = N'IDX_Meritve_SEP_12_Content')
DROP INDEX [IDX_Meritve_SEP_12_Content] ON [dbo].[Meritve_SEP_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_SEP_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_SEP_12_Content] ON [dbo].[Meritve_SEP_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



GO

/****** Object:  Index [IDX_Meritve_OKT_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_12]') AND name = N'IDX_Meritve_OKT_12_Content')
DROP INDEX [IDX_Meritve_OKT_12_Content] ON [dbo].[Meritve_OKT_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_OKT_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_OKT_12_Content] ON [dbo].[Meritve_OKT_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_NOV_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_12]') AND name = N'IDX_Meritve_NOV_12_Content')
DROP INDEX [IDX_Meritve_NOV_12_Content] ON [dbo].[Meritve_NOV_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_NOV_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_NOV_12_Content] ON [dbo].[Meritve_NOV_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


GO

/****** Object:  Index [IDX_Meritve_DEC_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_12]') AND name = N'IDX_Meritve_DEC_12_Content')
DROP INDEX [IDX_Meritve_DEC_12_Content] ON [dbo].[Meritve_DEC_12] WITH ( ONLINE = OFF )
GO


GO

/****** Object:  Index [IDX_Meritve_DEC_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_DEC_12_Content] ON [dbo].[Meritve_DEC_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


