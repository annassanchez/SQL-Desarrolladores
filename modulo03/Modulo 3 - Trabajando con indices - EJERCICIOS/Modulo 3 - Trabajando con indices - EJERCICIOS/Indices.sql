------------------------------------------------------------
-- EJERCICIOS DEL MÓDULO 3 - Índices
-- 15 ejercicios
--
-- crear índices
-- modificar índices
-- opcciones de índice
-- eliminar índices 
-- índice único
-- columnas incluidas
-- reconstruir y reorganizar
-- índices filtrados
-- actualizar estadísticas
-- vistas de administración dinámica para usos de índice
-- vistas de administración dinámica para índices que faltan
------------------------------------------------------------

-- AdventureWorks2012 es la base de datos de ejemplo
USE AdventureWorks2012;
GO

-- EJERCICIO 1
-- Crea un índice no agrupado llamado IX_LibraryBooks_PublisherID en la tabla Library.Books (columna BookPublisherID). 


-- EJERCICIO 2
-- Selecciona las columnas incluidas necesarias para esta consulta:
--DECLARE @PublisherID int;

--SELECT
--	  BookTitle
--	, BookPages
--	, BookISBN
--FROM
--	Library.Books		B
--WHERE
--	BookPublisherID	= @PublisherID
-- 
-- Después, añádelas en el nuevo índice llamado IX_LibraryBooks_PublisherID_Cover.


-- EJERCICIO 3
-- Crea un índice filtrado llamado IX_LibraryBooks_PublisherID_Filter, siendo el filtro BookPublisherID = 1


-- EJERCICIO 4
-- Crea un índice único en la tabla Library.Publishers (columna PublisherName)


-- EJERCICIO 5
-- Modifica el índice único UX_LibraryPublishers_PublisherName estableciendo la clave IGNORE_DUP_KEY en ON


-- EJERCICIO 6
-- Crea un índice no agrupado en Library.Books (columna BookDate) estableciendo el factor de relleno al 90% y el índice de relleno en ON.


-- EJERCICIO 7
-- Elimina el indice IX_LibraryBooks_PublisherID de Library.Books.


-- EJERCICIO 8
-- Desactiva el índice IX_LibraryBooks_BookDate de Library.Books.


-- EJERCICIO 9
-- Reconstruye todos los índices IX_LibraryBooks_BookDate de Library.Books


-- EJERCICIO 10
-- Elimina el indice IX_LibraryBooks_BookDate y créalo de nuevo usando un proceso online y ordenando los resultados intermedios en un tempdb


-- EJERCICIO 11
-- Reorganiza el índice IX_LibraryBooks_BookDate.


-- EJERCICIO 12
-- Actualiza las estadísticas de las tablas Library.Books y Library.Publishers


-- EJERCICIO 13
-- Actualiza todas las estadísticas.


-- EJERCICIO 14
-- Averigua el indice que falta en la base de datos AdventureWorks2012 asicomo las columnas necesarias.
-- Sugerencia: usa la función DB_ID() con las vistas de administración dinámica del índice del sistema


-- EJERCICIO 15
-- Anota en la base de datos AdventureWorks2012 los usos de los índices del usuario.
-- Sugerencia: usa la función DB_ID() con las vistas de administración dinámica del índice del sistema.