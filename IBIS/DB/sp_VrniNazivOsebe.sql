/****** Object:  StoredProcedure [dbo].[sp_VrniNazivOsebe]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_VrniNazivOsebe]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_VrniNazivOsebe]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_VrniNazivOsebe]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_VrniNazivOsebe]
	@OsebaID int,
	@stanje datetime,
	@Naziv varchar(50) OUTPUT,
	@Kratica varchar(10) OUTPUT
AS
BEGIN
declare @obstaja int
 
set @obstaja = 	(select count(OsebaID) from Oseba
				where OsebaID=@osebaID and 
				DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje);

--je obstaja =1 zna iti na else, ker imamo lahko 2 al vec zapisov 
	if(@obstaja > 0)
	begin
	--obstaja neka oseba za izbrano  stnje na dan
		select @Naziv=Naziv,@Kratica=Kratica from Oseba
		where OsebaID=@osebaID and 
		DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje;
	end
	else
	begin
		set @Naziv=''''
		set @Kratica=''''
	end
	
	

END' 
END
GO
