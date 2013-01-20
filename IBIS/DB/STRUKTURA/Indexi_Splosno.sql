USE [IBIS2]
GO

/****** Object:  Index [IDX_Obracun_Content]    Script Date: 06/16/2012 07:41:06 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Obracun]') AND name = N'IDX_Obracun_Content')
DROP INDEX [IDX_Obracun_Content] ON [dbo].[Obracun] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Obracun_Content]    Script Date: 06/16/2012 07:41:06 ******/
CREATE NONCLUSTERED INDEX [IDX_Obracun_Content] ON [dbo].[Obracun] 
(
	[ObracunID] ASC
)
INCLUDE ( [ObracunskoObdobjeID],
[ObracunStatusID],
[DatumVnosa],
[DatumSpremembe],
[ObracunTipID],
[tPoint],
[velja],
[objavljen]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



USE [IBIS2]
GO

/****** Object:  Index [IDX_Pogodba_Content_2]    Script Date: 06/16/2012 07:38:30 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Pogodba]') AND name = N'IDX_Pogodba_Content_2')
DROP INDEX [IDX_Pogodba_Content_2] ON [dbo].[Pogodba] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Pogodba_Content_2]    Script Date: 06/16/2012 07:38:30 ******/
CREATE NONCLUSTERED INDEX [IDX_Pogodba_Content_2] ON [dbo].[Pogodba] 
(
	[Partner2] ASC
)
INCLUDE ( [PogodbaID],
[PogodbaTipID],
[Partner1],
[NadrejenaOsebaID],
[ClanBSID],
[VeljaOd],
[VeljaDo],
[DatumVnosa],
[DatumSpremembe],
[Aktivno]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



USE [IBIS2]
GO

/****** Object:  Index [IDX_Pogodba_Content]    Script Date: 06/16/2012 07:33:37 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Pogodba]') AND name = N'IDX_Pogodba_Content')
DROP INDEX [IDX_Pogodba_Content] ON [dbo].[Pogodba] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Pogodba_Content]    Script Date: 06/16/2012 07:33:37 ******/
CREATE NONCLUSTERED INDEX [IDX_Pogodba_Content] ON [dbo].[Pogodba] 
(
	[PogodbaID] ASC
)
INCLUDE ( [PogodbaTipID],
[Partner1],
[Partner2],
[NadrejenaOsebaID],
[ClanBSID],
[VeljaOd],
[VeljaDo],
[DatumVnosa],
[DatumSpremembe],
[Aktivno]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



USE [IBIS2]
GO

/****** Object:  Index [IDX_Oseba]    Script Date: 06/16/2012 07:30:11 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Oseba]') AND name = N'IDX_Oseba')
DROP INDEX [IDX_Oseba] ON [dbo].[Oseba] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Oseba]    Script Date: 06/16/2012 07:30:11 ******/
CREATE NONCLUSTERED INDEX [IDX_Oseba] ON [dbo].[Oseba] 
(
	[OsebaID] ASC
)
INCLUDE ( [VeljaOd],
[VeljaDo],
[OsebaSkupinaTipID],
[EIC],
[Naziv],
[Kratica],
[VrstniRedExcelUvoz],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO





USE [IBIS2]
GO

/****** Object:  Index [IDX_Izpadi_Content]    Script Date: 06/13/2012 06:38:09 ******/
CREATE NONCLUSTERED INDEX [IDX_Izpadi_Content] ON [dbo].[Izpadi] 
(
	[OsebaID] ASC,
	[Interval] ASC,
	[Upostevaj] ASC
)
INCLUDE ( [Izpad],
[value]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [IBIS2]
GO

/****** Object:  Index [IDX_Izravnava_Content]    Script Date: 06/13/2012 06:38:20 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Izravnava]') AND name = N'IDX_Izravnava_Content')
DROP INDEX [IDX_Izravnava_Content] ON [dbo].[Izravnava] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Izravnava_Content]    Script Date: 06/13/2012 06:38:20 ******/
CREATE NONCLUSTERED INDEX [IDX_Izravnava_Content] ON [dbo].[Izravnava] 
(
	[Interval] ASC,
	[OsebaID] ASC
)
INCLUDE ( [Wp],
[Wm],
[Sp],
[Sm],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_KBPS_Content]    Script Date: 06/13/2012 06:38:28 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[KolicinskaOdstopanjaPoBPS]') AND name = N'IDX_KBPS_Content')
DROP INDEX [IDX_KBPS_Content] ON [dbo].[KolicinskaOdstopanjaPoBPS] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_KBPS_Content]    Script Date: 06/13/2012 06:38:28 ******/
CREATE NONCLUSTERED INDEX [IDX_KBPS_Content] ON [dbo].[KolicinskaOdstopanjaPoBPS] 
(
	[ObracunID] ASC,
	[OsebaID] ASC
)
INCLUDE ( [Interval],
[Kolicina],
[Odstopanje],
[VozniRed],
[KoregiranTP]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



USE [IBIS2]
GO

/****** Object:  Index [IDX_KBS_Content]    Script Date: 06/13/2012 06:38:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[KolicinskaOdstopanjaPoBS]') AND name = N'IDX_KBS_Content')
DROP INDEX [IDX_KBS_Content] ON [dbo].[KolicinskaOdstopanjaPoBS] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_KBS_Content]    Script Date: 06/13/2012 06:38:36 ******/
CREATE NONCLUSTERED INDEX [IDX_KBS_Content] ON [dbo].[KolicinskaOdstopanjaPoBS] 
(
	[ObracunID] ASC,
	[OsebaID] ASC
)
INCLUDE ( [Interval],
[Kolicina],
[Odstopanje],
[VozniRed],
[KoregiranTP]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Meritve_JAN_12]') AND name = N'IDX_Meritve_Jan_12_Content')
DROP INDEX [IDX_Meritve_Jan_12_Content] ON [dbo].[Meritve_JAN_12] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Meritve_Jan_12_Content]    Script Date: 06/13/2012 06:38:47 ******/
CREATE NONCLUSTERED INDEX [IDX_Meritve_Jan_12_Content] ON [dbo].[Meritve_JAN_12] 
(
	[Interval] ASC,
	[PPMID] ASC
)
INCLUDE ( [Kolicina],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Oseba]    Script Date: 06/13/2012 06:39:03 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Oseba]') AND name = N'IDX_Oseba')
DROP INDEX [IDX_Oseba] ON [dbo].[Oseba] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_Oseba]    Script Date: 06/13/2012 06:39:03 ******/
CREATE NONCLUSTERED INDEX [IDX_Oseba] ON [dbo].[Oseba] 
(
	[OsebaID] ASC,
	[DatumVnosa] ASC,
	[DatumSpremembe] ASC
)
INCLUDE ( [VeljaOd],
[VeljaDo]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_OsebaTip_Content]    Script Date: 06/13/2012 06:39:12 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OsebaTip]') AND name = N'IDX_OsebaTip_Content')
DROP INDEX [IDX_OsebaTip_Content] ON [dbo].[OsebaTip] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_OsebaTip_Content]    Script Date: 06/13/2012 06:39:12 ******/
CREATE NONCLUSTERED INDEX [IDX_OsebaTip_Content] ON [dbo].[OsebaTip] 
(
	[OsebaID] ASC,
	[OsebaTipID] ASC
)
INCLUDE ( [DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [IBIS2]
GO

/****** Object:  Index [IDX_OsebaZCalc_Content]    Script Date: 06/13/2012 06:39:18 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OsebaZCalc]') AND name = N'IDX_OsebaZCalc_Content')
DROP INDEX [IDX_OsebaZCalc_Content] ON [dbo].[OsebaZCalc] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_OsebaZCalc_Content]    Script Date: 06/13/2012 06:39:18 ******/
CREATE NONCLUSTERED INDEX [IDX_OsebaZCalc_Content] ON [dbo].[OsebaZCalc] 
(
	[OsebaID] ASC
)
INCLUDE ( [OsebaZID],
[DatumVnosa],
[DatumSpremembe]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



USE [IBIS2]
GO

/****** Object:  Index [IDX_OsebaZId_Content]    Script Date: 06/13/2012 06:39:23 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OsebaZId]') AND name = N'IDX_OsebaZId_Content')
DROP INDEX [IDX_OsebaZId_Content] ON [dbo].[OsebaZId] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_OsebaZId_Content]    Script Date: 06/13/2012 06:39:23 ******/
CREATE NONCLUSTERED INDEX [IDX_OsebaZId_Content] ON [dbo].[OsebaZId] 
(
	[OsebaZId] ASC
)
INCLUDE ( [Naziv],
[Sifra]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



USE [IBIS2]
GO

/****** Object:  Index [IDX_PodatkiObracuna_Content]    Script Date: 06/13/2012 06:39:31 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PodatkiObracuna]') AND name = N'IDX_PodatkiObracuna_Content')
DROP INDEX [IDX_PodatkiObracuna_Content] ON [dbo].[PodatkiObracuna] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_PodatkiObracuna_Content]    Script Date: 06/13/2012 06:39:31 ******/
CREATE NONCLUSTERED INDEX [IDX_PodatkiObracuna_Content] ON [dbo].[PodatkiObracuna] 
(
	[ObracunID] ASC
)
INCLUDE ( [OsebaID],
[TolerancniPas],
[Odstopanje],
[Cplus],
[Cminus],
[Ckplus],
[Ckminus]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [IBIS2]
GO

/****** Object:  Index [IDX_PodatkiObracunaSkupni_Content]    Script Date: 06/13/2012 06:39:37 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PodatkiObracuna_Skupni]') AND name = N'IDX_PodatkiObracunaSkupni_Content')
DROP INDEX [IDX_PodatkiObracunaSkupni_Content] ON [dbo].[PodatkiObracuna_Skupni] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_PodatkiObracunaSkupni_Content]    Script Date: 06/13/2012 06:39:37 ******/
CREATE NONCLUSTERED INDEX [IDX_PodatkiObracunaSkupni_Content] ON [dbo].[PodatkiObracuna_Skupni] 
(
	[ObracunID] ASC
)
INCLUDE ( [Interval],
[SroskiIzravnave],
[SaldoStroskiObracunov],
[SkupnaOdstopanja],
[C+],
[C-]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [IBIS2]
GO

/****** Object:  Index [IXD_PPM]    Script Date: 06/13/2012 06:39:44 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PPM]') AND name = N'IXD_PPM')
DROP INDEX [IXD_PPM] ON [dbo].[PPM] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IXD_PPM]    Script Date: 06/13/2012 06:39:45 ******/
CREATE NONCLUSTERED INDEX [IXD_PPM] ON [dbo].[PPM] 
(
	[PPMID] ASC,
	[SistemskiOperater1] ASC,
	[Dobavitelj1] ASC,
	[PPMTipID] ASC,
	[DatumVnosa] ASC,
	[DatumSpremembe] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_PPMTip_Content]    Script Date: 06/13/2012 06:40:24 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PPMTip]') AND name = N'IDX_PPMTip_Content')
DROP INDEX [IDX_PPMTip_Content] ON [dbo].[PPMTip] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_PPMTip_Content]    Script Date: 06/13/2012 06:40:24 ******/
CREATE NONCLUSTERED INDEX [IDX_PPMTip_Content] ON [dbo].[PPMTip] 
(
	[PPMTipID] ASC
)
INCLUDE ( [Naziv],
[Virtualen]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [IBIS2]
GO

/****** Object:  Index [IDX_RelPoDob]    Script Date: 06/13/2012 06:40:30 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RealizacijaPoDobaviteljih]') AND name = N'IDX_RelPoDob')
DROP INDEX [IDX_RelPoDob] ON [dbo].[RealizacijaPoDobaviteljih] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_RelPoDob]    Script Date: 06/13/2012 06:40:30 ******/
CREATE NONCLUSTERED INDEX [IDX_RelPoDob] ON [dbo].[RealizacijaPoDobaviteljih] 
(
	[ObracunID] ASC,
	[OsebaID] ASC,
	[Nivo] ASC,
	[NadrejenaOsebaID] ASC
)
INCLUDE ( [Kolicina],
[Oddaja],
[Odjem],
[Interval]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_TP_Content]    Script Date: 06/13/2012 06:40:37 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TrzniPlan]') AND name = N'IDX_TP_Content')
DROP INDEX [IDX_TP_Content] ON [dbo].[TrzniPlan] WITH ( ONLINE = OFF )
GO

USE [IBIS2]
GO

/****** Object:  Index [IDX_TP_Content]    Script Date: 06/13/2012 06:40:37 ******/
CREATE NONCLUSTERED INDEX [IDX_TP_Content] ON [dbo].[TrzniPlan] 
(
	[OsebaID] ASC,
	[Interval] ASC
)
INCLUDE ( [Kolicina],
[KoregiranTP],
[JeKorigiran]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO













