/****** Object:  StoredProcedure [dbo].[sp_PPMDelete]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PPMDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PPMDelete]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PPMDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_PPMDelete]
	@id int,
	@ppmID int
AS

SET NOCOUNT ON
BEGIN

UPDATE PPM
SET DatumSpremembe = getdate()
WHERE ID=@id AND PPMID=@ppmID AND DatumSpremembe is NULL 

END' 
END
GO
