------------------------------------------------------------
-- EJERCICIOS on M�DULO 2 - T-SQL
-- 15 EJERCICIOs
--
-- operaciones CRUD
-- uniones
-- agregaciones
-- funciones de categor�a
-- expresiones de tabla com�n
-- objetos temporales
-- procedimientos
-- funciones
-- cl�usulas
------------------------------------------------------------

-- AdventureWorks2012 es la base de datos de ejemplo
USE AdventureWorks2012;
GO

-- EJERCICIO 1
-- Introduce algunos datos de ejemplo en las tablas Library.Publishers y Library.Books.
-- Los datos para Library.Publishers son:
-- PublisherID			PublisherName
-- 1				Editorial Ejemplo
-- 2				Editorial Ejercicios
-- 3				Krasis Press
--
-- Los datos para Books son:
-- BookTitle		BookDescription					BookPages	BookPublisherID			BookDate	BookISBN
-- Sample text		"Sample text" es un libro de ejemplos			50		1			2001-01-01	1234
-- Samples in action	"Samples in action" es un libro con ejemplos		350		1			2002-02-02	12345
-- Exercise one		"Exercise one" es un libro de ejercicios 		150		2			2003-03-03	123456
-- Try this exercise 	"Try this exercise" es un libro de ejercicios		100		2			2003-03-03	1234567
-- Solve it!		"Solve it!" es un libro con ejemplos y ejercicios	200		3			2001-01-01	12345678


INSERT INTO Library.Publishers ( PublisherID, PublisherName )
VALUES 
	  ( 1, N'Editorial Ejemplo' )
	, ( 2, N'Editorial Ejercicios' )
	, ( 3, N'Krasis Press' );

INSERT INTO Library.Books (BookTitle, BookDescription, BookPages, BookPublisherID, BookDate, BookISBN)
VALUES
      (N'Sample text'		, N'"Sample text" is a book for samples'			, 50	, 1, '20010101', '1234')
	, (N'Samples in action'	, N'"Samples in action" is a book for samples'		, 350	, 1, '20020202', '12345')
	, (N'Exercise one'		, N'"Exercise one" is a book for exercises'			, 150	, 2, '20030303', '123456')
	, (N'Try this exercise'	, N'"Try this exercise" is a book for exercises'	, 100	, 2, '20030303', '1234567')
	, (N'Solve it!'			, N'"Solve it!" is a book for samples & exercises'	, 200	, 3, '20010101', '12345678');
--



-- EJERCICIO 2
-- Extrae la lista de libros que cumplan las siguientes condiciones (una consulta por opci�n):
-- 1 - El t�tulo empieza por "S"
-- 2 - PublisherID es igual a 3
-- 3 - Fecha, entre la medianoche de 2002-02-01 y la medianoche de 2003-03-31
-- Muestra �nicamente el t�tulo y la descripci�n.

--1)
SELECT
	  BookTitle
	, BookDescription
FROM
	Library.Books
WHERE
	BookTitle LIKE 'S%';
	
--2)
SELECT
	  BookTitle
	, BookDescription
FROM
	Library.Books
WHERE
	BookPublisherID = 3;
	
--3)
SELECT
	  BookTitle
	, BookDescription
FROM
	Library.Books
WHERE
	BookDate >= '20020201 00:00'
	AND BookDate < '20030401';
--


-- EJERCICIO 3
-- Actualiza el ID de la editorial de la tabla Library.Books cuyo ISBN sea igual a "1234567". Su nuevo ID ser� 3.

UPDATE Library.Books
SET BookPublisherID = 3
WHERE BookISBN = '1234567';
--


-- EJERCICIO 4
-- Inserta un nuevo registro en la tabla Library.Books y asign�le el ISBN "123456789", los dem�s datos ser�n los mismos que los del
-- libro cuyo ISBN es "12345".
-- Despu�s, borra la fila que has copiado (aquella cuyo ISBN es "12345")

INSERT INTO Library.Books (BookTitle, BookDescription, BookPages, BookPublisherID, BookDate, BookISBN)
SELECT
	  BookTitle
	, BookDescription
	, BookPages
	, BookPublisherID
	, BookDate
	, '123456789'
FROM
	Library.Books
WHERE
	BookISBN = '12345';

DELETE FROM Library.Books WHERE BookISBN = '12345';
--


-- EJERCICIO 5
-- Actualiza la tabla Library.Books a�adiendo 50 campos BookPages.
-- Muestra el resultado de las operaciones teniendo en cuenta los valores anteriores de BookPages
-- y el nuevo uso de la cl�usula OUTPUT.

UPDATE Library.Books
SET
	BookPages = BookPages + 50
OUTPUT
	INSERTED.BookPages AS NewBookPages, DELETED.BookPages AS PreviousBookPages;
--


-- EJERCICIO 6
-- Usa una subconsulta en lugar de la cl�usula de la consulta de la tabla Library.Books
-- para filtrar �nicamente la editorial cuyo nombre contiene la palabra "Krasis".
-- Muestra solamente el t�tulo y la descripci�n.

SELECT
	  BookTitle
	, BookDescription
FROM
	Library.Books
WHERE
	BookPublisherID IN (SELECT PublisherID FROM Library.Publishers WHERE PublisherName LIKE '%Krasis%');
--

-- EJERCICIO 7
-- Escribe una consulta que muestre el t�tulo, el ISBN y el nombre de la editorial de los libros.
-- Ordena el resultado por orden ascendente seg�n el BookTitle.

SELECT
	  B.BookTitle
	, B.BookISBN
	, P.PublisherName
FROM
	Library.Books			B
	JOIN Library.Publishers P ON B.BookPublisherID = P.PublisherID
ORDER BY
	B.BookTitle ASC;
--


-- EJERCICIO 8
-- En primer lugar, a�ade una nueva editorial a la tabla Library.Publishers. Introduce los siguientes valores:
-- PublisherID = 5, PublisherName = "New Press"
--
-- Escribe una consulta que cuente el n�mero de libros correspondientes a cada editorial.
-- Todas las editoriales deben ser mostradas, tanto si tienen libros como si no.
-- La consulta debe tener al menos dos columnas: PublisherName y StockMessage.
-- La segunda columna debe ser un campo de c�lculo al vuelo con la siguiente estructura
-- Si el n�mero de libros de la editorial es 1 --> "Hay" + <N�mero de libros> + " libro"
-- Si el n�mero de libros de la editorial es 0 --> "�No hay libros!"
-- En el resto de los casos --> "Hay " + <N�mero de libros> + " libros"

INSERT INTO Library.Publishers ( PublisherID, PublisherName )
VALUES ( 4, N'New Press' );

SELECT
	  P.PublisherName
	, StockMessage =
				CASE COUNT(B.BookID)
					WHEN 1 THEN 'Hay ' + CAST(COUNT(B.BookID) AS char(1)) + ' libros'
					WHEN 0 THEN '�No hay libros!'
					ELSE 'Hay ' + CAST(COUNT(B.BookID) AS varchar(10)) + ' libros'
				END
FROM
	Library.Books					B
	RIGHT JOIN Library.Publishers	P ON B.BookPublisherID = P.PublisherID
GROUP BY
	P.PublisherName;
--


-- EJERCICIO 9
-- Clasifica los libros en orden descendente seg�n su n�mero de p�ginas.
-- Muestra el t�tulo del libro, las p�ginas, el nombre de la editorial, el ISBN y la posici�n seg�n dicha clasificaci�n de cada libro.

SELECT
	  B.BookTitle
	, B.BookPages
	, P.PublisherName
	, B.BookISBN
	, RankPosition = RANK() OVER(ORDER BY BookPages DESC)
FROM
	Library.Books					B
	JOIN Library.Publishers	P ON B.BookPublisherID = P.PublisherID;

--


-- EJERCICIO 10
-- Crea una expresi�n de tabla com�n llamada CTE_BooksWithPages con la consulta del EJERCICIO 9.
-- Crea una nueva tabla e inserta la primera de las tres posiciones en dicha tabla. Esta tabla se llamar� Library.Top3Books
-- Muestra los datos de la tabla Library.Top3Books con un simple seleccionar y verifica los datos.

WITH CTE_BooksWithPages AS
(
	SELECT
		  B.BookTitle
		, B.BookPages
		, P.PublisherName
		, B.BookISBN
		, RankPosition = RANK() OVER(ORDER BY BookPages DESC)
	FROM
		Library.Books					B
		JOIN Library.Publishers	P ON B.BookPublisherID = P.PublisherID
)

SELECT
	TOP 3
	  BookTitle
	, BookPages
	, PublisherName
	, BookISBN
	, RankPosition
INTO 
	Library.Top3Books
FROM
	CTE_BooksWithPages
ORDER BY
	RankPosition;

SELECT 
	  BookTitle
	, BookPages
	, PublisherName
	, BookISBN
	, RankPosition
FROM
	Library.Top3Books;
--


-- EJERCICIO 11
-- Combina el conjunto de resultados de la siguiente declaraci�n con la tabla Library.Books:
--
-- SELECT 
--	  BookTitle
--	, BookPages
-- FROM
--	Library.Top3Books
--
-- Muestra los tres registros de la tabla Library.Top3Books antes que el resto de registros de la tabla Library.Books 
-- Cada libro debe aparecer al menos una vez.
-- Sugerencia: A�ade una columna de autorelleno llamada TablePrio que contenga prio (1="Top3Books", 2="Top3Books") como tabla de origen.
-- Puedes, simplemente, ordenar el conjunto de resultados en un nuevo campo.

SELECT 
  	  BookTitle
	, BookPages
	, TablePrio = 1
FROM
	Library.Top3Books
UNION
SELECT 
	  B.BookTitle
	, B.BookPages
	, TablePrio = 2
FROM
	Library.Books					B
	LEFT JOIN Library.Top3Books		TB ON B.BookISBN = TB.BookISBN
WHERE
	TB.BookISBN IS NULL
ORDER BY TablePrio;
--


-- EJERCICIO 12
-- Crea una tabla temporal con la consulta del EJERCICIO 9. Usa la funci�n CREATE TABLE en lugar de la cl�usula INTO.

CREATE TABLE #temp
(
	  BookTitle nvarchar(50)
	, BookPages smallint
	, PublisherName nvarchar(50)
	, BookISBN varchar(10)
	, RankPosition int
);

INSERT INTO #temp (BookTitle, BookPages, PublisherName, BookISBN, RankPosition)
SELECT
	  B.BookTitle
	, B.BookPages
	, P.PublisherName
	, B.BookISBN
	, RankPosition = RANK() OVER(ORDER BY BookPages DESC)
FROM
	Library.Books					B
	JOIN Library.Publishers	P ON B.BookPublisherID = P.PublisherID;

DROP TABLE #temp;
--


-- EJERCICIO 13
-- Define un procedimiento almacenado llamado Library.proc_Books_FromTempVariable el cual:
-- - crea una variable temporal con la consulta del EJERCICIO 9 
-- - devuelve los datos desde una variable temporal.
-- Llama al procedimiento almacenado para mostrar los resultados.

CREATE PROCEDURE Library.proc_Books_FromTempVariable
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @temp TABLE 
	(
		  BookTitle nvarchar(50)
		, BookPages smallint
		, PublisherName nvarchar(50)
		, BookISBN varchar(10)
		, RankPosition int
	);

	INSERT INTO @temp (BookTitle, BookPages, PublisherName, BookISBN, RankPosition)
	SELECT
		  B.BookTitle
		, B.BookPages
		, P.PublisherName
		, B.BookISBN
		, RankPosition = RANK() OVER(ORDER BY BookPages DESC)
	FROM
		Library.Books					B
		JOIN Library.Publishers	P ON B.BookPublisherID = P.PublisherID

	SELECT 
  		  BookTitle
		, BookPages
		, PublisherName
		, BookISBN
		, RankPosition
	FROM 
		@temp;

END;

EXEC Library.proc_Books_FromTempVariable;
--


-- EJERCICIO 14
-- Crea una funci�n llamada Library.udf_GetNumberOfBooks que devuelva el n�mero de libros seg�n el PublisherID que se le pase (fuci�n escalar)
-- Obt�n la lista de editoriales con el n�mero correspondiente usando dicha funci�n.

CREATE FUNCTION Library.udf_GetNumberOfBooks (@PublisherID smallint)
RETURNS int
AS
BEGIN
  
  DECLARE @Counter int = 0;
  SELECT @Counter = COUNT(*) FROM Library.Books WHERE BookPublisherID = @PublisherID;

  RETURN @Counter;
END;

SELECT
	  PublisherName
	, Books = Library.udf_GetNumberOfBooks(PublisherID)
FROM
	Library.Publishers;
--


-- EJERCICIO 15
-- Crea una funci�n en l�nea llamada Library.udf_BooksByDate que devuelva la lista de libros para un rango espec�fico de fechas (con dos par�metros, date from y to).
-- Prueba a llamarlo pasando '20030301' y '20030331'

CREATE FUNCTION Library.udf_BooksByDate (@FromDate date, @ToDate date)
RETURNS TABLE
AS
RETURN 
  (
     SELECT
		    BookID
		  , BookTitle
		  , BookDescription
		  , BookPages
		  , BookPublisherID
		  , BookDate
		  , BookISBN
	 FROM
		Library.Books   
	 WHERE
		BookDate >= @FromDate 
		AND BookDate <= @ToDate
  );
  
SELECT
	  BookID
	, BookTitle
	, BookDescription
	, BookPages
	, BookPublisherID
	, BookDate
	, BookISBN
FROM
	Library.udf_BooksByDate('20030301', '20030331');
--
