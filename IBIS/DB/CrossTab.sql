EXEC [dbo].[DropPRCorUDF] @ObjectName = 'CrossTab'
GO


CREATE procedure CrossTab 
(
@select varchar(8000),
@PivotCol varchar(100), 
@Summaries varchar(100), 
@GroupBy varchar(100),
@OtherCols varchar(100) = NULL,
@OrderByFunction VARCHAR(800) = NULL
)

AS
set nocount on
set ansi_warnings off 
declare @sql varchar(8000)

Select @sql = ''

Select @OtherCols= isNull(', ' + @OtherCols,'')

create table #pivot_columns (pivot_column_name varchar(100))

Select @sql='select ''' + replace( + @PivotCol,',',''' as pivot_column_name union all select ''')+''''

insert into #pivot_columns
exec(@sql)

select @sql=''

create table #pivot_columns_data (pivot_column_name varchar(100),pivot_column_data varchar(100))

Select @PivotCol=''

Select @PivotCol=min(pivot_column_name) from #pivot_columns

While @PivotCol>''
Begin
    insert into #pivot_columns_data(pivot_column_name,pivot_column_data) 
    exec 
    (
    'select distinct ''' + @PivotCol +''' as pivot_column_name, convert(varchar(100),' + @PivotCol + ') as pivot_column_data    from 
    ('+
        @select
    +'
    ) T'
    )

    Select @PivotCol=min(pivot_column_name) from #pivot_columns where pivot_column_name>@PivotCol
end 
select 
    @sql = @sql + ', ' + 
    replace(
        replace(
                @Summaries,'(','(CASE WHEN ' + Pivot_Column_name + '=''' + 
                pivot_column_data + ''' THEN ' 
                    ),
            ')[', ' END) as [' + pivot_column_data 
                )
from #pivot_columns_data
order by pivot_column_name

IF (@OrderByFunction IS null)
	exec 
	(
		 'select ' + @GroupBy +@OtherCols +@sql + 
		' from (
		'+
			@select 
		+'
		) T
		GROUP BY ' + @GroupBy
	) 
ELSE
	exec 
	(
		 'select ' + @GroupBy +@OtherCols +@sql + 
		' from (
		'+
			@select 
		+'
		) T
		GROUP BY ' + @GroupBy +@OrderByFunction
		
	) 

drop table #pivot_columns
drop table #pivot_columns_data

set nocount off
set ansi_warnings on