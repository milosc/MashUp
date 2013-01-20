

/****** Object:  View [dbo].[view_Meritve]    Script Date: 08/03/2012 00:23:28 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[view_Meritve]'))
DROP VIEW [dbo].[view_Meritve]
GO


/****** Object:  View [dbo].[view_Meritve]    Script Date: 08/03/2012 00:23:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_Meritve]
AS
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_APR_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_AVG_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_DEC_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_FEB_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JAN_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUL_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUN_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAJ_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAR_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_NOV_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_OKT_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_SEP_08
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JAN_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_FEB_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAR_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_APR_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAJ_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUN_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUL_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_AVG_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_SEP_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_OKT_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_NOV_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_DEC_09
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JAN_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_FEB_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAR_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_APR_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAJ_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUN_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUL_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_AVG_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_SEP_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_OKT_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_NOV_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_DEC_10
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JAN_11
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_FEB_11
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAR_11
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_APR_11
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAJ_11
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUN_11
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUL_11
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_AVG_11
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_SEP_11
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_OKT_11
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_NOV_11
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_DEC_11
--UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JAN_12
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_FEB_12
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAR_12
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_APR_12
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAJ_12
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUN_12
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUL_12
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_AVG_12
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_SEP_12
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_OKT_12
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_NOV_12
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_DEC_12
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JAN_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_FEB_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAR_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_APR_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAJ_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUN_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUL_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_AVG_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_SEP_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_OKT_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_NOV_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_DEC_13
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JAN_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_FEB_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAR_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_APR_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAJ_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUN_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUL_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_AVG_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_SEP_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_OKT_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_NOV_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_DEC_14
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JAN_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_FEB_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAR_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_APR_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAJ_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUN_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUL_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_AVG_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_SEP_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_OKT_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_NOV_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_DEC_15
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JAN_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_FEB_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAR_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_APR_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAJ_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUN_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUL_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_AVG_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_SEP_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_OKT_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_NOV_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_DEC_16
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JAN_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_FEB_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAR_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_APR_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAJ_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUN_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUL_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_AVG_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_SEP_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_OKT_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_NOV_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_DEC_17
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JAN_18
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_FEB_18
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAR_18
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_APR_18
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_MAJ_18
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUN_18
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_JUL_18
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_AVG_18
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_SEP_18
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_OKT_18
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_NOV_18
--UNION ALL
--SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
--FROM         dbo.Meritve_DEC_18



GO



