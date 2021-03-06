/****** Object:  StoredProcedure [dbo].[usp_UpdateNastavitve]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateNastavitve]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdateNastavitve]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateNastavitve]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



--region [dbo].[usp_SelectNajvecjeIzgubesAll]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   kraljic
-- Procedure Name: [dbo].[usp_UpdateNastavitve]
-- Date Created: 9.6.2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_UpdateNastavitve]
	@ID INT,
	@oznaka VARCHAR(50),
	@opis VARCHAR(250),
	@vrednost VARCHAR(50)
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

update Nastavitev set DatumSpremembe = getdate() where ID =@id;

insert into Nastavitev (oznaka, vrednost, opis) values (@oznaka,@vrednost, @opis);
	

--endregion




' 
END
GO
