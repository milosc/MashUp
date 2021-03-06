/*TEST TEST TEST*/

/****** Object:  StoredProcedure [dbo].[BO_novTP]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BO_novTP]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BO_novTP]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BO_novTP]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
--  Au: MT 
-- Create date: 2010.2.22
--  cisto nova procedura.
-- v koncni fazi se podatki sfilajo v Kolicine.
-- zaokrozevanje: z decimal (18,0), kar pomeni 1kWh./ na koncu!.
-- =============================================

CREATE procedure [dbo].[BO_novTP](
  @obracunId int,
  @VIRT_REGULACIJA int,
  @dtOd datetime,
  @dtDo datetime,
  @tPoint datetime,
  @dbgPrint int  
) as
begin

--declare @obracunId int
--set @obracunId=91

--declare @VIRT_REGULACIJA int
--SELECT  @VIRT_REGULACIJA = [PPMTipID] FROM [PPMTip]  WHERE   Naziv = ''(REG) VIRT_REGULACIJA''

/* 
-- tole lahko skipnemo, #bs se skreira v BO   
    declare @DatumVeljavnostiPodatkov datetime= ''2010-1-31 0:00:00''
	if object_id(''tempdb..#BS'') is not null drop table #BS
	CREATE TABLE #BS ( BilancnaSkupinaID int)
    IF (1=1)
	begin -- rocno filanje vseh trenutnih BS, ce je @bs null 	  
	    insert into #BS (BilancnaSkupinaID) 
		     select clanbsid from Pogodba P where PogodbaTipID=1 
		--and ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe) and P.Aktivno=1) or (P.Aktivno=1)) --@casPogleda
		and (''2012-1-1'' between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) --@casPogleda
		and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo) )  --@velja						
	end
*/

declare @anaTP table(
	OsebaID [int] NOT NULL,
	Interval [datetime] NOT NULL,
	TrzniPlan [decimal](18, 8),
	Regulacija [decimal](18, 8),
	Nivo [int] NOT NULL,
	NadrejenaOsebaID [int] NULL
	)

declare @agrTP  table (
	OsebaID [int] NOT NULL,
	Interval [datetime] NOT NULL,
	TrzniPlan [decimal](18, 8),
	Regulacija [decimal](18, 8),
	KorigiranTP [decimal](18, 8)
	)

truncate table BO_TrzniPlan  
insert into BO_TrzniPlan (osebaid,interval,kolicina,KorigiranTp,Jekorigiran,popravek)
       select             osebaid,interval,kolicina, 0,  0,          0
       from TrzniPlan  where Interval between @dtOd and @dtDo
       and @tPoint between DatumVnosa and dbo.infinite(DatumSpremembe)


INSERT INTO @anaTP (TrzniPlan,Regulacija,Interval,OsebaID,Nivo,NadrejenaOsebaID)
		SELECT  0,
		  sum(ISNULL(R.[SekRegM] + R.[SekRegP] + R.[TerRegM]+ R.[TerRegP], 0)),
				R.Interval,
				PPM.Dobavitelj1,
				P.Nivo,					
				NadrejenaOsebaID
			FROM Regulacija R				 
				INNER JOIN BO_PPM PPM ON R.[PPMID] = PPM.[PPMID]
				INNER JOIN BO_Pogodba P ON PPM.Dobavitelj1 = P.Partner2
				INNER JOIN [#BS] BS ON (BS.[BilancnaSkupinaID] = P.ClanBSID)				
			WHERE PPM.[PPMTipID] = @VIRT_REGULACIJA 
			  and R.Interval between @dtOd  and @dtDo
			  and @tPoint between R.DatumVnosa and dbo.infinite(R.DatumSpremembe)				 
			GROUP BY R.[Interval],P.Nivo,PPM.[Dobavitelj1],P.NadrejenaOsebaID
			OPTION (MAXDOP 1)


-- dodajanje zapisov navzgor
declare @nivo int
select @nivo= MAX(nivo) from @anaTP
while (@nivo) > 1 begin
	insert into @anaTP (osebaid,interval,TrzniPlan,Regulacija,nivo, nadrejenaosebaid)
	  select  a.NadrejenaOsebaId,a.interval,a.TrzniPlan, a.Regulacija, @nivo-1, p.partner1 from @anaTP a 
		  inner join BO_Pogodba p on a.nadrejenaosebaid=p.partner2    
		where a.nivo =@nivo  --and a.interval=''2010-1-1 1:00''  		
	  set @nivo=@nivo-1
end

INSERT INTO @anaTP (TrzniPlan,Regulacija,Interval,OsebaID,Nivo,NadrejenaOsebaID)
		SELECT  TP.Kolicina,
		        0, -- regulacija
				TP.Interval,
				TP.OsebaID,
				P.Nivo,					
				NadrejenaOsebaID
			FROM BO_TrzniPlan TP				 
				INNER JOIN BO_Pogodba P ON TP.OsebaID = P.Partner2
				INNER JOIN [#BS] BS ON (BS.[BilancnaSkupinaID] = P.ClanBSID)				 
			OPTION (MAXDOP 1)

--select ''anaTP'',*  from @anaTP where Interval=''2010-1-1 1:00'' order by osebaid

insert into @agrTP 	(OsebaID ,Interval,TrzniPlan,Regulacija)
       select osebaid,interval,SUM(TrzniPlan),SUM(regulacija) 
       from @anaTP 
       group by OsebaID,interval

update @agrTP set KorigiranTP=TrzniPlan-Regulacija

--select ''agrTP'',* from @agrTP where Interval=''2010-1-1 1:00'' order by osebaid


insert into Kolicine (ObracunID,OsebaID,Interval,TrzniPlan,Regulacija,KorigiranTP,Realizacija,Odstopanje,BS)        
      select @obracunId,
             coalesce(tp.osebaid, rs.osebaid),
             coalesce(tp.interval,rs.interval),
             cast(coalesce(tp.TrzniPlan, 0) as decimal (18,0)),
             cast(coalesce(tp.Regulacija,0) as decimal (18,0)),
             cast(coalesce(tp.KorigiranTP,0) as decimal (18,0)),
             cast(coalesce(rs.Kolicina,0) as decimal (18,0)),
             cast(ISNULL(rs.Kolicina,0)-ISNULL(tp.KorigiranTP,0) as decimal (18,0)),
             coalesce(rs.isBS, (select count(*) from BO_Pogodba where partner2=tp.osebaid and Nivo=1))            
      from @agrTP tp full outer join (select * from rpodsum where obracunid=@obracunID) rs on rs.interval=tp.Interval and rs.osebaid=tp.OsebaID 

--+++f01 popravek odstopanja za meje 
-- po novem je TP-realizacija, oz obratno, kot za vse ostale.
declare @osebeMeje table (id int)
insert into @osebeMeje 
select k.osebaid 
  from kolicine k
  inner join OsebaZCalc t on k.OsebaID=t.OsebaID
  where  k.bs=1 
  and k.Interval = @dtOd
  and k.ObracunID=@obracunID
  and @tPoint between t.datumvnosa  and dbo.infinite(t.DatumSpremembe)
  and t.OsebaZId=5 -- meje
  order by k.OsebaID asc

update Kolicine set Odstopanje=-Odstopanje where 
     ObracunID=@obracunID and 
     OsebaID in (select id from @osebeMeje)

--+++ konec popravka


if (@dbgPrint > 10) begin
	select ''Kolic:'',*  from Kolicine where interval = ''2010-1-1 1:00'' order by ObracunID,OsebaID asc	                  
	select * from BO_TrzniPlan where Interval=''2010-1-1 1:00'' order by osebaid
    select ''kolic-oseba=9'',* from kolicine where interval = ''2010-1-1 1:00'' and osebaid=9
end 

end
' 
END
GO
