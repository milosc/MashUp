USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_18]') AND name = N'IDX_Meritve_Jan_18_Content')
DROP INDEX [IDX_Meritve_Jan_18_Content] ON [dbo].[Meritve_JAN_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_Jan_18_Content] ON [dbo].[Meritve_JAN_18] 
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

/****** Object:  Index [IDX_Meritve_FEB_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_18]') AND name = N'IDX_Meritve_FEB_18_Content')
DROP INDEX [IDX_Meritve_FEB_18_Content] ON [dbo].[Meritve_FEB_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_FEB_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_FEB_18_Content] ON [dbo].[Meritve_FEB_18] 
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

/****** Object:  Index [IDX_Meritve_MAR_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_18]') AND name = N'IDX_Meritve_MAR_18_Content')
DROP INDEX [IDX_Meritve_MAR_18_Content] ON [dbo].[Meritve_MAR_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAR_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAR_18_Content] ON [dbo].[Meritve_MAR_18] 
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

/****** Object:  Index [IDX_Meritve_APR_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_18]') AND name = N'IDX_Meritve_APR_18_Content')
DROP INDEX [IDX_Meritve_APR_18_Content] ON [dbo].[Meritve_APR_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_APR_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_APR_18_Content] ON [dbo].[Meritve_APR_18] 
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

/****** Object:  Index [IDX_Meritve_MAJ_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_18]') AND name = N'IDX_Meritve_MAJ_18_Content')
DROP INDEX [IDX_Meritve_MAJ_18_Content] ON [dbo].[Meritve_MAJ_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAJ_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAJ_18_Content] ON [dbo].[Meritve_MAJ_18] 
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

/****** Object:  Index [IDX_Meritve_JUN_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_18]') AND name = N'IDX_Meritve_JUN_18_Content')
DROP INDEX [IDX_Meritve_JUN_18_Content] ON [dbo].[Meritve_JUN_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUN_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUN_18_Content] ON [dbo].[Meritve_JUN_18] 
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

/****** Object:  Index [IDX_Meritve_JUL_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_18]') AND name = N'IDX_Meritve_JUL_18_Content')
DROP INDEX [IDX_Meritve_JUL_18_Content] ON [dbo].[Meritve_JUL_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUL_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUL_18_Content] ON [dbo].[Meritve_JUL_18] 
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

/****** Object:  Index [IDX_Meritve_AVG_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_18]') AND name = N'IDX_Meritve_AVG_18_Content')
DROP INDEX [IDX_Meritve_AVG_18_Content] ON [dbo].[Meritve_AVG_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_AVG_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_AVG_18_Content] ON [dbo].[Meritve_AVG_18] 
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

/****** Object:  Index [IDX_Meritve_SEP_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_18]') AND name = N'IDX_Meritve_SEP_18_Content')
DROP INDEX [IDX_Meritve_SEP_18_Content] ON [dbo].[Meritve_SEP_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_SEP_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_SEP_18_Content] ON [dbo].[Meritve_SEP_18] 
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

/****** Object:  Index [IDX_Meritve_OKT_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_18]') AND name = N'IDX_Meritve_OKT_18_Content')
DROP INDEX [IDX_Meritve_OKT_18_Content] ON [dbo].[Meritve_OKT_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_OKT_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_OKT_18_Content] ON [dbo].[Meritve_OKT_18] 
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

/****** Object:  Index [IDX_Meritve_NOV_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_18]') AND name = N'IDX_Meritve_NOV_18_Content')
DROP INDEX [IDX_Meritve_NOV_18_Content] ON [dbo].[Meritve_NOV_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_NOV_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_NOV_18_Content] ON [dbo].[Meritve_NOV_18] 
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

/****** Object:  Index [IDX_Meritve_DEC_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_18]') AND name = N'IDX_Meritve_DEC_18_Content')
DROP INDEX [IDX_Meritve_DEC_18_Content] ON [dbo].[Meritve_DEC_18] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_DEC_18_Content]    Script Date: 06/18/2018 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_DEC_18_Content] ON [dbo].[Meritve_DEC_18] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


