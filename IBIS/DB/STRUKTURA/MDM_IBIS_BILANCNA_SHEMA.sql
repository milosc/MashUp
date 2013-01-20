IF EXISTS ( SELECT  *
            FROM    sys.views
            WHERE   object_id = OBJECT_ID(N'[dbo].[MDM_IBIS_BILANCNA_SHEMA]') ) 
    DROP VIEW [dbo].[MDM_IBIS_BILANCNA_SHEMA]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MDM_IBIS_BILANCNA_SHEMA]
AS  
 select    
				p.ID AS BIL_SKUPINA_ID,
                p.veljaOD as VELJAVNO_OD,
                p.veljaDo as VELJAVNO_DO,
                P.DatumVnosa AS INS_DATE,
                P.DatumSpremembe AS UPD_DATE,
                (CASE WHEN P.PogodbaTipID = 1 THEN O2.naziv ELSE o.Naziv end) AS BIL_SKUPINA_NAZIV,
                P.Partner1 AS  Nadrejeni_PARTNER_ID,
                o.Naziv as Nadrejeni_Partner_Naziv,
                P.Partner2 AS  Podrejeni_PARTNER_ID,
                o2.Naziv as Podrejeni_Partner_Naziv,
                p.ClanBSID AS NADREJEN_BIL_SKUPINA_ID
      from      Pogodba p JOIN Oseba o ON p.Partner1 = O.OsebaID
						  JOIN Oseba o2 ON p.Partner2 = O2.OsebaID
      where Nivo < 3
		AND	CAST(GETDATE()  AS date) BETWEEN CAST(p.VeljaOd AS Date) AND CAST(ISNULL(p.VeljaDo,DATEADD(YEAR,100,GETDATE())) AS date)
		AND CAST(GETDATE()  AS date) BETWEEN CAST(p.DatumVnosa AS Date) AND CAST(ISNULL(p.DatumSpremembe,DATEADD(YEAR,100,GETDATE())) AS date)
		AND	CAST(GETDATE()  AS date) BETWEEN CAST(o.VeljaOd AS Date) AND CAST(ISNULL(o.VeljaDo,DATEADD(YEAR,100,GETDATE())) AS date)
		AND CAST(GETDATE()  AS date) BETWEEN CAST(o.DatumVnosa AS Date) AND CAST(ISNULL(o.DatumSpremembe,DATEADD(YEAR,100,GETDATE())) AS date)
		AND	CAST(GETDATE()  AS date) BETWEEN CAST(o2.VeljaOd AS Date) AND CAST(ISNULL(o2.VeljaDo,DATEADD(YEAR,100,GETDATE())) AS date)
		AND CAST(GETDATE()  AS date) BETWEEN CAST(o2.DatumVnosa AS Date) AND CAST(ISNULL(o2.DatumSpremembe,DATEADD(YEAR,100,GETDATE())) AS date)



GO