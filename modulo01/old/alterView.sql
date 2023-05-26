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