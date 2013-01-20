/****** Object:  StoredProcedure [dbo].[usp_UpdateDrzava]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateDrzava]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdateDrzava]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateDrzava]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_UpdateDrzava]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdateDrzava]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_UpdateDrzava]
	@DrzavaID int,
	@Naziv varchar(50),
	@Okrajsava varchar(50)
AS

SET NOCOUNT ON

UPDATE [dbo].[Drzava] SET
	[Naziv] = @Naziv,
	[Okrajsava] = @Okrajsava
WHERE
	[DrzavaID] = @DrzavaID

--endregion

' 
END
GO
