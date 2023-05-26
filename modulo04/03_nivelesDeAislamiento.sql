ALTER DATABASE test
SET ALLOW_SNAPSHOT_ISOLATION ON

ALTER DATABASE test
SET READ_COMMITTED_SNAPSHOT ON

--cambiar el nivel de aislamiento
SET TRANSACTION ISOLATION LEVEL {READ UNCOMMITTED|READ COMMITTED|REPEATABLE READ|SNAPSHOT|SERIALIZABLE};

--aplicar un nivel de aislamiento distinto dentro de una transacción
use [test]
go

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
GO
BEGIN TRANSACTION;
GO
SELECT CustomerID
, FirstName
, LastName
FROM dbo.Customers C
GO
COMMIT TRANSACTION;
GO

--read uncommitted
SELECT
 SO.SalesOrderDate
 , C.FirstName
 , C.LastName
 , SOD.UnitPrice
 , SOD.OrderQty
FROM 
 -- read committed (por defecto) en las primeras dos tablas 
 dbo.SalesOrders SO
 JOIN dbo.SalesOrdersDetails SOD ON SO.SalesOrdersID = SOD.SalesOrderID 
 -- read uncommitted en la tabla Sales.Customers
 JOIN dbo.Customers C WITH(NOLOCK) ON SO.CustomerID = C.CustomerID

 --serializable
 SELECT
 SO.SalesOrderDate
 , C.FirstName
 , C.LastName
 , SOD.UnitPrice
 , SOD.OrderQty
FROM 
 -- read committed (por defecto) 
--en las primeras dos tablas  
dbo.SalesOrders SO
 JOIN dbo.SalesOrdersDetails SOD ON SO.SalesOrdersID = SOD.SalesOrderID 
 -- serializable en la tabla Sales.Customers
JOIN dbo.Customers C WITH(HOLDLOCK) ON So.CustomerID = C.CustomerID