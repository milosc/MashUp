/****** Object:  StoredProcedure [dbo].[usp_SelectPreostaliOdjemsDynamic]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectPreostaliOdjemsDynamic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectPreostaliOdjemsDynamic]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectPreostaliOdjemsDynamic]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--region [dbo].[usp_SelectPreostaliOdjemsDynamic]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   lipanje using CodeSmith 4.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_SelectPreostaliOdjemsDynamic]
-- Date Generated: 16. januar 2008
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_SelectPreostaliOdjemsDynamic]
	@WhereCondition nvarchar(500),
	@OrderByExpression nvarchar(250) = NULL
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

DECLARE @SQL nvarchar(3250)

SET @SQL = ''
SELECT
	[ID],
	[Interval],
	[Kolicina],
	[UdelezenecTrga],
	[SistemskiOperater],
	[DatumVnosa]
FROM
	[dbo].[PreostaliOdjem]
WHERE
	'' + @WhereCondition

IF @OrderByExpression IS NOT NULL AND LEN(@OrderByExpression) > 0
BEGIN
	SET @SQL = @SQL + ''
ORDER BY
	'' + @OrderByExpression
END

EXEC sp_executesql @SQL

--endregion

' 
END
GO
