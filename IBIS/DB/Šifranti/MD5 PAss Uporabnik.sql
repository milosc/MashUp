
SELECT * FROM [dbo].[Uporabnik]

UPDATE [dbo].[Uporabnik] SET geslo = CONVERT(NVARCHAR(32),HashBytes('MD5', geslo),2)

SELECT * FROM [dbo].[Uporabnik]