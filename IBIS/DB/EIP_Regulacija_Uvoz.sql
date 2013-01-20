EXEC dbo.DropPRCorUDF @ObjectName = 'EIP_Regulacija_Uvoz'
GO


CREATE PROCEDURE dbo.EIP_Regulacija_Uvoz
    @ImportBusinessType VARCHAR(10) /*If PO_SEK then update PO_SEK if @CheckIfExistsSEK > 0 else update PO_TER*/
AS 
    BEGIN
	
        DECLARE @CheckIfExistsSEK INT = 0 ;
		
        SELECT  @CheckIfExistsSEK = COUNT(*)
        FROM    dbo.Regulacija R
                JOIN RegulacijaEIP E ON R.Interval = E.Interval
        WHERE   ( R.DatumSpremembe IS NULL
                  OR DATEDIFF(DAY, R.DatumSpremembe, GETDATE()) = 0
                )/*Same day import must be ACTIVE*/
                AND DATEDIFF(DAY, R.DatumVnosa, GETDATE()) = 0 /*Primerjamo čas vnešene regulacije in uvožene v stageing tabeli RegulacijaEIP*/
		
        IF ( @CheckIfExistsSEK = 0 ) 
            BEGIN
                INSERT  INTO Regulacija
                        (
                          Interval,
                          PPMID,
                          SekRegP,
                          SekRegM,
                          TerRegP,
                          TerRegM,
                          SekRegSp,
                          SekRegSm,
                          TerRegSp,
                          TerRegSm
                        )
                        SELECT  Interval,
                                PPMID,
                                SUM(SekRegP),
                                SUM(SekRegM),
                                SUM(TerRegP),
                                SUM(TerRegM),
                                SUM(SekRegSp),
								SUM(SekRegSm),
								SUM(TerRegSp),
								SUM(TerRegSm)
                        FROM    RegulacijaEIP
                        GROUP BY Interval,
                                PPMID 
            END
        ELSE 
            BEGIN
                IF ( @ImportBusinessType = 'PO_SEK' ) 
                    BEGIN 
			/*Update PO_SEK in Regulacija with values from RegulacijaEIP and leave PO_TER as it is*/
         
                        ;
                        WITH    UpdateCTE
                                  AS ( SELECT  
												R.PPMID,
                                                R.SekRegM AS SekRegM,
                                                R.SekRegP AS SekRegP,
                                                R.SekRegSp,
                                                R.SekRegSm,
                                                R.DatumSpremembe,
                                                R.Interval,
                                                ROW_NUMBER() OVER (PARTITION BY R.PPMID,R.Interval,R.DatumSpremembe ORDER BY R.Id DESC) AS rn
                                       FROM     dbo.Regulacija R
                                       WHERE    R.DatumSpremembe IS NULL
                                                AND DATEDIFF(DAY, R.DatumVnosa,
                                                             GETDATE()) = 0
                                     )
                            UPDATE  R
                            SET     R.SekRegM = E.SekRegM,
                                    R.SekRegP = E.SekRegP,
                                    R.SekRegSp = E.SekRegSp,
                                    R.SekRegSm = E.SekRegSm,
                                    R.DatumSpremembe = NULL
                            FROM    UpdateCTE R
                                    JOIN (SELECT SUM(SekRegM) AS SekRegM,
                                                SUM(SekRegP) AS SekRegP,
                                                SUM(SekRegSp) AS SekRegSp,
                                                SUM(SekRegSm) AS SekRegSm,
                                                PPMId,
                                                INterval
                                                FROM RegulacijaEIP
                                                GROUP BY INterval,PPMId
                                                 ) E ON R.Interval = E.Interval AND R.PPMID = E.PPMID
                                    AND R.rn = 1
							
				
                    END
                ELSE 
                    IF ( @ImportBusinessType = 'PO_TER' ) 
                        BEGIN 
			/*Update PO_TER in Regulacija with values from RegulacijaEIP and leave PO_SEK as it is*/
                                       
			                        ;
                        WITH    UpdateCTE
                                  AS ( SELECT  
												R.PPMID,
                                                R.TerRegM AS TerRegM,
                                                R.TerRegP AS TerRegP,
                                                R.TerRegSp,
                                                R.TerRegSm,
                                                R.DatumSpremembe,
                                                R.Interval,
                                                ROW_NUMBER() OVER (PARTITION BY R.PPMID,R.Interval,R.DatumSpremembe ORDER BY R.Id DESC) AS rn
                                       FROM     dbo.Regulacija R
                                       WHERE    R.DatumSpremembe IS NULL AND DATEDIFF(DAY, R.DatumVnosa,GETDATE()) = 0
                                     )
                            UPDATE  R
                            SET     R.TerRegM = E.TerRegM,
                                    R.TerRegP = E.TerRegP,
                                    R.TerRegSp = E.TerRegSp,
                                    R.TerRegSm = E.TerRegSm,
                                    R.DatumSpremembe = NULL
                            FROM    UpdateCTE R
                                    JOIN (SELECT  SUM(TerRegM) AS TerRegM,
                                                SUM(TerRegP) AS TerRegP,
                                                SUM(TerRegSp) AS TerRegSp,
                                                SUM(TerRegSm) AS TerRegSm,
                                                PPMId,
                                                INterval
                                                FROM RegulacijaEIP
                                                GROUP BY INterval,PPMId
                                                 ) E ON R.Interval = E.Interval AND R.PPMID = E.PPMID
                                    AND R.rn = 1
                                    
                        END 
       
            END
       
	
    END
