/****** Object:  StoredProcedure [dbo].[usp_UpdateMeritve]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateMeritve]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdateMeritve]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateMeritve]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_UpdateMeritve]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdateMeritve]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_UpdateMeritve]
	@ID int,
	@PPMID int,
	@Interval datetime,
	@Kolicina decimal(18, 0),
	@DatumVnosa datetime
AS

SET NOCOUNT ON

UPDATE [dbo].[Meritve] SET
	[PPMID] = @PPMID,
	[Interval] = @Interval,
	[Kolicina] = @Kolicina,
	[DatumVnosa] = @DatumVnosa
WHERE
	[ID] = @ID

--endregion

' 
END
GO
