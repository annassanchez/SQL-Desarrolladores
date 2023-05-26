--UNBOUNDED PRECEDING
SELECT
 SalesOrderID
 , OrderNumber
 , Quantity
 , Price
 , SUM(Price) OVER (ORDER BY SalesOrderID ROWS UNBOUNDED PRECEDING)
FROM 
 dbo.SalesOrderDetails;