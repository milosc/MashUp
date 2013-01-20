

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_Realizacije_Vrednost]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_Realizacije] DROP CONSTRAINT [DF_Kontrola_Realizacije_Vrednost]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_Realizacije_Skupaj]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_Realizacije] DROP CONSTRAINT [DF_Kontrola_Realizacije_Skupaj]
END

GO


/****** Object:  Table [dbo].[Kontrola_Realizacije]    Script Date: 06/03/2012 21:55:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Kontrola_Realizacije]') AND type in (N'U'))
DROP TABLE [dbo].[Kontrola_Realizacije]
GO


/****** Object:  Table [dbo].[Kontrola_Realizacije]    Script Date: 06/03/2012 21:55:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Kontrola_Realizacije](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ObracunID] [bigint] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[OsebaID] [bigint] NOT NULL,
	[Vrednost] [decimal](24, 8) NOT NULL,
	[Skupaj] [decimal](24, 8) NOT NULL,
 CONSTRAINT [PK_Kontrola_Realizacije] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vrednost sumarna za vse osebe v interval - meje' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Kontrola_Realizacije', @level2type=N'COLUMN',@level2name=N'Skupaj'
GO

ALTER TABLE [dbo].[Kontrola_Realizacije] ADD  CONSTRAINT [DF_Kontrola_Realizacije_Vrednost]  DEFAULT ((0)) FOR [Vrednost]
GO

ALTER TABLE [dbo].[Kontrola_Realizacije] ADD  CONSTRAINT [DF_Kontrola_Realizacije_Skupaj]  DEFAULT ((0)) FOR [Skupaj]
GO


