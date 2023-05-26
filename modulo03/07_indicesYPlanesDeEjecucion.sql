use [test]
go

select CustomerID, COUNT(*)
from dbo.SalesOrders
group by CustomerID

SELECT * 
INTO test.dbo.SalesOrdersDetails
FROM AdventureWorks2012.Sales.SalesOrderDetail

declare @CustomerID int = 41;

set statistics io on;

select
	so.SalesOrderDate,
	so.ExpireDate,
	c.FirstName,
	c.LastName,
	sod.UnitPrice,
	sod.OrderQty
from dbo.SalesOrders so
	join dbo.SalesOrdersDetails sod on so.SalesOrdersID = sod.SalesOrderID
	join dbo.Customers c on c.CustomerID = so.CustomerID
where c.CustomerID = @CustomerID
order by so.SalesOrderDate desc
option (maxdop 1); -- número de procesadores físicos que ejecutan la consulta

set statistics io off;


USE [test]
GO
CREATE NONCLUSTERED INDEX IX_SalesOrderDetails_SalesOrderID
ON [dbo].[SalesOrdersDetails] ([SalesOrderID])
INCLUDE ([OrderQty],[UnitPrice])
GO

