USE [IBIS2]
GO


/*07*/

IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_07]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_07]'))
ALTER TABLE [dbo].[Meritve_JAN_07] DROP CONSTRAINT [CHK_Meritve_JAN_07]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_07_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_07] DROP CONSTRAINT [DF_Meritve_JAN_07_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_07]    Script Date: 05/18/2007 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_07]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_07]
GO

/****** Object:  Table [dbo].[Meritve_JAN_07]    Script Date: 05/18/2007 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_07](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_07] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_07]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_07] CHECK  (([Interval]>='2007-01-01 00:00:00' AND [Interval]< '2007-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_07] CHECK CONSTRAINT [CHK_Meritve_JAN_07]
GO

ALTER TABLE [dbo].[Meritve_JAN_07] ADD  CONSTRAINT [DF_Meritve_JAN_07_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO

--07

--08



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_08]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_08]'))


ALTER TABLE [dbo].[Meritve_JAN_08] DROP CONSTRAINT [CHK_Meritve_JAN_08]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_08_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_08] DROP CONSTRAINT [DF_Meritve_JAN_08_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_08]    Script Date: 05/18/2008 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_08]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_08]
GO

/****** Object:  Table [dbo].[Meritve_JAN_08]    Script Date: 05/18/2008 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_08](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_08] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_08]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_08] CHECK  (([Interval]>='2008-01-01 00:00:00' AND [Interval]< '2008-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_08] CHECK CONSTRAINT [CHK_Meritve_JAN_08]
GO

ALTER TABLE [dbo].[Meritve_JAN_08] ADD  CONSTRAINT [DF_Meritve_JAN_08_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--08


--09



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_09]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_09]'))


ALTER TABLE [dbo].[Meritve_JAN_09] DROP CONSTRAINT [CHK_Meritve_JAN_09]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_09_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_09] DROP CONSTRAINT [DF_Meritve_JAN_09_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_09]    Script Date: 05/18/2009 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_09]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_09]
GO

/****** Object:  Table [dbo].[Meritve_JAN_09]    Script Date: 05/18/2009 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_09](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_09] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_09]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_09] CHECK  (([Interval]>='2009-01-01 00:00:00' AND [Interval]< '2009-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_09] CHECK CONSTRAINT [CHK_Meritve_JAN_09]
GO

ALTER TABLE [dbo].[Meritve_JAN_09] ADD  CONSTRAINT [DF_Meritve_JAN_09_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--09



--10



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_10]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_10]'))


ALTER TABLE [dbo].[Meritve_JAN_10] DROP CONSTRAINT [CHK_Meritve_JAN_10]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_10_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_10] DROP CONSTRAINT [DF_Meritve_JAN_10_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_10]    Script Date: 05/18/2010 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_10]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_10]
GO

/****** Object:  Table [dbo].[Meritve_JAN_10]    Script Date: 05/18/2010 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_10](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_10] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_10]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_10] CHECK  (([Interval]>='2010-01-01 00:00:00' AND [Interval]< '2010-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_10] CHECK CONSTRAINT [CHK_Meritve_JAN_10]
GO

ALTER TABLE [dbo].[Meritve_JAN_10] ADD  CONSTRAINT [DF_Meritve_JAN_10_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--10



--11



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_11]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_11]'))


ALTER TABLE [dbo].[Meritve_JAN_11] DROP CONSTRAINT [CHK_Meritve_JAN_11]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_11_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_11] DROP CONSTRAINT [DF_Meritve_JAN_11_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_11]    Script Date: 05/18/2011 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_11]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_11]
GO

/****** Object:  Table [dbo].[Meritve_JAN_11]    Script Date: 05/18/2011 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_11](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_11] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_11]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_11] CHECK  (([Interval]>='2011-01-01 00:00:00' AND [Interval]< '2011-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_11] CHECK CONSTRAINT [CHK_Meritve_JAN_11]
GO

ALTER TABLE [dbo].[Meritve_JAN_11] ADD  CONSTRAINT [DF_Meritve_JAN_11_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--11


--12



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_12]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_12]'))


ALTER TABLE [dbo].[Meritve_JAN_12] DROP CONSTRAINT [CHK_Meritve_JAN_12]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_12_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_12] DROP CONSTRAINT [DF_Meritve_JAN_12_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_12]    Script Date: 05/18/2012 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_12]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_12]
GO

/****** Object:  Table [dbo].[Meritve_JAN_12]    Script Date: 05/18/2012 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_12](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_12] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_12]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_12] CHECK  (([Interval]>='2012-01-01 00:00:00' AND [Interval]< '2012-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_12] CHECK CONSTRAINT [CHK_Meritve_JAN_12]
GO

ALTER TABLE [dbo].[Meritve_JAN_12] ADD  CONSTRAINT [DF_Meritve_JAN_12_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--12


--13



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_13]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_13]'))


ALTER TABLE [dbo].[Meritve_JAN_13] DROP CONSTRAINT [CHK_Meritve_JAN_13]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_13_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_13] DROP CONSTRAINT [DF_Meritve_JAN_13_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_13]    Script Date: 05/18/2013 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_13]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_13]
GO

/****** Object:  Table [dbo].[Meritve_JAN_13]    Script Date: 05/18/2013 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_13](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_13] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_13]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_13] CHECK  (([Interval]>='2013-01-01 00:00:00' AND [Interval]< '2013-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_13] CHECK CONSTRAINT [CHK_Meritve_JAN_13]
GO

ALTER TABLE [dbo].[Meritve_JAN_13] ADD  CONSTRAINT [DF_Meritve_JAN_13_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--13


--14



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_14]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_14]'))


ALTER TABLE [dbo].[Meritve_JAN_14] DROP CONSTRAINT [CHK_Meritve_JAN_14]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_14_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_14] DROP CONSTRAINT [DF_Meritve_JAN_14_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_14]    Script Date: 05/18/2014 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_14]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_14]
GO

/****** Object:  Table [dbo].[Meritve_JAN_14]    Script Date: 05/18/2014 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_14](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_14] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_14]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_14] CHECK  (([Interval]>='2014-01-01 00:00:00' AND [Interval]< '2014-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_14] CHECK CONSTRAINT [CHK_Meritve_JAN_14]
GO

ALTER TABLE [dbo].[Meritve_JAN_14] ADD  CONSTRAINT [DF_Meritve_JAN_14_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--14


--15



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_15]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_15]'))


ALTER TABLE [dbo].[Meritve_JAN_15] DROP CONSTRAINT [CHK_Meritve_JAN_15]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_15_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_15] DROP CONSTRAINT [DF_Meritve_JAN_15_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_15]    Script Date: 05/18/2015 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_15]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_15]
GO

/****** Object:  Table [dbo].[Meritve_JAN_15]    Script Date: 05/18/2015 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_15](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_15] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_15]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_15] CHECK  (([Interval]>='2015-01-01 00:00:00' AND [Interval]< '2015-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_15] CHECK CONSTRAINT [CHK_Meritve_JAN_15]
GO

ALTER TABLE [dbo].[Meritve_JAN_15] ADD  CONSTRAINT [DF_Meritve_JAN_15_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--15



--16



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_16]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_16]'))


ALTER TABLE [dbo].[Meritve_JAN_16] DROP CONSTRAINT [CHK_Meritve_JAN_16]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_16_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_16] DROP CONSTRAINT [DF_Meritve_JAN_16_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_16]    Script Date: 05/18/2016 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_16]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_16]
GO

/****** Object:  Table [dbo].[Meritve_JAN_16]    Script Date: 05/18/2016 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_16](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_16] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_16]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_16] CHECK  (([Interval]>='2016-01-01 00:00:00' AND [Interval]< '2016-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_16] CHECK CONSTRAINT [CHK_Meritve_JAN_16]
GO

ALTER TABLE [dbo].[Meritve_JAN_16] ADD  CONSTRAINT [DF_Meritve_JAN_16_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--16



--17



IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_17]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_17]'))


ALTER TABLE [dbo].[Meritve_JAN_17] DROP CONSTRAINT [CHK_Meritve_JAN_17]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_17_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_17] DROP CONSTRAINT [DF_Meritve_JAN_17_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_17]    Script Date: 05/18/2017 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_17]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_17]
GO

/****** Object:  Table [dbo].[Meritve_JAN_17]    Script Date: 05/18/2017 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_17](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_17] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_17]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_17] CHECK  (([Interval]>='2017-01-01 00:00:00' AND [Interval]< '2017-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_17] CHECK CONSTRAINT [CHK_Meritve_JAN_17]
GO

ALTER TABLE [dbo].[Meritve_JAN_17] ADD  CONSTRAINT [DF_Meritve_JAN_17_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--17


--18

IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Meritve_JAN_18]') AND parent_object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_18]'))


ALTER TABLE [dbo].[Meritve_JAN_18] DROP CONSTRAINT [CHK_Meritve_JAN_18]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Meritve_JAN_18_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Meritve_JAN_18] DROP CONSTRAINT [DF_Meritve_JAN_18_DatumVnosa]
END

GO

/****** Object:  Table [dbo].[Meritve_JAN_18]    Script Date: 05/18/2018 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_18]') AND type in (N'U'))
DROP TABLE [dbo].[Meritve_JAN_18]
GO

/****** Object:  Table [dbo].[Meritve_JAN_18]    Script Date: 05/18/2018 21:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Meritve_JAN_18](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](24, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_18] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_18]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_18] CHECK  (([Interval]>='2018-01-01 00:00:00' AND [Interval]< '2018-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_18] CHECK CONSTRAINT [CHK_Meritve_JAN_18]
GO

ALTER TABLE [dbo].[Meritve_JAN_18] ADD  CONSTRAINT [DF_Meritve_JAN_18_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


--18