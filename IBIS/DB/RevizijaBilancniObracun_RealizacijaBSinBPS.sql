/****** Object:  StoredProcedure [dbo].[RevizijaBilancniObracun_RealizacijaBSinBPS]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevizijaBilancniObracun_RealizacijaBSinBPS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[RevizijaBilancniObracun_RealizacijaBSinBPS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevizijaBilancniObracun_RealizacijaBSinBPS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[RevizijaBilancniObracun_RealizacijaBSinBPS]
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
				SUM(Kolicina) AS Realizacija,
				SUM(Oddaja) AS Oddaja,
				SUM(Odjem) AS Odjem
				
			FROM 
				[RealizacijaPoDobaviteljih] RPD INNER JOIN [Pogodba] P ON RPD.[OsebaID] = P.[Partner2] AND (P.[PogodbaTipID]=@PI)
			AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe)) and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))

			WHERE
				[ObracunID] = @NewObracunID
			GROUP BY [OsebaID],Interval
		--	ORDER BY [Interval] asc,[OsebaID] ASC
			SET @NOErrors = @NOErrors +  @@ERROR
			IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES (''Napaka 006: Napaka pri izračunu realizacije po bilančnih pod skupinah.'');

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
				SUM(Kolicina) AS Realizacija,
				SUM(Oddaja) AS Oddaja,
				SUM(Odjem) AS Odjem	
			FROM 
				[RealizacijaPoDobaviteljih] RPD INNER JOIN [Pogodba] P ON RPD.[OsebaID] = P.[Partner2] 
			AND (P.[PogodbaTipID]=@BP OR P.[PogodbaTipID]=@PI)
			AND ((@DatumStanjaBaze between P.DatumVnosa and dbo.infinite(P.DatumSpremembe))
				 and (@DatumVeljavnostiPodatkov between P.VeljaOd and dbo.infinite(P.VeljaDo)))
			WHERE
				[ObracunID] = @NewObracunID
			GROUP BY Interval,P.[ClanBSID]
		--	ORDER BY [Interval] asc,P.[ClanBSID] ASC
			
			SET @NOErrors = @NOErrors +  @@ERROR    
			IF (@NOErrors > 0)
				INSERT INTO [#Errors] ([Napaka]) VALUES (''Napaka 007: Napaka pri izračunu realizacije po bilančnih skupinah.'')

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
