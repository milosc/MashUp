/****** Object:  StoredProcedure [dbo].[sp_PreveriCeTabelaObstaja]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreveriCeTabelaObstaja]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PreveriCeTabelaObstaja]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreveriCeTabelaObstaja]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_PreveriCeTabelaObstaja]
	@tblName varchar(255) ,
	@Obstaja int OUTPUT
AS
BEGIN


set @Obstaja =  (select count(name) from sysobjects where xtype=''u'' and name = @tblName)

	

END' 
END
GO
