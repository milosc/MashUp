

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_W+]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_W+]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_W-]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_W-]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_S+]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_S+]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_S-]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_S-]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Table_1_SroškiIzravnave]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_Table_1_SroškiIzravnave]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_SaldoStroskiObracunov]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_SaldoStroskiObracunov]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_SkupnaOdstopanja]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_SkupnaOdstopanja]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_Razlika]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_Razlika]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_SIPXurni]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_SIPXurni]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_C+]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_C+]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_C-]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_C-]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_q+]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_q+]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_q-]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_q-]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_C+'']') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_C+']
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_C-'']') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_C-']
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_Korekcija]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_Korekcija]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_TP_GJS]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_TP_GJS]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_Realizacija_GJS]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_Realizacija_GJS]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_Odstopanje_GJS]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_Odstopanje_GJS]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_C+GJS]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_C+GJS]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PodatkiObracuna_Skupni_C-GJS]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PodatkiObracuna_Skupni] DROP CONSTRAINT [DF_PodatkiObracuna_Skupni_C-GJS]
END


/****** Object:  Table [dbo].[PodatkiObracuna_Skupni]    Script Date: 05/12/2012 23:13:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PodatkiObracuna_Skupni]') AND type in (N'U'))
DROP TABLE [dbo].[PodatkiObracuna_Skupni]
GO



CREATE TABLE [dbo].[PodatkiObracuna_Skupni](
	[ObracunID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[W+] [decimal](24, 8) NOT NULL,
	[W-] [decimal](24, 8) NOT NULL,
	[S+] [decimal](24, 8) NOT NULL,
	[S-] [decimal](24, 8) NOT NULL,
	[SroskiIzravnave] [decimal](24, 8) NOT NULL,
	[SaldoStroskiObracunov] [decimal](24, 8) NOT NULL,
	[SkupnaOdstopanja] [decimal](24, 8) NOT NULL,
	[Razlika] [decimal](24, 8) NOT NULL,
	[SIPXurni] [decimal](24, 8) NOT NULL,
	[C+] [decimal](24, 8) NOT NULL,
	[C-] [decimal](24, 8) NOT NULL,
	[q+] [decimal](24, 8) NOT NULL,
	[q-] [decimal](24, 8) NOT NULL,
	[C+'] [decimal](24, 8) NOT NULL,
	[C-'] [decimal](24, 8) NOT NULL,
	[Korekcija] [char](1) NOT NULL,
	[TP_GJS] [decimal](24, 8) NOT NULL,
	[Realizacija_GJS] [decimal](24, 8) NOT NULL,
	[Odstopanje_GJS] [decimal](24, 8) NOT NULL,
	[C+GJS] [decimal](24, 8) NOT NULL,
	[C-GJS] [decimal](24, 8) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_W+]  DEFAULT ((0)) FOR [W+]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_W-]  DEFAULT ((0)) FOR [W-]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_S+]  DEFAULT ((0)) FOR [S+]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_S-]  DEFAULT ((0)) FOR [S-]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_Table_1_SroškiIzravnave]  DEFAULT ((0)) FOR [SroskiIzravnave]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_SaldoStroskiObracunov]  DEFAULT ((0)) FOR [SaldoStroskiObracunov]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_SkupnaOdstopanja]  DEFAULT ((0)) FOR [SkupnaOdstopanja]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_Razlika]  DEFAULT ((0)) FOR [Razlika]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_SIPXurni]  DEFAULT ((0)) FOR [SIPXurni]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_C+]  DEFAULT ((0)) FOR [C+]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_C-]  DEFAULT ((0)) FOR [C-]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_q+]  DEFAULT ((0)) FOR [q+]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_q-]  DEFAULT ((0)) FOR [q-]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_C+']  DEFAULT ((0)) FOR [C+']
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_C-']  DEFAULT ((0)) FOR [C-']
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_Korekcija]  DEFAULT ('N') FOR [Korekcija]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_TP_GJS]  DEFAULT ((0)) FOR [TP_GJS]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_Realizacija_GJS]  DEFAULT ((0)) FOR [Realizacija_GJS]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_Odstopanje_GJS]  DEFAULT ((0)) FOR [Odstopanje_GJS]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_C+GJS]  DEFAULT ((0)) FOR [C+GJS]
GO

ALTER TABLE [dbo].[PodatkiObracuna_Skupni] ADD  CONSTRAINT [DF_PodatkiObracuna_Skupni_C-GJS]  DEFAULT ((0)) FOR [C-GJS]
GO

EXEC [dbo].[AddColumn]
	@TableName = 'PodatkiObracuna_Skupni', --  varchar(max)
	@ColumnName = 'Wplusi', --  varchar(max)
	@ColumnType = 'decimal(24,8)', --  varchar(max)
	@ColumnNull = 'NOT NULL', --  varchar(max)
	@ColumnDefault = '0' --  varchar(max)
GO

EXEC [dbo].[AddColumn]
	@TableName = 'PodatkiObracuna_Skupni', --  varchar(max)
	@ColumnName = 'Wminusi', --  varchar(max)
	@ColumnType = 'decimal(24,8)', --  varchar(max)
	@ColumnNull = 'NOT NULL', --  varchar(max)
	@ColumnDefault = '0' --  varchar(max)
GO


EXEC [dbo].[AddColumn]	@TableName = 'PodatkiObracuna', 	@ColumnName = 'Qplus',	@ColumnType = 'decimal(24,8)',	@ColumnNull = 'not null', 	@ColumnDefault = '(0)' 
GO
EXEC [dbo].[AddColumn]	@TableName = 'PodatkiObracuna', 	@ColumnName = 'Qminus',	@ColumnType = 'decimal(24,8)',	@ColumnNull = 'not null', 	@ColumnDefault = '(0)' 
GO
EXEC [dbo].[AddColumn]	@TableName = 'PodatkiObracuna', 	@ColumnName = 'Korekcija',	@ColumnType = 'int',	@ColumnNull = 'not null', 	@ColumnDefault = '(0)' 
GO


