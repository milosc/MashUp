
SELECT DISTINCT
                o.name ,
                o.xtype
FROM syscomments c
    INNER JOIN sysobjects o ON c.id=o.id
WHERE c.[text] LIKE '%Premalo podatkov za izraèun CSloP/N%'
--o.name LIKE '%lookup%'
--             AND o.xtype='P'



SELECT DISTINCT
                o.name ,
                o.xtype
FROM syscomments c
    INNER JOIN sysobjects o ON c.id=o.id
WHERE c.[text] LIKE '%rpodsum%'
--o.name LIKE '%lookup%'
--             AND o.xtype='P'

SELECT DISTINCT
                o.name ,
                o.xtype
FROM syscomments c
    INNER JOIN sysobjects o ON c.id=o.id
WHERE c.[text] LIKE '%BO_Pogodba%'
--o.name LIKE '%lookup%'
--             AND o.xtype='P'

