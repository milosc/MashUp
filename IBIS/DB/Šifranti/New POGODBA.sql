 

--CREATE TABLE [dbo].[PogodbaNew](
--	[ID] [int] NOT NULL,
--	[PogodbaID] [int] NOT NULL,
--	[PogodbaTipID] [int] NOT NULL,
--	[Partner1] [int] NOT NULL,
--	[Partner2] [int] NOT NULL,
--	[NadrejenaOsebaID] [int] NULL,
--	[ClanBSID] [int] NULL,
--	[VeljaOd] [datetime] NOT NULL,
--	[VeljaDo] [datetime] NULL,
--	[Nivo] [int] NOT NULL,
--	[IzvrsilniDan] [datetime] NULL,
--	[Opis] [varchar](500) NULL,
--	[Opombe] [varchar](500) NULL,
--	[Avtor] [int] NOT NULL,
--	[DatumVnosa] [datetime] NULL,
--	[DatumSpremembe] [datetime] NULL,
--	[Aktivno] [int] NULL
--) ON [PRIMARY]

--GO

--CREATE TABLE [dbo].[PogodbaOLD](
--	[ID] [int] NOT NULL,
--	[PogodbaID] [int] NOT NULL,
--	[PogodbaTipID] [int] NOT NULL,
--	[Partner1] [int] NOT NULL,
--	[Partner2] [int] NOT NULL,
--	[NadrejenaOsebaID] [int] NULL,
--	[ClanBSID] [int] NULL,
--	[VeljaOd] [datetime] NOT NULL,
--	[VeljaDo] [datetime] NULL,
--	[Nivo] [int] NOT NULL,
--	[IzvrsilniDan] [datetime] NULL,
--	[Opis] [varchar](500) NULL,
--	[Opombe] [varchar](500) NULL,
--	[Avtor] [int] NOT NULL,
--	[DatumVnosa] [datetime] NULL,
--	[DatumSpremembe] [datetime] NULL,
--	[Aktivno] [int] NULL
--) ON [PRIMARY]

--GO

INSERT INTO [dbo].[PogodbaOLD]
 (
	ID,
	[PogodbaID],
	[PogodbaTipID],
	[Partner1],
	[Partner2],
	[NadrejenaOsebaID],
	[ClanBSID],
	[VeljaOd],
	[VeljaDo],
	[Nivo],
	[IzvrsilniDan],
	[Opis],
	[Opombe],
	[Avtor],
	[DatumVnosa],
	[DatumSpremembe],
	[Aktivno]
)
SELECT
ID,
	[PogodbaID],
	[PogodbaTipID],
	[Partner1],
	[Partner2],
	[NadrejenaOsebaID],
	[ClanBSID],
	[VeljaOd],
	[VeljaDo],
	[Nivo],
	[IzvrsilniDan],
	[Opis],
	[Opombe],
	[Avtor],
	[DatumVnosa],
	[DatumSpremembe],
	[Aktivno]
	FROM [dbo].[Pogodba]

insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(11,1,999,1,3,3,3,'Jan  1 2006 12:00AM','Dec 31 2010 12:00AM',1,'Jan  1 2006 12:00AM',NULL,NULL,1,'Jan  1 2008 12:00AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(16,6,2,3,6,3,3,'Jan  1 2006 12:00AM','Jan  1 2010 12:00AM',2,'Jan  1 2006 12:00AM',NULL,NULL,1,'Jan  1 2008 12:00AM','Oct 23 2009  9:55AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(17,7,2,3,7,3,3,'Jan  1 2006 12:00AM',NULL,2,'Jan  1 2006 12:00AM',NULL,NULL,1,'Jan  1 2008 12:00AM','May 18 2011  2:12PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8377,4,1,1,9,9,9,'Jan 21 2007 12:00AM','Jan  1 2010 12:00AM',1,NULL,NULL,NULL,1,'Mar 16 2008  2:52PM','Jun 30 2009 10:20AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8387,11,2,3,11,3,3,'Jan  1 2008 12:00AM',NULL,2,NULL,NULL,NULL,1,'Mar 25 2008  3:46PM','Sep 27 2009  1:40PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8400,24,6,2,10,9,9,'Jan  1 2005 12:00AM',NULL,2,NULL,NULL,NULL,1,'Mar 26 2008 10:31AM','Nov 29 2009  1:58PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8583,1,102,1,12,12,12,'Jan  1 2006 12:00AM','Dec 31 2011 12:00AM',2,NULL,'d','d',1,'May 29 2008 11:03AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8603,5,2,3,5,3,3,'Jan  1 2006 12:00AM','Jan  1 2010 12:00AM',2,NULL,NULL,NULL,1,'Jun 17 2008  3:34PM','May 11 2010  2:00PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8604,204,2,3,8,3,3,'Jun  1 2008 12:00AM',NULL,2,NULL,'test','test',1,'Jun 20 2008  1:54PM','Oct  7 2009  3:07PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8611,207,4,1,1,1,1,'Jan  1 2000 12:00AM',NULL,0,NULL,NULL,NULL,1,'Jan  1 2000 12:00AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8623,200,2,9,10,9,9,'Jan  1 2004 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jul  2 2008 12:18PM','Nov 29 2009  1:59PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8628,3,1,1,4,4,4,'Feb  1 2006 12:00AM','Jan  1 2010 12:00AM',1,NULL,NULL,NULL,1,'Jul  3 2008 11:29AM','Sep 29 2009 10:17AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8629,3,1,1,4,4,4,'Jan  2 2010 12:00AM','Dec  1 2010 12:00AM',1,NULL,NULL,NULL,1,'Jul  3 2008 11:29AM','Sep 29 2009  9:42AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8633,25,2,9,24,9,9,'Jan  1 2004 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jul 17 2008  9:19AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8642,226,2,9,25,9,9,'Jan  1 2007 12:00AM',NULL,2,NULL,NULL,NULL,1,'Nov 17 2008 11:33AM','May 18 2011  2:20PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8643,227,1,1,26,1,26,'Jan  1 2009 12:00AM',NULL,1,NULL,NULL,NULL,1,'Nov 20 2008 12:01PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8644,4,1,1,9,9,9,'Jan 21 2007 12:00AM','Jan  1 2010 12:00AM',1,NULL,NULL,'Tralala Test',1,'Jun 30 2009 10:20AM','Jan 10 2010 11:07AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8645,228,1,1,27,27,27,'Jan  1 2008 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jul  2 2009  9:08AM','Aug 17 2009 10:46AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8646,3,1,1,4,4,4,'Dec  2 2010 12:00AM','Dec 31 2011 12:00AM',1,NULL,NULL,NULL,1,'Jul 22 2009  8:38AM','Jul 22 2009  8:43AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8647,3,1,1,4,4,4,'Dec  2 2010 12:00AM','Dec 31 2011 12:00AM',1,NULL,'trala','hopsasa',1,'Jul 22 2009  8:43AM','Jul 22 2009  8:45AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8648,3,1,1,4,4,4,'Jan  1 2012 12:00AM','Dec 31 2012 12:00AM',1,NULL,'trala','hopsasa',1,'Jul 22 2009  8:45AM','Jul 22 2009  8:47AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8649,229,1,1,28,28,28,'Jan  1 2009 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jul 22 2009 12:12PM','Jul 22 2009 12:13PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8650,230,1,1,28,28,28,'Jan  1 2008 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jul 22 2009 12:37PM','Jul 22 2009 12:37PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8651,231,1,1,29,29,29,'Jan  1 2008 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jul 22 2009 12:38PM','Jul 22 2009 12:41PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8652,232,1,1,29,29,29,'Jan  1 2008 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jul 22 2009 12:41PM','Aug 17 2009 10:46AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8653,233,1,1,30,30,30,'Jan  1 2009 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jul 22 2009  1:18PM','Jul 22 2009  1:19PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8654,234,1,1,27,27,27,'Sep 24 2007 12:00AM',NULL,1,NULL,NULL,NULL,1,'Aug 17 2009 12:29PM','May 11 2010  1:36PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8655,235,1,1,29,29,29,'Jan  5 2007 12:00AM',NULL,1,NULL,NULL,NULL,1,'Aug 17 2009 12:30PM','Sep 27 2009  1:19PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8656,236,2,9,32,9,9,'Jan  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'Sep 27 2009  1:24PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8657,11,2,3,11,3,3,'Jan  1 2008 12:00AM','Dec 31 2008 12:00AM',2,NULL,NULL,NULL,1,'Sep 27 2009  1:40PM','Sep 29 2009  9:41AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8658,237,2,26,11,26,26,'Jan  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'Sep 27 2009  1:41PM','Apr 12 2010  9:08AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8659,238,1,1,33,33,33,'Jan  1 2009 12:00AM',NULL,1,NULL,NULL,NULL,1,'Sep 27 2009  2:00PM','Sep 28 2009  8:49AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8660,239,2,3,34,3,3,'Jan  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'Sep 27 2009  2:26PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8661,240,2,9,35,9,9,'Jan  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'Sep 27 2009  2:35PM','May 11 2010  1:48PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8662,241,2,3,36,3,3,'Jan  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'Sep 27 2009  2:38PM','May 11 2010  1:48PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8663,11,2,3,11,3,3,'Jan  1 2008 12:00AM','Jan  1 2009 12:00AM',2,NULL,NULL,NULL,1,'Sep 29 2009  9:41AM','Sep 29 2009 10:16AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8664,11,2,3,11,3,3,'Jan  1 2008 12:00AM','Dec 31 2008 12:00AM',2,NULL,NULL,NULL,1,'Sep 29 2009 10:16AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8665,3,1,1,4,4,4,'Feb  1 2006 12:00AM',NULL,1,NULL,NULL,NULL,1,'Sep 29 2009 10:17AM','Dec  1 2009  1:23PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8666,204,2,3,8,3,3,'Jan  1 2007 12:00AM',NULL,2,NULL,'test','test',1,'Oct  7 2009  3:07PM','Nov 20 2009  1:09PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8667,242,1,1,33,33,33,'Jan  1 2009 12:00AM',NULL,1,NULL,NULL,NULL,1,'Oct 10 2009  9:36AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8668,6,2,3,6,3,3,'Jan  1 2006 12:00AM',NULL,2,NULL,NULL,NULL,1,'Oct 23 2009  9:55AM','Aug  9 2011  3:17PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8669,204,2,3,8,3,3,'Jan  1 2007 12:00AM','Dec 31 2007 12:00AM',2,NULL,NULL,'test',1,'Nov 20 2009  1:09PM','Nov 20 2009  2:19PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8670,243,2,4,8,4,4,'Jan  1 2008 12:00AM',NULL,2,NULL,NULL,NULL,1,'Nov 20 2009  1:09PM','Nov 20 2009  1:11PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8671,243,2,4,8,4,4,'Jan  1 2008 12:00AM','Dec 31 2008 12:00AM',2,NULL,NULL,NULL,1,'Nov 20 2009  1:11PM','Nov 20 2009  2:18PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8672,244,2,3,8,3,3,'Jan  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'Nov 20 2009  1:43PM','Nov 20 2009  2:19PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8673,204,2,3,8,3,3,'Jan  1 2007 12:00AM',NULL,2,NULL,NULL,NULL,1,'Nov 20 2009  2:19PM','Jul 26 2012  8:41AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8674,245,4,3,5,3,3,'Jan  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'Nov 23 2009  9:28AM','Nov 23 2009  9:31AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8675,246,2,4,29,4,4,'Jan  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'Nov 23 2009  9:34AM','Nov 23 2009  9:34AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8676,247,1,1,29,29,29,'Jan  1 2009 12:00AM',NULL,1,NULL,NULL,NULL,1,'Nov 23 2009  9:37AM','Nov 23 2009  9:45AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8677,248,3,1,2,1,1,'Jan  1 2009 12:00AM',NULL,1,NULL,NULL,NULL,1,'Nov 23 2009  9:42AM','Nov 23 2009  9:43AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8678,249,3,3,5,3,3,'Jan  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'Nov 23 2009  9:44AM','Nov 23 2009  9:45AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8679,250,5,32,29,32,9,'Jan  1 2009 12:00AM',NULL,3,NULL,NULL,NULL,1,'Nov 23 2009  9:47AM','Nov 23 2009  9:48AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8680,5,2,3,5,3,3,'Jan  2 2010 12:00AM','Mar  1 2010 12:00AM',2,NULL,NULL,NULL,1,'Nov 24 2009 10:13AM','Nov 24 2009 10:13AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8681,5,2,3,5,3,3,'Jan  2 2010 12:00AM','Mar  1 2010 12:00AM',2,NULL,'dgdfg','dfgsfg',1,'Nov 24 2009 10:13AM','Nov 24 2009 10:14AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8682,200,2,9,10,9,9,'Jan  1 2004 12:00AM','Apr 30 2009 12:00AM',2,NULL,NULL,NULL,1,'Nov 29 2009  1:59PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8683,200,2,9,10,9,9,'May  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'Nov 29 2009  1:59PM','Nov 29 2009  2:00PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8684,251,1,1,10,10,10,'May  1 2009 12:00AM',NULL,1,NULL,NULL,NULL,1,'Nov 29 2009  2:00PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8685,252,2,3,5,3,3,'Jan  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'Nov 30 2009  8:30AM','Jul 25 2012  3:23PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8686,3,1,1,4,4,4,'Feb  1 2006 12:00AM',NULL,1,NULL,NULL,'test',1,'Dec  1 2009  1:23PM','Apr  1 2012  9:25AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8687,253,1,1,29,29,29,'Jan  1 2010 12:00AM','Dec 31 2010 12:00AM',1,NULL,NULL,NULL,1,'Jan  9 2010 12:17PM','Jan  9 2010 12:17PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8688,253,1,1,29,29,29,'Jan  1 2011 12:00AM','Dec 31 2011 12:00AM',1,NULL,NULL,NULL,1,'Jan  9 2010 12:17PM','Jan  9 2010 12:17PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8689,254,1,1,29,29,29,'Jan  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jan  9 2010 12:18PM','Jan  9 2010 12:18PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8690,254,1,1,29,29,29,'Jan  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jan  9 2010 12:18PM','Jan  9 2010 12:20PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8691,254,1,1,29,29,29,'Jan  1 2010 12:00AM','Dec 31 2010 12:00AM',1,NULL,NULL,NULL,1,'Jan  9 2010 12:20PM','Jan 10 2010 11:06AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8692,254,1,1,29,29,29,'Jan  1 2011 12:00AM','Dec 31 2011 12:00AM',1,NULL,NULL,NULL,1,'Jan  9 2010 12:21PM','Jan  9 2010 12:21PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8693,254,1,1,29,29,29,'Jan  1 2011 12:00AM','Dec 31 2011 12:00AM',1,NULL,'test','testdscsc  sdfsdfasdf  sdfsdfasdf  sdfsfasdf',1,'Jan  9 2010 12:21PM','Jan 10 2010 11:06AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8694,254,1,1,29,29,29,'Jan  1 2012 12:00AM','Dec 31 2012 12:00AM',1,NULL,'test 3','tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj',1,'Jan  9 2010 12:22PM','Jan  9 2010 12:22PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8695,254,1,1,29,29,29,'Jan  1 2012 12:00AM','Dec 31 2012 12:00AM',1,NULL,'test 3666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888','tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj',1,'Jan  9 2010 12:22PM','Jan  9 2010 12:23PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8696,254,1,1,29,29,29,'Jan  1 2012 12:00AM','Dec 31 2012 12:00AM',1,NULL,NULL,NULL,1,'Jan  9 2010 12:23PM','Jan 10 2010 11:06AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8697,4,1,1,9,9,9,'Jan 21 2007 12:00AM',NULL,1,NULL,NULL,'Tralala Test',1,'Jan 10 2010 11:07AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8699,256,4,3,3,3,3,'Jan  1 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jan 11 2010 10:07AM','Jan 11 2010 10:07AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8700,237,2,26,11,26,26,'Jan  1 2009 12:00AM','Jul 31 2009 12:00AM',2,NULL,NULL,NULL,1,'Apr 12 2010  9:08AM','Oct 13 2010  9:54AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8701,257,1,1,39,39,39,'Aug  1 2008 12:00AM',NULL,1,NULL,NULL,NULL,1,'May  5 2010 11:22AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8702,258,2,39,11,39,39,'Aug  1 2009 12:00AM',NULL,2,NULL,NULL,NULL,1,'May  6 2010 10:08AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8703,259,2,3,40,3,3,'Jan  1 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'May 11 2010  1:47PM','May 18 2011  2:16PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8704,241,2,3,36,3,3,'Jan  1 2009 12:00AM','Dec 31 2009 12:00AM',2,NULL,NULL,NULL,1,'May 11 2010  1:48PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8705,240,2,9,35,9,9,'Jan  1 2009 12:00AM','Dec 31 2009 12:00AM',2,NULL,NULL,NULL,1,'May 11 2010  1:48PM','May 17 2010  9:14AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8706,260,2,3,42,3,3,'Jan  1 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'May 11 2010  1:49PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8707,261,2,3,43,3,3,'Jan  1 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'May 11 2010  1:50PM','May 18 2011  2:16PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8708,262,2,9,41,9,9,'Jan  1 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'May 11 2010  1:50PM','May 18 2011  2:16PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8709,263,2,9,44,9,9,'Jan  1 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'May 11 2010  1:51PM','May 18 2011  2:17PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8710,264,1,1,45,45,45,'Jan  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'May 11 2010  1:56PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8711,265,1,1,46,46,46,'Jan  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'May 11 2010  1:56PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8712,266,1,1,47,47,47,'Jan  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'May 11 2010  1:57PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8713,5,2,3,5,3,3,'Jan  1 2006 12:00AM',NULL,2,NULL,NULL,NULL,1,'May 11 2010  2:00PM','Apr  1 2012 11:53AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8714,267,1,1,3,3,3,'Jan  1 2006 12:00AM',NULL,1,NULL,NULL,NULL,1,'May 15 2010 12:38PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8715,240,2,9,35,9,9,'Jan  1 2009 12:00AM','Dec 31 2010 12:00AM',2,NULL,NULL,NULL,1,'May 17 2010  9:14AM','May 17 2010  9:16AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8716,240,2,9,35,9,9,'Jan  1 2009 12:00AM','Dec 31 2009 12:00AM',2,NULL,NULL,NULL,1,'May 17 2010  9:16AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8717,268,2,9,48,9,9,'Jan  1 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jun 10 2010 10:13AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8718,269,2,34,49,34,3,'Jan  1 2010 12:00AM',NULL,3,NULL,NULL,NULL,1,'Jun 24 2010 12:09PM','May 18 2011  2:09PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8719,270,1,1,27,27,27,'Jan  1 2010 12:00AM',NULL,1,NULL,'Pogodba z Rudnap',NULL,1,'Aug 20 2010  1:26PM','Aug 24 2010 10:36AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8720,270,1,1,27,27,27,'Jan  1 2008 12:00AM','Dec 31 2009 12:00AM',1,NULL,'Pogodba z Rudnap',NULL,1,'Aug 24 2010 10:36AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8721,271,1,1,50,50,50,'Jan  1 2010 12:00AM',NULL,1,NULL,'Test za Rudnap 2 ',NULL,1,'Aug 24 2010 10:38AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8722,272,1,1,51,51,51,'Jul  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Sep 26 2010  1:07PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8723,273,1,1,52,52,52,'May  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Oct  5 2010  8:54AM','Oct  7 2010  9:53AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8724,274,2,52,29,52,52,'Sep 27 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'Oct  7 2010  9:07AM','Oct  7 2010  9:08AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8725,275,3,5,2,5,3,'Sep 27 2010 12:00AM',NULL,3,NULL,NULL,NULL,1,'Oct  7 2010  9:30AM','Oct  7 2010  9:31AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8726,273,1,1,52,52,52,'May  1 2010 12:00AM',NULL,1,NULL,'kr neki','kr neki',1,'Oct  7 2010  9:53AM','Oct  7 2010 10:09AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8727,273,1,1,52,52,52,'May  1 2010 12:00AM',NULL,1,NULL,'kr neki','kr neki',1,'Oct  7 2010 10:09AM','Oct  7 2010 10:10AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8728,273,1,1,52,52,52,'May  1 2010 12:00AM',NULL,1,NULL,'kr neki 1','kr neki',1,'Oct  7 2010 10:10AM','Oct 13 2010  9:53AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8729,273,1,1,52,52,52,'May  1 2010 12:00AM','Oct  6 2010 12:00AM',1,NULL,'kr neki 1','kr neki',1,'Oct 13 2010  9:53AM','Oct 13 2010  9:54AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8730,273,1,1,52,52,52,'May  1 2010 12:00AM','Oct  6 2010 12:00AM',1,NULL,'kr neki 1','kr neki',1,'Oct 13 2010  9:54AM','Oct 13 2010  9:55AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8731,276,1,1,52,52,52,'Sep 27 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Oct 13 2010  9:57AM','Oct 13 2010 10:02AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8732,276,1,1,52,52,52,'Sep 27 2010 12:00AM','Nov 11 2010 12:00AM',1,NULL,NULL,NULL,1,'Oct 13 2010 10:02AM','Oct 13 2010 10:03AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8733,277,1,1,52,52,52,'Jun 30 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Oct 13 2010 10:05AM','Oct 13 2010  1:36PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8734,278,2,52,2,52,52,'Sep 28 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'Oct 13 2010  1:33PM','Oct 13 2010  1:36PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8735,279,2,3,29,3,3,'Sep 28 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'Oct 13 2010  1:39PM','Oct 13 2010  1:45PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8736,280,5,29,2,29,3,'Sep 27 2010 12:00AM',NULL,3,NULL,NULL,NULL,1,'Oct 13 2010  1:45PM','Oct 13 2010  1:45PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8737,281,1,1,52,52,52,'Oct  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Oct 15 2010  8:04AM','Oct 15 2010  8:04AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8738,281,1,1,52,52,52,'Oct  2 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Oct 15 2010  8:04AM','Oct 15 2010  8:05AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8739,281,1,1,52,52,52,'Oct  2 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Oct 15 2010  8:05AM','Oct 15 2010  8:06AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8740,281,1,1,52,52,52,'Oct  2 2010 12:00AM','Oct  3 2010 12:00AM',1,NULL,NULL,NULL,1,'Oct 15 2010  8:06AM','Oct 15 2010  8:07AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8741,281,1,1,52,52,52,'Oct  4 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Oct 15 2010  8:07AM','Oct 15 2010  8:09AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8742,281,1,1,52,52,52,'Oct  2 2010 12:00AM','Oct  3 2010 12:00AM',1,NULL,NULL,NULL,1,'Oct 15 2010  8:08AM','Oct 15 2010  8:09AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8743,281,1,1,52,52,52,'Oct  2 2010 12:00AM','Oct  3 2010 12:00AM',1,NULL,NULL,NULL,1,'Oct 15 2010  8:09AM','Oct 15 2010  8:09AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8744,281,1,1,52,52,52,'Oct  4 2010 12:00AM','Oct  9 2010 12:00AM',1,NULL,NULL,NULL,1,'Oct 15 2010  8:09AM','Oct 19 2010  8:04AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8745,282,5,52,2,52,52,'Sep 27 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'Oct 17 2010 12:26PM','Oct 17 2010 12:26PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8746,283,1,1,53,53,53,'Jan  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Oct 19 2010  8:25AM','Oct 19 2010  8:27AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8747,284,1,1,52,52,52,'Oct  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Oct 19 2010 10:39AM','Oct 19 2010 10:39AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8748,284,1,1,52,52,52,'Oct  1 2010 12:00AM','Oct  2 2010 12:00AM',1,NULL,NULL,NULL,1,'Oct 19 2010 10:39AM','Oct 19 2010 10:39AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8749,284,1,1,52,52,52,'Oct  3 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Oct 19 2010 10:39AM','Oct 19 2010 10:43AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8750,285,1,1,52,52,52,'Nov  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Nov 17 2010  8:48AM','Nov 17 2010  8:51AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8751,285,1,1,52,52,52,'Nov  1 2010 12:00AM','Oct 25 2010 12:00AM',1,NULL,NULL,NULL,1,'Nov 17 2010  8:51AM','Nov 17 2010  8:55AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8752,286,1,1,52,52,52,'Nov  1 2010 12:00AM','Oct 25 2010 12:00AM',1,NULL,NULL,NULL,1,'Nov 17 2010  8:57AM','Nov 17 2010  8:58AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8753,286,1,1,52,52,52,'Nov  2 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Nov 17 2010  8:58AM','Nov 17 2010  8:58AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8754,286,1,1,52,52,52,'Nov  2 2010 12:00AM','Oct 27 2010 12:00AM',1,NULL,NULL,NULL,1,'Nov 17 2010  8:58AM','Nov 17 2010  8:59AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8755,287,1,1,52,52,52,'Nov  2 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Nov 17 2010  9:11AM','Nov 17 2010  9:11AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8756,287,1,1,52,52,52,'Nov  2 2010 12:00AM','Nov 18 2010 12:00AM',1,NULL,NULL,NULL,1,'Nov 17 2010  9:11AM','Apr 13 2011  9:19AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8757,287,1,1,52,52,52,'Nov 19 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Nov 17 2010  9:12AM','Nov 17 2010  9:12AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8758,288,1,1,52,52,52,'Dec  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Dec  2 2010  8:59AM','Dec  2 2010  9:00AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8759,289,2,52,53,52,52,'Dec  1 2010 12:00AM',NULL,2,NULL,NULL,NULL,1,'Dec  2 2010  8:59AM','Dec  2 2010  9:01AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8760,288,1,1,52,52,52,'Dec  1 2010 12:00AM','Dec 31 2010 12:00AM',1,NULL,NULL,NULL,1,'Dec  2 2010  9:00AM','Dec  2 2010  9:05AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8761,289,2,52,53,52,52,'Dec  1 2010 12:00AM','Dec 31 2010 12:00AM',2,NULL,NULL,NULL,1,'Dec  2 2010  9:01AM','Dec  2 2010  9:05AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8762,290,1,1,53,53,53,'Jan  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Dec  2 2010  9:02AM','Dec  2 2010  9:05AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8763,291,2,53,52,53,53,'Jan  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'Dec  2 2010  9:02AM','Dec  2 2010  9:02AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8764,292,2,6,54,6,3,'Jan  1 2010 12:00AM',NULL,3,NULL,NULL,NULL,1,'Dec 13 2010  1:19PM','Apr 17 2012 11:58AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8765,293,1,1,53,53,53,'Jan  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jan  3 2011  9:37AM','Jan  3 2011  9:42AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8766,294,1,1,53,53,53,'Jan  1 2011 12:00AM','Dec 31 2009 12:00AM',1,NULL,NULL,NULL,1,'Jan  3 2011 12:28PM','Jan  3 2011  1:12PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8767,294,1,1,53,53,53,'Jan  1 2010 12:00AM','Dec 31 2009 12:00AM',1,NULL,NULL,NULL,1,'Jan  3 2011  1:12PM','Jan  3 2011  1:14PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8768,294,1,1,53,53,53,'Jan  1 2009 12:00AM','Dec 31 2008 12:00AM',1,NULL,NULL,NULL,1,'Jan  3 2011  1:12PM','Jan  3 2011  1:14PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8769,295,1,1,53,53,53,'Jan  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jan  3 2011  1:19PM','May 10 2011  1:34PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8770,296,1,1,57,57,57,'Dec  1 2010 12:00AM',NULL,1,NULL,NULL,NULL,1,'Apr  6 2011  9:58AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8771,297,1,1,52,52,52,'Apr  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Apr 13 2011  9:20AM','Apr 13 2011  9:20AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8772,298,1,1,52,52,52,'Apr  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Apr 13 2011  9:20AM','May 10 2011  8:36AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8773,269,2,34,49,34,3,'Jan  1 2010 12:00AM','Dec 31 2010 12:00AM',3,NULL,NULL,NULL,1,'May 18 2011  2:09PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8774,299,1,1,49,49,49,'Jan  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'May 18 2011  2:09PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8775,300,2,34,58,34,3,'Jan  1 2011 12:00AM',NULL,3,NULL,NULL,NULL,1,'May 18 2011  2:11PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8776,7,2,3,7,3,3,'Jan  1 2006 12:00AM','Dec 31 2010 12:00AM',2,NULL,NULL,NULL,1,'May 18 2011  2:12PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8777,301,1,1,7,7,7,'Jan  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'May 18 2011  2:12PM','Jul 26 2012  9:37AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8778,259,2,3,40,3,3,'Jan  1 2010 12:00AM','Dec 31 2010 12:00AM',2,NULL,NULL,NULL,1,'May 18 2011  2:16PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8779,261,2,3,43,3,3,'Jan  1 2010 12:00AM','Dec 31 2010 12:00AM',2,NULL,NULL,NULL,1,'May 18 2011  2:16PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8780,262,2,9,41,9,9,'Jan  1 2010 12:00AM','Dec 31 2010 12:00AM',2,NULL,NULL,NULL,1,'May 18 2011  2:16PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8781,263,2,9,44,9,9,'Jan  1 2010 12:00AM','Dec 31 2010 12:00AM',2,NULL,NULL,NULL,1,'May 18 2011  2:17PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8782,302,2,7,40,7,7,'Jan  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'May 18 2011  2:18PM','Jul 26 2012  8:43AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8783,303,2,7,41,7,7,'Jan  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'May 18 2011  2:19PM','Jul 26 2012  8:44AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8784,304,2,7,43,7,7,'Jan  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'May 18 2011  2:19PM','Jul 26 2012  8:45AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8785,305,2,7,44,7,7,'Jan  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'May 18 2011  2:19PM','Jul 26 2012  8:46AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8786,226,2,9,25,9,9,'Jan  1 2007 12:00AM','Dec 31 2010 12:00AM',2,NULL,NULL,NULL,1,'May 18 2011  2:20PM','Jun 23 2011  8:55AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8787,306,1,1,59,59,59,'Jan  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'May 18 2011  4:46PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8788,307,1,1,60,60,60,'Apr  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jun 17 2011  2:02PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8789,308,1,1,61,61,61,'Apr  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jun 17 2011  2:02PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8790,309,1,1,62,62,62,'Apr  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jun 17 2011  2:02PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8791,226,2,9,25,9,9,'Jan  1 2007 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jun 23 2011  8:55AM','Jun 23 2011  9:26AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8792,226,2,9,25,9,9,'Jan  1 2007 12:00AM','Dec 31 2010 12:00AM',2,NULL,NULL,NULL,1,'Jun 23 2011  9:26AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8793,310,1,1,63,63,63,'Mar  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jul  2 2011 10:28AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8794,311,1,1,53,53,53,'Jan  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Aug  9 2011  2:54PM','Aug  9 2011  2:55PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8795,311,1,1,53,53,53,'Jan  1 2011 12:00AM','Feb  1 2011 12:00AM',1,NULL,NULL,NULL,1,'Aug  9 2011  2:55PM','Aug  9 2011  3:00PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8796,311,1,1,53,53,53,'Feb  2 2011 12:00AM','Jan  1 2011 12:00AM',1,NULL,NULL,NULL,1,'Aug  9 2011  2:57PM','Aug  9 2011  2:59PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8797,6,2,3,6,3,3,'Jan  1 2006 12:00AM',NULL,2,NULL,'fsdfsdf',NULL,1,'Aug  9 2011  3:17PM','Jul 25 2012  4:08PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8798,312,1,1,65,65,65,'May  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Sep  5 2011  1:26PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8799,313,1,1,66,66,66,'May  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Sep  5 2011  1:28PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8800,314,1,1,67,67,67,'Jan  1 2012 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jan 20 2012 10:26AM','Jan 20 2012 10:27AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8801,3,1,1,4,4,4,'Feb  1 2006 12:00AM','Nov 30 2011 12:00AM',1,NULL,NULL,'test',1,'Apr  1 2012  9:25AM','Apr  1 2012  9:26AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8802,315,2,3,4,3,3,'Dec  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'Apr  1 2012  9:26AM','Apr  2 2012  2:07PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8803,5,2,3,5,3,3,'Jan  1 2006 12:00AM','Nov 30 2011 12:00AM',2,NULL,NULL,NULL,1,'Apr  1 2012 11:53AM','Apr  1 2012 11:56AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8804,315,2,3,4,3,3,'Dec  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,2,'Apr  2 2012  2:07PM','Apr 17 2012 11:44AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8805,316,2,3,4,3,3,'Dec  1 2012 12:00AM',NULL,2,NULL,NULL,NULL,1,'Apr 17 2012 11:46AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8806,317,2,3,4,3,3,'Dec  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'Apr 17 2012 11:52AM','Jul 25 2012  2:40PM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8807,292,2,6,54,6,3,'Jan  1 2010 12:00AM','Dec 31 2012 12:00AM',3,NULL,NULL,NULL,1,'Apr 17 2012 11:58AM','Apr 17 2012 11:59AM',0)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8808,292,2,6,54,6,3,'Jan  1 2010 12:00AM','Dec 31 2011 12:00AM',3,NULL,NULL,NULL,1,'Apr 17 2012 11:59AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8809,318,2,9,54,9,9,'Jan  1 2012 12:00AM',NULL,2,NULL,NULL,NULL,1,'Apr 17 2012 12:00PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8810,319,1,1,68,68,68,'Jan  1 2012 12:00AM',NULL,1,NULL,NULL,NULL,1,'Apr 20 2012  3:59PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8811,320,1,1,69,69,69,'Jan  1 2012 12:00AM',NULL,1,NULL,NULL,NULL,1,'Apr 20 2012  4:00PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8812,321,2,3,70,3,3,'Jan  1 2012 12:00AM',NULL,2,NULL,NULL,NULL,1,'Apr 20 2012  4:13PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8813,322,2,3,71,3,3,'Dec  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jul 24 2012  2:20PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8814,323,2,3,72,3,3,'Dec  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jul 25 2012  2:42PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8815,252,2,3,5,3,3,'Jan  1 2009 12:00AM','Nov 30 2011 12:00AM',2,NULL,NULL,NULL,1,'Jul 25 2012  3:23PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8816,324,2,3,73,3,3,'Sep  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jul 25 2012  3:23PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8817,6,2,3,6,3,3,'Jan  1 2006 12:00AM','Aug 31 2011 12:00AM',2,NULL,NULL,NULL,1,'Jul 25 2012  4:08PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8818,325,2,3,75,3,3,'Dec  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jul 25 2012  4:10PM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8819,204,2,3,8,3,3,'Jan  1 2007 12:00AM','Nov 30 2011 12:00AM',2,NULL,NULL,NULL,1,'Jul 26 2012  8:41AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8820,326,1,1,74,74,74,'Dec  1 2011 12:00AM',NULL,1,NULL,NULL,NULL,1,'Jul 26 2012  8:41AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8821,302,2,7,40,7,7,'Jan  1 2011 12:00AM','Nov 30 2011 12:00AM',2,NULL,NULL,NULL,1,'Jul 26 2012  8:43AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8822,303,2,7,41,7,7,'Jan  1 2011 12:00AM','Nov 30 2011 12:00AM',2,NULL,NULL,NULL,1,'Jul 26 2012  8:44AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8823,304,2,7,43,7,7,'Jan  1 2011 12:00AM','Nov 30 2011 12:00AM',2,NULL,NULL,NULL,1,'Jul 26 2012  8:45AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8824,305,2,7,44,7,7,'Jan  1 2011 12:00AM','Nov 30 2011 12:00AM',2,NULL,NULL,NULL,1,'Jul 26 2012  8:46AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8825,327,2,74,40,74,74,'Dec  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jul 26 2012  8:47AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8826,328,2,74,43,74,74,'Dec  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jul 26 2012  8:50AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8827,329,2,74,44,74,74,'Dec  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jul 26 2012  8:50AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8828,330,2,74,41,74,74,'Dec  1 2011 12:00AM',NULL,2,NULL,NULL,NULL,1,'Jul 26 2012  8:51AM',NULL,1)
insert into PogodbaNew(ID,PogodbaID,PogodbaTipID,Partner1,Partner2,NadrejenaOsebaID,ClanBSID,VeljaOd,VeljaDo,Nivo,IzvrsilniDan,Opis,Opombe,Avtor,DatumVnosa,DatumSpremembe,Aktivno) values(8829,301,1,1,7,7,7,'Jan  1 2011 12:00AM','Nov 30 2011 12:00AM',1,NULL,NULL,NULL,1,'Jul 26 2012  9:37AM',NULL,1)

EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

SET IDENTITY_INSERT Pogodba ON 

TRUNCATE TABLE [dbo].[Pogodba]

INSERT INTO [dbo].[Pogodba]
 (
	ID,
	[PogodbaID],
	[PogodbaTipID],
	[Partner1],
	[Partner2],
	[NadrejenaOsebaID],
	[ClanBSID],
	[VeljaOd],
	[VeljaDo],
	[Nivo],
	[IzvrsilniDan],
	[Opis],
	[Opombe],
	[Avtor],
	[DatumVnosa],
	[DatumSpremembe],
	[Aktivno]
)
SELECT
ID,
	[PogodbaID],
	[PogodbaTipID],
	[Partner1],
	[Partner2],
	[NadrejenaOsebaID],
	[ClanBSID],
	[VeljaOd],
	[VeljaDo],
	[Nivo],
	[IzvrsilniDan],
	[Opis],
	[Opombe],
	[Avtor],
	[DatumVnosa],
	[DatumSpremembe],
	[Aktivno]
	FROM [dbo].[PogodbaNew]


SET IDENTITY_INSERT Pogodba OFF


exec sp_msforeachtable @command1="print '?'", @command2="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"

