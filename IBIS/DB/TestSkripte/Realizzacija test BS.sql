--SELECT * FROM [dbo].[Oseba] WHERE [DatumSpremembe] IS NULL AND [VeljaDo] IS NULL ORDER BY [OsebaID] ASC 
--SELECT * FROM [dbo].[Pogodba] WHERE ([Partner2] = 5 OR [Partner1] = 5) AND [DatumSpremembe] IS NULL AND [VeljaDo] IS null
--SELECT * FROM [dbo].[PogodbaTip]

DECLARE @DatumIntervalaDO DATETIME
DECLARE @DatumIntervalaOD DATETIME
DECLARE @DatumStanjaBaze DATETIME
DECLARE @DatumVeljavnostiPodatkov DATETIME
DECLARE @PI INT
DECLARE @BP INT


DECLARE @VIRT_MERJENI_ODJEM INT
DECLARE @VIRT_NEMERJENI_ODJEM INT
DECLARE @VIRT_MERJEN_ODDAJA INT
DECLARE @VIRT_NEMERJEN_ODDAJA INT 
DECLARE @VIRT_REGULACIJA INT
DECLARE @VIRT_ELES_ODJEM INT
DECLARE @VIRT_ELES_ODDAJA INT
DECLARE @VIRT_PBI INT
DECLARE @VIRT_DSP INT
DECLARE @UDO_P_MERJENI INT
DECLARE @UDO_P_NEMERJENI INT
DECLARE @UDO_P_IZGUBE INT
DECLARE @MP_SKUPAJ INT
DECLARE @MP_ND_NEMERJENI INT
DECLARE @MP_ND_MERJENI INT
DECLARE @MP_NP_NEMERJENI INT
DECLARE @MP_NP_MERJENI INT
DECLARE @MP_KP_NEMERJENI INT
DECLARE @MP_KP_MERJENI INT
DECLARE @VIRT_ELES_MERITVE INT
DECLARE @MEJE INT
DECLARE @ND_EL_PR INT
DECLARE @ND_EL_MB INT
DECLARE @ND_EL_LJ INT
DECLARE @ND_EL_GO INT
DECLARE @ND_EL_CE INT
DECLARE @VIRT_ELES_MERITVE_PREVZEM_SODO INT
  
  
         
SET @DatumVeljavnostiPodatkov = '20120426'
SET @DatumStanjaBaze = '20120426'
SET @DatumIntervalaOD = '20120101'
SET @DatumIntervalaDo = '20120131'
      
SELECT  @BP = [PogodbaTipID]
FROM    [PogodbaTip]
WHERE   Sifra = 'B_POG' ;
  
SELECT  @PI = [PogodbaTipID]
FROM    [PogodbaTip]
WHERE   Sifra = 'P_IZR' ;
      
      --Postavitev globalnih konstant - ZAÈETEK
 
  --Postavitev globalnih konstant - ZAÈETEK
SELECT  @VIRT_ELES_MERITVE = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SOPO) VIRT_ELES_MERITVE' ;
  
SELECT  @VIRT_MERJENI_ODJEM = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) VIRT_MERJENI_ODJEM' ;
  
SELECT  @VIRT_NEMERJENI_ODJEM = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) VIRT_NEMERJENI_ODJEM' ;
 
SELECT  @VIRT_MERJEN_ODDAJA = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) VIRT_MERJEN_ODDAJA' ;
  
SELECT  @VIRT_NEMERJEN_ODDAJA = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) VIRT_NEMERJEN_ODDAJA' ;
  
SELECT  @VIRT_REGULACIJA = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(REG) VIRT_REGULACIJA' ;
  
SELECT  @VIRT_ELES_ODJEM = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = 'VIRT_ELES_ODJEM' ;
  
SELECT  @VIRT_ELES_ODDAJA = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = 'VIRT_ELES_ODDAJA' ;
  
SELECT  @VIRT_PBI = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) VIRT_PBI' ;
  
SELECT  @VIRT_DSP = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) VIRT_DSP' ;
  
SELECT  @UDO_P_MERJENI = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) UDO_P_MERJENI' ;
  
SELECT  @UDO_P_NEMERJENI = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) UDO_P_NEMERJENI' ;
  
SELECT  @UDO_P_IZGUBE = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) UDO_P_IZGUBE' ;
  
SELECT  @MP_SKUPAJ = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) MP_SKUPAJ' ;
  
SELECT  @MP_ND_NEMERJENI = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) MP_ND_NEMERJENI' ;
  
SELECT  @MP_ND_MERJENI = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) MP_ND_MERJENI' ;
  
SELECT  @MP_NP_NEMERJENI = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) MP_NP_NEMERJENI' ;
  
SELECT  @MP_NP_MERJENI = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) MP_NP_MERJENI' ;
  
SELECT  @MP_KP_NEMERJENI = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) MP_KP_NEMERJENI' ;
  
SELECT  @MP_KP_MERJENI = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) MP_KP_MERJENI' ;

SELECT  @MEJE = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = 'MEJE' ;

SELECT  @ND_EL_PR = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) ND_EL_PR' ;

SELECT  @ND_EL_MB = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) ND_EL_MB' ;

SELECT  @ND_EL_LJ = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) ND_EL_LJ' ;

SELECT  @ND_EL_GO = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) ND_EL_GO' ;

SELECT  @ND_EL_CE = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SODO) ND_EL_CE' ;
	  
SELECT  @VIRT_ELES_MERITVE_PREVZEM_SODO = [PPMTipID]
FROM    [PPMTip]
WHERE   Naziv = '(SOPO) VIRT_ELES_MERITVE_PREVZEM_SODO' ;


SELECT  SUM(( CASE WHEN PPM.[PPMTipID] IN ( @VIRT_MERJENI_ODJEM,
                                            @VIRT_NEMERJENI_ODJEM,
                                            @UDO_P_IZGUBE )
                   THEN ABS(M.Kolicina)
                   WHEN PPM.[PPMTipID] IN ( @VIRT_MERJEN_ODDAJA,
                                            @VIRT_NEMERJEN_ODDAJA )
                   THEN -1 * M.Kolicina
                   ELSE 0
              END )) AS Kolicina,
        SUM(( CASE WHEN PPM.[PPMTipID] IN ( @VIRT_MERJEN_ODDAJA,
                                            @VIRT_NEMERJEN_ODDAJA )
                   THEN M.Kolicina
                   ELSE 0
              END )) AS ODDAJE,
        SUM(( CASE WHEN PPM.[PPMTipID] IN ( @VIRT_MERJENI_ODJEM,
                                            @VIRT_NEMERJENI_ODJEM,
                                            @UDO_P_IZGUBE )
                   THEN ABS(M.Kolicina)
                   ELSE 0
              END )) AS Odjemi,
        M.[Interval],
        PPM.[Dobavitelj1],
        P.Nivo,
        NadrejenaOsebaID,
        PPM.SistemskiOperater1
FROM    [dbo].[Meritve_JAN_12] M
        INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
        INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
WHERE   M.[Interval] > @DatumIntervalaOD
        AND M.[Interval] <= DATEADD(DAY, 1, @DatumIntervalaDO)
        AND M.[DatumVnosa] <= @DatumStanjaBaze
        AND Interval = '2012-01-01 10:00:00.000'
        AND ( PPM.[PPMTipID] <> @VIRT_REGULACIJA )
        AND ( PPM.[PPMTipID] <> @VIRT_ELES_MERITVE )
        AND PPM.[PPMTipID] IS NOT NULL
        AND P.Nivo > 0
        AND ( P.[PogodbaTipID] = @PI
              OR P.[PogodbaTipID] = @BP
            )
        AND ( ( @DatumStanjaBaze BETWEEN PPM.DatumVnosa
                                 AND     dbo.infinite(PPM.DatumSpremembe) )
              AND ( @DatumVeljavnostiPodatkov BETWEEN PPM.VeljaOd
                                              AND     dbo.infinite(PPM.VeljaDo) )
            )
        AND ( @DatumStanjaBaze BETWEEN M.[DatumVnosa]
                               AND     dbo.infinite(M.[DatumSpremembe]) )
        AND ( ( ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                   AND     dbo.infinite(P.DatumSpremembe)
                  AND P.Aktivno = 1
                )
                OR ( P.Aktivno = 1 )
              )
              AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                              AND     dbo.infinite(P.VeljaDo) )
            )
GROUP BY M.[Interval],
        P.Nivo,
        PPM.[Dobavitelj1],
        P.NadrejenaOsebaID,
        PPM.SistemskiOperater1
ORDER BY PPM.SistemskiOperater1 ASC, PPM.[Dobavitelj1] ASC,P.Nivo DESC


SELECT  M.*,P.[Naziv],P.[Dobavitelj1],P.[Dobavitelj2],t.[Naziv]
FROM    Meritve_jan_12 M JOIN [dbo].[PPM] P ON M.[PPMID] = P.[PPMID] AND P.[DatumSpremembe] IS NULL  AND [Dobavitelj1] = 24 OR [Dobavitelj2]=24
JOIN [dbo].[PPMTip] t ON P.[PPMTipID] = t.[PPMTipID]
WHERE   M.[Interval] = '2012-01-01 01:00:00'

SELECT  M.*,P.[Naziv],P.[Dobavitelj1],P.[Dobavitelj2],t.[Naziv],P.[Naziv]
FROM    Meritve_jan_12 M JOIN [dbo].[PPM] P ON M.[PPMID] = P.[PPMID] AND P.[DatumSpremembe] IS NULL 
JOIN [dbo].[PPMTip] t ON P.[PPMTipID] = t.[PPMTipID] AND T.[PPMTipID] = @UDO_P_IZGUBE
WHERE   M.[Interval] = '2012-01-01 01:00:00' 



SELECT  M.*,P.[Naziv],P.[Dobavitelj1],P.[Dobavitelj2],t.[Naziv],P.[Naziv]
FROM    Meritve_jan_12 M JOIN [dbo].[PPM] P ON M.[PPMID] = P.[PPMID] AND P.[DatumSpremembe] IS NULL 
JOIN [dbo].[PPMTip] t ON P.[PPMTipID] = t.[PPMTipID]--AND T.[PPMTipID] = @UDO_P_IZGUBE
WHERE   M.[Interval] = '2012-01-01 01:00:00' AND M.[PPMID] = 614

SELECT * FROM [dbo].[PPM] P JOIN [dbo].[PPMTip] t ON P.[PPMTipID] = t.[PPMTipID] WHERE P.[PPMID]=92
AND P.[DatumSpremembe] IS NULL 


SELECT  M.*
FROM    Meritve_jan_12 M
WHERE   M.[Interval] = '2012-01-01 01:00:00' --AND M.[PPMID] = 614
ORDER BY Kolicina ASC

SELECT  M.*
FROM    Meritve_jan_12 M
WHERE   M.[Interval] = '2012-01-01 01:00:00' --AND M.[PPMID] = 614
AND [Kolicina] = '1864.56'
ORDER BY Kolicina asc


SELECT * FROM ppm WHERE [PPMID]=614

--UPDATE ppm SET [PPMJeOddaja] = 1 WHERE [PPMID]=614 AND ID = 934
SELECT * FROM ppm WHERE [PPMID]=92



SELECT * FROM [dbo].[PPMTip] WHERE [PPMTipID]=21
SELECT * FROM [dbo].[PPM] P WHERE P.[PPMID]=614
AND P.[DatumSpremembe] IS NULL 

SELECT * FROM [dbo].[PPM] P WHERE P.[PPMID]=448
AND P.[DatumSpremembe] IS NULL

SELECT * FROM [dbo].[Pogodba] WHERE Partner2 = 3


SELECT * FROM [dbo].[Oseba] WHERE [OsebaID] IN (1,3,4)


