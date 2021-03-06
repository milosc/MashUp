/****** Object:  StoredProcedure [dbo].[usp_UpdatePPM1]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePPM1]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdatePPM1]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePPM1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_UpdatePPM1]
	@Naziv varchar(50),
	@STOD varchar(50),
	@SMM varchar(50),
	@Dobavitelj1 int,
	@Dobavitelj2 int,
	@PlacnikID nchar(10),
	@SistemskiOperater1 int,
	@PPMID int,
	@SistemskiOperater2 int,
	@PPMTIpID int
AS

SET NOCOUNT ON

UPDATE dbo.[PPM] SET DatumSpremembe = getdate() WHERE PPMID = @PPMID AND DatumSpremembe IS NULL

INSERT INTO [dbo].[PPM] (
	[Naziv],
	[STOD],
	[SMM],
	[Dobavitelj1],
	[Dobavitelj2],
	[PlacnikID],
	[SistemskiOperater1],
	[PPMID],
	[SistemskiOperater2],
	[PPMTipID]
	

	
) VALUES (
	@Naziv,
	@STOD,
	@SMM,
	@Dobavitelj1,
	@Dobavitelj2,
	@PlacnikID,
	@SistemskiOperater1,
	@PPMID,
	@SistemskiOperater2,
	@PPMTipID
)



--endregion


' 
END
GO
