USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_16]') AND name = N'IDX_Meritve_Jan_16_Content')
DROP INDEX [IDX_Meritve_Jan_16_Content] ON [dbo].[Meritve_JAN_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_Jan_16_Content] ON [dbo].[Meritve_JAN_16] 
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

/****** Object:  Index [IDX_Meritve_FEB_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_FEB_16]') AND name = N'IDX_Meritve_FEB_16_Content')
DROP INDEX [IDX_Meritve_FEB_16_Content] ON [dbo].[Meritve_FEB_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_FEB_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_FEB_16_Content] ON [dbo].[Meritve_FEB_16] 
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

/****** Object:  Index [IDX_Meritve_MAR_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAR_16]') AND name = N'IDX_Meritve_MAR_16_Content')
DROP INDEX [IDX_Meritve_MAR_16_Content] ON [dbo].[Meritve_MAR_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAR_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAR_16_Content] ON [dbo].[Meritve_MAR_16] 
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

/****** Object:  Index [IDX_Meritve_APR_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_APR_16]') AND name = N'IDX_Meritve_APR_16_Content')
DROP INDEX [IDX_Meritve_APR_16_Content] ON [dbo].[Meritve_APR_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_APR_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_APR_16_Content] ON [dbo].[Meritve_APR_16] 
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

/****** Object:  Index [IDX_Meritve_MAJ_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_MAJ_16]') AND name = N'IDX_Meritve_MAJ_16_Content')
DROP INDEX [IDX_Meritve_MAJ_16_Content] ON [dbo].[Meritve_MAJ_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_MAJ_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_MAJ_16_Content] ON [dbo].[Meritve_MAJ_16] 
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

/****** Object:  Index [IDX_Meritve_JUN_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUN_16]') AND name = N'IDX_Meritve_JUN_16_Content')
DROP INDEX [IDX_Meritve_JUN_16_Content] ON [dbo].[Meritve_JUN_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUN_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUN_16_Content] ON [dbo].[Meritve_JUN_16] 
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

/****** Object:  Index [IDX_Meritve_JUL_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JUL_16]') AND name = N'IDX_Meritve_JUL_16_Content')
DROP INDEX [IDX_Meritve_JUL_16_Content] ON [dbo].[Meritve_JUL_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_JUL_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_JUL_16_Content] ON [dbo].[Meritve_JUL_16] 
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

/****** Object:  Index [IDX_Meritve_AVG_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_AVG_16]') AND name = N'IDX_Meritve_AVG_16_Content')
DROP INDEX [IDX_Meritve_AVG_16_Content] ON [dbo].[Meritve_AVG_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_AVG_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_AVG_16_Content] ON [dbo].[Meritve_AVG_16] 
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

/****** Object:  Index [IDX_Meritve_SEP_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_SEP_16]') AND name = N'IDX_Meritve_SEP_16_Content')
DROP INDEX [IDX_Meritve_SEP_16_Content] ON [dbo].[Meritve_SEP_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_SEP_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_SEP_16_Content] ON [dbo].[Meritve_SEP_16] 
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

/****** Object:  Index [IDX_Meritve_OKT_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_OKT_16]') AND name = N'IDX_Meritve_OKT_16_Content')
DROP INDEX [IDX_Meritve_OKT_16_Content] ON [dbo].[Meritve_OKT_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_OKT_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_OKT_16_Content] ON [dbo].[Meritve_OKT_16] 
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

/****** Object:  Index [IDX_Meritve_NOV_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_16]') AND name = N'IDX_Meritve_NOV_16_Content')
DROP INDEX [IDX_Meritve_NOV_16_Content] ON [dbo].[Meritve_NOV_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_NOV_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_NOV_16_Content] ON [dbo].[Meritve_NOV_16] 
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

/****** Object:  Index [IDX_Meritve_DEC_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_16]') AND name = N'IDX_Meritve_DEC_16_Content')
DROP INDEX [IDX_Meritve_DEC_16_Content] ON [dbo].[Meritve_DEC_16] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_DEC_16_Content]    Script Date: 06/16/2016 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_DEC_16_Content] ON [dbo].[Meritve_DEC_16] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


