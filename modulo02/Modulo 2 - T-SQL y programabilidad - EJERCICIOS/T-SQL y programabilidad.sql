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


-- EJERCICIO 2
-- Extrae la lista de libros que cumplan las siguientes condiciones (una consulta por opci�n):
-- 1 - El t�tulo empieza por "S"
-- 2 - PublisherID es igual a 3
-- 3 - Fecha, entre la medianoche de 2002-02-01 y la medianoche de 2003-03-31
-- Muestra �nicamente el t�tulo y la descripci�n.


-- EJERCICIO 3
-- Actualiza el ID de la editorial de la tabla Library.Books cuyo ISBN sea igual a "1234567". Su nuevo ID ser� 3.


-- EJERCICIO 4
-- Inserta un nuevo registro en la tabla Library.Books y asign�le el ISBN "123456789", los dem�s datos ser�n los mismos que los del
-- libro cuyo ISBN es "12345".
-- Despu�s, borra la fila que has copiado (aquella cuyo ISBN es "12345")


-- EJERCICIO 5
-- Actualiza la tabla Library.Books a�adiendo 50 campos BookPages.
-- Muestra el resultado de las operaciones teniendo en cuenta los valores anteriores de BookPages
-- y el nuevo uso de la cl�usula OUTPUT.


-- EJERCICIO 6
-- Usa una subconsulta en lugar de la cl�usula de la consulta de la tabla Library.Books
-- para filtrar �nicamente la editorial cuyo nombre contiene la palabra "Sample".
-- Muestra solamente el t�tulo y la descripci�n.


-- EJERCICIO 7
-- Escribe una consulta que muestre el t�tulo, el ISBN y el nombre de la editorial de los libros.
-- Ordena el resultado por orden ascendente seg�n el BookTitle.


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


-- EJERCICIO 9
-- Clasifica los libros en orden descendente seg�n su n�mero de p�ginas.
-- Muestra el t�tulo del libro, las p�ginas, el nombre de la editorial, el ISBN y la posici�n seg�n dicha clasificaci�n de cada libro.


-- EJERCICIO 10
-- Crea una expresi�n de tabla com�n llamada CTE_BooksWithPages con la consulta del EJERCICIO 9.
-- Crea una nueva tabla e inserta la primera de las tres posiciones en dicha tabla. Esta tabla se llamar� Library.Top3Books
-- Muestra los datos de la tabla Library.Top3Books con un simple seleccionar y verifica los datos.


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


-- EJERCICIO 12
-- Crea una tabla temporal con la consulta del EJERCICIO 9. Usa la funci�n CREATE TABLE en lugar de la cl�usula INTO.


-- EJERCICIO 13
-- Define un procedimiento almacenado llamado Library.proc_Books_FromTempVariable el cual:
-- - crea una variable temporal con la consulta del EJERCICIO 9 
-- - devuelve los datos desde una variable temporal.
-- Llama al procedimiento almacenado para mostrar los resultados.


-- EJERCICIO 14
-- Crea una funci�n llamada Library.udf_GetNumberOfBooks que devuelva el n�mero de libros seg�n el PublisherID que se le pase (fuci�n escalar)
-- Obt�n la lista de editoriales con el n�mero correspondiente usando dicha funci�n.


-- EJERCICIO 15
-- Crea una funci�n en l�nea llamada Library.udf_BooksByDate que devuelva la lista de libros para un rango espec�fico de fechas (con dos par�metros, date from y to).
-- Prueba a llamarlo pasando '20030301' y '20030331'
