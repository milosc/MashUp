EXEC [dbo].[DropPRCorUDF] @ObjectName = 'usp_IntersectOseba' 
GO

CREATE PROCEDURE [dbo].[usp_IntersectOseba]
    @ID INT,
    @OsebaID INT,
    @VeljaOd DATETIME,
    @VeljaDo DATETIME
AS 
    SET NOCOUNT ON

    IF EXISTS ( SELECT  *
                FROM    Oseba
                WHERE   dbo.intersects(@VeljaOd, @VeljaDo, VeljaOd, VeljaDo) = 1
                        AND OsebaID = @OsebaID
                        AND ID <> @ID
                        AND DatumSpremembe IS NULL ) 
        RETURN 1
    ELSE 
        RETURN 0

GO