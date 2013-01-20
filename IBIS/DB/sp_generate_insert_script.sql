set ANSI_NULLS ON 

set QUOTED_IDENTIFIER ON 
GO 
/****** Object: Stored Procedure dbo.sp_generate_insert_script Script Date: 9/22/2006 11:03:01 AM ******/ 
/****** Object: Stored Procedure dbo.sp_generate_insert_script Script Date: 8/30/2006 3:47:26 PM ******/ 
CREATE procedure [dbo].[sp_generate_insert_script] 
@tablename_mask varchar(30) = NULL 
as 
begin 
declare @tablename varchar (128) 
declare @tablename_max varchar (128) 
declare @tableid int 
declare @columncount numeric (7,0) 
declare @columncount_max numeric (7,0) 
declare @columnname varchar (30) 
declare @columntype int 
declare @string varchar (30) 
declare @leftpart varchar (8000) /* 8000 is the longest string SQLSrv7 can EXECUTE */ 
declare @rightpart varchar (8000) /* without having to resort to concatenation */ 
declare @hasident int 
set nocount on 
-- take ALL tables when no mask is given (!) 
if (@tablename_mask is NULL) 
begin 
select @tablename_mask = '%' 
end 
-- create table columninfo now, because it will be used several times 
create table #columninfo 
(num numeric (7,0) identity, 
name varchar(30), 
usertype smallint) 


select name, id into #tablenames from sysobjects where type in ('U' ,'S') and name like @tablename_mask 
-- loop through the table #tablenames 
select @tablename_max = MAX (name), @tablename = MIN (name) 
from #tablenames 
while @tablename <= @tablename_max 
begin 
select @tableid = id 
from #tablenames 
where name = @tablename 
if (@@rowcount <> 0) 
begin 
-- Find out whether the table contains an identity column 
select @hasident = max( status & 0x80 ) 
from syscolumns 
where id = @tableid 


truncate table #columninfo 


insert into #columninfo (name,usertype) 
select name, type 
from syscolumns C 
where id = @tableid and type <> 37 -- do not include timestamps 
-- Fill @leftpart with the first part of the desired insert-statement, with the fieldnames 
select @leftpart = 'select ''insert into '+@tablename 
select @leftpart = @leftpart + '(' 
select @columncount = MIN (num), @columncount_max = MAX (num) 
from #columninfo 
while @columncount <= @columncount_max 
begin 
select @columnname = name, @columntype = usertype 
from #columninfo 
where num = @columncount 
if (@@rowcount <> 0) 
begin 
if (@columncount < @columncount_max) 
begin 
select @leftpart = @leftpart + @columnname + ',' 
end 
else 
begin 
select @leftpart = @leftpart + @columnname + ')' 
end 
end 
select @columncount = @columncount + 1 
end 
select @leftpart = @leftpart + ' values(''' 
-- Now fill @rightpart with the statement to retrieve the values of the fields, correctly formatted 
select @columncount = MIN (num), 
@columncount_max = MAX (num) 
from #columninfo 
select @rightpart = '' 
while @columncount <= @columncount_max 
begin 
select @columnname = name, @columntype = usertype 
from #columninfo 
where num = @columncount 
if (@@rowcount <> 0) 
begin 
if @columntype in (39,47) /* char fields need quotes (except when entering NULL); 
* use char(39) == ', easier readable than escaping */ 
begin 
select @rightpart = @rightpart + '+' 
select @rightpart = @rightpart + 'ISNULL(' + replicate( char(39), 4 ) + '+replace(' + @columnname + ',' + replicate( char(39), 4 ) + ',' + replicate( char(39), 6) + ')+' + replicate( char(39), 4 ) + ',''NULL'')' 
end 
else if @columntype = 35 /* TEXT fields cannot be RTRIM-ed and need quotes */ 
/* convert to VC 1000 to leave space for other fields */ 
begin 
select @rightpart = @rightpart + '+' 
select @rightpart = @rightpart + 'ISNULL(' + replicate( char(39), 4 ) + '+replace(convert(varchar(1000),' + @columnname + ')' + ',' + replicate( char(39), 4 ) + ',' + replicate( char(39), 6 ) + ')+' + replicate( char(39), 4 ) + ',''NULL'')' 
end 
else if @columntype in (58,61,111) /* datetime fields */ 
begin 
select @rightpart = @rightpart + '+' 
select @rightpart = @rightpart + 'ISNULL(' + replicate( char(39), 4 ) + '+convert(varchar(20),' + @columnname + ')+'+ replicate( char(39), 4 ) + ',''NULL'')' 
end 
else /* numeric types */ 
begin 
select @rightpart = @rightpart + '+' 
select @rightpart = @rightpart + 'ISNULL(convert(varchar(99),' + @columnname + '),''NULL'')' 
end 
if ( @columncount < @columncount_max) 
begin 
select @rightpart = @rightpart + '+'',''' 
end 
end 
select @columncount = @columncount + 1 
end 
end 
select @rightpart = @rightpart + '+'')''' + ' from ' + @tablename 
-- Order the select-statements by the first column so you have the same order for 
-- different database (easy for comparisons between databases with different creation orders) 
select @rightpart = @rightpart + ' order by 1' 
-- For tables which contain an identity column we turn identity_insert on 
-- so we get exactly the same content 
if @hasident > 0 
select 'SET IDENTITY_INSERT ' + @tablename + ' ON ' 
exec ( @leftpart + @rightpart ) 
if @hasident > 0 
select 'SET IDENTITY_INSERT ' + @tablename + ' OFF' 
select @tablename = MIN (name) 
from #tablenames 
where name > @tablename 
end 
end