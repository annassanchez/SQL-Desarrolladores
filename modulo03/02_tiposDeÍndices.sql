SELECT
 UserName
 , FirstName
 , LastName
FROM
 Accounts.Users U
WHERE
 LastName LIKE 'A%'

 CREATE INDEX IX_AccountsUsers_LastName ON Accounts.Users
(
 LastName
) INCLUDE (FirstName, UserName)

CREATE INDEX IX_AccountsUsers_FilteredShortDescription ON Accounts.Users
(
 LastName
)
INCLUDE
(
 FirstName
)
WHERE ShortDescription IS NULL

--índices eliminados
CREATE INDEX IX_AccountsUsers_FilteredShortDescription ON Accounts.Users
(
 LastName
)
INCLUDE
(
 FirstName
)
WHERE UserStatusId IN (1,2,3)

--íNDICES XML

--creación del esquema xml
CREATE XML SCHEMA COLLECTION SchemaCollectionName AS Expression

--creación de la tabla
CREATE TABLE dbo.SampleXMLTable
(
 IDSample int PRIMARY KEY CLUSTERED
 , XmlValue xml (CONTENT SchemaCollectionName)
);

--creación del índice xml
CREATE PRIMARY XML INDEX IX_PrimaryXMLIndex ON dbo.SampleXMLTable (XmlValue);

--creación del índice xml
CREATE XML INDEX IX_SecondaryXMLIndex ON dbo.SampleXMLTable (XmlValue) USING XML INDEX IX_PrimaryXMLIndex FOR { VALUE | PATH | PROPERTY };