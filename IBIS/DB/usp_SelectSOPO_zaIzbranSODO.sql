/****** Object:  StoredProcedure [dbo].[usp_SelectSOPO_zaIzbranSODO]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectSOPO_zaIzbranSODO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectSOPO_zaIzbranSODO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectSOPO_zaIzbranSODO]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[usp_SelectSOPO_zaIzbranSODO]
	@osebaID int,
	@obdobjeOd  datetime,
	@obdobjeDo datetime
AS
BEGIN

select PPMID,Naziv,PPMTipID from PPM
where SistemskiOperater1=@osebaID and PPMTipID=7 and
dbo.intersects(@obdobjeOd , @obdobjeDo, VeljaOd, VeljaDo) = 1 AND 
DatumSpremembe is null

/*
(VeljaOd between @obdobjeOd and @obdobjeDo and 
isnull(VeljaDo,@obdobjeDo) between @obdobjeOd and @obdobjeDo) and
*/
END


' 
END
GO
