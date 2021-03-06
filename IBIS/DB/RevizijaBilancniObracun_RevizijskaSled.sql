
EXEC dbo.DropPRCorUDF	@ObjectName = 'RevizijaBilancniObracun_RevizijskaSled'
GO


create PROCEDURE [dbo].[RevizijaBilancniObracun_RevizijskaSled]
(
    @DatumIntervalaDO AS DATETIME,
    @DatumIntervalaOD AS DATETIME,
    @DatumStanjaBaze AS DATETIME,
    @DatumVeljavnostiPodatkov AS DATETIME,
    @NewObracunID AS INT,
    @NOErrors AS INT OUTPUT,
    @Obracun AS int,
    @ObracunskoObdobjeID AS INT,
    @Bs AS XML,
    @ErrorHeadXML XML OUTPUT,
    @ErrorDetailsXML XML output
) AS
BEGIN
PRINT 'NO ERRORS'
PRINT @NOErrors
DECLARE @ObjektID INT;
DECLARE @PSEKREG INT;
DECLARE @PTERREG INT;

 if object_id('#Errors') is not null 
            drop table #Errors
        
        CREATE TABLE #Errors
            (
              ErrorID BIGINT IDENTITY(1, 1)
                             NOT NULL,
              Napaka VARCHAR(255) NOT NULL
            )

        if object_id('#ErrorDetail') is not null 
            drop table #ErrorDetail
        
        CREATE TABLE #ErrorDetail
            (
              ErrorID BIGINT,
              ErrorDetail VARCHAR(900) NOT NULL
            )


IF (@NOErrors = 0 AND @NewObracunID > 0)
		BEGIN
		
		if object_id('#BS') is not null
				drop table #BS

			CREATE TABLE #BS (
				BilancnaSkupinaID bigint
			)
		    IF (@Bs IS NOT null)
		    begin
				declare @hdocVTC int;
				declare @xmlpath varchar(255);
				set @xmlpath = '/SeznamBS/bskupine';
				exec sp_xml_preparedocument @hdocVTC OUTPUT, @Bs;

				insert into #BS (BilancnaSkupinaID)
				select bilancnaskupina
				from openxml(@hdocVTC,@xmlpath,2) with 
				(
					bilancnaskupina bigint
				)
				order by bilancnaskupina asc     
				exec sp_xml_removedocument @hdocVTC
			END
			
			--meritve
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'view_Meritve'
			AND ((@DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe)))
			
			IF ((SELECT COUNT(*) FROM #BS) = 0)
			BEGIN	
				INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
				SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				M.[ID],
				GETDATE()
				FROM
				[view_Meritve]  M 
					INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
					INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
				WHERE 
					M.[Interval] > @DatumIntervalaOD
				AND M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
				AND M.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
				AND PPM.[PPMTipID] <> 6
				AND P.Nivo > 0
		        AND ((@DatumStanjaBaze between PPM.DatumVnosa and dbo.infinite(PPM.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between PPM.VeljaOd and dbo.infinite(PPM.VeljaDo)))
				AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
				AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
				OPTION (MAXDOP 1)
				SET @NOErrors = @NOErrors +  @@ERROR
				IF (@NOErrors > 0)
					INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 015: Napaka pri ustvarjanju revizijske sledi - meritve.');

			END
			ELSE
			BEGIN
				INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
				SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				M.[ID],
				GETDATE()
				FROM 
					[view_Meritve]  M 
					INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
					INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
					INNER JOIN [#BS] BS ON (BS.[BilancnaSkupinaID] = P.ClanBSID)
				WHERE 
					M.[Interval] > @DatumIntervalaOD
				AND M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
				AND M.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
				AND PPM.[PPMTipID] <> 6
				AND P.Nivo > 0
		        AND ((@DatumStanjaBaze between PPM.DatumVnosa and dbo.infinite(PPM.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between PPM.VeljaOd and dbo.infinite(PPM.VeljaDo)))
				AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
				AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
				OPTION (MAXDOP 1)
				SET @NOErrors = @NOErrors +  @@ERROR
				IF (@NOErrors > 0)
					INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 016: Napaka pri ustvarjanju revizijske sledi - meritve.');

			END

			--POGODBA TIP
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'PogodbaTip'
			
			INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
			SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				P.[PogodbaTipID],
				GETDATE()
			FROM 
				PogodbaTip P
			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 017: Napaka pri ustvarjanju revizijske sledi - tip pogodbe.');

			 
			 
			--POGODBA
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'Pogodba'
			AND ((@DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe)))

			INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
			SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				P.[ID],
				GETDATE()
			FROM 
				[Pogodba] P
			WHERE
			   ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 018: Napaka pri ustvarjanju revizijske sledi - pogodbe.');

			--PPM TIP
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'PPMTip'
			
			INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
			SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				P.PPMTipID,
				GETDATE()
			FROM 
				PPMTip P
			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 019: Napaka pri ustvarjanju revizijske sledi - tip PPM.');

			 
			--PPM
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'PPM'
			AND ((@DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe)))
			
			IF ((SELECT COUNT(*) FROM #BS) = 0)
			BEGIN	
				INSERT INTO [Revizija] (
						[ObracunTipID],
						[ObracunID],
						[ObjektID],
						[ID],
						[Datum]
					)
				SELECT
					@Obracun,
					@NewObracunID,
					@ObjektID,
					PPM.[ID],
					GETDATE()
				FROM 
						[view_Meritve]  M 
						INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
						INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
				WHERE 
					M.[Interval] > @DatumIntervalaOD
				AND M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
				AND M.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
				AND PPM.[PPMTipID] <> 6
				AND P.Nivo > 0
		        AND ((@DatumStanjaBaze between PPM.DatumVnosa and dbo.infinite(PPM.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between PPM.VeljaOd and dbo.infinite(PPM.VeljaDo)))
				AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
				AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
				OPTION (MAXDOP 1)
				SET @NOErrors = @NOErrors +  @@ERROR
				IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 020: Napaka pri ustvarjanju revizijske sledi - PPM.');

				END
			ELSE
			BEGIN
				INSERT INTO [Revizija] (
						[ObracunTipID],
						[ObracunID],
						[ObjektID],
						[ID],
						[Datum]
					)
				SELECT
					@Obracun,
					@NewObracunID,
					@ObjektID,
					PPM.[ID],
					GETDATE()
				FROM 
						[view_Meritve]  M 
						INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
						INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
						INNER JOIN [#BS] BS ON (BS.[BilancnaSkupinaID] = P.ClanBSID)
				WHERE 
					M.[Interval] > @DatumIntervalaOD
				AND M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
				AND M.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
				AND PPM.[PPMTipID] <> 6
				AND P.Nivo > 0
		        AND ((@DatumStanjaBaze between PPM.DatumVnosa and dbo.infinite(PPM.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between PPM.VeljaOd and dbo.infinite(PPM.VeljaDo)))
				AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
				AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
				OPTION (MAXDOP 1)
				SET @NOErrors = @NOErrors +  @@ERROR
				IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 021: Napaka pri ustvarjanju revizijske sledi - PPM.');

			END
			
			--OSEBA
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'Oseba'
			AND ((@DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe)))
			
			INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
			SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				P.[ID],
				GETDATE()
			FROM 
				[Oseba] P
			WHERE
			   ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
			INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 022: Napaka pri ustvarjanju revizijske sledi - osebe.');

			 --OSEBA TIP
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'OsebaTip'
			
			INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
			SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				[OsebaTipID],
				GETDATE()
			FROM 
				[OsebaTipID] 
			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
			INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 023: Napaka pri ustvarjanju revizijske sledi - tip osebe.');

			 
			 
			 --Regulacija
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'Regulacija'
			AND ((@DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe)))
			
			INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
			SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				R.[ID],
				GETDATE()
			FROM [TrzniPlan] TP INNER JOIN Pogodba  P ON TP.[OsebaID] = P.Partner1
				left JOIN [Regulacija] R ON  TP.[Interval] = R.[Interval]
				LEFT JOIN PPM M ON M.[PPMID] = R.PPMID				
			WHERE 
				(P.[PogodbaTipID] = @PSEKREG OR P.[PogodbaTipID] = @PTERREG) 
--			AND	P.Partner2 = R.[OsebaID]
			AND (@DatumStanjaBaze between TP.[DatumVnosa] and dbo.infinite(TP.DatumSpremembe))
			AND (@DatumStanjaBaze between R.[DatumVnosa] and dbo.infinite(R.DatumSpremembe))
		        AND ((@DatumStanjaBaze between M.DatumVnosa and dbo.infinite(M.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between M.VeljaOd and dbo.infinite(M.VeljaDo)))
			AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
			INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 024: Napaka pri ustvarjanju revizijske sledi - regulacija.');

			 --Izravnava
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'Izravnava'
			AND ((@DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe)))


			INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
			SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				I.[ID],
				GETDATE()
			FROM [Izravnava] I
			WHERE
				I.Interval  BETWEEN @DatumIntervalaOD AND DATEADD(DAY,1,@DatumIntervalaDO)
			AND (@DatumStanjaBaze between I.[DatumVnosa] and dbo.infinite(I.DatumSpremembe))

			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
			INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 025: Napaka pri ustvarjanju revizijske sledi - izravnava.');


			 --CSLOEX
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'CSLOEX'
			AND ((@DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe)))
			
			INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
			SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				C.[ID],
				GETDATE()
			FROM 
				 [Izravnava] I INNER JOIN [SIPX] C ON I.Interval = C.Interval
			WHERE 
				I.Interval  BETWEEN @DatumIntervalaOD AND DATEADD(DAY,1,@DatumIntervalaDO)
			AND I.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
			AND (@DatumStanjaBaze between I.[DatumVnosa] and dbo.infinite(I.DatumSpremembe))

			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
			INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 026: Napaka pri ustvarjanju revizijske sledi - SIPX.');

			 --TrzniPlan
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'TrzniPlan'
			AND ((@DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe)))
			
			INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
			SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				T.[ID],
				GETDATE()
			FROM 
			[TolerancniPas] TP 
				INNER JOIN [TrzniPlan] T ON TP.[OsebaID] = T.OsebaID AND TP.[Interval] = T.[Interval] 
			WHERE 
				TP.[ObracunID] = @NewObracunID
			AND	TP.Interval  BETWEEN @DatumIntervalaOD AND DATEADD(DAY,1,@DatumIntervalaDO)
			AND (@DatumStanjaBaze between T.[DatumVnosa] and dbo.infinite(T.DatumSpremembe))

			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
			INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 027: Napaka pri ustvarjanju revizijske sledi - tržni plan.');
					

			--IZJEME
			--NOT USING THEM RIHGT NOW !!!?????!!!!
			
			--Izpadi
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'Izpadi'
			AND ((@DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe)))
			
			INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
			SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				I.ID,
				GETDATE()
			FROM 
				Oseba P INNER JOIN dbo.Izpadi I ON P.OsebaID = I.OsebaID
			WHERE 
				I.[Interval] > @DatumIntervalaOD
			AND I.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
			AND	((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
			AND ((@DatumStanjaBaze between I.[DatumVnosa] and dbo.infinite(I.DatumSpremembe)))

			
			--ObracunskoObdobje
			SELECT 
				@ObjektID = [ObjektID]  
			FROM [Objekt] 
			WHERE 
				[Naziv] = 'ObracunskoObdobje'
			AND ((@DatumStanjaBaze between [DatumVnosa] and dbo.infinite(DatumSpremembe)))
			
			INSERT INTO [Revizija] (
					[ObracunTipID],
					[ObracunID],
					[ObjektID],
					[ID],
					[Datum]
				)
			SELECT
				@Obracun,
				@NewObracunID,
				@ObjektID,
				T.ID,
				GETDATE()
			FROM 
				[ObracunskoObdobje] T
			WHERE 
				[ObracunskoObdobjeID] = @ObracunskoObdobjeID
			AND (@DatumStanjaBaze between T.[DatumVnosa] and dbo.infinite(T.DatumSpremembe))

			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
			INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 028: Napaka pri ustvarjanju revizijske sledi - obračunsko obdoboje.');

				
		END

IF (@NOErrors <> 0)
	BEGIN
		SET @ErrorHeadXML = (SELECT TOP 20 * FROM #Errors FOR XML PATH ('Napake'), ROOT ('Root'))		
		SET @ErrorDetailsXML = (SELECT TOP 50 * FROM #ErrorDetail FOR XML PATH ('ErrorDetail'), ROOT ('Root'))
	END
	ELSE
	BEGIN
		SET @ErrorHeadXML = NULL
		SET @ErrorDetailsXML = NULL
	END

	RETURN @NOErrors
END

