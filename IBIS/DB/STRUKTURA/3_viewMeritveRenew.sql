
insert into view_Meritve 
(
	[ID] ,
	[PPMID],
	[Interval],
	[Kolicina],
	[DatumVnosa],
	[DatumSpremembe]
) 
select
	[ID] ,
	[PPMID],
	[Interval],
	[Kolicina],
	[DatumVnosa],
	[DatumSpremembe]
	from oldMeritve
	
	
