/****** Object:  StoredProcedure [dbo].[usp_InsertNovaOsebaTip]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertNovaOsebaTip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertNovaOsebaTip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertNovaOsebaTip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

create PROCEDURE [dbo].[usp_InsertNovaOsebaTip]
--	@OsebaTipID int,
	@Naziv varchar(50),
	@sifra varchar(5)
AS
begin
SET NOCOUNT ON

declare @maxOs int
select @maxOs=max(OsebaTipID)+1 from [OsebaTipID]
INSERT INTO [dbo].[OsebaTipID] (
	OsebaTipID,
	Naziv,
	Sifra
) VALUES (
	@maxOs,-- @OsebaTipID,
	@Naziv,
    @sifra
)
end


' 
END
GO
