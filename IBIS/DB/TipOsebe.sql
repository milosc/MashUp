/****** Object:  StoredProcedure [dbo].[TipOsebe]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TipOsebe]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[TipOsebe]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TipOsebe]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--exec TipOsebe 41,''2010-3-2''
CREATE procedure [dbo].[TipOsebe] (
	@OsebaID int,
	@tPoint datetime	
) as
begin

declare @tip int
select @tip = osebaZId from osebaZCalc
    where osebaid= @OsebaID
    and @tPoint between datumVnosa and dbo.infinite(datumSpremembe)

--select @tip 
 return @tip
end
' 
END
GO
