exec [dbo].[DropPRCorUDF]	@ObjectName = 'UporabnikPreveri' 
GO

CREATE PROCEDURE [dbo].[UporabnikPreveri]
	@uporabnik varchar(50),
	@geslo varchar(500)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Prijava int
    -- Insert statements for procedure here
    
   
 SELECT @Prijava = COUNT(UporabnikID)
 FROM   Uporabnik
 WHERE  Geslo = CONVERT(NVARCHAR(32), HashBytes('MD5', @geslo), 2)
        AND UporabniskoIme = @uporabnik
        AND DatumSpremembe IS NULL
        AND VeljaOd <= GETDATE()
        AND ISNULL(VeljaDo, DATEADD(yy, 500, GETDATE())) >= GETDATE() ;
	
	if(@Prijava > 0)
	begin
		return 1
	end
	else
	begin
		return 0
	end

END


