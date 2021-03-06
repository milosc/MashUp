/****** Object:  StoredProcedure [dbo].[sp_SelectVseDobZaEnegaSistOPizPPM]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SelectVseDobZaEnegaSistOPizPPM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_SelectVseDobZaEnegaSistOPizPPM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SelectVseDobZaEnegaSistOPizPPM]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_SelectVseDobZaEnegaSistOPizPPM]
	@osebaID int,
	@obdobjeOd datetime,
	@obdobjeDo datetime,
	@stanje datetime
AS
BEGIN
--dobimo ven vse dobavitelje za dano osbeo npr-> el_ce_el_lj,el_ce_el_mb......
--ppmtipid pustimo kar 1 da nam vrne v bistvi ppmje z eno osebo, drugace pomeni 1->VIRT_MERJENI_ODJEM ,v osnvi jih imamo 4
select PPMID,Naziv,PPMTipID,SistemskiOperater1 as SistOp1,Dobavitelj1 as Dob1 from PPM
where SistemskiOperater1=@osebaID and PPMTipID in (1)
and
dbo.intersects(@obdobjeOd , @obdobjeDo, VeljaOd, VeljaDo) = 1 AND 
DatumSpremembe is null
and
DatumVnosa <= @stanje and dbo.infinite(DatumSpremembe) >= @stanje
END' 
END
GO
