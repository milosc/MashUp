/****** Object:  StoredProcedure [dbo].[sp_PreveriCeSo4TipiZaDobavitelja]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreveriCeSo4TipiZaDobavitelja]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PreveriCeSo4TipiZaDobavitelja]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreveriCeSo4TipiZaDobavitelja]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_PreveriCeSo4TipiZaDobavitelja]
	@SistOp1 int ,
	@Dobav1 int,
	@napaka int OUTPUT
AS
BEGIN
--preverimo ce ima  izbrani  dobavitelj res 4 razlicne tipe (1,2,4,5)
--in sicer so to 
-- 1-> merjena oddaja | 2-> nemrejena oddaja | 4 -> merjen odjem | 5->nemerjen odjem
--ce imamo v posameznem tipu vec kot enega ni ok 
--ce je vrednost napake >0 imamo napako
declare @tipOddajaMerjena int
declare @tipOddajaNeMerjena int
declare @tipOdjemMerjen int
declare @tipOdjemNeMerjen int


set @napaka = 0

	set @tipOddajaMerjena = (select count(*) from PPM
							where DatumSpremembe is null
							and PPMTipID=1
							and SistemskiOperater1=@SistOp1
							and Dobavitelj1=@Dobav1)
	
	set @tipOddajaNeMerjena =(select count(*) from PPM
							where DatumSpremembe is null
							and PPMTipID=2
							and SistemskiOperater1=@SistOp1
							and Dobavitelj1=@Dobav1)

	set @tipOdjemMerjen =(select count(*) from PPM
							where DatumSpremembe is null
							and PPMTipID=4
							and SistemskiOperater1=@SistOp1
							and Dobavitelj1=@Dobav1)
	
	set @tipOdjemNeMerjen = (select count(*) from PPM
							where DatumSpremembe is null
							and PPMTipID=5
							and SistemskiOperater1=@SistOp1
							and Dobavitelj1=@Dobav1)

 if((@tipOddajaMerjena=1) and (@tipOddajaNeMerjena=1) and (@tipOdjemMerjen=1) and (@tipOdjemNeMerjen=1))
	begin
		--vse je ok
		set @napaka=0
	end
	else
	begin
   -- ni ok
		set @napaka=1
	end

END' 
END
GO
