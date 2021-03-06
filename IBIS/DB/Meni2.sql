/****** Object:  StoredProcedure [dbo].[Meni2]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meni2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Meni2]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Meni2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Meni2]
	@stran INT,
	@VlogaID INT,
	@Revizija INT = 0
AS
BEGIN


if (@Revizija = 0)
		begin

	select * from Stran where nivo > 0 and parent = @stran and 
	pravica in 	(select distinct PravicaID from  VlogaPravica 
		where 
		DatumSpremembe IS NULL and
		VlogaID in 
			(select VlogaID from VlogaPrednik where 
			DatumSpremembe IS NULL and 
			PrednikID=@VlogaID)) 
	order by pozicija ASC;
end
else
begin
	select * from Stran where nivo > 0 and parent = @stran and 
	pravica in 	(select distinct PravicaID from  VlogaPravica 
		where 
		DatumSpremembe IS NULL and 
		PravicaID in (select PraviceID from Pravice where Revizija = @Revizija) and 
		VlogaID in 
			(select VlogaID from VlogaPrednik where 
			DatumSpremembe IS NULL and 
			PrednikID=@VlogaID)) 
	order by pozicija ASC;

end

END




' 
END
GO
