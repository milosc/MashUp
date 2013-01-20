
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_Distribucij_Vrednost]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_Distribucij] DROP CONSTRAINT [DF_Kontrola_Distribucij_Vrednost]
END

GO



/****** Object:  Table [dbo].[Kontrola_Distribucij]    Script Date: 06/03/2012 21:54:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Kontrola_Distribucij]') AND type in (N'U'))
DROP TABLE [dbo].[Kontrola_Distribucij]
GO



/****** Object:  Table [dbo].[Kontrola_Distribucij]    Script Date: 06/03/2012 21:54:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Kontrola_Distribucij](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ObracunID] [bigint] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[OsebaID] [bigint] NOT NULL,
	[Vrednost] [decimal](24, 8) NOT NULL,
 CONSTRAINT [PK_Kontrola_Distribucij] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Kontrola_Distribucij] ADD  CONSTRAINT [DF_Kontrola_Distribucij_Vrednost]  DEFAULT ((0)) FOR [Vrednost]
GO


