USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_15]') AND name = N'IDX_Meritve_Jan_15_Content')
DROP INDEX [IDX_Meritve_Jan_15_Content] ON [dbo].[Meritve_JAN_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_Jan_15_Content] ON [dbo].[Meritve_JAN_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_FEB_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_15]') AND name = N'IDX_Meritve_FEB_15_Content')
DROP INDEX [IDX_Meritve_FEB_15_Content] ON [dbo].[Meritve_FEB_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_FEB_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_FEB_15_Content] ON [dbo].[Meritve_FEB_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAR_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_15]') AND name = N'IDX_Meritve_MAR_15_Content')
DROP INDEX [IDX_Meritve_MAR_15_Content] ON [dbo].[Meritve_MAR_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAR_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAR_15_Content] ON [dbo].[Meritve_MAR_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_APR_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_15]') AND name = N'IDX_Meritve_APR_15_Content')
DROP INDEX [IDX_Meritve_APR_15_Content] ON [dbo].[Meritve_APR_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_APR_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_APR_15_Content] ON [dbo].[Meritve_APR_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAJ_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_15]') AND name = N'IDX_Meritve_MAJ_15_Content')
DROP INDEX [IDX_Meritve_MAJ_15_Content] ON [dbo].[Meritve_MAJ_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAJ_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAJ_15_Content] ON [dbo].[Meritve_MAJ_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUN_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_15]') AND name = N'IDX_Meritve_JUN_15_Content')
DROP INDEX [IDX_Meritve_JUN_15_Content] ON [dbo].[Meritve_JUN_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUN_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUN_15_Content] ON [dbo].[Meritve_JUN_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUL_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_15]') AND name = N'IDX_Meritve_JUL_15_Content')
DROP INDEX [IDX_Meritve_JUL_15_Content] ON [dbo].[Meritve_JUL_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUL_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUL_15_Content] ON [dbo].[Meritve_JUL_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_AVG_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_15]') AND name = N'IDX_Meritve_AVG_15_Content')
DROP INDEX [IDX_Meritve_AVG_15_Content] ON [dbo].[Meritve_AVG_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_AVG_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_AVG_15_Content] ON [dbo].[Meritve_AVG_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_SEP_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_15]') AND name = N'IDX_Meritve_SEP_15_Content')
DROP INDEX [IDX_Meritve_SEP_15_Content] ON [dbo].[Meritve_SEP_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_SEP_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_SEP_15_Content] ON [dbo].[Meritve_SEP_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_OKT_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_15]') AND name = N'IDX_Meritve_OKT_15_Content')
DROP INDEX [IDX_Meritve_OKT_15_Content] ON [dbo].[Meritve_OKT_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_OKT_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_OKT_15_Content] ON [dbo].[Meritve_OKT_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_NOV_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_15]') AND name = N'IDX_Meritve_NOV_15_Content')
DROP INDEX [IDX_Meritve_NOV_15_Content] ON [dbo].[Meritve_NOV_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_NOV_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_NOV_15_Content] ON [dbo].[Meritve_NOV_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_DEC_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_15]') AND name = N'IDX_Meritve_DEC_15_Content')
DROP INDEX [IDX_Meritve_DEC_15_Content] ON [dbo].[Meritve_DEC_15] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_DEC_15_Content]    Script Date: 06/15/2015 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_DEC_15_Content] ON [dbo].[Meritve_DEC_15] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


