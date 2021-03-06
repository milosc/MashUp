/****** Object:  StoredProcedure [dbo].[sp_OsebaDodajSpremembo]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_OsebaDodajSpremembo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_OsebaDodajSpremembo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_OsebaDodajSpremembo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_OsebaDodajSpremembo]
	@OsebaID int
AS
BEGIN

--id je v tabeli autoincrement (osebaId ni atuoincrement)
declare @Naslov varchar(50)
declare @Stevilka varchar(50)
declare @VeljaOD datetime
declare @OsebaTipID int
declare @EIC varchar(50)
declare @ID int
declare @OdgOseba1 varchar(100)
declare @OdgOseba2 varchar(100)
declare @tel varchar(50)
declare @email varchar(100)
declare @naziv varchar(50)

select  @ID= ID,
		@Naslov = Naslov,
		@Stevilka = Stevilka,
		@OsebaTipID = OsebaTipID,
		@VeljaOD =VeljaOd,
		@EIC = EIC,
		@OdgOseba1 = OdgovornaOseba1,
		@OdgOseba2 = OdgovornaOseba2,
		@tel = Telefon,	
		@email = Email,
		@naziv = Naziv	
 from Oseba 
where VeljaOd=(select  max(VeljaOd)  from Oseba
				where OsebaID=@OsebaID 
				group by OsebaID)

--poparvimo trenutni veljado z trenutnim datumom 
update Oseba set VeljaDo= getdate()
		where ID=@ID

--zapisemo novo spremembo 
insert into Oseba (OsebaID,OsebaTipID,Naslov,Stevilka,VeljaOd,EIC,Naziv) values 
					(@OsebaID,@OsebaTipID,@Naslov,@Stevilka,getdate(),@EIC,@naziv)

END
' 
END
GO
