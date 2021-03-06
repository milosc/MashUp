EXEC dbo.DropPRCorUDF @ObjectName = 'usp_SelectIzravnavasAll'
GO

CREATE PROCEDURE [dbo].[usp_SelectIzravnavasAll] 
@stanje DATETIME
AS 

    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED

    SELECT  i.[ID],
            i.[Interval],
            CAST(ISNULL(i.[Wp],0)+RWp AS DECIMAL(10, 2)) AS Wp,
            CAST(ISNULL(i.[Wm],0)+RWm AS DECIMAL(10, 2)) AS Wm,
            CAST(i.[Sp]+RSp AS DECIMAL(10, 2)) AS Sp,
            CAST(i.[Sm]+RSm AS DECIMAL(10, 2)) AS Sm,
            i.[DatumVnosa],
            o.Naziv,
            o.OsebaID
    FROM    [dbo].[Izravnava] i LEFT JOIN
	(SELECT interval,
																		   sum(ISNULL(SekRegP,0)+ISNULL(TerRegP,0)) as RWp,
																		   sum(ISNULL(SekRegM,0)+ISNULL(TerRegM,0)) RWm,
																		   sum(ISNULL(SekRegSp,0)+ISNULL(TerRegSp,0)) as RSp,
																		   sum(ISNULL(SekRegSm,0)+ISNULL(TerRegSm,0)) as RSm
										from dbo.Regulacija
										where 
											 @stanje BETWEEN [DatumVnosa] AND dbo.infinite(DatumSpremembe) 
										GROUP BY Interval 
										) R ON i.Interval = R.Interval 
            LEFT JOIN dbo.PPM P ON I.OsebaID = P.PPMID  AND P.DatumVnosa <= @stanje AND ISNULL(P.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje
            LEFT JOIN Oseba o ON P.Dobavitelj1 = o.OsebaID AND  o.DatumVnosa <= @stanje AND ISNULL(o.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje
    WHERE		I.DatumVnosa <= @stanje
            AND ISNULL(I.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje
           
            
