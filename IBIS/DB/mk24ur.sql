/****** Object:  UserDefinedFunction [dbo].[mk24ur]    Script Date: 03/11/2012 21:58:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mk24ur]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[mk24ur]
GO


create FUNCTION [dbo].[mk24ur] ( @Interval DATETIME )
RETURNS NVARCHAR(20)
AS 
    BEGIN
        RETURN 
	    CASE WHEN DATEPART(hour , @Interval) = 0 
	            THEN CONVERT (VARCHAR(20) , DATEADD(day , 0 , @Interval) , 104) + ' 24' --prej je bilo CONVERT (VARCHAR(20) , DATEADD(day , -1 , @Interval) , 104) + ' 24'
	         WHEN DATEPART(hour , @Interval) < 10 THEN CONVERT (VARCHAR(10) , @Interval , 104) + ' 0' + CAST(DATEPART(hour , @Interval) AS VARCHAR(5)) 
	         ELSE CONVERT (VARCHAR(10) , @Interval , 104) + ' ' + CAST(DATEPART(hour , @Interval) AS VARCHAR(5)) END  

    END

GO
