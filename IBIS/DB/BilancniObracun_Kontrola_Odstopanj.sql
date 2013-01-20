

EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_Kontrola_Odstopanj'
GO 

CREATE PROCEDURE [dbo].[BilancniObracun_Kontrola_Odstopanj]
    (
      @DatumStanjaBaze AS DATETIME,
      @ObracunID AS INT,
      @OsebaID INT,
      @Tip CHAR(1) = 'O' --O -- odstopanja I -- izravnava
    )
AS 
    BEGIN
     
        DECLARE @DatumIntervalaDO DATETIME
        DECLARE @DatumIntervalaOD DATETIME
        DECLARE @ObdobjeId INT
     
          
        SELECT  @ObdobjeId = ObracunskoObdobjeID
        FROM    Obracun
        WHERE   ObracunID = @ObracunID
      
        SELECT  @DatumIntervalaDO = VeljaDo,
                @DatumIntervalaOD = VeljaOd
        FROM    ObracunskoObdobje
        WHERE   ObracunskoObdobjeID = @ObdobjeId 
    
    
        IF ( @Tip = 'O' ) 
            BEGIN    
                IF ( EXISTS ( SELECT    *
                              FROM      [TrzniPlan]
                              WHERE     OsebaID = @OsebaID
                                        AND interval BETWEEN @DatumIntervalaOD
                                                     AND     @DatumIntervalaDO ) ) 
                    BEGIN  
				
                        
                        SELECT  K.[Interval],
                                SUM(CASE WHEN O.OsebaID = 46
                                         THEN -1*K.[Odstopanje]
                                         ELSE K.[Odstopanje]
                                    END) AS Odstopanje
                        FROM    [dbo].[KolicinskaOdstopanjaPoBS] K
                                JOIN [dbo].[Oseba] O ON K.OsebaID = O.OSebaID
                        WHERE   K.[ObracunID] = @ObracunID
                                AND K.[OsebaID] = @OsebaID
                                AND ( ( @DatumStanjaBaze BETWEEN O.DatumVnosa
                                                         AND     dbo.infinite(O.DatumSpremembe) )
                                      AND ( @DatumStanjaBaze BETWEEN O.VeljaOd
                                                             AND     dbo.infinite(O.VeljaDo) )
                                    )
                        GROUP BY O.Naziv,
                                K.Interval
                        ORDER BY DATEPART(month, K.[Interval]) ASC,
                                DATEPART(day, K.[Interval]) ASC,
                                ( CASE WHEN DATEPART(HH, K.[Interval]) = 0
                                       THEN 24
                                       ELSE DATEPART(HH, K.[Interval])
                                  END ) ASC
                          
                    END
                ELSE 
                    BEGIN
                                                      
                        SELECT  K.[Interval],
                                0.0 AS Odstopanje
                        FROM    [dbo].[KolicinskaOdstopanjaPoBS] K
                        WHERE   [OsebaID] = 3
                                AND [ObracunID] = @ObracunID
                        ORDER BY DATEPART(month, K.[Interval]) ASC,
                                DATEPART(day, K.[Interval]) ASC,
                                ( CASE WHEN DATEPART(HH, K.[Interval]) = 0
                                       THEN 24
                                       ELSE DATEPART(HH, K.[Interval])
                                  END ) ASC
                    END
            END
        ELSE 
            IF ( @Tip = 'I' ) 
                BEGIN
				
                  
        
                    SELECT  K.[Interval],
                            AVG(K.[W+]) AS [Wizr+],
                            AVG(K.[W-]) AS [Wizr-]
                    FROM    PodatkiObracuna_Skupni K
                    WHERE   K.ObracunID = @ObracunID
                    GROUP BY K.Interval
                    ORDER BY DATEPART(month, K.[Interval]) ASC,
                            DATEPART(day, K.[Interval]) ASC,
                            ( CASE WHEN DATEPART(HH, K.[Interval]) = 0 THEN 24
                                   ELSE DATEPART(HH, K.[Interval])
                              END ) ASC
				
                END       

       
    END



GO