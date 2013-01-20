USE [IBIS2]
GO

/****** Object:  View [dbo].[view_Meritve]    Script Date: 05/18/2012 21:23:45 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[view_Meritve]'))
DROP VIEW [dbo].[view_Meritve]
GO

USE [IBIS2]
GO

/****** Object:  View [dbo].[view_Meritve]    Script Date: 05/18/2012 21:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_Meritve]
AS
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_APR_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_AVG_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_DEC_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_FEB_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JAN_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUL_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUN_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAJ_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAR_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_NOV_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_OKT_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_SEP_08
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JAN_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_FEB_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAR_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_APR_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAJ_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUN_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUL_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_AVG_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_SEP_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_OKT_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_NOV_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_DEC_09
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JAN_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_FEB_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAR_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_APR_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAJ_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUN_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUL_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_AVG_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_SEP_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_OKT_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_NOV_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_DEC_10
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JAN_11
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_FEB_11
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAR_11
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_APR_11
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAJ_11
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUN_11
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUL_11
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_AVG_11
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_SEP_11
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_OKT_11
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_NOV_11
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_DEC_11
UNION ALL
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
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JAN_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_FEB_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAR_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_APR_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAJ_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUN_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUL_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_AVG_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_SEP_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_OKT_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_NOV_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_DEC_13
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JAN_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_FEB_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAR_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_APR_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAJ_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUN_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUL_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_AVG_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_SEP_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_OKT_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_NOV_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_DEC_14
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JAN_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_FEB_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAR_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_APR_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAJ_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUN_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUL_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_AVG_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_SEP_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_OKT_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_NOV_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_DEC_15
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JAN_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_FEB_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAR_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_APR_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAJ_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUN_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUL_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_AVG_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_SEP_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_OKT_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_NOV_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_DEC_16
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JAN_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_FEB_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAR_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_APR_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAJ_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUN_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUL_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_AVG_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_SEP_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_OKT_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_NOV_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_DEC_17
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JAN_18
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_FEB_18
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAR_18
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_APR_18
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_MAJ_18
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUN_18
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_JUL_18
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_AVG_18
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_SEP_18
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_OKT_18
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_NOV_18
UNION ALL
SELECT     ID, PPMID, Interval, Kolicina, DatumVnosa, DatumSpremembe
FROM         dbo.Meritve_DEC_18

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[15] 2[74] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 3
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 5
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Meritve'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'           End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Meritve_JUL_08"
            Begin Extent = 
               Top = 222
               Left = 227
               Bottom = 330
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Meritve_JUN_08"
            Begin Extent = 
               Top = 222
               Left = 416
               Bottom = 330
               Right = 567
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Meritve_MAJ_08"
            Begin Extent = 
               Top = 330
               Left = 38
               Bottom = 438
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Meritve_MAR_08"
            Begin Extent = 
               Top = 330
               Left = 227
               Bottom = 438
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Meritve_NOV_08"
            Begin Extent = 
               Top = 330
               Left = 416
               Bottom = 438
               Right = 567
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Meritve_OCT_08"
            Begin Extent = 
               Top = 438
               Left = 38
               Bottom = 546
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Meritve_SEP_08"
            Begin Extent = 
               Top = 438
               Left = 227
               Bottom = 546
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Meritve'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Meritve'
GO


