/****** Object:  StoredProcedure [dbo].[BO_Test]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BO_Test]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BO_Test]
GO
