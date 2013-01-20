USE [IBIS2]
GO

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
	[Kolicina] [decimal](19, 6) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
 CONSTRAINT [PK_Meritve_JAN_12] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Interval] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Meritve_JAN_12]  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_JAN_12] CHECK  (([Interval]>='2012-01-01 01:00:00' AND [Interval]<= '2012-02-01 00:00:00'))
GO

ALTER TABLE [dbo].[Meritve_JAN_12] CHECK CONSTRAINT [CHK_Meritve_JAN_12]
GO

ALTER TABLE [dbo].[Meritve_JAN_12] ADD  CONSTRAINT [DF_Meritve_JAN_12_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO


