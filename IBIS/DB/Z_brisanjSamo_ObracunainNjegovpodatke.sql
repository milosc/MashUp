/****** Object:  StoredProcedure [dbo].[Z_brisanjSamo_ObracunainNjegovpodatke]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Z_brisanjSamo_ObracunainNjegovpodatke]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Z_brisanjSamo_ObracunainNjegovpodatke]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Z_brisanjSamo_ObracunainNjegovpodatke]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE procedure [dbo].[Z_brisanjSamo_ObracunainNjegovpodatke]
as
begin
-- za brisanje samo obracunov in vseh podatkov obracuna (meritve,obdobja itd.. ostanje)
--
print 1
--delete from KolicinskaOdstopanjaPoBPS
--delete from KolicinskaOdstopanjaPoBS
--delete from Obracun
--delete from Obracun_PodatkiPoracuna
--delete from Obracun_PodatkiPoracunaVrstice
--delete from ObracunKolicinski
--delete from PodatkiObracuna
--delete from PreostaliOdjem
--delete from RealizacijaPoBPS
--delete from RealizacijaPoBS
--delete from RealizacijaPoDobaviteljih
--delete from RealizacijaPoSo
--delete from TolerancniPas


end
' 
END
GO
