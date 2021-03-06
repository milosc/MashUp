/****** Object:  StoredProcedure [dbo].[usp_UpdateObracunskoObdobje]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateObracunskoObdobje]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdateObracunskoObdobje]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdateObracunskoObdobje]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[usp_UpdateObracunskoObdobje]
	@Od datetime,
	@Do datetime,
	@Naziv varchar(50),
	@ObracunskoObdobjeTipID int,
	@ObracunskoObdobjeID int OUTPUT
AS

SET NOCOUNT ON
-- najprej preverim prekrivanja
	DECLARE @InObdobje int
-- OD
select @InObdobje=0
select @InObdobje=count(ObracunskoObdobjeID) from ObracunskoObdobje where VeljaOd <= @Od and VeljaDo >= @Od and ObracunskoObdobjeTipID=@ObracunskoObdobjeTipID
if @InObdobje > 0
begin
	SET @ObracunskoObdobjeID = 0
	RETURN (1);
end
-- DO
select @InObdobje=count(ObracunskoObdobjeID) from ObracunskoObdobje where VeljaOd <= @Do and VeljaDo >= @Do and ObracunskoObdobjeTipID=@ObracunskoObdobjeTipID
if @InObdobje > 0
begin
	SET @ObracunskoObdobjeID = 0
	RETURN (2);
end



--Pogoj je tudi da je datum Do vecji od datuma od
if (select DATEDIFF(DAY,@Od,@Do)) >= 0
begin

-- prevedem nov ID
DECLARE @NewObdobjeID INT
SELECT @NewObdobjeID=ISNULL(MAX(ObracunskoObdobjeID),0)+1 FROM [ObracunskoObdobje]
SET @ObracunskoObdobjeID=@NewObdobjeID
-- dodam novo
INSERT INTO [dbo].[ObracunskoObdobje] (
	[ObracunskoObdobjeID],
	[Naziv],
	[VeljaOd],
	[VeljaDo],
	[ObracunskoObdobjeTipID]
) VALUES (
	@NewObdobjeID,
	@Naziv,
	@Od,
	@Do,
	@ObracunskoObdobjeTipID
)
SET @ObracunskoObdobjeID = SCOPE_IDENTITY()
RETURN (0);

end
else
begin
	SET @ObracunskoObdobjeID = 0
	RETURN (3);
end

' 
END
GO
