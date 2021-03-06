/****** Object:  StoredProcedure [dbo].[sp_KreirajTabeloMeritve]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_KreirajTabeloMeritve]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_KreirajTabeloMeritve]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_KreirajTabeloMeritve]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_KreirajTabeloMeritve]
	@tblName varchar(255) 
AS
BEGIN


Declare @SQL VarChar(1000)

SELECT @SQL = ''Create Table '' + @tblName + ''(''
SELECT @SQL = @SQL + ''ID int NOT NULL IDENTITY(1,1) ,
					PPMID int NOT NULL,
					Interval datetime NOT NULL,
					Kolicina decimal(18,8),
					DatumVnosa datetime NOT NULL DEFAULT (getdate()),
					DatumSpremembe datetime,
					primary key (ID,Interval)
					)''

Exec (@SQL)

	

END' 
END
GO
