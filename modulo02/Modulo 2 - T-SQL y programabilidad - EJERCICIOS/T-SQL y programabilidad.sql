------------------------------------------------------------
-- EJERCICIOS on MÓDULO 2 - T-SQL
-- 15 EJERCICIOs
--
-- operaciones CRUD
-- uniones
-- agregaciones
-- funciones de categoría
-- expresiones de tabla común
-- objetos temporales
-- procedimientos
-- funciones
-- cláusulas
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
-- Extrae la lista de libros que cumplan las siguientes condiciones (una consulta por opción):
-- 1 - El título empieza por "S"
-- 2 - PublisherID es igual a 3
-- 3 - Fecha, entre la medianoche de 2002-02-01 y la medianoche de 2003-03-31
-- Muestra únicamente el título y la descripción.


-- EJERCICIO 3
-- Actualiza el ID de la editorial de la tabla Library.Books cuyo ISBN sea igual a "1234567". Su nuevo ID será 3.


-- EJERCICIO 4
-- Inserta un nuevo registro en la tabla Library.Books y asignále el ISBN "123456789", los demás datos serán los mismos que los del
-- libro cuyo ISBN es "12345".
-- Después, borra la fila que has copiado (aquella cuyo ISBN es "12345")


-- EJERCICIO 5
-- Actualiza la tabla Library.Books añadiendo 50 campos BookPages.
-- Muestra el resultado de las operaciones teniendo en cuenta los valores anteriores de BookPages
-- y el nuevo uso de la cláusula OUTPUT.


-- EJERCICIO 6
-- Usa una subconsulta en lugar de la cláusula de la consulta de la tabla Library.Books
-- para filtrar únicamente la editorial cuyo nombre contiene la palabra "Sample".
-- Muestra solamente el título y la descripción.


-- EJERCICIO 7
-- Escribe una consulta que muestre el título, el ISBN y el nombre de la editorial de los libros.
-- Ordena el resultado por orden ascendente según el BookTitle.


-- EJERCICIO 8
-- En primer lugar, añade una nueva editorial a la tabla Library.Publishers. Introduce los siguientes valores:
-- PublisherID = 5, PublisherName = "New Press"
--
-- Escribe una consulta que cuente el número de libros correspondientes a cada editorial.
-- Todas las editoriales deben ser mostradas, tanto si tienen libros como si no.
-- La consulta debe tener al menos dos columnas: PublisherName y StockMessage.
-- La segunda columna debe ser un campo de cálculo al vuelo con la siguiente estructura
-- Si el número de libros de la editorial es 1 --> "Hay" + <Número de libros> + " libro"
-- Si el número de libros de la editorial es 0 --> "¡No hay libros!"
-- En el resto de los casos --> "Hay " + <Número de libros> + " libros"


-- EJERCICIO 9
-- Clasifica los libros en orden descendente según su número de páginas.
-- Muestra el título del libro, las páginas, el nombre de la editorial, el ISBN y la posición según dicha clasificación de cada libro.


-- EJERCICIO 10
-- Crea una expresión de tabla común llamada CTE_BooksWithPages con la consulta del EJERCICIO 9.
-- Crea una nueva tabla e inserta la primera de las tres posiciones en dicha tabla. Esta tabla se llamará Library.Top3Books
-- Muestra los datos de la tabla Library.Top3Books con un simple seleccionar y verifica los datos.


-- EJERCICIO 11
-- Combina el conjunto de resultados de la siguiente declaración con la tabla Library.Books:
--
-- SELECT 
--	  BookTitle
--	, BookPages
-- FROM
--	Library.Top3Books
--
-- Muestra los tres registros de la tabla Library.Top3Books antes que el resto de registros de la tabla Library.Books 
-- Cada libro debe aparecer al menos una vez.
-- Sugerencia: Añade una columna de autorelleno llamada TablePrio que contenga prio (1="Top3Books", 2="Top3Books") como tabla de origen.
-- Puedes, simplemente, ordenar el conjunto de resultados en un nuevo campo.


-- EJERCICIO 12
-- Crea una tabla temporal con la consulta del EJERCICIO 9. Usa la función CREATE TABLE en lugar de la cláusula INTO.


-- EJERCICIO 13
-- Define un procedimiento almacenado llamado Library.proc_Books_FromTempVariable el cual:
-- - crea una variable temporal con la consulta del EJERCICIO 9 
-- - devuelve los datos desde una variable temporal.
-- Llama al procedimiento almacenado para mostrar los resultados.


-- EJERCICIO 14
-- Crea una función llamada Library.udf_GetNumberOfBooks que devuelva el número de libros según el PublisherID que se le pase (fución escalar)
-- Obtén la lista de editoriales con el número correspondiente usando dicha función.


-- EJERCICIO 15
-- Crea una función en línea llamada Library.udf_BooksByDate que devuelva la lista de libros para un rango específico de fechas (con dos parámetros, date from y to).
-- Prueba a llamarlo pasando '20030301' y '20030331'
