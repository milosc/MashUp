IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SelectPPMTipIDFilter]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_SelectPPMTipIDFilter]
GO



CREATE PROCEDURE [dbo].[usp_SelectPPMTipIDFilter]
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT 
*
FROM
(
SELECT
	[PPMTipID],
	[Naziv]
FROM
	[dbo].[PPMTip]
UNION ALL
select
	 0 AS PPMTipID,
	'----------VSE-----------' AS Naziv	
) AS A
ORDER BY PPMTipID asc
--endregion



GO