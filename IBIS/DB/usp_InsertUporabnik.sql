EXEC [dbo].[DropPRCorUDF]	@ObjectName = 'usp_InsertUporabnik' 
GO

CREATE PROCEDURE [dbo].[usp_InsertUporabnik]
	@UporabnikID int,
	@VlogaID int,
	@UporabniskoIme varchar(50),
	@Geslo varchar(500),
	@Ime varchar(50),
	@Priimek nchar(50),
	@Email varchar(50),
	@CSerial varchar(250),
	@CIssuer varchar(255),
	@CThumbPrint varchar(255),
	@VeljaOd datetime,
	@VeljaDo datetime,
	@OsebaID int,
	@Avtor int,
	@Aktivno int,
	@ID int OUTPUT
AS

SET NOCOUNT ON

INSERT INTO [dbo].[Uporabnik] (
	[UporabnikID],
	[VlogaID],
	[UporabniskoIme],
	[Geslo],
	[Ime],
	[Priimek],
	[Email],
	CSerial ,
	CIssuer ,
	CThumbprint ,
	[VeljaOd],
	[VeljaDo],
	[OsebaID],
	[Avtor],
	[Aktivno]
) VALUES (
	@UporabnikID,
	@VlogaID,
	@UporabniskoIme,
	CONVERT(NVARCHAR(32), HashBytes('MD5', @Geslo), 2),
	@Ime,
	@Priimek,
	@Email,
	@CSerial ,
	@CIssuer,
	@CThumbPrint ,
	@VeljaOd,
	@VeljaDo,
	@OsebaID,
	@Avtor,
	@Aktivno
)

SET @ID = SCOPE_IDENTITY()

