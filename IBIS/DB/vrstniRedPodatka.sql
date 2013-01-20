/****** Object:  UserDefinedFunction [dbo].[vrstniRedPodatka]    Script Date: 03/11/2012 21:58:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vrstniRedPodatka]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[vrstniRedPodatka]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vrstniRedPodatka]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[vrstniRedPodatka]
(
	@tip int 
)
RETURNS int
AS
BEGIN
    if(@tip=4) return 1
    if(@tip=5) return 2
    if(@tip=1) return 3
    if(@tip=2) return 4
    if(@tip=13) return 13
    if(@tip=121) return 121
    if(@tip=122) return 122 
    return 1000       
END
' 
END
GO
