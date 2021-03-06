EXEC dbo.DropPRCorUDF @ObjectName = 'Dovoljenje' 
	GO


CREATE PROCEDURE [dbo].[Dovoljenje]
    @VlogaID INT, --vloga oz uporabniška skupina
    @PravicaID INT, -- zahtevana pravica
    @Revizija INT = 0,
    @Stanje DATETIME = GETDATE, --stanje baze,
    @NazivPravice VARCHAR(500) OUT
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;
        DECLARE @Dovoljeno INT
        IF ( @Revizija = 0 ) 
            BEGIN

                SELECT  @Dovoljeno = COUNT(PravicaID)
                FROM    VlogaPravica
                WHERE   PravicaID = @PravicaID
                        AND DatumSpremembe IS NULL
                        AND VlogaID IN ( SELECT VlogaID
                                         FROM   VlogaPrednik
                                         WHERE  DatumSpremembe IS NULL
                                                AND PrednikID = @VlogaID ) ;

            END
        ELSE 
            BEGIN
                SELECT  @Dovoljeno = COUNT(PravicaID)
                FROM    VlogaPravica p
                WHERE   p.PravicaID = @PravicaID
                        AND p.DatumSpremembe IS NULL
                        AND p.VlogaID IN ( SELECT   VlogaID
                                           FROM     VlogaPrednik
                                           WHERE    DatumSpremembe IS NULL
                                                    AND PrednikID = @VlogaID )
                        AND p.PravicaID IN ( SELECT PraviceID
                                             FROM   Pravice
                                             WHERE  Revizija = 1 ) ;

            END

        SELECT  @NazivPravice = ISNULL(P.Modul,'')+'->'+ISNULL(P.Akcija,'')
        FROM    Pravice P
        WHERE   P.PraviceID = @PravicaID

        IF ( @Dovoljeno > 0 ) 
            BEGIN
                RETURN 1
            END
        ELSE 
            BEGIN
                RETURN 0
            END
    END




GO