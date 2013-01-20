/****** Object:  StoredProcedure [dbo].[zaFinObra_hiterQuery]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zaFinObra_hiterQuery]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[zaFinObra_hiterQuery]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zaFinObra_hiterQuery]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[zaFinObra_hiterQuery]
as
begin
-- za finačni obračun

--za jan
select * from PodatkiObracuna
where OsebaID=3
and ObracunID=1
and Interval >= ''2008-01-31 22:00''
	 and Interval<=''2008-02-05 00:00''
--za feb	 
select * from PodatkiObracuna
where OsebaID=3
and ObracunID=2
and Interval >= ''2008-01-29 22:00''
	 and Interval<=''2008-03-05 00:00''

end' 
END
GO
