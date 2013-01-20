USE [IBIS2]
GO


/*07*/

IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_07]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_07]'))
ALTER TABLE [dbo].[Meritve_DEC_07] DROP CONSTRAINT [CHK_Meritve_DEC_07]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_07_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_07] DROP CONSTRAINT [DF_Meritve_DEC_07_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_07]    Script Date: 05/18/2007 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_07]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_07]
GO

/****** Object:  Table [dbo].[Meritve_DEC_07]    Script Date: 05/18/2007 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_07](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_07] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_07]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_07] CHECK  (([Interval]>='2007-12-01 00:00:00' AND [Interval]< '2008-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_07] CHECK CONSTRAINT [CHK_Meritve_DEC_07]
GO

ALTER TABLE [dbo].[Meritve_DEC_07] ADD  CONSTRAINT [DF_Meritve_DEC_07_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO

--07

--08



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_08]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_08]'))


ALTER TABLE [dbo].[Meritve_DEC_08] DROP CONSTRAINT [CHK_Meritve_DEC_08]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_08_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_08] DROP CONSTRAINT [DF_Meritve_DEC_08_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_08]    Script Date: 05/18/2008 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_08]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_08]
GO

/****** Object:  Table [dbo].[Meritve_DEC_08]    Script Date: 05/18/2008 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_08](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_08] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_08]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_08] CHECK  (([Interval]>='2008-12-01 00:00:00' AND [Interval]< '2009-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_08] CHECK CONSTRAINT [CHK_Meritve_DEC_08]
GO

ALTER TABLE [dbo].[Meritve_DEC_08] ADD  CONSTRAINT [DF_Meritve_DEC_08_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--08


--09



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_09]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_09]'))


ALTER TABLE [dbo].[Meritve_DEC_09] DROP CONSTRAINT [CHK_Meritve_DEC_09]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_09_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_09] DROP CONSTRAINT [DF_Meritve_DEC_09_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_09]    Script Date: 05/18/2009 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_09]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_09]
GO

/****** Object:  Table [dbo].[Meritve_DEC_09]    Script Date: 05/18/2009 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_09](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_09] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_09]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_09] CHECK  (([Interval]>='2009-12-01 00:00:00' AND [Interval]< '2010-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_09] CHECK CONSTRAINT [CHK_Meritve_DEC_09]
GO

ALTER TABLE [dbo].[Meritve_DEC_09] ADD  CONSTRAINT [DF_Meritve_DEC_09_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--09



--10



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_10]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_10]'))


ALTER TABLE [dbo].[Meritve_DEC_10] DROP CONSTRAINT [CHK_Meritve_DEC_10]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_10_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_10] DROP CONSTRAINT [DF_Meritve_DEC_10_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_10]    Script Date: 05/18/2010 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_10]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_10]
GO

/****** Object:  Table [dbo].[Meritve_DEC_10]    Script Date: 05/18/2010 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_10](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_10] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_10]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_10] CHECK  (([Interval]>='2010-12-01 00:00:00' AND [Interval]< '2011-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_10] CHECK CONSTRAINT [CHK_Meritve_DEC_10]
GO

ALTER TABLE [dbo].[Meritve_DEC_10] ADD  CONSTRAINT [DF_Meritve_DEC_10_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--10



--11



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_11]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_11]'))


ALTER TABLE [dbo].[Meritve_DEC_11] DROP CONSTRAINT [CHK_Meritve_DEC_11]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_11_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_11] DROP CONSTRAINT [DF_Meritve_DEC_11_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_11]    Script Date: 05/18/2011 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_11]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_11]
GO

/****** Object:  Table [dbo].[Meritve_DEC_11]    Script Date: 05/18/2011 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_11](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_11] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_11]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_11] CHECK  (([Interval]>='2011-12-01 00:00:00' AND [Interval]< '2012-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_11] CHECK CONSTRAINT [CHK_Meritve_DEC_11]
GO

ALTER TABLE [dbo].[Meritve_DEC_11] ADD  CONSTRAINT [DF_Meritve_DEC_11_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--11


--12



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_12]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_12]'))


ALTER TABLE [dbo].[Meritve_DEC_12] DROP CONSTRAINT [CHK_Meritve_DEC_12]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_12_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_12] DROP CONSTRAINT [DF_Meritve_DEC_12_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_12]    Script Date: 05/18/2012 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_12]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_12]
GO

/****** Object:  Table [dbo].[Meritve_DEC_12]    Script Date: 05/18/2012 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_12](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_12] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_12]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_12] CHECK  (([Interval]>='2012-12-01 00:00:00' AND [Interval]< '2013-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_12] CHECK CONSTRAINT [CHK_Meritve_DEC_12]
GO

ALTER TABLE [dbo].[Meritve_DEC_12] ADD  CONSTRAINT [DF_Meritve_DEC_12_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--12


--13



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_13]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_13]'))


ALTER TABLE [dbo].[Meritve_DEC_13] DROP CONSTRAINT [CHK_Meritve_DEC_13]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_13_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_13] DROP CONSTRAINT [DF_Meritve_DEC_13_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_13]    Script Date: 05/18/2013 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_13]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_13]
GO

/****** Object:  Table [dbo].[Meritve_DEC_13]    Script Date: 05/18/2013 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_13](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_13] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_13]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_13] CHECK  (([Interval]>='2013-12-01 00:00:00' AND [Interval]< '2014-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_13] CHECK CONSTRAINT [CHK_Meritve_DEC_13]
GO

ALTER TABLE [dbo].[Meritve_DEC_13] ADD  CONSTRAINT [DF_Meritve_DEC_13_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--13


--14



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_14]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_14]'))


ALTER TABLE [dbo].[Meritve_DEC_14] DROP CONSTRAINT [CHK_Meritve_DEC_14]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_14_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_14] DROP CONSTRAINT [DF_Meritve_DEC_14_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_14]    Script Date: 05/18/2014 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_14]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_14]
GO

/****** Object:  Table [dbo].[Meritve_DEC_14]    Script Date: 05/18/2014 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_14](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_14] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_14]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_14] CHECK  (([Interval]>='2014-12-01 00:00:00' AND [Interval]< '2015-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_14] CHECK CONSTRAINT [CHK_Meritve_DEC_14]
GO

ALTER TABLE [dbo].[Meritve_DEC_14] ADD  CONSTRAINT [DF_Meritve_DEC_14_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--14


--15



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_15]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_15]'))


ALTER TABLE [dbo].[Meritve_DEC_15] DROP CONSTRAINT [CHK_Meritve_DEC_15]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_15_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_15] DROP CONSTRAINT [DF_Meritve_DEC_15_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_15]    Script Date: 05/18/2015 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_15]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_15]
GO

/****** Object:  Table [dbo].[Meritve_DEC_15]    Script Date: 05/18/2015 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_15](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_15] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_15]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_15] CHECK  (([Interval]>='2015-12-01 00:00:00' AND [Interval]< '2016-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_15] CHECK CONSTRAINT [CHK_Meritve_DEC_15]
GO

ALTER TABLE [dbo].[Meritve_DEC_15] ADD  CONSTRAINT [DF_Meritve_DEC_15_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--15



--16



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_16]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_16]'))


ALTER TABLE [dbo].[Meritve_DEC_16] DROP CONSTRAINT [CHK_Meritve_DEC_16]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_16_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_16] DROP CONSTRAINT [DF_Meritve_DEC_16_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_16]    Script Date: 05/18/2016 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_16]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_16]
GO

/****** Object:  Table [dbo].[Meritve_DEC_16]    Script Date: 05/18/2016 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_16](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_16] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_16]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_16] CHECK  (([Interval]>='2016-12-01 00:00:00' AND [Interval]< '2017-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_16] CHECK CONSTRAINT [CHK_Meritve_DEC_16]
GO

ALTER TABLE [dbo].[Meritve_DEC_16] ADD  CONSTRAINT [DF_Meritve_DEC_16_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--16



--17



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_17]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_17]'))


ALTER TABLE [dbo].[Meritve_DEC_17] DROP CONSTRAINT [CHK_Meritve_DEC_17]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_17_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_17] DROP CONSTRAINT [DF_Meritve_DEC_17_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_17]    Script Date: 05/18/2017 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_17]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_17]
GO

/****** Object:  Table [dbo].[Meritve_DEC_17]    Script Date: 05/18/2017 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_17](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_17] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_17]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_17] CHECK  (([Interval]>='2017-12-01 00:00:00' AND [Interval]< '2018-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_17] CHECK CONSTRAINT [CHK_Meritve_DEC_17]
GO

ALTER TABLE [dbo].[Meritve_DEC_17] ADD  CONSTRAINT [DF_Meritve_DEC_17_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--17


--18

IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_DEC_18]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_18]'))


ALTER TABLE [dbo].[Meritve_DEC_18] DROP CONSTRAINT [CHK_Meritve_DEC_18]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_DEC_18_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_DEC_18] DROP CONSTRAINT [DF_Meritve_DEC_18_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_DEC_18]    Script Date: 05/18/2018 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_DEC_18]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_DEC_18]
GO

/****** Object:  Table [dbo].[Meritve_DEC_18]    Script Date: 05/18/2018 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_DEC_18](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_DEC_18] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_DEC_18]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_DEC_18] CHECK  (([Interval]>='2018-12-01 00:00:00' AND [Interval]< '2019-01-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_DEC_18] CHECK CONSTRAINT [CHK_Meritve_DEC_18]
GO

ALTER TABLE [dbo].[Meritve_DEC_18] ADD  CONSTRAINT [DF_Meritve_DEC_18_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--18