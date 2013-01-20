
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontorla_Odstopanj_W+i]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontorla_Odstopanj] DROP CONSTRAINT [DF_Kontorla_Odstopanj_W+i]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontorla_Odstopanj_W-i]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontorla_Odstopanj] DROP CONSTRAINT [DF_Kontorla_Odstopanj_W-i]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontorla_Odstopanj_Wgjs+]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontorla_Odstopanj] DROP CONSTRAINT [DF_Kontorla_Odstopanj_Wgjs+]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontorla_Odstopanj_Wgjs-]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontorla_Odstopanj] DROP CONSTRAINT [DF_Kontorla_Odstopanj_Wgjs-]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontorla_Odstopanj_Wizr+]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontorla_Odstopanj] DROP CONSTRAINT [DF_Kontorla_Odstopanj_Wizr+]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontorla_Odstopanj_Wizr-]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontorla_Odstopanj] DROP CONSTRAINT [DF_Kontorla_Odstopanj_Wizr-]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontorla_Odstopanj_Vrednost]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontorla_Odstopanj] DROP CONSTRAINT [DF_Kontorla_Odstopanj_Vrednost]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontorla_Odstopanj_Skupaj]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontorla_Odstopanj] DROP CONSTRAINT [DF_Kontorla_Odstopanj_Skupaj]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontorla_Odstopanj_Razlika]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontorla_Odstopanj] DROP CONSTRAINT [DF_Kontorla_Odstopanj_Razlika]
END

GO


GO

/****** Object:  Table [dbo].[Kontorla_Odstopanj]    Script Date: 06/03/2012 21:54:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Kontorla_Odstopanj]') AND type in (N'U'))
DROP TABLE [dbo].[Kontorla_Odstopanj]
GO


GO

/****** Object:  Table [dbo].[Kontorla_Odstopanj]    Script Date: 06/03/2012 21:54:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Kontorla_Odstopanj](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ObracunID] [bigint] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[W+i] [decimal](24, 8) NOT NULL,
	[W-i] [decimal](24, 8) NOT NULL,
	[Wgjs+] [decimal](24, 8) NOT NULL,
	[Wgjs-] [decimal](24, 8) NOT NULL,
	[Wizr+] [decimal](24, 8) NOT NULL,
	[Wizr-] [decimal](24, 8) NOT NULL,
	[OsebaID] [bigint] NULL,
	[Vrednost] [decimal](24, 8) NOT NULL,
	[Skupaj] [decimal](24, 8) NOT NULL,
	[Razlika] [decimal](24, 8) NOT NULL,
 CONSTRAINT [PK_Kontorla_Odstopanj] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Èe je OsebaID NULL potem so to podatki za interval skupni, ÈE ni NULL potem so to podatki za doloèeno osebo.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Kontorla_Odstopanj', @level2type=N'COLUMN',@level2name=N'OsebaID'
GO

ALTER TABLE [dbo].[Kontorla_Odstopanj] ADD  CONSTRAINT [DF_Kontorla_Odstopanj_W+i]  DEFAULT ((0)) FOR [W+i]
GO

ALTER TABLE [dbo].[Kontorla_Odstopanj] ADD  CONSTRAINT [DF_Kontorla_Odstopanj_W-i]  DEFAULT ((0)) FOR [W-i]
GO

ALTER TABLE [dbo].[Kontorla_Odstopanj] ADD  CONSTRAINT [DF_Kontorla_Odstopanj_Wgjs+]  DEFAULT ((0)) FOR [Wgjs+]
GO

ALTER TABLE [dbo].[Kontorla_Odstopanj] ADD  CONSTRAINT [DF_Kontorla_Odstopanj_Wgjs-]  DEFAULT ((0)) FOR [Wgjs-]
GO

ALTER TABLE [dbo].[Kontorla_Odstopanj] ADD  CONSTRAINT [DF_Kontorla_Odstopanj_Wizr+]  DEFAULT ((0)) FOR [Wizr+]
GO

ALTER TABLE [dbo].[Kontorla_Odstopanj] ADD  CONSTRAINT [DF_Kontorla_Odstopanj_Wizr-]  DEFAULT ((0)) FOR [Wizr-]
GO

ALTER TABLE [dbo].[Kontorla_Odstopanj] ADD  CONSTRAINT [DF_Kontorla_Odstopanj_Vrednost]  DEFAULT ((0)) FOR [Vrednost]
GO

ALTER TABLE [dbo].[Kontorla_Odstopanj] ADD  CONSTRAINT [DF_Kontorla_Odstopanj_Skupaj]  DEFAULT ((0)) FOR [Skupaj]
GO

ALTER TABLE [dbo].[Kontorla_Odstopanj] ADD  CONSTRAINT [DF_Kontorla_Odstopanj_Razlika]  DEFAULT ((0)) FOR [Razlika]
GO


