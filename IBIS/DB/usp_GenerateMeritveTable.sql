/****** Object:  StoredProcedure [dbo].[usp_GenerateMeritveTable]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GenerateMeritveTable]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_GenerateMeritveTable]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_GenerateMeritveTable]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


------------------------------------------------------------------------------------------------------------------------
-- Generated By:   Borut mehle
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_GenerateMeritveTable]
-- Date Generated: 29. maj 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_GenerateMeritveTable]
	@Mesec varchar(10),
	@MesecNaziv varchar(10),
	@Leto varchar(10),
	@LetoNaziv varchar(10)
AS

SET NOCOUNT ON

DECLARE @CreateQuery as varchar(max)

if (object_id(''Meritve_''+@MesecNaziv+''_''+@LetoNaziv) is not null)
begin
	SET @CreateQuery=''
	CREATE TABLE [dbo].[Meritve_''+@MesecNaziv+''_''+@LetoNaziv+''](
		[ID] [int] IDENTITY(1,1) NOT NULL,
		[PPMID] [int] NOT NULL,
		[Interval] [datetime] NOT NULL,
		[Kolicina] [decimal](19, 6) NOT NULL,
		[DatumVnosa] [datetime] NOT NULL,
		[DatumSpremembe] [datetime] NULL,
	 CONSTRAINT [PK_Meritve_''+@MesecNaziv+''_''+@LetoNaziv+''] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC,
		[Interval] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	GO
	ALTER TABLE [dbo].[Meritve_''+@MesecNaziv+''_''+@LetoNaziv+'']  WITH CHECK ADD  CONSTRAINT [CHK_Meritve_''+@MesecNaziv+''_''+@LetoNaziv+''] CHECK  (([Interval]>=''+@Leto+@Mesec+''01''+'' AND [Interval]<''+@Leto+@Mesec+''31''+''))
	GO
	ALTER TABLE [dbo].[Meritve_''+@MesecNaziv+''_''+@LetoNaziv+''] CHECK CONSTRAINT [CHK_Meritve_''+@MesecNaziv+''_''+@LetoNaziv+'']
	''
	exec @CreateQuery
	
	return 1

End

return 0
' 
END
GO
