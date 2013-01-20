

EXEC [dbo].[DropPRCorUDF] @ObjectName = 'EIP_ResolvePPM' 
GO

CREATE PROCEDURE [dbo].[EIP_ResolvePPM]
    @partnerCode1 VARCHAR(250), --DOBAVITELJ
    @partnerCode2 VARCHAR(250), --SISTEMSKIOPERATER
    @senderCode VARCHAR(250), --PošiljateljPaketavDES
    @businessType VARCHAR(50),
    @direction VARCHAR(50),
    @meteringMethod VARCHAR(50),
    @DatumVeljavnostiPodatkov DATETIME = GETDATE,
    @DatumStanjaBaze DATETIME = GETDATE,
	@jePPMOddaja int output
AS 
    BEGIN
		set @jePPMOddaja=-1;
        DECLARE @PPMID INT ;
        DECLARE @PPMTipID INT ;
        SET @PPMID = -1 ;
	
        DECLARE @VIRT_MERJENI_ODJEM INT
        DECLARE @VIRT_NEMERJENI_ODJEM INT
        DECLARE @VIRT_MERJEN_ODDAJA INT
        DECLARE @VIRT_NEMERJEN_ODDAJA INT 
        DECLARE @VIRT_REGULACIJA INT
        DECLARE @VIRT_ELES_ODJEM INT
        DECLARE @VIRT_ELES_ODDAJA INT
        DECLARE @VIRT_PBI INT
        DECLARE @VIRT_DSP INT
        DECLARE @PO_SIS INT
        DECLARE @UDO_P_MERJENI INT
        DECLARE @UDO_P_NEMERJENI INT
        DECLARE @UDO_P_IZGUBE INT
        DECLARE @MP_SKUPAJ INT
        DECLARE @MP_ND_NEMERJENI INT
        DECLARE @MP_ND_MERJENI INT
        DECLARE @MP_NP_NEMERJENI INT
        DECLARE @MP_NP_MERJENI INT
        DECLARE @MP_KP_NEMERJENI INT
        DECLARE @MP_KP_MERJENI INT
        DECLARE @VIRT_ELES_MERITVE INT
        DECLARE @MEJE INT
        DECLARE @ND_EL_PR INT
        DECLARE @ND_EL_MB INT
        DECLARE @ND_EL_LJ INT
        DECLARE @ND_EL_GO INT
        DECLARE @ND_EL_CE INT
        DECLARE @VIRT_ELES_MERITVE_PREVZEM_SODO INT
    
        SELECT  @VIRT_ELES_MERITVE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SOPO) VIRT_ELES_MERITVE' ;

		SELECT  @PO_SIS = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = 'PO_SIS' ;

        SELECT  @VIRT_MERJENI_ODJEM = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) VIRT_MERJENI_ODJEM' ;

        SELECT  @VIRT_NEMERJENI_ODJEM = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) VIRT_NEMERJENI_ODJEM' ;

        SELECT  @VIRT_MERJEN_ODDAJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) VIRT_MERJEN_ODDAJA' ;

        SELECT  @VIRT_NEMERJEN_ODDAJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) VIRT_NEMERJEN_ODDAJA' ;

        SELECT  @VIRT_REGULACIJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(REG) VIRT_REGULACIJA' ;

        SELECT  @VIRT_ELES_ODJEM = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = 'VIRT_ELES_ODJEM' ;

        SELECT  @VIRT_ELES_ODDAJA = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = 'VIRT_ELES_ODDAJA' ;

        SELECT  @VIRT_PBI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) VIRT_PBI' ;

        SELECT  @VIRT_DSP = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) VIRT_DSP' ;

        SELECT  @UDO_P_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) UDO_P_MERJENI' ;

        SELECT  @UDO_P_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) UDO_P_NEMERJENI' ;

        SELECT  @UDO_P_IZGUBE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) UDO_P_IZGUBE' ;

        SELECT  @MP_SKUPAJ = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) MP_SKUPAJ' ;

        SELECT  @MP_ND_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) MP_ND_NEMERJENI' ;

        SELECT  @MP_ND_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) MP_ND_MERJENI' ;

        SELECT  @MP_NP_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) MP_NP_NEMERJENI' ;

        SELECT  @MP_NP_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) MP_NP_MERJENI' ;

        SELECT  @MP_KP_NEMERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) MP_KP_NEMERJENI' ;

        SELECT  @MP_KP_MERJENI = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) MP_KP_MERJENI' ;

        SELECT  @MEJE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = 'MEJE' ;

        SELECT  @ND_EL_PR = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) ND_EL_PR' ;

        SELECT  @ND_EL_MB = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) ND_EL_MB' ;

        SELECT  @ND_EL_LJ = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) ND_EL_LJ' ;

        SELECT  @ND_EL_GO = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) ND_EL_GO' ;

        SELECT  @ND_EL_CE = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SODO) ND_EL_CE' ;
  
        SELECT  @VIRT_ELES_MERITVE_PREVZEM_SODO = [PPMTipID]
        FROM    [PPMTip]
        WHERE   LTRIM(RTRIM(Naziv)) = '(SOPO) VIRT_ELES_MERITVE_PREVZEM_SODO' ;

        IF ( UPPER(@businessType) = 'DO_PRO'
             AND UPPER(@meteringMethod) = 'METERED'
             AND UPPER(@direction) = 'NEGATIVE'
           ) --MERJEN ODJEM
            SET @PPMTipID = @VIRT_MERJENI_ODJEM
        ELSE 
            IF ( UPPER(@businessType) = 'DO_PRO'
                 AND UPPER(@meteringMethod) = 'UNMETERED'
                 AND UPPER(@direction) = 'NEGATIVE'
               ) --NEMERJEN ODJEM
                SET @PPMTipID = @VIRT_NEMERJENI_ODJEM
            ELSE 
            IF ( UPPER(@businessType) = 'PO_SIS'
               ) --Sistemska Izravnava
                SET @PPMTipID = @PO_SIS
            ELSE 
            IF ( UPPER(@businessType) = 'DO_OMR'
                 AND UPPER(@meteringMethod) = 'METERED'
               ) --NEREGULIRANA DOBAVA
               BEGIN
              
                IF (@partnerCode2 = '28YELEKTROGOR--P')
		            SET @PPMTipID = @ND_EL_GO
		        ELSE
		        IF (@partnerCode2 = '28YELEKTROCE---Q')
		            SET @PPMTipID = @ND_EL_CE
		        ELSE
		        IF (@partnerCode2 = '28YELEKTROMB---I')
		            SET @PPMTipID = @ND_EL_MB
		        ELSE
		        IF (@partnerCode2 = '28YELEKTROPRIM-Y')
		            SET @PPMTipID = @ND_EL_PR
		        ELSE
		        IF (@partnerCode2 = '28YELEKTROLJ---L')
		            SET @PPMTipID = @ND_EL_LJ
				ELSE
				IF (@partnerCode2 = '10YSI-ELES-----O')
		            SET @PPMTipID = @VIRT_ELES_ODJEM
  
               END 
                ELSe
                IF ( UPPER(@businessType) = 'DO_PRO'
                     AND UPPER(@meteringMethod) = 'METERED'
                     AND UPPER(@direction) = 'POSITIVE'
                   ) --MERJENA ODDAJA
                    SET @PPMTipID = @VIRT_MERJEN_ODDAJA
                ELSE 
                    IF ( UPPER(@businessType) = 'DO_PRO'
                         AND UPPER(@meteringMethod) = 'UNMETERED'
                         AND UPPER(@direction) = 'POSITIVE'
                       ) --NEMERJENA ODDAJA
                        SET @PPMTipID = @VIRT_NEMERJEN_ODDAJA
                    ELSE 
                        IF ( UPPER(@businessType) = 'DO_IZG' ) -- IZGUBE 
                            SET @PPMTipID = @UDO_P_IZGUBE
                        ELSE 
                            IF ( UPPER(@businessType) = 'DO_PO' ) -- SOPO 
                                SET @PPMTipID = @UDO_P_IZGUBE	
                            ELSE 
                                IF ( UPPER(@businessType) = 'PO_IZG' ) -- IZGUBE SOPO 
                                    SET @PPMTipID = @VIRT_ELES_MERITVE	
                           
        IF ( UPPER(@businessType) = 'DO_OMR'
--             AND UPPER(@direction) = 'NEGATIVE'
           ) 
            BEGIN
             
				IF (@PPMTipID IN (@ND_EL_PR,@ND_EL_GO,@ND_EL_LJ,@ND_EL_MB,@ND_EL_CE))
				BEGIN --neregulirana dobava
                SELECT  @PPMID = P.PPMID,
						@jePPMOddaja = P.PPMJeOddaja
                FROM    PPM P
                        JOIN [dbo].[Oseba] Od ON P.[SistemskiOperater1] = Od.[OsebaID]
                                                 AND Od.[EIC] = @partnerCode1
                WHERE   P.PPMTipID = @PPMTipID
                        AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                               AND     dbo.infinite(P.DatumSpremembe) )
                        AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                        AND     dbo.infinite(P.VeljaDo) )
                        AND ( @DatumStanjaBaze BETWEEN Od.DatumVnosa
                                               AND     dbo.infinite(Od.DatumSpremembe) )
                        AND ( @DatumVeljavnostiPodatkov BETWEEN Od.VeljaOd
                                                        AND     dbo.infinite(Od.VeljaDo) )
                RETURN @PPMID
                END
                ELSE
                IF (@PPMTipID = @VIRT_ELES_ODJEM)
                BEGIN --Prevzem sopo
                
					SELECT  @PPMID = P.PPMID,
									@jePPMOddaja = P.PPMJeOddaja
                FROM    PPM P
                        JOIN [dbo].[Oseba] Od ON P.[SistemskiOperater1] = Od.[OsebaID]
                                                 AND Od.[EIC] = @partnerCode1
                WHERE   P.PPMTipID = @PPMTipID
                        AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                               AND     dbo.infinite(P.DatumSpremembe) )
                        AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                        AND     dbo.infinite(P.VeljaDo) )
                        AND ( @DatumStanjaBaze BETWEEN Od.DatumVnosa
                                               AND     dbo.infinite(Od.DatumSpremembe) )
                        AND ( @DatumVeljavnostiPodatkov BETWEEN Od.VeljaOd
                                                        AND     dbo.infinite(Od.VeljaDo) )
				END
              
            END
        ELSE 
         IF ( UPPER(@businessType) = 'DO_PRO') 
            BEGIN --SODO MERITVE PO DOBAVITELJIH
                SELECT  @PPMID = P.PPMID,
								@jePPMOddaja = P.PPMJeOddaja
                FROM    PPM P
						JOIN [dbo].[Oseba] Os ON P.[SistemskiOperater1] = Os.[OsebaID]
                                                     AND Os.[EIC] = @partnerCode1
                        JOIN [dbo].[Oseba] Od ON P.[Dobavitelj1] = Od.[OsebaID]
                                                 AND Od.[EIC] = @partnerCode2
                WHERE   P.PPMTipID = @PPMTipID
                        AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                               AND     dbo.infinite(P.DatumSpremembe) )
                        AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                        AND     dbo.infinite(P.VeljaDo) )
                        AND ( @DatumStanjaBaze BETWEEN Od.DatumVnosa
                                               AND     dbo.infinite(Od.DatumSpremembe) )
                        AND ( @DatumVeljavnostiPodatkov BETWEEN Od.VeljaOd
                                                        AND     dbo.infinite(Od.VeljaDo) )
                                                        AND ( @DatumStanjaBaze BETWEEN Od.DatumVnosa
                        AND     dbo.infinite(Os.DatumSpremembe) )
                        AND ( @DatumVeljavnostiPodatkov BETWEEN Os.VeljaOd
                                                        AND     dbo.infinite(Os.VeljaDo) )
                RETURN @PPMID
            END
        ELSE 
            IF ( UPPER(@businessType) = 'PO_PRO'
                 --AND UPPER(@direction) = 'POSITIVE' --SPREMNEIL 15.10 zaradi SOPO ELEKTRARN
               ) 
                BEGIN
                    SELECT  @PPMID = P.PPMID,
									@jePPMOddaja = P.PPMJeOddaja
                    FROM    PPM P
                            JOIN [dbo].[Oseba] Od ON P.[Dobavitelj1] = Od.[OsebaID]
                                                     AND Od.[EIC] = @partnerCode1
                    WHERE   P.EIC = @partnerCode2
                            AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                   AND     dbo.infinite(P.DatumSpremembe) )
                            AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                            AND     dbo.infinite(P.VeljaDo) )
                            AND ( @DatumStanjaBaze BETWEEN Od.DatumVnosa
                                                   AND     dbo.infinite(Od.DatumSpremembe) )
                            AND ( @DatumVeljavnostiPodatkov BETWEEN Od.VeljaOd
                                                            AND     dbo.infinite(Od.VeljaDo) )
                   
					IF (@PPMID IS NULL OR @PPMID < 0)
					BEGIN --poskus pridobitve preko PPM

						SELECT  @PPMID = P.PPMID,
										@jePPMOddaja = P.PPMJeOddaja
						FROM    PPM P
						WHERE   P.EIC = @partnerCode2 
								AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
													   AND     dbo.infinite(P.DatumSpremembe) )
								AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
																AND     dbo.infinite(P.VeljaDo) )
							
					END
					
                    RETURN @PPMID
                END
            ELSE 
                IF ( UPPER(@businessType) = 'PO_SEK' OR UPPER(@businessType) = 'PO_TER') 
                    BEGIN
						
                        SELECT  @PPMID = P.PPMID,
										@jePPMOddaja = P.PPMJeOddaja
                        FROM    PPM P
                                JOIN [dbo].[Oseba] Os ON P.[Dobavitelj1] = Os.[OsebaID] AND Os.[EIC] = @partnerCode2
                        WHERE   P.[PPMTipID] = @VIRT_REGULACIJA
                                AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                       AND     dbo.infinite(P.DatumSpremembe) )
                                AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                AND     dbo.infinite(P.VeljaDo) )
                        RETURN @PPMID
                    END
                        ELSE 
                            IF ( UPPER(@businessType) = 'PO_SIS'
                                 AND UPPER(@direction) = 'POSITIVE'
                               ) 
                                BEGIN
									SELECT  @PPMID = P.PPMID,
													@jePPMOddaja = P.PPMJeOddaja
									FROM    PPM P
											JOIN [dbo].[Oseba] Os ON P.[Dobavitelj1] = Os.[OsebaID] AND Os.[EIC] = @partnerCode2
									WHERE   P.[PPMTipID] = @PO_SIS
											AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
																   AND     dbo.infinite(P.DatumSpremembe) )
											AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
																			AND     dbo.infinite(P.VeljaDo) )
			                                                                
                                    RETURN @PPMID
                                END
                            ELSE 
                                IF ( UPPER(@businessType) = 'PO_SIS'
                                     AND UPPER(@direction) = 'NEGATIVE'
                                   ) 
                                    BEGIN
                                   SELECT  @PPMID = P.PPMID,
								   				@jePPMOddaja = P.PPMJeOddaja
									FROM    PPM P
											JOIN [dbo].[Oseba] Os ON P.[Dobavitelj1] = Os.[OsebaID] AND Os.[EIC] = @partnerCode2
									WHERE   P.[PPMTipID] = @PO_SIS
											AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
																   AND     dbo.infinite(P.DatumSpremembe) )
											AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
																			AND     dbo.infinite(P.VeljaDo) )
			                                                                
                                    RETURN @PPMID
                                    
                                        RETURN @PPMID
                                    END
                                ELSE 
                                    IF ( UPPER(@businessType) = 'PO_PO' ) 
                                        BEGIN
                                            SELECT  @PPMID = P.PPMID,
															@jePPMOddaja = P.PPMJeOddaja
                                            FROM    PPM P
                                            WHERE   P.EIC = @partnerCode2
                                                    AND P.PPMTipID = @VIRT_ELES_MERITVE
                                                    AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                                           AND     dbo.infinite(P.DatumSpremembe) )
                                                    AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                                    AND     dbo.infinite(P.VeljaDo) )
																				
                                                        
                                            RETURN @PPMID
                                        END
                                                                 
                                                                    
            
        IF ( UPPER(@businessType) = 'DO_IZG' ) 
            BEGIN
                    SELECT  @PPMID = P.PPMID,
									@jePPMOddaja = P.PPMJeOddaja
                    FROM    PPM P
                            JOIN [dbo].[Oseba] Od ON P.[SistemskiOperater1] = Od.[OsebaID]
                                                     AND Od.[EIC] = @partnerCode1
                    WHERE   P.[PPMTipID] = @PPMTipID
							AND P.EIC = @senderCode
                            AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                   AND     dbo.infinite(P.DatumSpremembe) )
                            AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                            AND     dbo.infinite(P.VeljaDo) )
                            AND ( @DatumStanjaBaze BETWEEN Od.DatumVnosa
                                                   AND     dbo.infinite(Od.DatumSpremembe) )
                            AND ( @DatumVeljavnostiPodatkov BETWEEN Od.VeljaOd
                                                            AND     dbo.infinite(Od.VeljaDo) )
                RETURN @PPMID
            END
        ELSE 
            IF ( UPPER(@businessType) = 'DO_PRO' ) 
                BEGIN	
                    SELECT  @PPMID = P.PPMID,
									@jePPMOddaja = P.PPMJeOddaja
                    FROM    PPM P
                            JOIN [dbo].[Oseba] Od ON P.[SistemskiOperater1] = Od.[OsebaID]
                                                     AND Od.[EIC] = @partnerCode1
                            JOIN [dbo].[Oseba] Os ON P.[Dobavitelj1] = Os.[OsebaID]
                                                     AND Os.[EIC] = @partnerCode2
                    WHERE   P.[PPMTipID] = @PPMTipID
                            AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                   AND     dbo.infinite(P.DatumSpremembe) )
                            AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                            AND     dbo.infinite(P.VeljaDo) )
                            AND ( @DatumStanjaBaze BETWEEN Od.DatumVnosa
                                                   AND     dbo.infinite(Od.DatumSpremembe) )
                            AND ( @DatumVeljavnostiPodatkov BETWEEN Od.VeljaOd
                                                            AND     dbo.infinite(Od.VeljaDo) )
                            AND ( @DatumStanjaBaze BETWEEN Os.DatumVnosa
                                                   AND     dbo.infinite(Os.DatumSpremembe) )
                            AND ( @DatumVeljavnostiPodatkov BETWEEN Os.VeljaOd
                                                            AND     dbo.infinite(Os.VeljaDo) )
                END
            ELSE 
                IF ( UPPER(@businessType) = 'PO_IZG' ) 
                    BEGIN	
                        SELECT  @PPMID = P.PPMID,
										@jePPMOddaja = P.PPMJeOddaja
                        FROM    PPM P
                                JOIN [dbo].[Oseba] Od ON P.Dobavitelj1 = Od.[OsebaID]
                                                         AND Od.[EIC] = @senderCode
                        WHERE   P.[PPMTipID] = @PPMTipID
                                AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                       AND     dbo.infinite(P.DatumSpremembe) )
                                AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                AND     dbo.infinite(P.VeljaDo) )
                                AND ( @DatumStanjaBaze BETWEEN Od.DatumVnosa
                                                       AND     dbo.infinite(Od.DatumSpremembe) )
                                AND ( @DatumVeljavnostiPodatkov BETWEEN Od.VeljaOd
                                                                AND     dbo.infinite(Od.VeljaDo) )
                    END
                ELSE 
                    IF ( UPPER(@businessType) = 'DO_PO' ) 
                        BEGIN	
                            SELECT  @PPMID = P.PPMID,
											@jePPMOddaja = P.PPMJeOddaja
                            FROM    PPM P
                                    JOIN [dbo].[Oseba] Od ON P.[SistemskiOperater1] = Od.[OsebaID]
                                                             AND Od.[EIC] = @partnerCode1
                                    JOIN [dbo].[Oseba] Os ON P.[Dobavitelj1] = Os.[OsebaID]
                                                             AND Os.[EIC] = @partnerCode2
                            WHERE   P.[PPMTipID] = @PPMTipID
                                    AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                           AND     dbo.infinite(P.DatumSpremembe) )
                                    AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                    AND     dbo.infinite(P.VeljaDo) )
                                    AND ( @DatumStanjaBaze BETWEEN Od.DatumVnosa
                                                           AND     dbo.infinite(Od.DatumSpremembe) )
                                    AND ( @DatumVeljavnostiPodatkov BETWEEN Od.VeljaOd
                                                                    AND     dbo.infinite(Od.VeljaDo) )
                                    AND ( @DatumStanjaBaze BETWEEN Os.DatumVnosa
                                                           AND     dbo.infinite(Os.DatumSpremembe) )
                                    AND ( @DatumVeljavnostiPodatkov BETWEEN Os.VeljaOd
                                                                    AND     dbo.infinite(Os.VeljaDo) )
                        END
                    ELSE 
                        IF ( UPPER(@businessType) = 'DO_DO' ) 
                            BEGIN	
                                SELECT  @PPMID = P.PPMID,
												@jePPMOddaja = P.PPMJeOddaja
                                FROM    PPM P
                                        JOIN [dbo].[Oseba] Od ON P.[SistemskiOperater1] = Od.[OsebaID]
                                                                 AND Od.[EIC] = @partnerCode1
                                        JOIN [dbo].[Oseba] Os ON P.[Dobavitelj1] = Os.[OsebaID]
                                                                 AND Os.[EIC] = @partnerCode2
                                WHERE   P.[PPMTipID] = @PPMTipID
                                        AND ( @DatumStanjaBaze BETWEEN P.DatumVnosa
                                                               AND     dbo.infinite(P.DatumSpremembe) )
                                        AND ( @DatumVeljavnostiPodatkov BETWEEN P.VeljaOd
                                                                        AND     dbo.infinite(P.VeljaDo) )
                                        AND ( @DatumStanjaBaze BETWEEN Od.DatumVnosa
                                                               AND     dbo.infinite(Od.DatumSpremembe) )
                                        AND ( @DatumVeljavnostiPodatkov BETWEEN Od.VeljaOd
                                                                        AND     dbo.infinite(Od.VeljaDo) )
                                        AND ( @DatumStanjaBaze BETWEEN Os.DatumVnosa
                                                               AND     dbo.infinite(Os.DatumSpremembe) )
                                        AND ( @DatumVeljavnostiPodatkov BETWEEN Os.VeljaOd
                                                                        AND     dbo.infinite(Os.VeljaDo) )
                            END
	

        RETURN @PPMID ; 
    END
