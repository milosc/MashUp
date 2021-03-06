/****** Object:  UserDefinedFunction [dbo].[tipPodatka]    Script Date: 03/11/2012 21:58:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tipPodatka]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[tipPodatka]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tipPodatka]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[tipPodatka]
(
	@tip int 
)
RETURNS nvarchar(30)
AS
BEGIN
    if(@tip=1) return ''Merjen Odjem''
    if(@tip=2) return ''Nemerjen Odjem''    
    if(@tip=4) return ''Merjena Oddaja''
    if(@tip=5) return ''Nemerjena Oddaja''
    if(@tip=13) return ''Izgube''
    if(@tip=121) return ''Odjem''
    if(@tip=122) return ''Oddaja''    
    return ''Neznano''
END
' 
END
GO
