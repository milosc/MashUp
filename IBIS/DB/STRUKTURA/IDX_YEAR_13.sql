USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_13]') AND name = N'IDX_Meritve_Jan_13_Content')
DROP INDEX [IDX_Meritve_Jan_13_Content] ON [dbo].[Meritve_JAN_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_Jan_13_Content] ON [dbo].[Meritve_JAN_13] 
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

/****** Object:  Index [IDX_Meritve_FEB_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_13]') AND name = N'IDX_Meritve_FEB_13_Content')
DROP INDEX [IDX_Meritve_FEB_13_Content] ON [dbo].[Meritve_FEB_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_FEB_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_FEB_13_Content] ON [dbo].[Meritve_FEB_13] 
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

/****** Object:  Index [IDX_Meritve_MAR_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_13]') AND name = N'IDX_Meritve_MAR_13_Content')
DROP INDEX [IDX_Meritve_MAR_13_Content] ON [dbo].[Meritve_MAR_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAR_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAR_13_Content] ON [dbo].[Meritve_MAR_13] 
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

/****** Object:  Index [IDX_Meritve_APR_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_13]') AND name = N'IDX_Meritve_APR_13_Content')
DROP INDEX [IDX_Meritve_APR_13_Content] ON [dbo].[Meritve_APR_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_APR_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_APR_13_Content] ON [dbo].[Meritve_APR_13] 
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

/****** Object:  Index [IDX_Meritve_MAJ_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_13]') AND name = N'IDX_Meritve_MAJ_13_Content')
DROP INDEX [IDX_Meritve_MAJ_13_Content] ON [dbo].[Meritve_MAJ_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAJ_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAJ_13_Content] ON [dbo].[Meritve_MAJ_13] 
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

/****** Object:  Index [IDX_Meritve_JUN_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_13]') AND name = N'IDX_Meritve_JUN_13_Content')
DROP INDEX [IDX_Meritve_JUN_13_Content] ON [dbo].[Meritve_JUN_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUN_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUN_13_Content] ON [dbo].[Meritve_JUN_13] 
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

/****** Object:  Index [IDX_Meritve_JUL_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_13]') AND name = N'IDX_Meritve_JUL_13_Content')
DROP INDEX [IDX_Meritve_JUL_13_Content] ON [dbo].[Meritve_JUL_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUL_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUL_13_Content] ON [dbo].[Meritve_JUL_13] 
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

/****** Object:  Index [IDX_Meritve_AVG_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_13]') AND name = N'IDX_Meritve_AVG_13_Content')
DROP INDEX [IDX_Meritve_AVG_13_Content] ON [dbo].[Meritve_AVG_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_AVG_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_AVG_13_Content] ON [dbo].[Meritve_AVG_13] 
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

/****** Object:  Index [IDX_Meritve_SEP_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_13]') AND name = N'IDX_Meritve_SEP_13_Content')
DROP INDEX [IDX_Meritve_SEP_13_Content] ON [dbo].[Meritve_SEP_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_SEP_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_SEP_13_Content] ON [dbo].[Meritve_SEP_13] 
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

/****** Object:  Index [IDX_Meritve_OKT_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_13]') AND name = N'IDX_Meritve_OKT_13_Content')
DROP INDEX [IDX_Meritve_OKT_13_Content] ON [dbo].[Meritve_OKT_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_OKT_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_OKT_13_Content] ON [dbo].[Meritve_OKT_13] 
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

/****** Object:  Index [IDX_Meritve_NOV_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_13]') AND name = N'IDX_Meritve_NOV_13_Content')
DROP INDEX [IDX_Meritve_NOV_13_Content] ON [dbo].[Meritve_NOV_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_NOV_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_NOV_13_Content] ON [dbo].[Meritve_NOV_13] 
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

/****** Object:  Index [IDX_Meritve_DEC_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_13]') AND name = N'IDX_Meritve_DEC_13_Content')
DROP INDEX [IDX_Meritve_DEC_13_Content] ON [dbo].[Meritve_DEC_13] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_DEC_13_Content]    Script Date: 06/13/2013 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_DEC_13_Content] ON [dbo].[Meritve_DEC_13] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


