/****** Object:  StoredProcedure [dbo].[usp_InsertLog]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertLog]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



--region [dbo].[usp_InsertLog]

------------------------------------------------------------------------------------------------------------------------
-- Author:			Jan Kraljič
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_InsertLog]
-- Date Generated: 8.4.2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_InsertLog]
	@LogID int,
	@UporabnikID int,
	@naslov varchar(50),
	@opis text = null
	--@ID int OUTPUT
AS

SET NOCOUNT ON


INSERT INTO [dbo].[Log]
           (
			[LogID]
           ,[opis]
           ,[naslov]
           ,[UporabnikID]
           )
     VALUES
           (
			@LogID
           ,@opis
           ,@naslov
           ,@UporabnikID
           )



--SET @ID = SCOPE_IDENTITY()

--endregion




' 
END
GO
