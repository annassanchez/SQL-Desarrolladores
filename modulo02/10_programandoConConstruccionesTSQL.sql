--SALTOS
DECLARE @i int = 1;

WHILE @i <= 2
BEGIN

 IF @i = 1 GOTO LBL_ONE;

 SET @i = @i + 1;
END;

LBL_ONE: SELECT 'ONE!'

LBL_TWO: SELECT 'TWO!'

--VARIABLES

DECLARE @s nvarchar(30);

SET @i = 1;
SET @s = 'Hello!';

SELECT @i = 1;
SELECT @s = 'Hello!';



USE test

DECLARE @name varchar(30);

SELECT
 @name = FirstName + ' ' + LastName
FROM
 dbo.Customers C
WHERE
 CustomerID = 11;

SELECT @name AS Customer_Name;


SELECT * FROM @table;

--sp_ExecuteSQL

DECLARE @i AS int = 1;
DECLARE @sql AS varchar(MAX) = 'SELECT * FROM dbo.Customers WHERE CustomerID = ' + CAST(@i AS varchar(10));
EXEC (@sql);

DECLARE @i AS int = 1;
EXEC sp_executeSQL N'SELECT * FROM Sales.Customers WHERE CustomerID = @customerID', N'@customerID int', @customerID = @i

--GESTIÓN DE ERRORES

USE tempdb;
GO

CREATE TABLE #FooData(id int NOT NULL);
DECLARE @value int;

INSERT #FooData VALUES (@value)
IF @@ERROR <> 0
 PRINT 'Error inserting data!'

 BEGIN TRY
 DECLARE @s smallint = CAST(11111111 AS smallint);
END TRY
BEGIN CATCH
 SELECT 
 ErrorNumber = error_number()
 , ErrorMessage = error_message()
 , ErrorLine = ERROR_LINE()
 , ErrorSeverity = ERROR_SEVERITY();
END CATCH;


THROW 55000, 'Error!', 1;

RAISERROR (N'Error number: %s, please retry after %d seconds', 16, 1, '55000', 30);