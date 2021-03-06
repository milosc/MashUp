/****** Object:  StoredProcedure [dbo].[Podatki_ReferencniIndeksPregled]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_ReferencniIndeksPregled]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Podatki_ReferencniIndeksPregled]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Podatki_ReferencniIndeksPregled]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[Podatki_ReferencniIndeksPregled]
	@OdDatum datetime,
	@DoDatum datetime,
	@stanje datetime
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT    
 CASE WHEN DATEPART(hour, Interval) = 0 THEN CONVERT(varchar(20), DATEADD(day, - 1, Interval), 104) + '' 24'' 
 WHEN DATEPART(hour, Interval) < 10 THEN CONVERT(varchar(10), Interval, 104) + '' 0'' + CAST(DATEPART(hour, Interval) AS varchar(5))
  ELSE CONVERT(varchar(10), Interval, 104) + '' '' + CAST(DATEPART(hour, Interval) AS varchar(5)) 
 END AS Interval, Vrednost
FROM         CSLOEX
WHERE     (Interval > @OdDatum) AND (Interval <= DATEADD(d, 1, @DoDatum)) AND (DatumVnosa <= @stanje) AND (ISNULL(DatumSpremembe, DATEADD(yy, 50, 
                      GETDATE())) >= @stanje)
                      ORDER by Interval


' 
END
GO
