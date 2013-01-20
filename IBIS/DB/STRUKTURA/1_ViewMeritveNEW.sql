/*1*/
CREATE TABLE [dbo].[oldMeritve](
	[ID] [int] NOT NULL,
	[PPMID] [int] NOT NULL,
	[Interval] [datetime] NOT NULL,
	[Kolicina] [decimal](19, 6) NOT NULL,
	[DatumVnosa] [datetime] NOT NULL,
	[DatumSpremembe] [datetime] NULL
) ON [PRIMARY]


insert into oldMeritve
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
	from view_Meritve
	
	
