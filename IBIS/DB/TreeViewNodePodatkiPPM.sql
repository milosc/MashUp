/****** Object:  StoredProcedure [dbo].[TreeViewNodePodatkiPPM]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TreeViewNodePodatkiPPM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[TreeViewNodePodatkiPPM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TreeViewNodePodatkiPPM]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





-- =============================================
-- Author:		Jan Kraljič
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TreeViewNodePodatkiPPM]
	-- Add the parameters for the stored procedure here
    @parent INT,
    @stanje DATETIME
AS 
    BEGIN
        SET NOCOUNT ON ;

    -- izbor childs v bilancni shemi
        SELECT  PPMID,
                Naziv
        FROM    PPM p
        WHERE   p.Dobavitelj1 = @parent
                AND p.DatumVnosa <= @stanje
                AND ISNULL(p.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje
                AND CAST(@stanje AS DATE) BETWEEN CAST(VeljaOd AS DATE)
                                          AND     CAST(ISNULL(VeljaDo, DATEADD(year, 100, GETDATE())) AS DATE)
    END







' 
END
GO
