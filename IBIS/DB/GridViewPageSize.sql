/****** Object:  StoredProcedure [dbo].[GridViewPageSize]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GridViewPageSize]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GridViewPageSize]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GridViewPageSize]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridViewPageSize]
	--@ID int
AS
BEGIN

 select velikost, naziv from GridViewSize;
end
' 
END
GO
