
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_Sistema_Oddaja]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_Sistema] DROP CONSTRAINT [DF_Kontrola_Sistema_Oddaja]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_Sistema_Odjem]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_Sistema] DROP CONSTRAINT [DF_Kontrola_Sistema_Odjem]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_Sistema_Meje]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_Sistema] DROP CONSTRAINT [DF_Kontrola_Sistema_Meje]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_Sistema_Izgube]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_Sistema] DROP CONSTRAINT [DF_Kontrola_Sistema_Izgube]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_Sistema_Skupaj]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_Sistema] DROP CONSTRAINT [DF_Kontrola_Sistema_Skupaj]
END

GO



/****** Object:  Table [dbo].[Kontrola_Sistema]    Script Date: 06/03/2012 21:55:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Kontrola_Sistema]') AND type in (N'U'))
DROP TABLE [dbo].[Kontrola_Sistema]
GO



/****** Object:  Table [dbo].[Kontrola_Sistema]    Script Date: 06/03/2012 21:55:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Kontrola_Sistema](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ObracunID] [bigint] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Oddaja] [decimal](24, 8) NOT NULL,
	[Odjem] [decimal](24, 8) NOT NULL,
	[Meje] [decimal](24, 8) NOT NULL,
	[Izgube] [decimal](24, 8) NOT NULL,
	[Skupaj] [decimal](24, 8) NOT NULL,
 CONSTRAINT [PK_Kontrola_Sistema] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Kontrola_Sistema] ADD  CONSTRAINT [DF_Kontrola_Sistema_Oddaja]  DEFAULT ((0)) FOR [Oddaja]
GO

ALTER TABLE [dbo].[Kontrola_Sistema] ADD  CONSTRAINT [DF_Kontrola_Sistema_Odjem]  DEFAULT ((0)) FOR [Odjem]
GO

ALTER TABLE [dbo].[Kontrola_Sistema] ADD  CONSTRAINT [DF_Kontrola_Sistema_Meje]  DEFAULT ((0)) FOR [Meje]
GO

ALTER TABLE [dbo].[Kontrola_Sistema] ADD  CONSTRAINT [DF_Kontrola_Sistema_Izgube]  DEFAULT ((0)) FOR [Izgube]
GO

ALTER TABLE [dbo].[Kontrola_Sistema] ADD  CONSTRAINT [DF_Kontrola_Sistema_Skupaj]  DEFAULT ((0)) FOR [Skupaj]
GO


