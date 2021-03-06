/****** Object:  StoredProcedure [dbo].[NazivOsebeVrstniRed]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NazivOsebeVrstniRed]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[NazivOsebeVrstniRed]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NazivOsebeVrstniRed]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


create PROCEDURE [dbo].[NazivOsebeVrstniRed]
	@OsebaID int,
	@stanje datetime,
	@Naziv varchar(50) OUTPUT,
	@Kratica varchar(10) OUTPUT,
	@vr int output
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
		select @Naziv=Naziv,@Kratica=Kratica, @vr=VrstniRedExcelUvoz from Oseba
		where OsebaID=@osebaID and 
		DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje;
	end
	else
	begin
		set @Naziv=''''
		set @Kratica=''''
		set @vr=0
	end
	
	

END
' 
END
GO
