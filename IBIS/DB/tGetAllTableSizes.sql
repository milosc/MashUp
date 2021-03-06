/****** Object:  StoredProcedure [dbo].[tGetAllTableSizes]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tGetAllTableSizes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[tGetAllTableSizes]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tGetAllTableSizes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

create PROCEDURE [dbo].[tGetAllTableSizes]
AS
/*
    Obtains spaced used data for ALL user tables in the database
*/
DECLARE @TableName VARCHAR(100)    --For storing values in the cursor
 
--Cursor to get the name of all user tables from the sysobjects listing
DECLARE tableCursor CURSOR
FOR 
SELECT [name]
FROM dbo.sysobjects 
WHERE  OBJECTPROPERTY(id, N''IsUserTable'') = 1
FOR READ ONLY
 
--A procedure level temp table to store the results
CREATE TABLE #TempTable
(
    tableName VARCHAR(100),
    numberofRows VARCHAR(100),
    reservedSize VARCHAR(50),
    dataSize VARCHAR(50),
    indexSize VARCHAR(50),
    unusedSize VARCHAR(50)
)
 
--Open the cursor
OPEN tableCursor
 
--Get the first table name from the cursor
FETCH NEXT FROM tableCursor INTO @TableName
 
--Loop until the cursor was not able to fetch
WHILE (@@FETCH_STATUS >= 0)
BEGIN
    --Dump the results of the sp_spaceused query to the temp table
    INSERT  #TempTable
        EXEC SP_SPACEUSED @TableName
 
    --Get the next table name
    FETCH NEXT FROM tableCursor INTO @TableName
END
 
--Get rid of the cursor
CLOSE tableCursor
DEALLOCATE tableCursor
 
--Select all records so we can use the reults
SELECT * 
FROM #TempTable ORDER BY CAST(numberofrows AS INT) DESC
 
--Final cleanup!
DROP TABLE #TempTable' 
END
GO
