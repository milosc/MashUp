EXEC [dbo].[DropPRCorUDF] @ObjectName = 'UporabnikPodatkiPrijava'
GO

CREATE PROCEDURE [dbo].[UporabnikPodatkiPrijava]
    @uporabnik VARCHAR(50),
    @geslo VARCHAR(500),
    @OsebaID INT OUTPUT,
    @VlogaID INT OUTPUT,
    @UserID INT OUTPUT
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

    -- Insert statements for procedure here
        SELECT  @UserID = UporabnikID,
                @OsebaID = OsebaID,
                @VlogaID = VlogaID
        FROM    Uporabnik
        WHERE   Geslo = CONVERT(NVARCHAR(32), HashBytes('MD5', @geslo), 2)
                AND UporabniskoIme = @uporabnik
                AND DatumSpremembe IS NULL
                AND VeljaOd <= GETDATE()
                AND ISNULL(VeljaDo, DATEADD(yy, 50, GETDATE())) >= GETDATE() ;
    END


