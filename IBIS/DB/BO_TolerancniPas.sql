IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BO_TolerancniPas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BO_TolerancniPas]
GO
