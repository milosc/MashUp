/****** Object:  StoredProcedure [dbo].[BilnacniObracunTip_Select]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracunTip_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracunTip_Select]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracunTip_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracunTip_Select]
	--@ID int
AS
BEGIN

 select ObracunTipID, naziv from ObracunTip;
end
' 
END
GO
