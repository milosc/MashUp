/****** Object:  StoredProcedure [dbo].[usp_InsertMeritvePoracunTip]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertMeritvePoracunTip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_InsertMeritvePoracunTip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_InsertMeritvePoracunTip]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[usp_InsertMeritvePoracunTip]
	@MeritvePoracunTipID int,	
	@Naziv varchar(50),
	@Sifra varchar(4)
AS

SET NOCOUNT ON

INSERT INTO [dbo].[MeritvePoracunTip] (
	MeritvePoracunTipID, SIfra, Naziv
) VALUES (
	@MeritvePoracunTipID, @Sifra, @Naziv
)



--endregion

' 
END
GO
