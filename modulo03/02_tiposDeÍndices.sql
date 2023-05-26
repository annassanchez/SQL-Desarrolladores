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

--�ndices eliminados
CREATE INDEX IX_AccountsUsers_FilteredShortDescription ON Accounts.Users
(
 LastName
)
INCLUDE
(
 FirstName
)
WHERE UserStatusId IN (1,2,3)

--�NDICES XML

--creaci�n del esquema xml
CREATE XML SCHEMA COLLECTION SchemaCollectionName AS Expression

--creaci�n de la tabla
CREATE TABLE dbo.SampleXMLTable
(
 IDSample int PRIMARY KEY CLUSTERED
 , XmlValue xml (CONTENT SchemaCollectionName)
);

--creaci�n del �ndice xml
CREATE PRIMARY XML INDEX IX_PrimaryXMLIndex ON dbo.SampleXMLTable (XmlValue);

--creaci�n del �ndice xml
CREATE XML INDEX IX_SecondaryXMLIndex ON dbo.SampleXMLTable (XmlValue) USING XML INDEX IX_PrimaryXMLIndex FOR { VALUE | PATH | PROPERTY };