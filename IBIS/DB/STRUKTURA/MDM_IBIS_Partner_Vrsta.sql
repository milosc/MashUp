IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[MDM_IBIS_Partner_Vrsta]'))
DROP VIEW [dbo].[MDM_IBIS_Partner_Vrsta]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MDM_IBIS_Partner_Vrsta]
AS
SELECT O.OsebaID,1 AS Skupina_ID, 'LIC' AS Skupina_Koda,'Licenca' AS Opis,L.LicencaID AS Vrsta_Partnerja_ID ,L.Naziv AS Vrsta_Partnerja_Koda, '' AS Vrsta_Partnerja_Opis,1 AS Aktiven_IND 
FROM Oseba O LEFT JOIN dbo.Oseba_Licence OL ON O.OsebaID = OL.OsebaID
			 LEFT JOIN dbo.Licenca L ON OL.LicencaID = L.LicencaID
WHERE CAST(GETDATE()  AS date) BETWEEN CAST(O.VeljaOd AS Date) AND CAST(ISNULL(O.VeljaDo,DATEADD(YEAR,100,GETDATE())) AS date)
AND CAST(GETDATE()  AS date) BETWEEN CAST(O.DatumVnosa AS Date) AND CAST(ISNULL(O.DatumSpremembe,DATEADD(YEAR,100,GETDATE())) AS date)
AND CAST(GETDATE()  AS date) BETWEEN CAST(OL.VeljaOd AS Date) AND CAST(ISNULL(OL.VeljaDo,DATEADD(YEAR,100,GETDATE())) AS date)
AND CAST(GETDATE()  AS date) BETWEEN CAST(OL.DatumVnosa AS Date) AND CAST(ISNULL(OL.DatumSpremembe,DATEADD(YEAR,100,GETDATE())) AS date)
UNION ALL
SELECT O.OsebaID,2 AS Skupina_ID, 'TIP' AS Skupina_Koda,'Tip oseba' AS Opis,
T.OsebaTipID AS Vrsta_Partnerja_ID ,OT.Sifra AS Vrsta_Partnerja_Koda, OT.Naziv AS Vrsta_Partnerja_Opis,1 AS Aktiven_IND 
FROM Oseba O LEFT JOIN dbo.OsebaTip T ON O.OsebaID = T.OsebaID
			 LEFT JOIN dbo.OsebaTipID OT ON OT.OsebaTipID = T.OsebaTipID
WHERE CAST(GETDATE()  AS date) BETWEEN CAST(O.VeljaOd AS Date) AND CAST(ISNULL(O.VeljaDo,DATEADD(YEAR,100,GETDATE())) AS date)
AND CAST(GETDATE()  AS date) BETWEEN CAST(O.DatumVnosa AS Date) AND CAST(ISNULL(O.DatumSpremembe,DATEADD(YEAR,100,GETDATE())) AS date)
AND CAST(GETDATE()  AS date) BETWEEN CAST(T.DatumVnosa AS Date) AND CAST(ISNULL(T.DatumSpremembe,DATEADD(YEAR,100,GETDATE())) AS date)
UNION ALL
SELECT O.OsebaID,3 AS Skupina_ID, 'PEN' AS Skupina_Koda,'Tip penalizacije ' AS Opis,
T.OsebaZId AS Vrsta_Partnerja_ID ,OT.Sifra AS Vrsta_Partnerja_Koda, OT.Naziv AS Vrsta_Partnerja_Opis,1 AS Aktiven_IND 
FROM Oseba O LEFT JOIN dbo.OsebaZCalc T ON O.OsebaID = T.OsebaID
			 LEFT JOIN dbo.OsebaZId OT ON OT.OsebaZId = T.OsebaZId
WHERE CAST(GETDATE()  AS date) BETWEEN CAST(O.VeljaOd AS Date) AND CAST(ISNULL(O.VeljaDo,DATEADD(YEAR,100,GETDATE())) AS date)
AND CAST(GETDATE()  AS date) BETWEEN CAST(O.DatumVnosa AS Date) AND CAST(ISNULL(O.DatumSpremembe,DATEADD(YEAR,100,GETDATE())) AS date)
AND CAST(GETDATE()  AS date) BETWEEN CAST(T.DatumVnosa AS Date) AND CAST(ISNULL(T.DatumSpremembe,DATEADD(YEAR,100,GETDATE())) AS date)

GO

