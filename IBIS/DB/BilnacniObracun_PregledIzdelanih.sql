/****** Object:  StoredProcedure [dbo].[BilnacniObracun_PregledIzdelanih]    Script Date: 03/11/2012 21:58:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BilnacniObracun_PregledIzdelanih]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BilnacniObracun_PregledIzdelanih]
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BilnacniObracun_PregledIzdelanih]
    @DatumStart DATETIME,
    @DatumStop DATETIME,
    @stanje DATETIME,
    @TipD VARCHAR(1) = NULL,
    @TipK VARCHAR(1) = NULL,
    @TipI VARCHAR(1) = NULL,
    @TipIN VARCHAR(1) = NULL,
    @TipKN VARCHAR(1) = NULL,
    @Obdobje VARCHAR(100) = NULL
AS 
    BEGIN
        SET NOCOUNT ON ;
        SET LANGUAGE Slovenian
		
        SELECT  CAST(CONVERT(CHAR(10), [d].[VeljaOd], 104) AS VARCHAR) + ' - '
                + CAST(CONVERT(CHAR(10), [d].[VeljaDo], 104) AS VARCHAR) AS obdobje,
                o.Naziv,
                ( SELECT    MIN(DatumVnosa)
                  FROM      Obracun
                  WHERE     ObracunID = o.ObracunID
                ) AS DatumVnosa,
                s.Naziv AS stanje,
                o.ObracunID,
                o.ID,
                t.Naziv AS Tip,
                o.ObracunTipID AS ObracunTipID
        FROM    Obracun o
                JOIN ObracunStatus s ON O.ObracunStatusID = S.ObracunStatusID
                JOIN dbo.ObracunskoObdobje d ON o.ObracunskoObdobjeID = d.ObracunskoObdobjeID
                JOIN dbo.ObracunTip t ON o.ObracunTipID = t.ObracunTipID
        WHERE   d.VeljaOd >= @DatumStart
                AND d.VeljaDo <= @DatumStop
                AND o.DatumVnosa <= @stanje
                AND ISNULL(o.DatumSpremembe, DATEADD(yy, 50, GETDATE())) >= @stanje
                AND (( ( @TipD = 1
                        AND s.Sifra = 'DEL'
                      )
                      OR ( @TipI = '1'
                           AND s.Sifra = 'INF'
                         )
                      OR ( @TipK = '1'
                           AND s.Sifra = 'KON'
                         )
                      OR ( @TipIN = '1'
                           AND s.Sifra = 'NIF'
                         )
                      OR ( @TipKN = '1'
                           AND s.Sifra = 'NKO'
                         )
                    )
                    OR (@TipD = '0' AND @TipI = '0' AND @TipK = '0' AND @TipIN = '0' AND @TipKn = '0' )
                    )
                 AND (LTRIM(RTRIM(ISNULL(@Obdobje,''))) = '' OR @Obdobje = DATENAME(month, d.VeljaDo)+' '+CAST(DATEPART(YEAR, d.VeljaDo) AS VARCHAR(4)))
        ORDER BY o.DatumVnosa DESC,
                d.VeljaDo DESC
	

    END


GO
