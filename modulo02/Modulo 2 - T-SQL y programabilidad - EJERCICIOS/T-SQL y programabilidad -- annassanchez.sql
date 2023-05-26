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

-- Usamos AdventureWorks2012, como base de datos de ejemplo
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

SET IDENTITY_INSERT Library.Publishers ON
insert into Library.Publishers(PublisherID, PublisherName)
values(1, 'Editorial Ejemplo'), (2, 'Editorial Ejercicios'), (3, 'Krasis Press')

select * from Library.Publishers

--SET IDENTITY_INSERT Library.Books ON
insert into Library.Books(BookTitle, BookDescription, BookPages, BookPublisherID, BookDate, BookISBN)
values('Sample text', '"Sample text" es un libro de ejemplos', 50, 1, '2001-01-01', 1234)
	, ('Samples in action', '"Samples in action" es un libro con ejemplos', 350, 1, '2002-02-02', 12345)
	, ('Exercise one', '"Exercise one" es un libro de ejercicios', 150, 2, '2003-03-03', 123456)
	, ('Try this exercise', '"Try this exercise" es un libro de ejercicios', 100, 2, '2003-03-03', 1234567)
	, ('Solve it!',	'"Solve it!" es un libro con ejemplos y ejercicios', 200, 3, '2001-01-01', 12345678)

select * from Library.Books


-- EJERCICIO 2
-- Extrae la lista de libros que cumplan las siguientes condiciones (una consulta por opci�n):
-- 1 - El t�tulo empieza por "S"
-- 2 - PublisherID es igual a 3
-- 3 - Fecha, entre la medianoche de 2002-02-01 y la medianoche de 2003-03-31
-- Muestra �nicamente el t�tulo y la descripci�n.

select BookTitle, BookDescription from Library.Books
	where BookTitle LIKE 'S%' 

select BookTitle, BookDescription from Library.Books
	where BookPublisherID = 3 

select BookTitle, BookDescription from Library.Books
	where BookDate >= '2002-02-01' and BookDate < '2003-03-31'

-- EJERCICIO 3
-- Actualiza el ID de la editorial de la tabla Library.Books cuyo ISBN sea igual a "1234567". Su nuevo ID ser� 3.

UPDATE Library.Books
SET BookPublisherID = 3
where BookISBN = '1234567'

select * from Library.Books

-- EJERCICIO 4
-- Inserta un nuevo registro en la tabla Library.Books y asign�le el ISBN "123456789", los dem�s datos ser�n los mismos que los del
-- libro cuyo ISBN es "12345".
-- Despu�s, borra la fila que has copiado (aquella cuyo ISBN es "12345")

insert into Library.Books(BookTitle, BookDescription, BookPages, BookPublisherID, BookDate, BookISBN)
select
	BookTitle, 
	BookDescription, 
	BookPages, 
	BookPublisherID, 
	BookDate, 
	'123456789'
FROM Library.Books
where
	BookISBN = '12345'

DELETE FROM Library.Books WHERE BookISBN = '12345';

select * from Library.Books


-- EJERCICIO 5
-- Actualiza la tabla Library.Books a�adiendo 50 campos BookPages.
-- Muestra el resultado de las operaciones teniendo en cuenta los valores anteriores de BookPages
-- y el nuevo uso de la cl�usula OUTPUT.

UPDATE Library.Books
SET 
	BookPages = BookPages + 50
OUTPUT
	INSERTED.BookPages AS NewBookPages, DELETED.BookPages AS PreviousBookPages;

select * from Library.Books


-- EJERCICIO 6
-- Usa una subconsulta en lugar de la cl�usula de la consulta de la tabla Library.Books
-- para filtrar �nicamente la editorial cuyo nombre contiene la palabra "Krasis".
-- Muestra solamente el t�tulo y la descripci�n.

SELECT BookTitle, BookDescription
FROM Library.Books
WHERE BookPublisherID IN (SELECT BookPublisherID from Library.Publishers where PublisherName like '%Krasis%')

-- EJERCICIO 7
-- Escribe una consulta que muestre el t�tulo, el ISBN y el nombre de la editorial de los libros.
-- Ordena el resultado por orden ascendente seg�n el BookTitle.

SELECT B.BookTitle, B.BookISBN, P.PublisherName
FROM Library.Books B
	join Library.Publishers P on B.BookPublisherID = P.PublisherID
ORDER BY BookTitle ASC;

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

SET IDENTITY_INSERT Library.Publishers ON
insert into Library.Publishers(PublisherID, PublisherName)
values(5, 'New Press')

select * from Library.Publishers

SELECT 
	P.PublisherName,
	StockMessage = (
		CASE COUNT(B.BookID)
			WHEN 1 THEN 'Hay ' + CAST(COUNT(B.BookID) AS char(1)) + ' libros'
			WHEN 0 THEN 'No hay libros'
			ELSE 'Hay ' + CAST(COUNT(B.BookID) AS varchar(10)) + ' libros'
		 END
	)
FROM Library.Books B
	join Library.Publishers P on B.BookPublisherID = P.PublisherID
GROUP BY
	P.PublisherName;

-- EJERCICIO 9
-- Clasifica los libros en orden descendente seg�n su n�mero de p�ginas.
-- Muestra el t�tulo del libro, las p�ginas, el nombre de la editorial, el ISBN y la posici�n seg�n dicha clasificaci�n de cada libro.

SELECT B.BookTitle
	, B.BookPages
	, B.BookISBN
	, P.PublisherName
	, ClasificationPosition = (
		rANK() OVER (ORDER BY B.BookPages DESC) 
	)
FROM Library.Books B
	join Library.Publishers P on B.BookPublisherID = P.PublisherID

-- EJERCICIO 10
-- Crea una expresi�n de tabla com�n llamada CTE_BooksWithPages con la consulta del EJERCICIO 9.
-- Crea una nueva tabla e inserta la primera de las tres posiciones en dicha tabla. Esta tabla se llamar� Library.Top3Books
-- Muestra los datos de la tabla Library.Top3Books con un simple seleccionar y verifica los datos.

with CTE_BooksWithPages as
(
	SELECT B.BookTitle
		, B.BookPages
		, B.BookISBN
		, P.PublisherName
		, ClasificationPosition = (
			RANK() OVER (ORDER BY B.BookPages DESC) 
		)
	FROM Library.Books B
		join Library.Publishers P on B.BookPublisherID = P.PublisherID
)

SELECT
	TOP 3
	  BookTitle
	, BookPages
	, PublisherName
	, BookISBN
	, ClasificationPosition
INTO 
	Library.Top3Books 
FROM 
    CTE_BooksWithPages
ORDER BY
	ClasificationPosition

select * from Library.Top3Books 

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
	Library.Top3Books T
	right join Library.Books B on B.BookISBN = T. BookISBN
WHERE
	T.BookISBN IS NULL
Order By 
	TablePrio

-- EJERCICIO 12
-- Crea una tabla temporal con la consulta del EJERCICIO 9. Usa la funci�n CREATE TABLE en lugar de la cl�usula INTO.
DROP TABLE #temp;

CREATE TABLE #temp (
	BookTitle nchar(50) not null,
	BookPages smallint not null,
	BookISBN varchar(10) not null,
	PublisherName nchar(50) not null,
	ClasificationPosition int
)

INSERT INTO #temp (BookTitle, BookPages, BookISBN, PublisherName, ClasificationPosition)
SELECT B.BookTitle
	, B.BookPages
	, B.BookISBN
	, P.PublisherName
	, ClasificationPosition = (
		rANK() OVER (ORDER BY B.BookPages DESC) 
	)
FROM Library.Books B
	join Library.Publishers P on B.BookPublisherID = P.PublisherID

select * from #temp

-- EJERCICIO 13
-- Define un procedimiento almacenado llamado Library.proc_Books_FromTempVariable el cual:
-- - crea una variable temporal con la consulta del EJERCICIO 9 
-- - devuelve los datos desde una variable temporal.
-- Llama al procedimiento almacenado para mostrar los resultados.

CREATE PROCEDURE Library.proc_Books_FromTempVariable
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @temp TABLE  (
		BookTitle nchar(50) not null,
		BookPages smallint not null,
		BookISBN varchar(10) not null,
		PublisherName nchar(50) not null,
		ClasificationPosition int
	)


	INSERT INTO @temp (BookTitle, BookPages, BookISBN, PublisherName, ClasificationPosition)
	SELECT B.BookTitle
		, B.BookPages
		, B.BookISBN
		, P.PublisherName
		, ClasificationPosition = (
			rANK() OVER (ORDER BY B.BookPages DESC) 
		)
	FROM Library.Books B
		join Library.Publishers P on B.BookPublisherID = P.PublisherID

	SELECT BookTitle
		, BookPages
		, BookISBN
		, PublisherName
		, ClasificationPosition
	FROM
		@temp;
END
GO

EXEC Library.proc_Books_FromTempVariable;

-- EJERCICIO 14
-- Crea una funci�n llamada Library.udf_GetNumberOfBooks que devuelva el n�mero de libros seg�n el PublisherID que se le pase (fuci�n escalar)
-- Obt�n la lista de editoriales con el n�mero correspondiente usando dicha funci�n.

select * from Library.Books

CREATE FUNCTION Library.udf_GetNumberOfBooks
(
	-- Add the parameters for the function here
	@PublisherID smallint
)
RETURNS int
AS
BEGIN

	-- Declare the return variable here

	DECLARE @Result int = 0;

	-- Add the T-SQL statements to compute the return value here

	SELECT @Result = Count(*)
	from Library.Books
	where BookPublisherID = @PublisherID

	-- Return the result of the function

	RETURN @Result

END
GO

SELECT
	  PublisherName
	, Books = Library.udf_GetNumberOfBooks(PublisherID)
FROM
	Library.Publishers;

-- EJERCICIO 15
-- Crea una funci�n en l�nea llamada Library.udf_BooksByDate que devuelva la lista de libros para un rango espec�fico de fechas (con dos par�metros, date from y to).
-- Prueba a llamarlo pasando '20030301' y '20030331'

select * from Library.Books

CREATE FUNCTION Library.udf_BooksByDate (@StartDate date, @EndDate date)
RETURNS 
TABLE
--@Table_Var TABLE 
--(
	-- Add the column definitions for the TABLE variable here
--	BookTitle nchar(50) not null,
--	BookDate date not null 
--)
AS
--BEGIN
RETURN
	-- Fill the table variable with the rows for your result set
	--insert into @Table_Var(BookTitle)
	select 	BookID
		  , BookTitle
		  , BookDescription
		  , BookPages
		  , BookPublisherID
		  , BookDate
		  , BookISBN
	from Library.Books
	where BookDate >= @StartDate
		and	BookDate <= @EndDate


SELECT
	  BookID
	, BookTitle
	, BookDescription
	, BookPages
	, BookPublisherID
	, BookDate
	, BookISBN
	
FROM
	Library.udf_BooksByDate('20030301', '20030331')

