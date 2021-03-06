/****** Object:  StoredProcedure [dbo].[zaKolObra_hiter_query]    Script Date: 03/11/2012 21:58:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zaKolObra_hiter_query]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[zaKolObra_hiter_query]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zaKolObra_hiter_query]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[zaKolObra_hiter_query]
as
begin
--za količnisko obračun
select * from KolicinskaOdstopanjaPoBPS --View_KolicinskaOdstopanja
where OsebaID=5 and
	 ObracunID=1
	 and Interval >= ''2008-01-31 22:00''
	 and Interval<=''2008-02-05 00:00''
	 
select * from View_KolicinskaOdstopanja
where OsebaID=5 and
	 ObracunID=1 and 
	 Interval=''2008-02-01 00:00''
	 
select * from ObracunKolicinski
where OsebaID=3 and
	 ObracunID=1
	 and Interval >= ''2008-01-31 22:00''
	 and Interval<=''2008-02-05 00:00''

	 end' 
END
GO
