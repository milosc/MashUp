/****** Object:  StoredProcedure [dbo].[BilnacniObracun_Primerjava]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_Primerjava]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_Primerjava]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_Primerjava]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracun_Primerjava]
	-- Add the parameters for the stored procedure here
	--@Obdobje int,
	@Obracun1 int,
	@Obracun2 int,
	@start DateTime,
	@stop DateTime = null,
	@Bs XML = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- napolnim seznam OsebeID


if object_id(''#BS'') is not null
        drop table #BS

    CREATE TABLE #BS (
        OsebaID bigint
    )
    
    declare @hdocVTC int;
    declare @xmlpath varchar(255);
    --<Podatki><Osebe><OsebaID>
    set @xmlpath = ''/Podatki/Osebe'';

    exec sp_xml_preparedocument @hdocVTC OUTPUT, @Bs;


    insert into #BS (OsebaID)
    select OsebaID
    from openxml(@hdocVTC,@xmlpath,2) with 
    (
        OsebaID bigint
    )
	order by OsebaID asc     
    exec sp_xml_removedocument @hdocVTC


if object_id(''#PR'') is not null
        drop table #PR

    CREATE TABLE #PR (
        primerjava bigint
    )
    
    declare @hdocVTC1 int;
    declare @xmlpath1 varchar(255);
    --<Podatki><Primerjave><Primerjava>
    set @xmlpath1 = ''/Podatki/Primerjave'';

    exec sp_xml_preparedocument @hdocVTC1 OUTPUT, @Bs;


    insert into #PR (primerjava)
    select primerjava
    from openxml(@hdocVTC1,@xmlpath1,2) with 
    (
        primerjava bigint
    )
	order by primerjava asc     
    exec sp_xml_removedocument @hdocVTC1


    /*-- Insert statements for procedure here
	select distinct obr1.Interval as interval
	, obr1.OsebaID as bs
	, obr1.PoravnavaZnotrajT as obracun1
	,obr1.PoravnavaZunajT as obracun1m
	, obr2.PoravnavaZnotrajT  as obracun2
	,obr2.PoravnavaZunajT as obracun2m 
from PodatkiObracuna obr1
	, PodatkiObracuna obr2 
where obr2.ObracunID=@Obracun1 
	and obr1.ObracunID=@Obracun2 
	and (obr1.PoravnavaZnotrajT <> obr2.PoravnavaZnotrajT) 
	and obr1.Interval=obr2.Interval 
	and obr1.OsebaID=obr2.OsebaID;
*/
exec (''select * from OsebaTipID'')
END

' 
END
GO
