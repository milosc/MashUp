/****** Object:  StoredProcedure [dbo].[sp_OsebePreveriCeJeVrstniRed]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_OsebePreveriCeJeVrstniRed]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_OsebePreveriCeJeVrstniRed]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_OsebePreveriCeJeVrstniRed]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_OsebePreveriCeJeVrstniRed]
	@vrstniRed int,
	@stanje datetime
AS
BEGIN
--ce vrne 1 pomeni da je stevilka vrstnega reda ze obstaja

if EXISTS
    (
	select *
	from Oseba o 
	where o.id = (select max(id) from oseba o1 where o1.osebaid = o.osebaid and
	o1.DatumVnosa <= @stanje and dbo.infinite(o1.DatumSpremembe) >= @stanje )
	and o.OsebaID > 1 and o.VrstniRedExcelUvoz=@vrstniRed
	)
	-- osebaId> 1 spustimo borzen
	return 1
ELSE
	return 0

END
' 
END
GO
