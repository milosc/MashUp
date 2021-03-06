/****** Object:  StoredProcedure [dbo].[usp_UpdateOsebaSprememba]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateOsebaSprememba]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdateOsebaSprememba]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateOsebaSprememba]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'---------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_UpdateOsebaSprememba]
	@ID int
AS

SET NOCOUNT ON

UPDATE Oseba
SET DatumSpremembe = getdate() 
WHERE ID = @ID

--ko pobrisemo osebo(postavimo datum spremembe) moramo tudi pri ppm-jih
--postaviti datum sprememeb za vse tiste ppm-je ki imajo sistop(osebo) in dobavitelja,ker drugace bodo doloceni ppm pripadali osebi ki je ni
declare @tmpOsebaID int
set @tmpOsebaID =( select OsebaID from Oseba where ID=@ID)

/*
spodnja dva stavka zakmonetiramo ker sedaj bomo samo opozirili da ne moremo pobrisati
osebe ker imamo ppm.je vezane na osebo, potrebno najprej pobriast ppmje ,seveda ce si prijavljen kot admin(vlogaid=1)
*/
--update PPM set DatumSpremembe = getdate() where SistemskiOperater1=@tmpOsebaID
--update PPM set DatumSpremembe = getdate() where Dobavitelj1=@tmpOsebaID


' 
END
GO
