/****** Object:  StoredProcedure [dbo].[usp_InsertPodatkiObracuna]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPodatkiObracuna]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertPodatkiObracuna]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertPodatkiObracuna]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_InsertPodatkiObracuna]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_InsertPodatkiObracuna]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_InsertPodatkiObracuna]
	@ObracunID int,
	@BilancnaSkupina int,
	@Interval datetime,
	@TolerancniPas decimal(18, 0),
	@Odstopanje datetime,
	@Cplus decimal(18, 0),
	@Cminus decimal(18, 0),
	@Cp decimal(18, 0),
	@Cn decimal(18, 0),
	@PoravnavaZnotrajT decimal(18, 0),
	@PoravnavaZunajT decimal(18, 0),
	@ID int OUTPUT
AS

SET NOCOUNT ON

INSERT INTO [dbo].[PodatkiObracuna] (
	[ObracunID],
	[BilancnaSkupina],
	[Interval],
	[TolerancniPas],
	[Odstopanje],
	[Cplus],
	[Cminus],
	[Cp],
	[Cn],
	[PoravnavaZnotrajT],
	[PoravnavaZunajT]
) VALUES (
	@ObracunID,
	@BilancnaSkupina,
	@Interval,
	@TolerancniPas,
	@Odstopanje,
	@Cplus,
	@Cminus,
	@Cp,
	@Cn,
	@PoravnavaZnotrajT,
	@PoravnavaZunajT
)

SET @ID = SCOPE_IDENTITY()

--endregion

' 
END
GO
