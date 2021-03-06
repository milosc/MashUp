IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'[dbo].[usp_SelectPPMzaDobav]')
                    AND type IN ( N'P', N'PC' ) ) 
    DROP PROCEDURE [dbo].[usp_SelectPPMzaDobav]
GO


CREATE PROCEDURE [dbo].[usp_SelectPPMzaDobav]
    @osebaID INT,
    @obdobjeOd DATETIME,
    @obdobjeDo DATETIME
AS 
    BEGIN
	-- dobimo vse ppm-je za izbran sodo za vse dobavitelje razen ppmja za sam sodo,npr: el_mb_MERJNENA ODDAJA_el_ce...
--za vsak sodo za vse dobavitlje mora biti st. ppmjev deljivo z 4,ker imamo merjena oddaja,odjem in nemerjena oddaj,odjem
        SELECT  PPM.PPMID,
                PPM.Naziv,
                PPM.PPMTipID,
                PPM.SistemskiOperater1 AS SistOp1,
                PPM.Dobavitelj1 AS Dob1
        FROM    PPM
                JOIN Oseba os ON os.OsebaID = PPM.Dobavitelj1 AND os.DatumSpremembe IS NULL 
                AND dbo.intersects(@obdobjeOd, @obdobjeDo, os.VeljaOd,os.VeljaDo) = 1
                LEFT OUTER JOIN PPMTip pt ON pt.PPMTipID = PPM.PPMTipID
         WHERE   PPM.SistemskiOperater1 = @osebaID
                AND PPM.PPMTipID IN ( 1, 2, 4, 5 )
                AND dbo.intersects(@obdobjeOd, @obdobjeDo, PPM.VeljaOd,
                                   PPM.VeljaDo) = 1
                AND PPM.DatumSpremembe IS NULL
        ORDER BY os.VrstniRedExcelUvoz,
                pt.VrstniRedExcelUvoz

    END




GO


