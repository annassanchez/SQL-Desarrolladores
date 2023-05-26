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

USE [AdventureWorks2012]

GO

CREATE NONCLUSTERED INDEX IX_LibraryBooks_PublisherID ON [Library].[Books]
(
	[BookPublisherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

GO

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

DECLARE @PublisherID int;
SELECT
	  BookTitle
	, BookPages
	, BookISBN
FROM
	Library.Books		B
WHERE
	BookPublisherID	= @PublisherID

CREATE NONCLUSTERED INDEX IX_LibraryBooks_PublisherID_Cover ON [Library].[Books]
(
	[BookPublisherID] ASC
)
INCLUDE (
	  BookTitle
	, BookPages
	, BookISBN
)


-- EJERCICIO 3
-- Crea un índice filtrado llamado IX_LibraryBooks_PublisherID_Filter, siendo el filtro BookPublisherID = 1

CREATE NONCLUSTERED INDEX IX_LibraryBooks_PublisherID_Filter ON [Library].[Books]
(
	[BookPublisherID] ASC
)
WHERE BookPublisherID = 1 ;

-- EJERCICIO 4
-- Crea un índice único en la tabla Library.Publishers (columna PublisherName)

CREATE UNIQUE NONCLUSTERED INDEX uidx_LibraryPublishers_PublisherName
ON Library.Publishers (PublisherName); 

-- EJERCICIO 5
-- Modifica el índice único UX_LibraryPublishers_PublisherName estableciendo la clave IGNORE_DUP_KEY en ON

ALTER INDEX uidx_LibraryPublishers_PublisherName ON
    Library.Publishers
SET (
    IGNORE_DUP_KEY = ON
    )
;

-- EJERCICIO 6
-- Crea un índice no agrupado en Library.Books (columna BookDate) estableciendo el factor de relleno al 90% y el índice de relleno en ON.

CREATE NONCLUSTERED INDEX IX_LibraryBooks_BookDate ON Library.Books
(
	BookDate
)WITH (FILLFACTOR = 90, PAD_INDEX = ON)

GO

-- EJERCICIO 7
-- Elimina el indice IX_LibraryBooks_PublisherID de Library.Books.

DROP INDEX IX_LibraryBooks_PublisherID ON Library.Books; 

-- EJERCICIO 8
-- Desactiva el índice IX_LibraryBooks_BookDate de Library.Books.

ALTER INDEX IX_LibraryBooks_BookDate ON Library.Books  
DISABLE; 

-- EJERCICIO 9
-- Reconstruye todos los índices IX_LibraryBooks_BookDate de Library.Books

ALTER INDEX [IX_LibraryBooks_BookDate] ON [Library].[Books] REBUILD PARTITION = ALL;


-- EJERCICIO 10
-- Elimina el indice IX_LibraryBooks_BookDate y créalo de nuevo usando un proceso online y ordenando los resultados intermedios en un tempdb

DROP INDEX IX_LibraryBooks_BookDate ON Library.Books; 

CREATE NONCLUSTERED INDEX IX_LibraryBooks_BookDate ON Library.Books
(
	BookDate
)WITH (SORT_IN_TEMPDB  = ON)--(ONLINE = ON, SORT_IN_TEMPDB  = ON) -- no lo puedo ejecutar porque es para enterprise, sorry

GO

-- EJERCICIO 11
-- Reorganiza el índice IX_LibraryBooks_BookDate.

USE [AdventureWorks2012]
GO
ALTER INDEX IX_LibraryBooks_BookDate ON Library.Books REORGANIZE  WITH ( LOB_COMPACTION = ON )
GO


-- EJERCICIO 12
-- Actualiza las estadísticas de las tablas Library.Books y Library.Publishers

UPDATE STATISTICS Library.Books;
UPDATE STATISTICS Library.Publishers;

-- EJERCICIO 13
-- Actualiza todas las estadísticas.

EXEC sp_updatestats

-- EJERCICIO 14
-- Averigua el indice que falta en la base de datos AdventureWorks2012 asicomo las columnas necesarias.
-- Sugerencia: usa la función DB_ID() con las vistas de administración dinámica del índice del sistema

SELECT
	    i.index_handle
	  , i.database_id
	  , i.object_id
	  , i.equality_columns
	  , i.inequality_columns
	  , i.included_columns
	  , i.statement
	  , c.column_name
	  , c.column_usage
FROM
	sys.dm_db_missing_index_details i
	CROSS APPLY sys.dm_db_missing_index_columns(index_handle) c
WHERE
	i.database_id = DB_ID('AdventureWorks2012');

-- EJERCICIO 15
-- Anota en la base de datos AdventureWorks2012 los usos de los índices del usuario.
-- Sugerencia: usa la función DB_ID() con las vistas de administración dinámica del índice del sistema.

SELECT 
	    database_id
	  , object_id
	  , index_id
	  , user_seeks
	  , user_scans
	  , user_lookups
	  , user_updates
	  , last_user_seek
	  , last_user_scan
	  , last_user_lookup
	  , last_user_update
FROM 
	sys.dm_db_index_usage_stats 
WHERE
	database_id = DB_ID('AdventureWorks2012');
--
