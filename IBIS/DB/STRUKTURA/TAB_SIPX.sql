
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SIPX_SIPX_Base]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SIPX] DROP CONSTRAINT [DF_SIPX_SIPX_Base]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SIPX_SIPX_EUROPeak]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SIPX] DROP CONSTRAINT [DF_SIPX_SIPX_EUROPeak]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SIPX_DatumVnosa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SIPX] DROP CONSTRAINT [DF_SIPX_DatumVnosa]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__SIPX__Vrednost__1E505424]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SIPX] DROP CONSTRAINT [DF__SIPX__Vrednost__1E505424]
END

GO



/****** Object:  Table [dbo].[SIPX]    Script Date: 03/18/2012 22:36:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SIPX]') AND type in (N'U'))
DROP TABLE [dbo].[SIPX]
GO


/****** Object:  Table [dbo].[SIPX]    Script Date: 03/18/2012 22:36:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SIPX](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Interval] [datetime] NOT NULL,
	[SIPX_Base] [decimal](18, 8) NOT NULL,
	[SIPX_EUROPeak] [decimal](18, 8) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL,
	[Vrednost] [decimal](18, 8) NOT NULL,
 CONSTRAINT [PK_SIPX] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[SIPX] ADD  CONSTRAINT [DF_SIPX_SIPX_Base]  DEFAULT ((0)) FOR [SIPX_Base]
GO

ALTER TABLE [dbo].[SIPX] ADD  CONSTRAINT [DF_SIPX_SIPX_EUROPeak]  DEFAULT ((0)) FOR [SIPX_EUROPeak]
GO

ALTER TABLE [dbo].[SIPX] ADD  CONSTRAINT [DF_SIPX_DatumVnosa]  DEFAULT (getdate()) FOR [DatumVnosa]
GO

ALTER TABLE [dbo].[SIPX] ADD  DEFAULT ((0)) FOR [Vrednost]
GO


