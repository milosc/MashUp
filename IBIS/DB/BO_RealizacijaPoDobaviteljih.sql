IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BO_RealizacijaPoDobaviteljih]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BO_RealizacijaPoDobaviteljih]
GO
