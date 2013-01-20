USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_17]') AND name = N'IDX_Meritve_Jan_17_Content')
DROP INDEX [IDX_Meritve_Jan_17_Content] ON [dbo].[Meritve_JAN_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_Jan_17_Content] ON [dbo].[Meritve_JAN_17] 
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

/****** Object:  Index [IDX_Meritve_FEB_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_17]') AND name = N'IDX_Meritve_FEB_17_Content')
DROP INDEX [IDX_Meritve_FEB_17_Content] ON [dbo].[Meritve_FEB_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_FEB_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_FEB_17_Content] ON [dbo].[Meritve_FEB_17] 
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

/****** Object:  Index [IDX_Meritve_MAR_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_17]') AND name = N'IDX_Meritve_MAR_17_Content')
DROP INDEX [IDX_Meritve_MAR_17_Content] ON [dbo].[Meritve_MAR_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAR_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAR_17_Content] ON [dbo].[Meritve_MAR_17] 
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

/****** Object:  Index [IDX_Meritve_APR_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_17]') AND name = N'IDX_Meritve_APR_17_Content')
DROP INDEX [IDX_Meritve_APR_17_Content] ON [dbo].[Meritve_APR_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_APR_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_APR_17_Content] ON [dbo].[Meritve_APR_17] 
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

/****** Object:  Index [IDX_Meritve_MAJ_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_17]') AND name = N'IDX_Meritve_MAJ_17_Content')
DROP INDEX [IDX_Meritve_MAJ_17_Content] ON [dbo].[Meritve_MAJ_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAJ_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAJ_17_Content] ON [dbo].[Meritve_MAJ_17] 
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

/****** Object:  Index [IDX_Meritve_JUN_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_17]') AND name = N'IDX_Meritve_JUN_17_Content')
DROP INDEX [IDX_Meritve_JUN_17_Content] ON [dbo].[Meritve_JUN_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUN_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUN_17_Content] ON [dbo].[Meritve_JUN_17] 
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

/****** Object:  Index [IDX_Meritve_JUL_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_17]') AND name = N'IDX_Meritve_JUL_17_Content')
DROP INDEX [IDX_Meritve_JUL_17_Content] ON [dbo].[Meritve_JUL_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUL_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUL_17_Content] ON [dbo].[Meritve_JUL_17] 
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

/****** Object:  Index [IDX_Meritve_AVG_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_17]') AND name = N'IDX_Meritve_AVG_17_Content')
DROP INDEX [IDX_Meritve_AVG_17_Content] ON [dbo].[Meritve_AVG_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_AVG_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_AVG_17_Content] ON [dbo].[Meritve_AVG_17] 
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

/****** Object:  Index [IDX_Meritve_SEP_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_17]') AND name = N'IDX_Meritve_SEP_17_Content')
DROP INDEX [IDX_Meritve_SEP_17_Content] ON [dbo].[Meritve_SEP_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_SEP_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_SEP_17_Content] ON [dbo].[Meritve_SEP_17] 
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

/****** Object:  Index [IDX_Meritve_OKT_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_17]') AND name = N'IDX_Meritve_OKT_17_Content')
DROP INDEX [IDX_Meritve_OKT_17_Content] ON [dbo].[Meritve_OKT_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_OKT_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_OKT_17_Content] ON [dbo].[Meritve_OKT_17] 
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

/****** Object:  Index [IDX_Meritve_NOV_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_17]') AND name = N'IDX_Meritve_NOV_17_Content')
DROP INDEX [IDX_Meritve_NOV_17_Content] ON [dbo].[Meritve_NOV_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_NOV_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_NOV_17_Content] ON [dbo].[Meritve_NOV_17] 
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

/****** Object:  Index [IDX_Meritve_DEC_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_17]') AND name = N'IDX_Meritve_DEC_17_Content')
DROP INDEX [IDX_Meritve_DEC_17_Content] ON [dbo].[Meritve_DEC_17] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_DEC_17_Content]    Script Date: 06/17/2017 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_DEC_17_Content] ON [dbo].[Meritve_DEC_17] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


