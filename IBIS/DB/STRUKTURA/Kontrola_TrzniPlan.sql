

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_TrzniPlan_Koregiran_TrzniPlan]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_TrzniPlan] DROP CONSTRAINT [DF_Kontrola_TrzniPlan_Koregiran_TrzniPlan]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_TrzniPlan_Regulacija]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_TrzniPlan] DROP CONSTRAINT [DF_Kontrola_TrzniPlan_Regulacija]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_TrzniPlan_Wizr+]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_TrzniPlan] DROP CONSTRAINT [DF_Kontrola_TrzniPlan_Wizr+]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Table_1_Wiz-]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_TrzniPlan] DROP CONSTRAINT [DF_Table_1_Wiz-]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_TrzniPlan_SB+terc]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_TrzniPlan] DROP CONSTRAINT [DF_Kontrola_TrzniPlan_SB+terc]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_TrzniPlan_KontrolaIzrInSB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_TrzniPlan] DROP CONSTRAINT [DF_Kontrola_TrzniPlan_KontrolaIzrInSB]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Kontrola_TrzniPlan_Skupaj]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_TrzniPlan] DROP CONSTRAINT [DF_Kontrola_TrzniPlan_Skupaj]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Table_1_Ralika]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Kontrola_TrzniPlan] DROP CONSTRAINT [DF_Table_1_Ralika]
END

GO



/****** Object:  Table [dbo].[Kontrola_TrzniPlan]    Script Date: 06/03/2012 21:56:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Kontrola_TrzniPlan]') AND type in (N'U'))
DROP TABLE [dbo].[Kontrola_TrzniPlan]
GO



/****** Object:  Table [dbo].[Kontrola_TrzniPlan]    Script Date: 06/03/2012 21:56:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Kontrola_TrzniPlan](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ObracunID] [bigint] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Koregiran_TrzniPlan] [decimal](24, 8) NOT NULL,
	[OsebaID] [bigint] NOT NULL,
	[Regulacija] [decimal](24, 8) NOT NULL,
	[Wizr+] [decimal](24, 8) NOT NULL,
	[Wizr-] [decimal](24, 8) NOT NULL,
	[SB+terc] [decimal](24, 8) NOT NULL,
	[KontrolaIzrInSB] [decimal](24, 8) NOT NULL,
	[Skupaj] [decimal](24, 8) NOT NULL,
	[Razlika] [decimal](24, 8) NOT NULL,
 CONSTRAINT [PK_Kontrola_TrzniPlan] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Kontrola_TrzniPlan] ADD  CONSTRAINT [DF_Kontrola_TrzniPlan_Koregiran_TrzniPlan]  DEFAULT ((0)) FOR [Koregiran_TrzniPlan]
GO

ALTER TABLE [dbo].[Kontrola_TrzniPlan] ADD  CONSTRAINT [DF_Kontrola_TrzniPlan_Regulacija]  DEFAULT ((0)) FOR [Regulacija]
GO

ALTER TABLE [dbo].[Kontrola_TrzniPlan] ADD  CONSTRAINT [DF_Kontrola_TrzniPlan_Wizr+]  DEFAULT ((0)) FOR [Wizr+]
GO

ALTER TABLE [dbo].[Kontrola_TrzniPlan] ADD  CONSTRAINT [DF_Table_1_Wiz-]  DEFAULT ((0)) FOR [Wizr-]
GO

ALTER TABLE [dbo].[Kontrola_TrzniPlan] ADD  CONSTRAINT [DF_Kontrola_TrzniPlan_SB+terc]  DEFAULT ((0)) FOR [SB+terc]
GO

ALTER TABLE [dbo].[Kontrola_TrzniPlan] ADD  CONSTRAINT [DF_Kontrola_TrzniPlan_KontrolaIzrInSB]  DEFAULT ((0)) FOR [KontrolaIzrInSB]
GO

ALTER TABLE [dbo].[Kontrola_TrzniPlan] ADD  CONSTRAINT [DF_Kontrola_TrzniPlan_Skupaj]  DEFAULT ((0)) FOR [Skupaj]
GO

ALTER TABLE [dbo].[Kontrola_TrzniPlan] ADD  CONSTRAINT [DF_Table_1_Ralika]  DEFAULT ((0)) FOR [Razlika]
GO


