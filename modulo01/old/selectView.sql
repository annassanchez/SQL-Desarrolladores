SELECT
 C.COLUMN_NAME
 , C.DATA_TYPE
 , C.IS_NULLABLE
FROM
 INFORMATION_SCHEMA.TABLES AS T
 JOIN INFORMATION_SCHEMA.COLUMNS AS C ON C.TABLE_NAME = T.TABLE_NAME AND C.TABLE_SCHEMA = T.TABLE_SCHEMA
WHERE
 T.TABLE_TYPE = 'VIEW';