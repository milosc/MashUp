/****** Object:  StoredProcedure [dbo].[MeniNapis]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MeniNapis]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[MeniNapis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MeniNapis]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MeniNapis]
	@stran INT
AS
BEGIN
	select * from Stran where StranID in 

	(
	select stranID from Stran where StranID =@stran and parent <> @stran
		union 
	select stranID from Stran where StranID = (select parent from Stran where StranID = @stran and parent <> @stran)
		union
	select stranID from Stran where StranID = (select parent from Stran where StranID = (select parent from Stran where StranID = @stran and parent <> @stran))
	)
order by pozicija DESC
END




' 
END
GO
