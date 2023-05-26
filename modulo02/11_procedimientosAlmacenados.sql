--trabajar con parámetros
USE test; 
GO

EXEC dbo.proc_Customers_Get @CustomerID = 10, @OrderbyType = 1;

--crear y modificar procedimientos almacenados

CREATE PROCEDURE Sales.proc_Customers_Get
 @CustomerID int
 , @OrderbyType tinyint = 1
AS
BEGIN

 -- ejecuta otro procedimiento almacenado
 EXEC Sales.proc_Customers_Check @CustomerID

 SELECT
 FirstName
 , LastName
 FROM
 Sales.Customers
 WHERE
 CustomerID = @CustomerID
 ORDER BY
 CASE 
 WHEN @OrderbyType = 1 THEN FirstName
 ELSE LastName
 END;

END;


--opciones de procedimientos almacenados
SET NOCOUNT ON;

CREATE PROCEDURE dbo.proc_Status_Return
AS
BEGIN
 SET NOCOUNT ON;
 RETURN -7;
END;
GO

DECLARE @status int;
EXEC @status = dbo.proc_Status_Return;
SELECT [Status Value] = @status;
GO

-- alteramos el procedimiento para devolver NULL
ALTER PROCEDURE dbo.proc_Status_Return
AS
BEGIN
 SET NOCOUNT ON;
 RETURN NULL;
END;
GO

DECLARE @status int;
EXEC @status = dbo.proc_Status_Return;
SELECT [Status Value] = @status;
GO


CREATE PROC dbo.proc_CustomerAndOrders_List 
AS
BEGIN

 -- primer conjunto de resultados
 SELECT
 FirstName
 , LastName
 FROM
 dbo.Customers
 ORDER BY
 LastName
 , FirstName;

 -- segundo conjunto de resultados 
 SELECT
 SalesOrdersID
 , SalesOrderDate
 , TotalQuantity
 , CustomerID
 FROM
 dbo.SalesOrders;
END;
GO

-- ejecutar 
EXEC dbo.proc_CustomerAndOrders_List 
WITH RESULT SETS 
(
 (
 FirstName varchar(30), -- primera definición del conjunto de resultados
 LastName varchar(30)
 )
, 
 (
 SalesOrderID int, -- segunda definición del conjunto de resultados
 SalesOrderDate smalldatetime,
 TotalQuantity smallint,
 CustomerID int
 )
);


CREATE PROCEDURE dbo.proc_Customers_Get
 @CustomerID int
 , @OrderbyType tinyint = 1
WITH EXECUTE AS OWNER
AS
BEGIN
-- instrucciones
END;