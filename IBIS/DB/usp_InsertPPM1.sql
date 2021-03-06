EXEC dbo.DropPRCorUDF
	@ObjectName = 'usp_InsertPPM1' --  varchar(max)
GO

CREATE PROCEDURE [dbo].[usp_InsertPPM1]
	@PPMID int,
	@Naziv varchar(50),
	@EIC varchar(50),
	@SistemskiOperater1 int,
	@Dobavitelj1 int,
	@PPMTIpID int,
	@PPmJeOddaja int,
	@VrstniRed int,
	@NazivExcel varchar(100),
	@NazivPorocila varchar(255),
	@VeljaOd datetime,	
	@VeljaDo datetime
AS

SET NOCOUNT ON

declare @ID int
set @ID=(select max(ID) from PPM)
set @ID= @ID+1

INSERT INTO [dbo].[PPM] (
	ID,
	PPMID,
	Naziv,
	EIC,
	SistemskiOperater1,
	Dobavitelj1,
	PPMTipID,
	PPMJeOddaja,
	VrstniRed,
	NazivExcel,
	NazivPorocila,
	VeljaOd,
	VeljaDo
) VALUES (
	@ID,
	@PPMID,
	@Naziv,
	@EIC,
	@SistemskiOperater1,
	@Dobavitelj1,
	@PPMTipID,
	@PPmJeOddaja,
	@VrstniRed,
	@NazivExcel,
	@NazivPorocila,
	@VeljaOd,
	@VeljaDo
)



GO
