

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_SOPO_Vrstica_MesecnaKolicina]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_SOPO] DROP CONSTRAINT [DF_Kontrola_SOPO_Vrstica_MesecnaKolicina]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_SOPO_Vrstica_Razlika]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_SOPO] DROP CONSTRAINT [DF_Kontrola_SOPO_Vrstica_Razlika]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_SOPO_Vrstica_ND_Merjeni]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_SOPO] DROP CONSTRAINT [DF_Kontrola_SOPO_Vrstica_ND_Merjeni]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_SOPO_Vrstica_PDP]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_SOPO] DROP CONSTRAINT [DF_Kontrola_SOPO_Vrstica_PDP]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_SOPO_Vrstica_PDO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_SOPO] DROP CONSTRAINT [DF_Kontrola_SOPO_Vrstica_PDO]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_SOPO_Vrstica_KolicnikIzgub]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_SOPO] DROP CONSTRAINT [DF_Kontrola_SOPO_Vrstica_KolicnikIzgub]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_SOPO_KolicnikIzubSuma]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_SOPO] DROP CONSTRAINT [DF_Kontrola_SOPO_KolicnikIzubSuma]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_SOPO_OdstotekMesecnaKolicina]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_SOPO] DROP CONSTRAINT [DF_Kontrola_SOPO_OdstotekMesecnaKolicina]
END

GO


/****** Object:  Table [dbo].[Kontrola_SOPO]    Script Date: 06/03/2012 21:55:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Kontrola_SOPO]') AND type in (N'U'))
DROP TABLE [dbo].[Kontrola_SOPO]
GO


/****** Object:  Table [dbo].[Kontrola_SOPO]    Script Date: 06/03/2012 21:55:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Kontrola_SOPO](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ObracunID] [bigint] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[OsebaID] [bigint] NOT NULL,
	[MesecnaKolicina] [decimal](24, 8) NOT NULL,
	[Razlika] [decimal](24, 8) NOT NULL,
	[ND_Merjeni] [decimal](24, 8) NOT NULL,
	[PDP] [decimal](24, 8) NOT NULL,
	[PDO] [decimal](24, 8) NOT NULL,
	[KolicnikIzgub] [decimal](24, 8) NOT NULL,
	[OdstotekIzgubSuma] [decimal](24, 8) NOT NULL,
	[OdstotekMesecnaKolicina] [decimal](24, 8) NOT NULL,
 CONSTRAINT [PK_Kontrola_SOPO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Kontrola_SOPO] ADD  CONSTRAINT [DF_Kontrola_SOPO_Vrstica_MesecnaKolicina]  DEFAULT ((0)) FOR [MesecnaKolicina]
GO

ALTER TABLE [dbo].[Kontrola_SOPO] ADD  CONSTRAINT [DF_Kontrola_SOPO_Vrstica_Razlika]  DEFAULT ((0)) FOR [Razlika]
GO

ALTER TABLE [dbo].[Kontrola_SOPO] ADD  CONSTRAINT [DF_Kontrola_SOPO_Vrstica_ND_Merjeni]  DEFAULT ((0)) FOR [ND_Merjeni]
GO

ALTER TABLE [dbo].[Kontrola_SOPO] ADD  CONSTRAINT [DF_Kontrola_SOPO_Vrstica_PDP]  DEFAULT ((0)) FOR [PDP]
GO

ALTER TABLE [dbo].[Kontrola_SOPO] ADD  CONSTRAINT [DF_Kontrola_SOPO_Vrstica_PDO]  DEFAULT ((0)) FOR [PDO]
GO

ALTER TABLE [dbo].[Kontrola_SOPO] ADD  CONSTRAINT [DF_Kontrola_SOPO_Vrstica_KolicnikIzgub]  DEFAULT ((0)) FOR [KolicnikIzgub]
GO

ALTER TABLE [dbo].[Kontrola_SOPO] ADD  CONSTRAINT [DF_Kontrola_SOPO_KolicnikIzubSuma]  DEFAULT ((0)) FOR [OdstotekIzgubSuma]
GO

ALTER TABLE [dbo].[Kontrola_SOPO] ADD  CONSTRAINT [DF_Kontrola_SOPO_OdstotekMesecnaKolicina]  DEFAULT ((0)) FOR [OdstotekMesecnaKolicina]
GO


