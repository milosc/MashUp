/****** Object:  UserDefinedFunction [dbo].[infinite]    Script Date: 03/11/2012 21:58:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[infinite]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[infinite]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[infinite]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

CREATE FUNCTION [dbo].[infinite]
(
	@dt datetime
)
RETURNS datetime
AS
BEGIN
	return isnull(@dt, DATEADD(YEAR,1000,getdate()))
END

' 
END
GO
