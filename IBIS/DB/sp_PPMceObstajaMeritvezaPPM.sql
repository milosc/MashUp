/****** Object:  StoredProcedure [dbo].[sp_PPMceObstajaMeritvezaPPM]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PPMceObstajaMeritvezaPPM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PPMceObstajaMeritvezaPPM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PPMceObstajaMeritvezaPPM]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'---------------------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_PPMceObstajaMeritvezaPPM]
	@PPMID int,
	@stanje datetime
AS

BEGIN
declare @st int
declare @ret int
set @ret=0 

--pogledamo ce za izbran ppm obstajajo meritve
select @st =  count(PPMID) from view_Meritve
 where PPMID=@PPMID	
 and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje

	if(@st > 0)
	begin
		--meritve obstajao vrnemo 1
		set @ret=1
		return @ret
	end
	else
	begin
		--ni se nobenih meritev za ppm
		set @ret=0
		return @ret
	end

END' 
END
GO
