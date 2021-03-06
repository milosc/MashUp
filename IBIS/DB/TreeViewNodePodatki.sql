/****** Object:  StoredProcedure [dbo].[TreeViewNodePodatki]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TreeViewNodePodatki]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[TreeViewNodePodatki]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TreeViewNodePodatki]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[TreeViewNodePodatki]
	-- Add the parameters for the stored procedure here
    @parent INT,
    @nivo INT,
    @stanje DATETIME
AS 
    BEGIN
        SET NOCOUNT ON ;

    -- izbor childs v bilancni shemi
        SELECT DISTINCT
                p.partner2 AS vrednost,
                o.kratica AS naziv,
                otp.Sifra AS TipOsebe
        FROM    Oseba O
                JOIN Pogodba p ON O.OsebaID = P.Partner2
                                  AND P.Partner1 = @parent
                                  AND p.Nivo = @nivo
                                  AND p.PogodbaTipID < 100
                                  AND p.DatumVnosa <= @stanje
                                  AND ISNULL(p.DatumSpremembe,
                                             DATEADD(yy, 50, GETDATE())) >= @stanje
                                  AND o.DatumVnosa <= @stanje
                                  AND ISNULL(o.DatumSpremembe,
                                             DATEADD(yy, 50, GETDATE())) >= @stanje
                                  AND p.VeljaOd <= @stanje
                                  AND ISNULL(p.VeljaDo,
                                             DATEADD(yy, 50, GETDATE())) >= @stanje
                LEFT JOIN dbo.OsebaTip ot ON ot.OsebaID = o.OsebaID
                                             AND ISNULL(ot.DatumSpremembe,
                                                        DATEADD(yy, 50, GETDATE())) >= @stanje
                                             AND ot.DatumVnosa <= @stanje
                                             AND ISNULL(ot.DatumSpremembe,
                                                        DATEADD(yy, 50, GETDATE())) >= @stanje
               LEFT JOIN dbo.OsebaTipID otp ON Ot.OsebaTipID = otp.OsebaTipID 
         where 
          cast(@stanje as date) between cast(o.VeljaOd as date) and cast(isnull(O.VeljaDo,dateadd(year,100,getdate())) as date)
           

    END


' 
END
GO
