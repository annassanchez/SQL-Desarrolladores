--JOIN
SELECT
 FirstName
 , LastName
 , dbo.Customers.CustomerID
FROM
 dbo.Customers
 JOIN dbo.SalesOrders ON dbo.Customers.CustomerID = dbo.SalesOrders.CustomerID;

 --replacing schema.table_name con variables
 SELECT
 FirstName
 , LastName
 , C.CustomerID
FROM
 Sales.Customers C
JOIN Sales.SalesOrders SO ON C.CustomerID = SO.CustomerID;

--intersect | except
USE tempdb;
GO

CREATE TABLE #FirstTable
(
 id int
 , number int
 , string varchar(10)
)
GO

CREATE TABLE #SecondTable
(
 id int
 , number int
)
GO

INSERT INTO #SecondTable ( id, number )
VALUES
 ( 1, 10 )
 , ( 2, 20 )
 , ( 2, 20 )
 , ( 3, 30 )
 , ( 4, 40 )
 , ( 5, 50 )
 , ( 5, 50 );
GO

INSERT INTO #FirstTable ( id, number, string )
VALUES
 ( 1, 10, 'ONE' )
 , ( 2, 20, 'TWO' )
 , ( 3, 30, 'THREE' )
 , ( 7, 70, 'SEVENT' )
 , ( 8, 80, 'EIGHT' );
GO

-- INTERSECT
SELECT id, number FROM #FirstTable
INTERSECT
SELECT id, number FROM #SecondTable;
GO

-- EXCEPT
SELECT id, number FROM #FirstTable
EXCEPT
SELECT id, number FROM #SecondTable;
GO

DROP TABLE #FirstTable;
DROP TABLE #SecondTable;


--intercept o except

USE tempdb;
GO

CREATE TABLE #FirstTable
(
 id int
 , number int
 , string varchar(10)
)
GO

CREATE TABLE #SecondTable
(
 id int
 , number int
)
GO

INSERT INTO #SecondTable ( id, number )
VALUES
 ( 1, 10 )
 , ( 2, 20 )
 , ( 2, 20 )
 , ( 3, 30 )
 , ( 4, 40 )
 , ( 5, 50 )
 , ( 5, 50 );
GO

INSERT INTO #FirstTable ( id, number, string )
VALUES
 ( 1, 10, 'ONE' )
 , ( 2, 20, 'TWO' )
 , ( 3, 30, 'THREE' )
 , ( 7, 70, 'SEVENT' )
 , ( 8, 80, 'EIGHT' );
GO

-- INTERSECT
SELECT id, number FROM #FirstTable
INTERSECT
SELECT id, number FROM #SecondTable;
GO

-- EXCEPT
SELECT id, number FROM #FirstTable
EXCEPT
SELECT id, number FROM #SecondTable;
GO

DROP TABLE #FirstTable;
DROP TABLE #SecondTable;



--operador UNION

USE tempdb;
GO

-- primer conjunto
CREATE TABLE #FirstSet (id int, val varchar(10));
-- segundo conjunto
CREATE TABLE #SecondSet (id int, val varchar(10), number smallint);
-- tercer conjunto
CREATE TABLE #ThirdSet (id int, number smallint);

-- INSERT VALUES
-- ///////////////////////////////////////////
INSERT INTO #FirstSet ( id, val )
VALUES 
 ( 1, 'ONE' )
, ( 2, 'TWO' )
, ( 3, 'THREE' );

INSERT INTO #SecondSet ( id, val, number )
VALUES 
 ( 3, 'THREE', 300 )
, ( 4, 'FOUR', 400 )
, ( 5, 'FIVE', 500 );

INSERT INTO #ThirdSet ( id, number )
VALUES 
 ( 2, 200 )
, ( 3, 300 )
, ( 4, 500 );
-- ///////////////////////////////////////////

-- solo UNION (sin duplicados)
SELECT
 id
 , val
FROM
 #FirstSet
UNION
SELECT
 id
 , val
FROM
 #SecondSet
UNION
SELECT
 id
 , val = CASE 
 WHEN id = 2 THEN 'TWO'
 WHEN id = 3 THEN 'THREE'
 WHEN id = 4 THEN 'FOUR'
 END
FROM
 #ThirdSet;

DROP TABLE #FirstSet;
DROP TABLE #SecondSet;
DROP TABLE #ThirdSet;
GO


--usando UNION ALL

SELECT
 id
 , val
FROM
 #FirstSet
UNION ALL
SELECT
 id
 , val
FROM
 #SecondSet
UNION ALL
SELECT
 id
 , val = CASE 
 WHEN id = 2 THEN 'TWO'
 WHEN id = 3 THEN 'THREE'
 WHEN id = 4 THEN 'FOUR'
 END
FROM
 #ThirdSet;