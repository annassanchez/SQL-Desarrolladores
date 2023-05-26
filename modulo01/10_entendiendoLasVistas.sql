USE [test]
GO

CREATE VIEW dbo.YoungerCustomers
AS
 SELECT
 *
 FROM
 dbo.Customers
 WHERE
 Age < 30;
GO

ALTER TABLE dbo.Customers ADD CustomerStatusID tinyint NULL

USE [test]
GO

ALTER VIEW dbo.YoungerCustomers
AS
 SELECT
 *
 FROM
 dbo.Customers
 WHERE
 Age < 30;
GO