/****** Object:  StoredProcedure [dbo].[sp_Insert_v_ViewMeritve]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Insert_v_ViewMeritve]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_Insert_v_ViewMeritve]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Insert_v_ViewMeritve]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[sp_Insert_v_ViewMeritve]
	@PPMID int,
	@Interval datetime,
	@Kolicina decimal(18,8)
AS
BEGIN

declare @id int	
select @id =isnull(max(ID),0)  from view_Meritve
set @id=@id +1

insert into view_Meritve (ID, PPMID, Interval, Kolicina, DatumVnosa,DatumSpremembe)
values(@id,@PPMID,@Interval,@Kolicina,getdate(),null)


END
' 
END
GO
