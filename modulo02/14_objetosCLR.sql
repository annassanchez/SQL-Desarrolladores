sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO

CREATE ASSEMBLY ListActiveCustomersAssembly from 'c:\ListActiveCustomersAssembly.dll' WITH PERMISSION_SET = SAFE

CREATE PROCEDURE Sales.proc_Customers_ListActive
AS
 EXTERNAL NAME ListActiveCustomersAssembly.StoredProcedures.ListActiveCustomers

 SELECT * FROM dbo.ListCustomers(1)

 SELECT * FROM dbo.ListCustomers(1)