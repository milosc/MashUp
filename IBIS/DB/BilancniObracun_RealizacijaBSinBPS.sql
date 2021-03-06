EXEC [dbo].[DropPRCorUDF]	@ObjectName = 'BilancniObracun_RealizacijaBSinBPS' 
GO

CREATE PROCEDURE [dbo].[BilancniObracun_RealizacijaBSinBPS]
(
    @BP AS INT,
    @DatumStanjaBaze AS DATETIME,
    @DatumVeljavnostiPodatkov AS DATETIME,
    @NewObracunID AS INT,
    @NOErrors AS INT OUTPUT,
    @PI AS INT,
    @ErrorHeadXML XML OUTPUT,
    @ErrorDetailsXML XML output
) AS
BEGIN

		
		
			INSERT INTO [RealizacijaPoBPS] (
				[ObracunID],
				[OsebaID],
				[Interval],
				[Kolicina],
				Oddaja,
				Odjem
			) 
			SELECT 
				@NewObracunID,
				[OsebaID],
				[Interval],
				0 ,
				SUM(Oddaja) AS Oddaja,
				SUM(Odjem) AS Odjem
				
			FROM 
				[RealizacijaPoDobaviteljih] RPD INNER JOIN [Pogodba] P ON RPD.[OsebaID] = P.[Partner2] AND (P.[PogodbaTipID]=@PI)
			AND (((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe))) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))

			WHERE
				[ObracunID] = @NewObracunID
			GROUP BY [OsebaID],Interval

			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 006: Napaka pri izračunu realizacije po bilančnih pod skupinah.');

				
--			izračun po BS
			INSERT INTO [RealizacijaPoBS] (
				[ObracunID],
				[OsebaID],
				[Interval],
				[Kolicina],
				Oddaja,
				Odjem
			) 
			SELECT 
				@NewObracunID,
				P.[ClanBSID],
				[Interval],
				0,
				SUM(Oddaja) AS Oddaja,
				SUM(Odjem) AS Odjem	
			FROM 
				[RealizacijaPoDobaviteljih] RPD INNER JOIN [Pogodba] P ON RPD.[OsebaID] = P.[Partner2] 
			AND (P.[PogodbaTipID]=@BP OR P.[PogodbaTipID]=@PI)
			AND (((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)))
				 and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
			WHERE
				[ObracunID] = @NewObracunID
			GROUP BY Interval,P.[ClanBSID]
			
			SET @NOErrors = @NOErrors +  @@ERROR    
			IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES ('Napaka 007: Napaka pri izračunu realizacije po bilančnih skupinah.')

	UPDATE [RealizacijaPoBPS]
		SET [Kolicina] = ROUND(Odjem - [Oddaja],3)
		WHERE [ObracunID] = @NewObracunID
		
		UPDATE [RealizacijaPoBS]
		SET [Kolicina] = ROUND(Odjem - [Oddaja],3)
		WHERE [ObracunID] = @NewObracunID
		
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
END

GO
