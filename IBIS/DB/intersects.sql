/****** Object:  UserDefinedFunction [dbo].[intersects]    Script Date: 03/11/2012 21:58:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[intersects]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[intersects]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[intersects]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[intersects]
(
	@dt1 datetime,
	@dt2 datetime,
	@dt3 datetime,
	@dt4 datetime
)
RETURNS bit
AS
BEGIN
	
	IF (
		@dt1 between @dt3 and dbo.infinite(@dt4) OR
		@dt3 between @dt1 and dbo.infinite(@dt2)
		)
		RETURN 1
	ELSE
		RETURN 0

	RETURN 0
END

' 
END
GO
