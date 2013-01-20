/****** Object:  StoredProcedure [dbo].[usp_UpdatePPM]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePPM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdatePPM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePPM]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_UpdatePPM]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdatePPM]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_UpdatePPM]
	@ID int,
	@PPMID int,
	@STOD varchar(50),
	@SMM varchar(50),
	@PlacnikID nchar(10),
	@DatumVnosa datetime,
	@SistemskiOperater1 int,
	@SistemskiOperater2 int,
	@Dobavitelj1 int,
	@Dobavitelj2 int,
	@PPMTipID int,
	@MerilnaNapravaID int
AS

SET NOCOUNT ON

UPDATE [dbo].[PPM] SET
	[PPMID] = @PPMID,
	[STOD] = @STOD,
	[SMM] = @SMM,
	[PlacnikID] = @PlacnikID,
	[DatumVnosa] = @DatumVnosa,
	[SistemskiOperater1] = @SistemskiOperater1,
	[SistemskiOperater2] = @SistemskiOperater2,
	[Dobavitelj1] = @Dobavitelj1,
	[Dobavitelj2] = @Dobavitelj2,
	[PPMTipID] = @PPMTipID,
	[MerilnaNapravaID] = @MerilnaNapravaID
WHERE
	[ID] = @ID

--endregion


' 
END
GO
