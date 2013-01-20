USE [IBIS2]
GO


/*07*/

IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_07]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_07]'))
ALTER TABLE [dbo].[Meritve_NOV_07] DROP CONSTRAINT [CHK_Meritve_NOV_07]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_07_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_07] DROP CONSTRAINT [DF_Meritve_NOV_07_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_07]    Script Date: 05/18/2007 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_07]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_07]
GO

/****** Object:  Table [dbo].[Meritve_NOV_07]    Script Date: 05/18/2007 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_07](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_07] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_07]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_07] CHECK  (([Interval]>='2007-11-01 00:00:00' AND [Interval]< '2007-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_07] CHECK CONSTRAINT [CHK_Meritve_NOV_07]
GO

ALTER TABLE [dbo].[Meritve_NOV_07] ADD  CONSTRAINT [DF_Meritve_NOV_07_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO

--07

--08



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_08]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_08]'))


ALTER TABLE [dbo].[Meritve_NOV_08] DROP CONSTRAINT [CHK_Meritve_NOV_08]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_08_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_08] DROP CONSTRAINT [DF_Meritve_NOV_08_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_08]    Script Date: 05/18/2008 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_08]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_08]
GO

/****** Object:  Table [dbo].[Meritve_NOV_08]    Script Date: 05/18/2008 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_08](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_08] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_08]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_08] CHECK  (([Interval]>='2008-11-01 00:00:00' AND [Interval]< '2008-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_08] CHECK CONSTRAINT [CHK_Meritve_NOV_08]
GO

ALTER TABLE [dbo].[Meritve_NOV_08] ADD  CONSTRAINT [DF_Meritve_NOV_08_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--08


--09



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_09]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_09]'))


ALTER TABLE [dbo].[Meritve_NOV_09] DROP CONSTRAINT [CHK_Meritve_NOV_09]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_09_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_09] DROP CONSTRAINT [DF_Meritve_NOV_09_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_09]    Script Date: 05/18/2009 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_09]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_09]
GO

/****** Object:  Table [dbo].[Meritve_NOV_09]    Script Date: 05/18/2009 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_09](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_09] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_09]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_09] CHECK  (([Interval]>='2009-11-01 00:00:00' AND [Interval]< '2009-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_09] CHECK CONSTRAINT [CHK_Meritve_NOV_09]
GO

ALTER TABLE [dbo].[Meritve_NOV_09] ADD  CONSTRAINT [DF_Meritve_NOV_09_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--09



--10



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_10]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_10]'))


ALTER TABLE [dbo].[Meritve_NOV_10] DROP CONSTRAINT [CHK_Meritve_NOV_10]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_10_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_10] DROP CONSTRAINT [DF_Meritve_NOV_10_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_10]    Script Date: 05/18/2010 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_10]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_10]
GO

/****** Object:  Table [dbo].[Meritve_NOV_10]    Script Date: 05/18/2010 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_10](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_10] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_10]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_10] CHECK  (([Interval]>='2010-11-01 00:00:00' AND [Interval]< '2010-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_10] CHECK CONSTRAINT [CHK_Meritve_NOV_10]
GO

ALTER TABLE [dbo].[Meritve_NOV_10] ADD  CONSTRAINT [DF_Meritve_NOV_10_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--10



--11



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_11]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_11]'))


ALTER TABLE [dbo].[Meritve_NOV_11] DROP CONSTRAINT [CHK_Meritve_NOV_11]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_11_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_11] DROP CONSTRAINT [DF_Meritve_NOV_11_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_11]    Script Date: 05/18/2011 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_11]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_11]
GO

/****** Object:  Table [dbo].[Meritve_NOV_11]    Script Date: 05/18/2011 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_11](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_11] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_11]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_11] CHECK  (([Interval]>='2011-11-01 00:00:00' AND [Interval]< '2011-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_11] CHECK CONSTRAINT [CHK_Meritve_NOV_11]
GO

ALTER TABLE [dbo].[Meritve_NOV_11] ADD  CONSTRAINT [DF_Meritve_NOV_11_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--11


--12



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_12]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_12]'))


ALTER TABLE [dbo].[Meritve_NOV_12] DROP CONSTRAINT [CHK_Meritve_NOV_12]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_12_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_12] DROP CONSTRAINT [DF_Meritve_NOV_12_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_12]    Script Date: 05/18/2012 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_12]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_12]
GO

/****** Object:  Table [dbo].[Meritve_NOV_12]    Script Date: 05/18/2012 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_12](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_12] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_12]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_12] CHECK  (([Interval]>='2012-11-01 00:00:00' AND [Interval]< '2012-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_12] CHECK CONSTRAINT [CHK_Meritve_NOV_12]
GO

ALTER TABLE [dbo].[Meritve_NOV_12] ADD  CONSTRAINT [DF_Meritve_NOV_12_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--12


--13



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_13]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_13]'))


ALTER TABLE [dbo].[Meritve_NOV_13] DROP CONSTRAINT [CHK_Meritve_NOV_13]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_13_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_13] DROP CONSTRAINT [DF_Meritve_NOV_13_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_13]    Script Date: 05/18/2013 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_13]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_13]
GO

/****** Object:  Table [dbo].[Meritve_NOV_13]    Script Date: 05/18/2013 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_13](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_13] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_13]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_13] CHECK  (([Interval]>='2013-11-01 00:00:00' AND [Interval]< '2013-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_13] CHECK CONSTRAINT [CHK_Meritve_NOV_13]
GO

ALTER TABLE [dbo].[Meritve_NOV_13] ADD  CONSTRAINT [DF_Meritve_NOV_13_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--13


--14



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_14]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_14]'))


ALTER TABLE [dbo].[Meritve_NOV_14] DROP CONSTRAINT [CHK_Meritve_NOV_14]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_14_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_14] DROP CONSTRAINT [DF_Meritve_NOV_14_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_14]    Script Date: 05/18/2014 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_14]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_14]
GO

/****** Object:  Table [dbo].[Meritve_NOV_14]    Script Date: 05/18/2014 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_14](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_14] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_14]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_14] CHECK  (([Interval]>='2014-11-01 00:00:00' AND [Interval]< '2014-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_14] CHECK CONSTRAINT [CHK_Meritve_NOV_14]
GO

ALTER TABLE [dbo].[Meritve_NOV_14] ADD  CONSTRAINT [DF_Meritve_NOV_14_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--14


--15



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_15]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_15]'))


ALTER TABLE [dbo].[Meritve_NOV_15] DROP CONSTRAINT [CHK_Meritve_NOV_15]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_15_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_15] DROP CONSTRAINT [DF_Meritve_NOV_15_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_15]    Script Date: 05/18/2015 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_15]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_15]
GO

/****** Object:  Table [dbo].[Meritve_NOV_15]    Script Date: 05/18/2015 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_15](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_15] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_15]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_15] CHECK  (([Interval]>='2015-11-01 00:00:00' AND [Interval]< '2015-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_15] CHECK CONSTRAINT [CHK_Meritve_NOV_15]
GO

ALTER TABLE [dbo].[Meritve_NOV_15] ADD  CONSTRAINT [DF_Meritve_NOV_15_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--15



--16



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_16]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_16]'))


ALTER TABLE [dbo].[Meritve_NOV_16] DROP CONSTRAINT [CHK_Meritve_NOV_16]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_16_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_16] DROP CONSTRAINT [DF_Meritve_NOV_16_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_16]    Script Date: 05/18/2016 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_16]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_16]
GO

/****** Object:  Table [dbo].[Meritve_NOV_16]    Script Date: 05/18/2016 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_16](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_16] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_16]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_16] CHECK  (([Interval]>='2016-11-01 00:00:00' AND [Interval]< '2016-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_16] CHECK CONSTRAINT [CHK_Meritve_NOV_16]
GO

ALTER TABLE [dbo].[Meritve_NOV_16] ADD  CONSTRAINT [DF_Meritve_NOV_16_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--16



--17



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_17]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_17]'))


ALTER TABLE [dbo].[Meritve_NOV_17] DROP CONSTRAINT [CHK_Meritve_NOV_17]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_17_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_17] DROP CONSTRAINT [DF_Meritve_NOV_17_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_17]    Script Date: 05/18/2017 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_17]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_17]
GO

/****** Object:  Table [dbo].[Meritve_NOV_17]    Script Date: 05/18/2017 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_17](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_17] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_17]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_17] CHECK  (([Interval]>='2017-11-01 00:00:00' AND [Interval]< '2017-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_17] CHECK CONSTRAINT [CHK_Meritve_NOV_17]
GO

ALTER TABLE [dbo].[Meritve_NOV_17] ADD  CONSTRAINT [DF_Meritve_NOV_17_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--17


--18

IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_NOV_18]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_18]'))


ALTER TABLE [dbo].[Meritve_NOV_18] DROP CONSTRAINT [CHK_Meritve_NOV_18]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_NOV_18_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_NOV_18] DROP CONSTRAINT [DF_Meritve_NOV_18_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_NOV_18]    Script Date: 05/18/2018 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_NOV_18]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_NOV_18]
GO

/****** Object:  Table [dbo].[Meritve_NOV_18]    Script Date: 05/18/2018 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_NOV_18](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_NOV_18] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_NOV_18]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_NOV_18] CHECK  (([Interval]>='2018-11-01 00:00:00' AND [Interval]< '2018-12-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_NOV_18] CHECK CONSTRAINT [CHK_Meritve_NOV_18]
GO

ALTER TABLE [dbo].[Meritve_NOV_18] ADD  CONSTRAINT [DF_Meritve_NOV_18_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--18