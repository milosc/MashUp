EXEC dbo.DropPRCorUDF
	@ObjectName = 'usp_SelectPPMsAll' --  varchar(max)
GO

CREATE PROCEDURE [dbo].[usp_SelectPPMsAll]
    @stanje DATETIME,
    @Naziv VARCHAR(100),
    @Virtualni VARCHAR(1) = NULL,
    @ShowAll VARCHAR(1) = NULL,
    @NEVirtualni VARCHAR(1) = NULL,
    @PPMTip bigint = 0,
    @SistemskiOperater bigint = 0,
    @Dobavitelj bigint = 0
AS 
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	
	SET @PPMTip = ISNULL(@PPMTip,0)

	IF (@ShowAll = 0)      
    SELECT  p.[ID],
            p.[PPMID],
            P.EIC,
            p.[STOD],
            p.[SMM],
            p.[Naziv],
            p.[PlacnikID],
            p.LastnikID,
            p.[DatumVnosa],
            p.SistemskiOperater1,
            p.[SistemskiOperater2],
            p.Dobavitelj1,
            p.[Dobavitelj2],
            p.[PPMTipID],
            t.[naziv] AS PPMTipNaziv,
            p.[MerilnaNapravaID],
            p.[DatumSpremembe],
            p.VrstniRed,
            p.VeljaOd,
            p.VeljaDo,
            os.Naziv AS NazivOsebe,
            T.Virtualen
    FROM    [dbo].[PPM] P
            JOIN dbo.PPMTip t ON p.PPMTipID = t.PPMTipID
            JOIN Oseba os ON os.OsebaID = p.dobavitelj1
                             AND @stanje BETWEEN os.veljaOd
                                         AND     dbo.infinite(os.veljaDo)
                             AND GETDATE() BETWEEN os.DatumVnosa
                                           AND     dbo.infinite(os.DatumSpremembe)
            JOIN ( SELECT   MAX(id) AS id,
							ppmID
                   FROM     PPM p1
                   WHERE    p1.DatumVnosa <= @stanje AND dbo.infinite(p1.DatumSpremembe) >= @stanje
                   GROUP BY PPMID
                 ) PPM1 ON PPM1.id = P.ID
    WHERE
		(@PPMTip = 0 OR P.PPMTipID = @PPMTip)
	AND (@SistemskiOperater = 0 OR P.SistemskiOperater1 = @SistemskiOperater)		
	AND (@Dobavitelj = 0 OR P.Dobavitelj1 = @Dobavitelj)
    AND (LTRIM(RTRIM(ISNULL(@Naziv,''))) = '' OR P.Naziv LIKE '%'+LTRIM(RTRIM(@Naziv))+'%')
    AND (@Virtualni = '0' OR @Virtualni = '1' AND t.Virtualen = 1)
    AND (@NEVirtualni = '0' OR @NEVirtualni = '1' AND t.Virtualen = 0)
    ORDER BY PPMID ASC
    ELSE
    IF  (@ShowAll = 1)      
SELECT  p.[ID],
            p.[PPMID],
            p.[STOD],
            P.EIC,
            p.[SMM],
            p.[Naziv],
            p.[PlacnikID],
            p.LastnikID,
            p.[DatumVnosa],
            p.SistemskiOperater1,
            p.[SistemskiOperater2],
            p.Dobavitelj1,
            p.[Dobavitelj2],
            p.[PPMTipID],
            t.[naziv] AS PPMTipNaziv,
            p.[MerilnaNapravaID],
            p.[DatumSpremembe],
            p.VrstniRed,
            p.VeljaOd,
            p.VeljaDo,
            os.Naziv AS NazivOsebe,
            T.Virtualen
    FROM    [dbo].[PPM] P
            JOIN dbo.PPMTip t ON p.PPMTipID = t.PPMTipID
            JOIN Oseba os ON os.OsebaID = p.dobavitelj1
    WHERE
		(@PPMTip = 0 OR P.PPMTipID = @PPMTip)
	AND (@SistemskiOperater = 0 OR P.SistemskiOperater1 = @SistemskiOperater)		
	AND (@Dobavitelj = 0 OR P.Dobavitelj1 = @Dobavitelj)
    AND (LTRIM(RTRIM(ISNULL(@Naziv,''))) = '' OR P.Naziv LIKE '%'+LTRIM(RTRIM(@Naziv))+'%')
    AND (@Virtualni = '0' OR @Virtualni = '1' AND t.Virtualen = 1)
    AND (@NEVirtualni = '0' OR @NEVirtualni = '1' AND t.Virtualen = 0)
    ORDER BY PPMID ASC
    


GO