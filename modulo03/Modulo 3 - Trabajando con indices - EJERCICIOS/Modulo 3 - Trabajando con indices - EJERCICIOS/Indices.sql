------------------------------------------------------------
-- EJERCICIOS DEL M�DULO 3 - �ndices
-- 15 ejercicios
--
-- crear �ndices
-- modificar �ndices
-- opcciones de �ndice
-- eliminar �ndices 
-- �ndice �nico
-- columnas incluidas
-- reconstruir y reorganizar
-- �ndices filtrados
-- actualizar estad�sticas
-- vistas de administraci�n din�mica para usos de �ndice
-- vistas de administraci�n din�mica para �ndices que faltan
------------------------------------------------------------

-- AdventureWorks2012 es la base de datos de ejemplo
USE AdventureWorks2012;
GO

-- EJERCICIO 1
-- Crea un �ndice no agrupado llamado IX_LibraryBooks_PublisherID en la tabla Library.Books (columna BookPublisherID). 


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
-- Despu�s, a��delas en el nuevo �ndice llamado IX_LibraryBooks_PublisherID_Cover.


-- EJERCICIO 3
-- Crea un �ndice filtrado llamado IX_LibraryBooks_PublisherID_Filter, siendo el filtro BookPublisherID = 1


-- EJERCICIO 4
-- Crea un �ndice �nico en la tabla Library.Publishers (columna PublisherName)


-- EJERCICIO 5
-- Modifica el �ndice �nico UX_LibraryPublishers_PublisherName estableciendo la clave IGNORE_DUP_KEY en ON


-- EJERCICIO 6
-- Crea un �ndice no agrupado en Library.Books (columna BookDate) estableciendo el factor de relleno al 90% y el �ndice de relleno en ON.


-- EJERCICIO 7
-- Elimina el indice IX_LibraryBooks_PublisherID de Library.Books.


-- EJERCICIO 8
-- Desactiva el �ndice IX_LibraryBooks_BookDate de Library.Books.


-- EJERCICIO 9
-- Reconstruye todos los �ndices IX_LibraryBooks_BookDate de Library.Books


-- EJERCICIO 10
-- Elimina el indice IX_LibraryBooks_BookDate y cr�alo de nuevo usando un proceso online y ordenando los resultados intermedios en un tempdb


-- EJERCICIO 11
-- Reorganiza el �ndice IX_LibraryBooks_BookDate.


-- EJERCICIO 12
-- Actualiza las estad�sticas de las tablas Library.Books y Library.Publishers


-- EJERCICIO 13
-- Actualiza todas las estad�sticas.


-- EJERCICIO 14
-- Averigua el indice que falta en la base de datos AdventureWorks2012 asicomo las columnas necesarias.
-- Sugerencia: usa la funci�n DB_ID() con las vistas de administraci�n din�mica del �ndice del sistema


-- EJERCICIO 15
-- Anota en la base de datos AdventureWorks2012 los usos de los �ndices del usuario.
-- Sugerencia: usa la funci�n DB_ID() con las vistas de administraci�n din�mica del �ndice del sistema.