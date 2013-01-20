/****** Object:  StoredProcedure [dbo].[usp_UpdateCSLOEX]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateCSLOEX]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdateCSLOEX]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateCSLOEX]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_UpdateCSLOEX]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdateCSLOEX]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_UpdateCSLOEX]
	@ID int,
	@Interval datetime,
	@Vrednost decimal(18, 0),
	@DatumVnosa datetime
AS

SET NOCOUNT ON

UPDATE [dbo].[CSLOEX] SET
	[Interval] = @Interval,
	[Vrednost] = @Vrednost,
	[DatumVnosa] = @DatumVnosa
WHERE
	[ID] = @ID

--endregion

' 
END
GO
