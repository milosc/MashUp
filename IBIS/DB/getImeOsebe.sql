EXEC [dbo].[DropPRCorUDF] @ObjectName = 'getImeOsebe' 
GO


CREATE PROCEDURE [dbo].[getImeOsebe]
    (
      @osebaId INT,
      @obracunId INT
    )
AS 
    BEGIN 
 
        DECLARE @dt DATETIME
        DECLARE @tVelja DATETIME
        SELECT  @dt = datumvnosa,
                @tVelja = velja
        FROM    Obracun
        WHERE   ObracunID = @obracunId




        SELECT  naziv
        FROM    ( SELECT    s.naziv,
                            s.osebaid
                  FROM      Oseba s
                  WHERE     @dt BETWEEN s.DatumVnosa
                                AND     dbo.infinite(s.DatumSpremembe)
                            AND @tVelja BETWEEN s.VeljaOd
                                        AND     dbo.infinite(s.VeljaDo)
                ) AS x
        WHERE   OsebaID = @osebaId

    END

GO