/****** Object:  StoredProcedure [dbo].[usp_SelectObracunskoObdobjeDropDown]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectObracunskoObdobjeDropDown]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectObracunskoObdobjeDropDown]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectObracunskoObdobjeDropDown]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SelectObracunskoObdobjeDropDown]
	@stanje datetime
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
	[ObracunskoObdobjeID],
	--(cast(VeljaOd as varchar) + '' - '' + cast(VeljaDo as varchar)) as obdobje0
	cast(convert(char(10),[VeljaOd],104) as varchar) + '' - '' + cast(convert(char(10),[VeljaDo],104) as varchar) as obdobje
FROM
	[dbo].[ObracunskoObdobje]
where 
	ObracunskoObdobjeTipID = 1 and DatumVnosa <= @stanje and ISNULL(DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= @stanje
	order by [ObracunskoObdobjeID] DESC
END




' 
END
GO
