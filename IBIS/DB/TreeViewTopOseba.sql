EXEC dbo.DropPRCorUDF @ObjectName = '[TreeViewTopOseba]'
GO

CREATE PROCEDURE [dbo].[TreeViewTopOseba]
    @OsebaID INT ,
    @stanje DATETIME
AS 
    BEGIN
        SET NOCOUNT ON;

        DECLARE @nivo INT
	
	--select top 1 @nivo=nivo from Pogodba where Partner1 =@OsebaID ;
        DECLARE @txt VARCHAR(250)
        SET @txt = 'sp:TreeViewTopOseba:' + CAST(@OsebaID AS VARCHAR)

        SELECT TOP 1
                p.partner1 AS vrednost ,
                o.kratica AS naziv ,
                nivo
        INTO    #tmp
        FROM    Pogodba p ,
                Oseba o
        WHERE   o.OsebaID = p.partner1
                AND Partner1 = @OsebaID
                AND p.DatumVnosa <= @stanje
                AND ISNULL(p.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje
                AND o.DatumVnosa <= @stanje
                AND ISNULL(o.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje;

        DECLARE @n INT
        SELECT  @n = COUNT(*)
        FROM    #tmp
--select @n
        IF ( @n > 0 ) 
            BEGIN
                SELECT  *
                FROM    #tmp
            END   
        ELSE 
            BEGIN
                SELECT TOP 1
                        p.partner2 AS vrednost ,
                        o.kratica AS naziv ,
                        nivo
                INTO    #tmp2
                FROM    Pogodba p ,
                        Oseba o
                WHERE   o.OsebaID = p.partner2
                        AND Partner2 = @OsebaID
                        AND p.DatumVnosa <= @stanje
                        AND ISNULL(p.DatumSpremembe,
                                   DATEADD(yy, 50, GETDATE())) >= @stanje
                        AND o.DatumVnosa <= @stanje
                        AND ISNULL(o.DatumSpremembe,
                                   DATEADD(yy, 50, GETDATE())) >= @stanje;
                SELECT  *
                FROM    #tmp2
            END

    END
