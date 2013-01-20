/****** Object:  StoredProcedure [dbo].[usp_UpdateOseba_Licence]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateOseba_Licence]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdateOseba_Licence]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateOseba_Licence]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_UpdateOseba_Licence]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdateOseba_Licence]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_UpdateOseba_Licence]
	@ID int,
	@OsebaID int,
	@LicencaID int,
	@VeljaOd datetime,
	@VeljaDo datetime,
	@DatumVnosa datetime,
	@Avtor int
AS

SET NOCOUNT ON

UPDATE [dbo].[Oseba_Licence] SET
	[OsebaID] = @OsebaID,
	[LicencaID] = @LicencaID,
	[VeljaOd] = @VeljaOd,
	[VeljaDo] = @VeljaDo,
	[DatumVnosa] = @DatumVnosa,
	[Avtor] = @Avtor
WHERE
	[ID] = @ID

--endregion

' 
END
GO
