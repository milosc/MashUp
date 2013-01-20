declare @p8 int
set @p8=10
declare @p9 xml
set @p9=convert(xml,N'')
declare @p10 xml
set @p10=NULL
exec BilnacniObracun @ObracunskoObdobjeID=82,@DatumVeljavnostiPodatkov='2013-10-31 00:00:00',@DatumStanjaBaze='2013-01-12 21:16:53.377',@Avtor=1,
@Naziv='November 12 ',@obracun=1,@BS=default,@ObracunID=@p8 output,@ValidationErrorsXML=@p9 output,@ValidationErrorsDetailXML=@p10 output
select @p8, @p9, @p10