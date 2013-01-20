exec DropPRCorUDF 'MDM_Oseba_Sync'
GO

CREATE PROCEDURE [dbo].[MDM_Oseba_Sync]
@NAZIV varchar(140),
@NASLOV varchar(50),
@HISNA_ST varchar(10),
@POSTA_KODA varchar(10),
@POSTA_KRAJ varchar(50),
@KRAJ varchar(50),
@DRZAVA_KODA varchar(2),
@DRZAVA_NAZIV varchar(140),
@TELEFON varchar(25),
@FAX varchar(25),
@EMAIL varchar(100),
@STATUS_PARTNERJA_OPIS varchar(50),
@EIC_KODA varchar(25),
@VELJAVNO_OD DATETIME ,
@VELJAVNO_DO DATETIME,
@DatumVeljavnostiPodatkov DATETIME = GETDATE,
@DatumStanjaBaze DATETIME = GETDATE,
@DRZAVA_ID int,
@POSTA_ID int,
@STATUS_PARTNERJA_ID int
AS 
    BEGIN

		declare @MinDate dateTime = '20000101'
		declare @MaxDate datetime = dateadd(year,100,getdate());
		declare @ActualVeljaOD datetime

		if (@VELJAVNO_DO > @MaxDate) set @VELJAVNO_DO = NULL;

		if (@VELJAVNO_OD < @MinDate) set @VELJAVNO_OD = @MinDate;

		declare @ResultCode int;
		set @ResultCode=-1;

		declare @DrzavaSlo int = 1;
		declare @MDMDrzavaID int;

		select @MDMDrzavaID=DrzavaID from Drzava where Okrajsava = @DRZAVA_KODA
		if (@MDMDrzavaID is null)
			set @MDMDrzavaID = @DrzavaSlo;

		if (ltrim(rtrim(isnull(@EIC_KODA,''))) <> '')
		BEGIN /*EIC OBSTAJA*/
			/*Postavimo v "zgodovino"*/
			BEGIN TRAN SyncMDM

			SELECT 
			   [OsebaID]
			  ,[OsebaSkupinaTipID]
			  ,[EIC]
			  ,[VeljaOd]
			  ,[VeljaDo]
			  ,[Naziv]
			  ,[Kratica]
			  ,[Ime]
			  ,[Priimek]
			  ,[Naslov]
			  ,[HisnaStevilka]
			  ,[Kraj]
			  ,[Posta]
			  ,[Drzava]
			  ,[OdgovornaOseba1]
			  ,[OdgovornaOseba2]
			  ,[Telefon]
			  ,[Fax]
			  ,[SpletnaStran]
			  ,[Email]
			  ,[Avtor]
			  ,[VrstniRedExcelUvoz]
			  ,[DatumVnosa]
			  ,[DatumSpremembe]
			INTO #OsebaToRefresh
			from 
			Oseba O 
			where O.EIC = @EIC_KODA
			AND @DatumStanjaBaze BETWEEN O.[DatumVnosa]  AND dbo.infinite(O.DatumSpremembe)
            AND @DatumVeljavnostiPodatkov BETWEEN O.VeljaOd AND dbo.infinite(O.VeljaDo)
			
			if (@@ROWCOUNT <> 0)
			BEGIN /*oseba že obstaja ...sync*/

					select @ActualVeljaOD =  [VeljaDo] from #OsebaToRefresh
					if (@ActualVeljaOD > @VELJAVNO_OD) set @VELJAVNO_OD=@ActualVeljaOD;

					UPDATE Oseba
					SET DatumSpremembe=getdate(),
						VeljaDo = getdate()
					where EIC = @EIC_KODA
					AND @DatumStanjaBaze BETWEEN [DatumVnosa]  AND dbo.infinite(DatumSpremembe)
					AND @DatumVeljavnostiPodatkov BETWEEN VeljaOd AND dbo.infinite(VeljaDo)
					if (@@ERROR <> 0 or @@ROWCOUNT <> 1)
						set @ResultCode=-1;
					INSERT INTO [dbo].[Oseba]
					   ([OsebaID]
					   ,[OsebaSkupinaTipID]
					   ,[EIC]
					   ,[VeljaOd]
					   ,[VeljaDo]
					   ,[Naziv]
					   ,[Kratica]
					   ,[Ime]
					   ,[Priimek]
					   ,[Naslov]
					   ,[HisnaStevilka]
					   ,[Kraj]
					   ,[Posta]
					   ,[Drzava]
					   ,[OdgovornaOseba1]
					   ,[OdgovornaOseba2]
					   ,[Telefon]
					   ,[Fax]
					   ,[SpletnaStran]
					   ,[Email]
					   ,[Avtor]
					   ,[VrstniRedExcelUvoz]
					   ,[DatumVnosa]
					   ,[DatumSpremembe])
					SELECT
						[OsebaID]
					   ,[OsebaSkupinaTipID]
					   ,[EIC]
					   ,@VELJAVNO_OD
					   ,@VELJAVNO_DO
					   ,(case when ltrim(rtrim(isnull(@NAZIV,''))) = '' then [Naziv] else @NAZIV end)
					   ,[Kratica]
					   ,[Ime]
					   ,[Priimek]
					   ,(case when ltrim(rtrim(isnull(@NASLOV,''))) = '' then [Naslov] else @NASLOV end) 
					   ,(case when ltrim(rtrim(isnull(@HISNA_ST,''))) = '' then [HisnaStevilka] else @HISNA_ST end) 
					   ,(case when ltrim(rtrim(isnull(@POSTA_KRAJ,''))) = '' then [Kraj] else @POSTA_KRAJ end) 
					   ,(case when ltrim(rtrim(isnull(@POSTA_KODA,''))) = '' then [Posta] else @POSTA_KODA end) 
					   ,@MDMDrzavaID
					   ,[OdgovornaOseba1]
					   ,[OdgovornaOseba2]
					   ,(case when ltrim(rtrim(isnull(@TELEFON,''))) = '' then [Telefon] else @TELEFON end) 
					   ,(case when ltrim(rtrim(isnull(@FAX,''))) = '' then [Fax] else @FAX end) 
					   ,[SpletnaStran]
					   ,(case when ltrim(rtrim(isnull(@EMAIL,''))) = '' then [Email] else @EMAIL end) 
					   ,[Avtor]
					   ,[VrstniRedExcelUvoz]
					   ,getdate()
					   ,null
					   from 
						#OsebaToRefresh
					
					if (@@ERROR <> 0 or @@ROWCOUNT <> 1)
						set @ResultCode=-1;
					ELSE
						set @ResultCode=1;

		   END /*oseba že obstaja ...sync*/
		   else
		   begin/*oseba ne obstaja ..insert*/
		   
					   declare @MaxOsebaID int;
					   select @MaxOsebaID = max(OsebaID)+1 from Oseba
		   
					   declare @OsebaSkupinaTipID int
					   Set @OsebaSkupinaTipID = null;
		   
					   declare @VrstniRedExcelUvoz int
					   select @VrstniRedExcelUvoz = max(VrstniRedExcelUvoz)+1 from Oseba

					   INSERT INTO [dbo].[Oseba]
					   ([OsebaID]
					   ,[OsebaSkupinaTipID]
					   ,[EIC]
					   ,[VeljaOd]
					   ,[VeljaDo]
					   ,[Naziv]
					   ,[Kratica]
					   ,[Ime]
					   ,[Priimek]
					   ,[Naslov]
					   ,[HisnaStevilka]
					   ,[Kraj]
					   ,[Posta]
					   ,[Drzava]
					   ,[OdgovornaOseba1]
					   ,[OdgovornaOseba2]
					   ,[Telefon]
					   ,[Fax]
					   ,[SpletnaStran]
					   ,[Email]
					   ,[Avtor]
					   ,[VrstniRedExcelUvoz]
					   ,[DatumVnosa]
					   ,[DatumSpremembe])
					SELECT
						@MaxOsebaID
					   ,@OsebaSkupinaTipID
					   ,@EIC_KODA
					   ,@VELJAVNO_OD
					   ,@VELJAVNO_DO
					   ,@NAZIV
					   ,''
					   ,''
					   ,''
					   ,@NASLOV
					   ,@HISNA_ST
					   ,@POSTA_KRAJ
					   ,@POSTA_KODA
					   ,@MDMDrzavaID
					   ,''
					   ,''
					   ,@TELEFON
					   ,@FAX
					   ,null
					   ,@EMAIL
					   ,1
					   ,@VrstniRedExcelUvoz
					   ,getdate()
					   ,null

					   if (@@ERROR <> 0 or @@ROWCOUNT <> 1)
						set @ResultCode=-1;
					ELSE
						set @ResultCode=1;
		   
		   END/*oseba ne obstaja ..insert*/

		   if (@ResultCode = 1)
		    COMMIT TRAN SyncMDM
		   else
		    rollback TRAN SyncMDM

		END /*EIC OBSTAJA*/

        RETURN @ResultCode ; 
    END

GO


