IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[toZdebug]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[toZdebug]
GO
