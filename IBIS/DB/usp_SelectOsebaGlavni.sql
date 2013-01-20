/****** Object:  StoredProcedure [dbo].[usp_SelectOsebaGlavni]    Script Date: 03/11/2012 21:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectOsebaGlavni]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectOsebaGlavni]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectOsebaGlavni]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[usp_SelectOsebaGlavni]
	
AS
BEGIN

SELECT OsebaID, MAX(DatumVnosa) AS DatumVnosa, MAX(Naziv) AS Naziv, MAX(Stevilka) AS Stevilka, MAX(Naslov) AS Naslov 
FROM Oseba GROUP BY OsebaID

END


' 
END
GO
