/****** Object:  StoredProcedure [dbo].[usp_UpdatePogodbaSprememba]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePogodbaSprememba]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_UpdatePogodbaSprememba]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_UpdatePogodbaSprememba]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[usp_UpdatePogodbaSprememba]
	@ID int
AS

SET NOCOUNT ON

UPDATE Pogodba 
SET datumspremembe = getdate() 
WHERE ID = @ID

--ce pogodbo pobrisemo potem postavimo aktvivno=0
update Pogodba set Aktivno=0
where ID=@ID


--endregion

' 
END
GO
