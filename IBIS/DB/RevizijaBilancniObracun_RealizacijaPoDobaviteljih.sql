/****** Object:  StoredProcedure [dbo].[RevizijaBilancniObracun_RealizacijaPoDobaviteljih]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevizijaBilancniObracun_RealizacijaPoDobaviteljih]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[RevizijaBilancniObracun_RealizacijaPoDobaviteljih]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevizijaBilancniObracun_RealizacijaPoDobaviteljih]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


create PROCEDURE [dbo].[RevizijaBilancniObracun_RealizacijaPoDobaviteljih]
(
    @BP AS INT,
    @Bs AS XML,
    @DatumIntervalaDO AS DATETIME,
    @DatumIntervalaOD AS DATETIME,
    @DatumStanjaBaze AS DATETIME,
    @DatumVeljavnostiPodatkov AS DATETIME,
    @NewObracunID AS INT,
    @NOErrors AS INT OUTPUT,
    @PI AS INT,
    @UDO_P_IZGUBE AS INT,
    @VIRT_ELES_MERITVE AS INT,
    @VIRT_MERJEN_ODDAJA AS INT,
    @VIRT_MERJENI_ODJEM AS INT,
    @VIRT_NEMERJEN_ODDAJA AS INT,
    @VIRT_NEMERJENI_ODJEM AS INT,
    @VIRT_REGULACIJA AS INT,
    @ErrorHeadXML XML OUTPUT,
    @ErrorDetailsXML XML output
) AS
BEGIN

 if object_id(''#Errors'') is not null 
            drop table #Errors
        
        CREATE TABLE #Errors
            (
              ErrorID BIGINT IDENTITY(1, 1)
                             NOT NULL,
              Napaka VARCHAR(255) NOT NULL
            )

        if object_id(''#ErrorDetail'') is not null 
            drop table #ErrorDetail
        
        CREATE TABLE #ErrorDetail
            (
              ErrorID BIGINT,
              ErrorDetail VARCHAR(900) NOT NULL
            )


			if object_id(''#BS'') is not null
				drop table #BS

			CREATE TABLE #BS (
				BilancnaSkupinaID bigint
			)
		    
		    IF (@Bs IS NOT null)
		    begin
				declare @hdocVTC int;
				declare @xmlpath varchar(255);
				set @xmlpath = ''/SeznamBS/bskupine'';
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
			--SODO MERITVE
			IF ((SELECT COUNT(*) FROM #BS) = 0)
			BEGIN
			print ''sodod if bs''
				INSERT INTO [RealizacijaPoDobaviteljih] (
					Kolicina,
					Oddaja,
					Odjem,
					Interval,
					OsebaID,
					Nivo,
					ObracunID,
					NadrejenaOsebaID,
					SistemskiOperaterID
				) 
				SELECT 
					
					SUM((CASE WHEN PPM.PPMTipID in (@VIRT_MERJENI_ODJEM,@VIRT_NEMERJENI_ODJEM,@UDO_P_IZGUBE) THEN ABS(M.Kolicina)
							  WHEN PPM.PPMTipID in (@VIRT_MERJEN_ODDAJA,@VIRT_NEMERJEN_ODDAJA) THEN -1*M.Kolicina
							  ELSE 0 end)),
					SUM((CASE WHEN PPM.PPMTipID in (@VIRT_MERJEN_ODDAJA,@VIRT_NEMERJEN_ODDAJA) THEN M.Kolicina ELSE 0 end)),
					SUM((CASE WHEN PPM.PPMTipID in (@VIRT_MERJENI_ODJEM,@VIRT_NEMERJENI_ODJEM,@UDO_P_IZGUBE) THEN ABS(M.Kolicina) ELSE 0 end)),
					M.[Interval],
					PPM.[Dobavitelj1],
					P.Nivo,
					@NewObracunID,
					NadrejenaOsebaID,
					PPM.SistemskiOperater1
				FROM 
				[view_Meritve]  M
				--	Meritve M
				INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
				INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]

				WHERE 
					M.[Interval] > @DatumIntervalaOD
				AND M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
				AND M.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
				AND (PPM.[PPMTipID] <> @VIRT_REGULACIJA )
				AND (PPM.[PPMTipID] <> @VIRT_ELES_MERITVE )
				AND PPM.[PPMTipID] IS NOT NULL
				AND P.Nivo > 0
				AND (P.[PogodbaTipID] =  @PI OR P.[PogodbaTipID] =  @BP)
		        AND ((@DatumStanjaBaze between PPM.DatumVnosa and dbo.infinite(PPM.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between PPM.VeljaOd and dbo.infinite(PPM.VeljaDo)))
				AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
				AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
				GROUP BY M.[Interval],P.Nivo,PPM.[Dobavitelj1],P.NadrejenaOsebaID,PPM.SistemskiOperater1
				OPTION (MAXDOP 1)
				
				SET @NOErrors = @NOErrors +  @@ERROR
				IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES (''Napaka 002: Napaka pri agregiranju realizacije po dobaviteljih (SODO).'');



			END
			ELSE
			BEGIN
				print''sodo else if bs''
				--samo določene BS
				INSERT INTO [RealizacijaPoDobaviteljih] (
					Kolicina,
					Oddaja,
					Odjem,
					Interval,
					OsebaID,
					Nivo,
					ObracunID,
					NadrejenaOsebaID,
					SistemskiOperaterID
				) 
				SELECT 
					SUM((CASE WHEN PPM.PPMTipID in (@VIRT_MERJENI_ODJEM,@VIRT_NEMERJENI_ODJEM,@UDO_P_IZGUBE) THEN ABS(M.Kolicina)
							  WHEN PPM.PPMTipID in (@VIRT_MERJEN_ODDAJA,@VIRT_NEMERJEN_ODDAJA) THEN -1*M.Kolicina
							  ELSE 0 end)),
					SUM((CASE WHEN PPM.PPMTipID in (@VIRT_MERJEN_ODDAJA,@VIRT_NEMERJEN_ODDAJA) THEN M.Kolicina ELSE 0 end)),
					SUM((CASE WHEN PPM.PPMTipID in (@VIRT_MERJENI_ODJEM,@VIRT_NEMERJENI_ODJEM,@UDO_P_IZGUBE) THEN ABS(M.Kolicina)  ELSE 0 end)),
					M.[Interval],
					PPM.[Dobavitelj1],
					P.Nivo,
					@NewObracunID,
					NadrejenaOsebaID,
					PPM.SistemskiOperater1
				FROM 
					[view_Meritve]  M 
					INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
					INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
					INNER JOIN [#BS] BS ON (BS.[BilancnaSkupinaID] = P.ClanBSID)
				WHERE 
					M.[Interval] > @DatumIntervalaOD
				AND M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
				AND M.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
				AND (PPM.[PPMTipID] <> @VIRT_REGULACIJA )
				AND (PPM.[PPMTipID] <> @VIRT_ELES_MERITVE)
				AND PPM.[PPMTipID] IS NOT NULL
				AND P.Nivo > 0
				AND (P.[PogodbaTipID] =  @PI OR P.[PogodbaTipID] =  @BP)
		        AND ((@DatumStanjaBaze between PPM.DatumVnosa and dbo.infinite(PPM.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between PPM.VeljaOd and dbo.infinite(PPM.VeljaDo)))
				AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
				AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
				GROUP BY M.[Interval],P.Nivo,PPM.[Dobavitelj1],P.NadrejenaOsebaID,PPM.SistemskiOperater1
				OPTION (MAXDOP 1)
				SET @NOErrors = @NOErrors +  @@ERROR
				IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES (''Napaka 003: Napaka pri agregiranju realizacije po dobaviteljih.'');



			END --SODO MERITVE
		
			
			--UPOŠTEVAMO ŠE SOPO MERITVE
			IF ((SELECT COUNT(*) FROM #BS) = 0)
			BEGIN --SOPO
			print ''if za sopo''
				INSERT INTO [RealizacijaPoDobaviteljih] (
					Kolicina,
					Oddaja,
					Odjem,
					Interval,
					OsebaID,
					Nivo,
					ObracunID,
					NadrejenaOsebaID,
					SistemskiOperaterID
				) 
				SELECT 
					SUM((
					(CASE WHEN PPMJeOddaja = 1 AND M.Kolicina < 0 THEN -1*M.Kolicina
						  WHEN PPMJeOddaja = 0 AND M.Kolicina >= 0 THEN M.Kolicina
						  ELSE 0
					END)
					 -
					 (CASE WHEN PPMJeOddaja = 1 AND M.Kolicina > 0 THEN M.Kolicina 
						  WHEN  PPMJeOddaja = 0 AND M.Kolicina < 0 THEN -1*M.Kolicina
						  ELSE 0
					 END)
					)),
					--oddaja
					SUM(
						(CASE WHEN PPMJeOddaja = 1 AND M.Kolicina > 0 THEN M.Kolicina 
						  WHEN  PPMJeOddaja = 0 AND M.Kolicina < 0 THEN -1*M.Kolicina
						  ELSE 0
						END)
					),
					--odjem
					SUM(
						(CASE WHEN PPMJeOddaja = 1 AND M.Kolicina < 0 THEN -1*M.Kolicina
						  WHEN PPMJeOddaja = 0 AND M.Kolicina >= 0 THEN  M.Kolicina
						  ELSE 0
						END)
					),
					M.[Interval],
					PPM.[Dobavitelj1],
					P.Nivo,
					@NewObracunID,
					NadrejenaOsebaID,
					PPM.SistemskiOperater1
				FROM 
				[view_Meritve]  M
				INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
				INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
				WHERE 
					M.[Interval] > @DatumIntervalaOD
				AND M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
				AND M.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
				AND (PPM.[PPMTipID] = @VIRT_ELES_MERITVE )
				AND P.Nivo > 0
				AND (P.[PogodbaTipID] =  @PI OR P.[PogodbaTipID] =  @BP)
		        AND ((@DatumStanjaBaze between PPM.DatumVnosa and dbo.infinite(PPM.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between PPM.VeljaOd and dbo.infinite(PPM.VeljaDo)))
				AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
				AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
				GROUP BY M.[Interval],P.Nivo,PPM.[Dobavitelj1],P.NadrejenaOsebaID,PPM.SistemskiOperater1
				OPTION (MAXDOP 1)
				
				SET @NOErrors = @NOErrors +  @@ERROR
				IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES (''Napaka 102: Napaka pri agregiranju realizacije po dobaviteljih (SOPO).'');



			END
			ELSE
			BEGIN
			print ''els if za sopo''
				--samo določene BS
				INSERT INTO [RealizacijaPoDobaviteljih] (
					Kolicina,
					Oddaja,
					Odjem,
					Interval,
					OsebaID,
					Nivo,
					ObracunID,
					NadrejenaOsebaID,
					SistemskiOperaterID
				) 
				SELECT 
					SUM((
					(CASE WHEN PPMJeOddaja = 1 AND M.Kolicina < 0 THEN -1*M.Kolicina
						  WHEN PPMJeOddaja = 0 AND M.Kolicina >= 0 THEN M.Kolicina
						  ELSE 0
					 END)
					 -
					 (CASE WHEN PPMJeOddaja = 1 AND M.Kolicina > 0 THEN M.Kolicina 
						  WHEN  PPMJeOddaja = 0 AND M.Kolicina < 0 THEN -1*M.Kolicina
						  ELSE 0
					END)
					)),
					--oddaja 1
					SUM((CASE WHEN PPMJeOddaja = 1 AND M.Kolicina > 0 THEN M.Kolicina 
						  WHEN  PPMJeOddaja = 0 AND M.Kolicina < 0 THEN -1*M.Kolicina
						  ELSE 0
					END)),
					-- odjem 1
					SUM((CASE WHEN PPMJeOddaja = 1 AND M.Kolicina < 0 THEN -1*M.Kolicina
						  WHEN PPMJeOddaja = 0 AND M.Kolicina >= 0 THEN M.Kolicina
						  ELSE 0
					 END)),
					M.[Interval],
					PPM.[Dobavitelj1],
					P.Nivo,
					@NewObracunID,
					NadrejenaOsebaID,
					PPM.SistemskiOperater1
				FROM 
					[view_Meritve]  M 
					INNER JOIN PPM PPM ON M.[PPMID] = PPM.[PPMID]
					INNER JOIN [Pogodba] P ON PPM.[Dobavitelj1] = P.[Partner2]
					INNER JOIN [#BS] BS ON (BS.[BilancnaSkupinaID] = P.ClanBSID)
				WHERE 
					M.[Interval] > @DatumIntervalaOD
				AND M.[Interval] <= DATEADD(DAY,1,@DatumIntervalaDO)
				AND M.[DatumVnosa] <= @DatumStanjaBaze--@DatumVeljavnostiPodatkov
				AND (PPM.[PPMTipID] = @VIRT_ELES_MERITVE)
				AND P.Nivo > 0
				AND (P.[PogodbaTipID] =  @PI OR P.[PogodbaTipID] =  @BP)
		        AND ((@DatumStanjaBaze between PPM.DatumVnosa and dbo.infinite(PPM.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between PPM.VeljaOd and dbo.infinite(PPM.VeljaDo)))
				AND (@DatumStanjaBaze between M.[DatumVnosa] and dbo.infinite(M.DatumSpremembe))
				AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
				GROUP BY M.[Interval],P.Nivo,PPM.[Dobavitelj1],P.NadrejenaOsebaID,PPM.SistemskiOperater1
				OPTION (MAXDOP 1)
				SET @NOErrors = @NOErrors +  @@ERROR
				IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES (''Napaka 103: Napaka pri agregiranju realizacije po dobaviteljih. (SOPO)'');
		
			END --SOPO MERITVE
			--END UPOŠTEVAMO ŠE SOPO MERITVE
			

		IF ((SELECT COUNT(*) FROM [RealizacijaPoDobaviteljih] WHERE ObracunID = @NewObracunID) > 0)
		BEGIN --imamo podatke za obračun
		PRINT ''agregiranje here''
			--AGREGIRANJE
			DECLARE @maxNivo INT
			SELECT 
				@maxNivo=MAX(Nivo) 
			FROM 
				[RealizacijaPoDobaviteljih] RPD 
			WHERE
				[ObracunID] = @NewObracunID
			SET @NOErrors = @NOErrors +  @@ERROR
			
			--PRINT ''Max nivo = ''+CAST(@maxNivo AS VARCHAR)
			
			
			WHILE (@maxNivo) > 2
			BEGIN
				
				UPDATE [RealizacijaPoDobaviteljih]
					SET [RealizacijaPoDobaviteljih].[Kolicina] = [RealizacijaPoDobaviteljih].[Kolicina] + RPD.Kolicina,
						[RealizacijaPoDobaviteljih].[Oddaja] = [RealizacijaPoDobaviteljih].[Oddaja] + RPD.[Oddaja],
						[RealizacijaPoDobaviteljih].[Odjem] = [RealizacijaPoDobaviteljih].[Odjem] + RPD.[Odjem]
				FROM [RealizacijaPoDobaviteljih] left JOIN 
								[RealizacijaPoDobaviteljih] RPD ON [RealizacijaPoDobaviteljih].[OsebaID] = RPD.[NadrejenaOsebaID] 
																	AND [RealizacijaPoDobaviteljih].[Interval] = RPD.[Interval] 
				WHERE 
					[RealizacijaPoDobaviteljih].[Nivo] = @maxNivo - 1
				AND RPD.[Nivo] = @maxNivo 
				AND RPD.OsebaID <> [RealizacijaPoDobaviteljih].[OsebaID]
				SET @NOErrors = @NOErrors +  @@ERROR
				IF (@NOErrors > 0)
					INSERT INTO [#Errors] ([Napaka]) VALUES (''Napaka 005: Napaka pri agregaciji navzgor.'');

					
				UPDATE [RealizacijaPoDobaviteljih]	SET [Nivo] = [Nivo] - 1 
				WHERE [ObracunID] = @NewObracunID AND [Nivo] = @maxNivo
				SET @NOErrors = @NOErrors +  @@ERROR
				SET @maxNivo = @maxNivo - 1
				PRINT @maxNivo
				
				IF (SELECT MAX(Nivo) FROM [RealizacijaPoDobaviteljih] WHERE [ObracunID] = @NewObracunID) = 2
				  BREAK
				ELSE
				  CONTINUE
			END
		
		END

	IF (@NOErrors <> 0)
	BEGIN
		SET @ErrorHeadXML = (SELECT TOP 20 * FROM #Errors FOR XML PATH (''Napake''), ROOT (''Root''))		
		SET @ErrorDetailsXML = (SELECT TOP 50 * FROM #ErrorDetail FOR XML PATH (''ErrorDetail''), ROOT (''Root''))
	END
	ELSE
	BEGIN
		SET @ErrorHeadXML = NULL
		SET @ErrorDetailsXML = NULL
	END

END




' 
END
GO
