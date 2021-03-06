/****** Object:  StoredProcedure [dbo].[tmp_Primerjava]    Script Date: 03/11/2012 21:58:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmp_Primerjava]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[tmp_Primerjava]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmp_Primerjava]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[tmp_Primerjava]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select o.Naziv, o.OsebaID , kobr1.Kolicina, kobr2.Kolicina, kobr1.Kolicina - kobr2.Kolicina as KolicinaRazlika, kobr1.Odstopanje, kobr2.Odstopanje, kobr1.Odstopanje - kobr2.Odstopanje as OdstopanjeRazlika, tp.Kolicina, tp.Kolicina, kobr2.Interval 
from Oseba o, View_KolicinskaOdstopanja kobr2, View_KolicinskaOdstopanja kobr1, TrzniPlan tp where kobr1.Interval >= ''2006-01-01 00:00:00'' and kobr1.Interval <= ''2010-12-31 00:00:00'' and o.OsebaID = kobr2.OsebaID and kobr2.ObracunID = 79 and kobr1.Interval = kobr2.Interval and kobr1.OsebaID = kobr2.OsebaID and kobr1.Interval = tp.Interval and kobr1.OsebaID = tp.OsebaID and kobr1.ObracunID = 78 and kobr2.ObracunID = 79 and ( kobr2.ObracunID = 79 OR kobr1.Interval = kobr2.Interval OR kobr1.OsebaID = kobr2.OsebaID OR kobr1.Interval = tp.Interval OR kobr1.OsebaID = tp.OsebaID OR kobr1.ObracunID = 78 OR kobr2.ObracunID = 79) and o.DatumVnosa <=''2008-05-06 17:07:31'' and ISNULL(o.DatumSpremembe,DATEADD(yy, 50, GETDATE())) >= ''2008-05-06 17:07:31'' and o.OsebaID in (7);

END
' 
END
GO
