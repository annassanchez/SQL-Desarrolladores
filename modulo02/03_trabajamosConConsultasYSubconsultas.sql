-- subconsulta
SELECT
 T.CustomerID
 , T.MAXTotalQuantity
FROM
 (
 SELECT
 CustomerID
 , MAXTotalQuantity = MAX(TotalQuantity)
 FROM
 dbo.SalesOrders
 WHERE
 TotalQuantity > 0
 GROUP BY
 CustomerID
) AS T
WHERE
T.CustomerID = 10;

--filtro in | not in
SELECT
 SalesOrdersID
 , SalesOrderDate
 , TotalQuantity
 , ExpireDate
 , CustomerID
FROM
 dbo.SalesOrders SO
WHERE
 CustomerID IN 
 (
 SELECT CustomerID FROM dbo.Customers C WHERE CustomerID > 1
 );

--filtros operadores de comparación
SELECT
 SalesOrdersID
 , SalesOrderDate
 , TotalQuantity
 , ExpireDate
 , CustomerID
FROM
 dbo.SalesOrders SO
WHERE
 TotalQuantity > (SELECT MAX(TotalQuantity) FROM dbo.SalesOrders);

 --función not exists | exists
 SELECT
 SalesOrdersID
 , SalesOrderDate
 , TotalQuantity
 , ExpireDate
 , CustomerID
FROM
 dbo.SalesOrders SO
WHERE
 NOT EXISTS (SELECT CustomerID FROM dbo.Customers C WHERE FirstName LIKE 'A%');

 --en lugar de una expresión (por ejemplo, en una instrucción select)
SELECT
 SalesOrdersID
 , SalesOrderDate
 , TotalQuantity
 , ExpireDate
 , CustomerID
 , Days = (SELECT DATEDIFF(DAY, GETDATE(),ExpireDate) FROM dbo.SalesOrders WHERE SalesOrdersID = 2)
FROM
dbo.SalesOrders SO

--ejemplo de una CTE no recursiva
WITH CustomersCTE (CustomerName, Quantity, ID)
AS
(
 SELECT
 DISTINCT
 C.FirstName + ' ' + C.LastName
 , SO.TotalQuantity
 , C.CustomerID
 FROM
 dbo.Customers C
 JOIN dbo.SalesOrders SO ON C.CustomerID = SO.CustomerID
)

SELECT
 CustomerName
 , Quantity
 , ID
FROM
 CustomersCTE;