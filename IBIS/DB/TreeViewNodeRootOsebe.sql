/****** Object:  StoredProcedure [dbo].[TreeViewNodeRootOsebe]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TreeViewNodeRootOsebe]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[TreeViewNodeRootOsebe]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TreeViewNodeRootOsebe]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'








-- =============================================
-- Author:		Jan Kraljič
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TreeViewNodeRootOsebe]
	-- Add the parameters for the stored procedure here
	@OsebaID int,
	@stanje datetime
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @nivo int
	
	--select top 1 @nivo=nivo from Pogodba where Partner1 =@OsebaID ;

	select top 1 p.partner1 as vrednost,  o.kratica as naziv , nivo
	from Pogodba p, Oseba o 
	where o.OsebaID=p.partner1 and Partner1 =@OsebaID and
		p.DatumVnosa <= @stanje and ISNULL(p.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje and 
		o.DatumVnosa <= @stanje and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje;
END









' 
END
GO
