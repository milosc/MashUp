/****** Object:  StoredProcedure [dbo].[updOsebaZCalc]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[updOsebaZCalc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[updOsebaZCalc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[updOsebaZCalc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[updOsebaZCalc]
	@OsebaID int,	
	@OsebaZId int
AS

begin 
SET NOCOUNT ON

-- brisemo staro.
UPDATE osebaZCalc
    SET DatumSpremembe = getdate()
    WHERE OsebaID=@OsebaID AND DatumSpremembe is NULL 
    --and OsebaZId <> @OsebaZId

--dodamo novo.
INSERT INTO osebaZCalc (OsebaID,OsebaZId,DatumVnosa)
    VALUES (@OsebaID, @OsebaZId, getdate())

end
' 
END
GO
