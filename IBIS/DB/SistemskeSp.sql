
IF EXISTS ( SELECT
               *
            FROM
               sys.objects
            WHERE
               object_id = OBJECT_ID(N'[dbo].[DropPRCorUDF]')
               AND type IN (N'P', N'PC') ) 
   DROP PROCEDURE [dbo].[DropPRCorUDF]
GO


CREATE PROCEDURE [dbo].[DropPRCorUDF]
   (
    @ObjectName VARCHAR(MAX)
   )
AS 
   BEGIN
    
      IF (LTRIM(RTRIM(ISNULL(@ObjectName, ''))) <> '') 
         BEGIN
			SET @ObjectName = REPLACE(@ObjectName,'[dbo].','');
			SET @ObjectName = REPLACE(@ObjectName,'dbo.','');
			SET @ObjectName = REPLACE(@ObjectName,'[','');
			SET @ObjectName = REPLACE(@ObjectName,']','');
         
            DECLARE @SqlStatement NVARCHAR(MAX)
		/*Poskusimo brisati proceduro*/
            SET @SqlStatement = N'IF  EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(''[' + @ObjectName
               + ']'') AND type in (''P'', ''PC''))
		DROP PROCEDURE  [' + @ObjectName + ']'

            EXEC dbo.sp_executesql 
               @statement = @SqlStatement

		/*Poskusimo brisati funkcijo*/		
            SET @SqlStatement = N'IF  EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(''[' + @ObjectName
               + ']'') AND type in (''F'', ''FN'',''TF'',''FS'',''FT'',''IF''))
		DROP FUNCTION  [' + @ObjectName + ']'
		
            EXEC dbo.sp_executesql 
               @statement = @SqlStatement
         END
   END
GO


exec DropPRCorUDF 'ColumnAlreadyExists'
GO

CREATE FUNCTION [dbo].[ColumnAlreadyExists](@TableName NVARCHAR(128),@ColumnName NVARCHAR(128)) 
RETURNS INTEGER--Returns 0 if column does not exist. Returns 1 if column exists.
AS
BEGIN 
--See if the Table already contains the column.
IF EXISTS
(SELECT * FROM SysObjects O INNER JOIN SysColumns C ON O.ID=C.ID
WHERE ObjectProperty(O.ID,'IsUserTable')=1 
AND O.Name=@TableName
AND C.Name=@ColumnName) 
RETURN 1
--Table does not contain the column.
RETURN 0
END
GO

exec DropPRCorUDF 'ConstraintAlreadyExists'
GO

CREATE FUNCTION [dbo].[ConstraintAlreadyExists](@TableName NVARCHAR(128),@ConstraintName NVARCHAR(128)) 
RETURNS INTEGER--Returns 0 if column does not exist. Returns 1 if column exists.
AS
BEGIN 
--See if the Table already contains the column.
IF EXISTS
(SELECT *
FROM sysobjects
WHERE object_name(parent_obj) = @TableName AND NAME=@ConstraintName) 
RETURN 1
--Table does not contain the column.
RETURN 0
END
GO

exec DropPRCorUDF 'IndexAlreadyExists'
GO

CREATE FUNCTION [dbo].[IndexAlreadyExists](@TableName NVARCHAR(128),@IndexName NVARCHAR(128)) 
RETURNS INTEGER--Returns 0 if column does not exist. Returns 1 if column exists.
AS
BEGIN 
--See if the Table already contains the column.
IF EXISTS
(SELECT * FROM sys.indexes O
WHERE 
	object_id = OBJECT_ID(@TableName)
AND O.Name=@IndexName) 
RETURN 1
--Table does not contain the column.
RETURN 0
END
GO

exec DropPRCorUDF 'TableAlreadyExists'
GO

CREATE FUNCTION [dbo].[TableAlreadyExists](@TableName NVARCHAR(128)) 
RETURNS INTEGER--Returns 0 if column does not exist. Returns 1 if column exists.
AS
BEGIN  

IF EXISTS (SELECT * 
            FROM dbo.sysobjects 
            WHERE id = object_id(@TableName) AND OBJECTPROPERTY(id, N'IsUserTable')= 1 ) 
                RETURN 1

RETURN 0
END
GO

exec DropPRCorUDF 'TriggerAlreadyExists'
GO

CREATE FUNCTION [dbo].[TriggerAlreadyExists](@TriggerName NVARCHAR(128)) 
RETURNS INTEGER--Returns 0 if column does not exist. Returns 1 if column exists.
AS
BEGIN 
 IF EXISTS ( SELECT  *
                FROM    sys.triggers
                WHERE   object_id = OBJECT_ID(@TriggerName) ) 
                RETURN 1
RETURN 0
END
GO


exec DropPRCorUDF 'AddColumn'
GO

CREATE PROCEDURE AddColumn (
@TableName VARCHAR(MAX),
@ColumnName varchar(MAX),
@ColumnType varchar(MAX),
@ColumnNull varchar(MAX) = 'NULL',
@ColumnDefault varchar(MAX) = ''
)
AS
BEGIN
	DECLARE @SqlStatement NVARCHAR(MAX)

	IF(dbo.[ColumnAlreadyExists](@TableName, @ColumnName) = 0) 
	BEGIN
		SELECT @SqlStatement =
		N'ALTER TABLE [dbo].[' + @TableName + '] ADD ' + @ColumnName + ' ' + @ColumnType + ' ' + @ColumnNull
		IF(@ColumnDefault <> '')
			SET @SqlStatement = @SqlStatement + ' CONSTRAINT[DV_' + @TableName + '_' + @ColumnName + '] DEFAULT ' + @ColumnDefault
		EXEC dbo.sp_executesql @statement = @SqlStatement
	END

	IF(dbo.[TableAlreadyExists]('A_' + @TableName) = 1 AND dbo.[ColumnAlreadyExists]('A_' + @TableName, @ColumnName) = 0) 
	BEGIN
		SELECT @SqlStatement =
		N'ALTER TABLE [dbo].[A_' + @TableName + '] ADD ' + @ColumnName + ' ' + @ColumnType + ' ' + 'NULL'
		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
END
GO 

exec DropPRCorUDF 'AddDefaultValue'
GO

CREATE PROCEDURE AddDefaultValue (
@TableName VARCHAR(MAX),
@ColumnName VARCHAR(MAX),
@Default VARCHAR(MAX),
@ConstraintName VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @SqlStatement NVARCHAR(MAX)

	IF (dbo.ConstraintAlreadyExists(@TableName,@ConstraintName) = 0)
	BEGIN
		SELECT @SqlStatement =
		'ALTER TABLE [dbo].[' + @TableName +'] ADD CONSTRAINT [' + @ConstraintName + ']  DEFAULT (' + @Default + ') FOR [' + @ColumnName + ']'
		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
END

GO 

exec DropPRCorUDF 'AddForeignKey'
GO

CREATE PROCEDURE AddForeignKey (
@TableName VARCHAR(MAX),
@ColumnName VARCHAR(MAX),
@ReferenceTable VARCHAR(MAX),
@ReferenceColumn VARCHAR(MAX),
@ConstraintName VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @SqlStatement NVARCHAR(MAX)

	IF (dbo.ConstraintAlreadyExists(@TableName,@ConstraintName) = 0)
	BEGIN
		SELECT @SqlStatement =
		'ALTER TABLE [dbo].[' + @TableName + ']  WITH CHECK ADD  CONSTRAINT [' + @ConstraintName + '] FOREIGN KEY([' + @ColumnName + '])
		REFERENCES [dbo].[' + @ReferenceTable + '] ([' + @ReferenceColumn + '])'
		EXEC dbo.sp_executesql @statement = @SqlStatement
		SELECT @SqlStatement =
		'ALTER TABLE [dbo].[' + @TableName + '] CHECK CONSTRAINT [' + @ConstraintName + ']'
		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
END



GO 

exec DropPRCorUDF 'AlterColumn'
GO

CREATE  PROCEDURE AlterColumn (
@TableName VARCHAR(MAX),
@ColumnName varchar(MAX),
@ColumnType varchar(MAX),
@ColumnNull varchar(MAX) = 'NULL',
@ColumnDefault varchar(MAX) = ''
)
AS
BEGIN
	DECLARE @SqlStatement NVARCHAR(MAX)

	IF(dbo.[ColumnAlreadyExists](@TableName, @ColumnName) = 1)
	BEGIN
		SELECT @SqlStatement =
		N'ALTER TABLE [dbo].[' + @TableName + '] ALTER COLUMN ' + @ColumnName + ' ' + @ColumnType + ' ' + @ColumnNull
			EXEC dbo.sp_executesql @statement = @SqlStatement
		
	
		IF(@ColumnDefault <> '')
				SET @SqlStatement = N'ALTER TABLE [dbo].[' + @TableName + '] ADD  CONSTRAINT DV_'+@TableName+'_'+@ColumnName+' DEFAULT (' +@ColumnDefault+') FOR '+@ColumnName
		EXEC dbo.sp_executesql @statement = @SqlStatement

	END

	IF(dbo.[ColumnAlreadyExists]('A_' + @TableName, @ColumnName) = 1) 
	BEGIN
		SELECT @SqlStatement =
		N'ALTER TABLE [dbo].[A_' + @TableName + '] ALTER COLUMN ' + @ColumnName + ' ' + @ColumnType + ' ' + 'NULL'
		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
END

GO

GO 

exec DropPRCorUDF 'CreateTable'
GO

CREATE PROCEDURE CreateTable (
@TableName VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @SqlStatement NVARCHAR(MAX)
	DECLARE @SrcRowGUID NVARCHAR(MAX)
	SET @SrcRowGUID = ''

	IF(dbo.IsDemoDatabase() = 1)
	BEGIN
		SET @SrcRowGUID = '[SrcRowGUID] bigint NULL,'
	END

	IF(dbo.[TableAlreadyExists](@TableName) = 0) 
	BEGIN
		SELECT @SqlStatement =
		N'CREATE TABLE [dbo].[' + @TableName + '] (
		[' + @TableName + 'ID] bigint IDENTITY(1,1) NOT NULL,
		[record_dt_created] datetime NOT NULL CONSTRAINT  [DV_' + @TableName + '_DateCreated] DEFAULT (getdate()),
		[record_dt_modified] datetime NOT NULL,
		[record_creator_id]	bigint NOT NULL,
		[record_modifier_id] bigint NOT NULL,
		[row_version] timestamp NOT NULL,'
		+ @SrcRowGUID +
		'CONSTRAINT [PK_' + @TableName + '] PRIMARY KEY CLUSTERED
		(
		  [' + @TableName + 'ID] ASC
		) ON [PRIMARY],
		) ON [PRIMARY]'

		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
	
	IF(dbo.[TableAlreadyExists]('A_' + @TableName) = 0 AND dbo.IsDemoDatabase() = 0)
	BEGIN
		SELECT @SqlStatement =
		N'CREATE TABLE [dbo].[A_' + @TableName + '] (
		[ArchiveID] bigint IDENTITY(1,1) NOT NULL,
		[ArchiveDate] datetime NOT NULL CONSTRAINT [DV_A_' + @TableName + '_ArchiveDate] DEFAULT (getdate()),
		[' + @TableName + 'ID] bigint NULL,
		[record_dt_created] datetime NULL,
		[record_dt_modified] datetime NULL,
		[record_creator_id]	bigint NULL,
		[record_modifier_id] bigint NULL
		) ON [PRIMARY]'

		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
END

GO 

exec DropPRCorUDF 'DropColumn'
GO

CREATE PROCEDURE DropColumn (
@TableName VARCHAR(MAX),
@ColumnName VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @SqlStatement NVARCHAR(MAX)

	IF (dbo.[ColumnAlreadyExists](@TableName,@ColumnName) = 1)
	BEGIN
		SELECT @SqlStatement =
		'exec sp_RENAME ''' + @TableName + '.' + @ColumnName + ''', ''OLD_' + @ColumnName + ''', ''COLUMN'''
		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
END
GO

exec DropPRCorUDF 'DropColumn'
GO

CREATE PROCEDURE DropColumn (
@TableName VARCHAR(MAX),
@ColumnName VARCHAR(MAX)
)
AS
BEGIN
	IF (dbo.[ColumnAlreadyExists](@TableName,@ColumnName) = 1)
	BEGIN
		declare @default sysname, @sql nvarchar(max)
		select @default = name 
		from sys.default_constraints 
		where parent_object_id = object_id(@TableName)
		AND type = 'D'
		AND parent_column_id = (
			select column_id 
			from sys.columns 
			where object_id = object_id(@TableName)
			and name = @ColumnName 
			)

		set @sql = N'alter table ' + @TableName + ' drop constraint ' + @default
		exec sp_executesql @sql

		set @sql = N'alter table ' + @TableName + ' drop column ' + @ColumnName
		exec sp_executesql @sql
	END
END
GO

exec DropPRCorUDF 'DropConstraint'
GO

CREATE PROCEDURE DropConstraint (
@TableName VARCHAR(MAX),
@ConstraintName VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @SqlStatement NVARCHAR(MAX)

	IF (dbo.ConstraintAlreadyExists(@TableName,@ConstraintName) = 1)
	BEGIN
		SELECT @SqlStatement =
		'ALTER TABLE [dbo].[' + @TableName + '] DROP CONSTRAINT ' + @ConstraintName
		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
END

GO 

exec DropPRCorUDF 'DropTable'
GO

CREATE PROCEDURE DropTable (
@TableName VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @SqlStatement NVARCHAR(MAX)

	IF(dbo.[TableAlreadyExists](@TableName) = 1) 
	BEGIN
		SELECT @SqlStatement =
		N'DROP TABLE [dbo].[' + @TableName + ']'

		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
	
	IF(dbo.[TableAlreadyExists]('A_' + @TableName) = 1)
	BEGIN
		SELECT @SqlStatement =
		N'DROP TABLE [dbo].[A_' + @TableName + ']'

		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
	
	IF(dbo.[TriggerAlreadyExists]('AT_' + @TableName) = 1)
	BEGIN
		SELECT @SqlStatement =
		'DROP TRIGGER [dbo].[AT_' + @TableName + ']'
		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
END

GO 

exec DropPRCorUDF 'DropTrigger'
GO

CREATE PROCEDURE DropTrigger (
@TableName VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @SqlStatement NVARCHAR(MAX)

	IF ([dbo].[TriggerAlreadyExists]('AT_' + @TableName) = 1)
	BEGIN
		SELECT @SqlStatement =
		'DROP TRIGGER [dbo].[AT_' + @TableName + ']'
		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
END

GO 

exec DropPRCorUDF 'UpdateTrigger'
GO

CREATE PROCEDURE UpdateTrigger (
@TableName VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @SqlStatement NVARCHAR(MAX)

	IF(dbo.[TriggerAlreadyExists]('AT_' + @TableName) = 1)
	BEGIN
		SELECT @SqlStatement =
		'DROP TRIGGER [dbo].[AT_' + @TableName + ']'
		EXEC dbo.sp_executesql @statement = @SqlStatement
	END

	IF(dbo.[TableAlreadyExists]('A_' + @TableName) = 1)
	BEGIN
		DECLARE @Columns VARCHAR(MAX)

		SELECT @Columns = ISNULL(@Columns + ', ', '') + name
		FROM syscolumns WHERE id=object_id(@TableName) and name not in ('row_version') and name not like + 'OLD_%'

		SELECT @SqlStatement =
		N'CREATE TRIGGER AT_' + @TableName + ' ON [dbo].[' + @TableName + ']
		FOR UPDATE, DELETE
		AS
		INSERT INTO [dbo].[A_' + @TableName + '](' + @Columns + ')
		SELECT ' + @Columns + '
		FROM DELETED'

		EXEC dbo.sp_executesql @statement = @SqlStatement
	END
END

GO 



exec DropPRCorUDF 'AddUniqueKey'
GO

CREATE PROCEDURE AddUniqueKey (
@TableName VARCHAR(MAX),
@Columns VARCHAR(MAX),
@ConstraintName VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @SqlStatement NVARCHAR(MAX)

	IF (dbo.ConstraintAlreadyExists(@TableName,@ConstraintName) = 0)
	BEGIN
		SELECT @SqlStatement =
		'ALTER TABLE [dbo].[' + @TableName + '] ADD  CONSTRAINT [' + @ConstraintName + '] UNIQUE NONCLUSTERED 
		('+ @Columns +')
		WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]'
		EXEC dbo.sp_executesql @statement = @SqlStatement		
	END
END
GO 


exec DropPRCorUDF 'BrisiPrevod'
GO

CREATE PROCEDURE BrisiPrevod
	@SifraSkupine VARCHAR(MAX),
	@SifraBesedila VARCHAR(MAX)
AS
BEGIN
	delete PrevajanjeBesedilo
	where SifraSkupine = @SifraSkupine AND SifraBesedila = @SifraBesedila
END
GO
