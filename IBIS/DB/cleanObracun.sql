IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cleanObracun]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cleanObracun]
GO
