EXEC dbo.DropPRCorUDF
	@ObjectName = 'sp_UpdatePPMNovo' --  varchar(max)
GO


CREATE PROCEDURE [dbo].[sp_UpdatePPMNovo]
@id int,	
@ppmid int,
		@Naziv varchar(50),
		@EIC varchar(50),
		@SistemskiOperater1 int,
		@Dobavitelj1 int,
		@PPMTipID int,
		@PPMJeOddaja int,
		@VrstniRed	int,
		@NazivExcel varchar(100),
		@NazivPorocila varchar(255),
	@VeljaOd datetime,	
	@VeljaDo datetime
	
AS
BEGIN
--dobimo max ID
declare @tmpMaxID int
set @tmpMaxID =(select max(ID) from PPM)
set @tmpMaxID = @tmpMaxID+1

--dobimo max PPMID
/* PPmId mora ostat enak
declare @tmpMaxPPMID int
set @tmpMaxPPMID =(select max(PPMID) from PPM)
set @tmpMaxPPMID = @tmpMaxPPMID+1
*/

--zapisemo trenutnemo ppmju datum spremembe
update PPM set DatumSpremembe=getdate()
	where ID=@id

	insert into PPM
	(	
		ID,
		[PPMID],
		[Naziv],
		EIC,
		[SistemskiOperater1],
		[Dobavitelj1],
		[PPMTipID],
		PPMJeOddaja,
		VrstniRed,
		NazivExcel,
		NazivPorocila,
		VeljaOd,
		VeljaDo	
	)
	values
	(
	@tmpMaxID,
	   @ppmid,
		@Naziv,
		@EIC,
		@SistemskiOperater1,
		@Dobavitelj1,
		@PPMTipID,
		@PPMJeOddaja,
		@VrstniRed,
		@NazivExcel,
		@NazivPorocila,
		@VeljaOd,
		@VeljaDo
	)

END

GO
