USE [IBIS2]
GO

EXEC dbo.DropPRCorUDF @ObjectName = 'BilancniObracun_Kontrola_Odstopanj_Seznam'
GO 

CREATE PROCEDURE [dbo].[BilancniObracun_Kontrola_Odstopanj_Seznam] ( @ObracunID AS INT )
AS 
    BEGIN
     
        SELECT  O.OsebaID,Naziv
        FROM  [dbo].[Oseba] O 
        JOIN [dbo].[Pogodba] P ON O.[OsebaID] = P.[Partner2]
                WHERE          
                         GETDATE() BETWEEN O.DatumVnosa   AND     dbo.infinite(O.DatumSpremembe) 
                AND GETDATE() BETWEEN p.DatumVnosa   AND     dbo.infinite(P.DatumSpremembe)  
                AND GETDATE() BETWEEN p.VeljaOd  AND     dbo.infinite(P.VeljaDo)                      
                AND GETDATE() BETWEEN O.VeljaOd AND     dbo.infinite(O.VeljaDo) 
                AND 
                P.[PogodbaTipID]=1
                
        GROUP BY O.OsebaID ,Naziv

                       
    END       

       




GO