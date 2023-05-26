------------------------------------------------------------
-- Ejercicios del M�DULO 1 - Trabajando con objetos de base de datos
-- 15 ejercicios 
--
-- crear esquemas 
-- crear y modificar tablas 
-- mover objetos entre esquemas 
-- a�adir restricciones y relaciones
-- crear y modificar vistas
-- crear y modificar sin�nimos
-- reinicializar una identidad
-- crear y modificar desencadenadores (triggers)
------------------------------------------------------------

-- AdventureWorks2012 es la base de datos de ejemplo
USE AdventureWorks2012;
GO

-- Crea un esquema para tablas nuevas, ll�malo Library
CREATE SCHEMA Library;
GO

-- EJERCICIO  1
-- Crea una tabla llamada Book bajo el esquema dbo con esta estructura:
-- BookID integer, BookTitle unicode string (50 chars), BookDescription unicode string (255 chars)
-- Crea la clave primaria en el campo BookID siendo la especificaci�n de identidad (1 valor de inizalizaci�n, 1 incremento)
-- Ninguna columna podr� aceptar valores nulos

CREATE TABLE dbo.Books
(
	  BookID int IDENTITY(1, 1) NOT NULL
    , BookTitle nvarchar(50) NOT NULL
    , BookDescription nvarchar(255) NOT NULL
    , CONSTRAINT PK_LibraryBooks PRIMARY KEY CLUSTERED
	(
		BookID
	)
);


-- EJERCICIO  2
-- Cambia el esquema de la tabla de dbo a Library
ALTER SCHEMA Library TRANSFER dbo.Books;


-- EJERCICIO  3
-- A�ade un nuevo campo del tipo entero peque�o (small integer) en la tabla Library.Books llamado BookPages y que no acepte valores nulos (not nullable).
-- A�ade un nuevo campo del tipo entero peque�o (small integer) en la tabla Library.Books llamado BookPublisherID y que no acepte valores nulos (not nullable)
-- A�ade un nuevo campo el tipo fecha en la tabla Library.Books llamado BookDate y que no acepte valores nulos (not nullable)

ALTER TABLE Library.Books ADD BookPages smallint NOT NULL;
ALTER TABLE Library.Books ADD BookPublisherID smallint NOT NULL;
ALTER TABLE Library.Books ADD BookDate date NOT NULL;


-- EJERCICIO  4
-- A�ade un nuevo campo en la tabla Library.Books, ll�malo BookISBN. Que sea del tipo 'non unicode string' (10 chars), 
-- Y aplica una restricci�n �NICA sobre �l. El campo no podr� ser nulo.

ALTER TABLE Library.Books ADD BookISBN varchar(10) NOT NULL;

ALTER TABLE Library.Books ADD 
	CONSTRAINT UK_LibraryBooks_BookISBN UNIQUE NONCLUSTERED 
	(
		BookISBN
	);



-- EJERCICIO  5
-- Define una restricci�n CHECK para la columna BookPages. Debe ser mayor que 2.

ALTER TABLE Library.Books ADD
	CONSTRAINT CK_LibraryBooks_BookPages_GreatherThan CHECK
	(
		BookPages > 2
	);



-- EJERCICIO  6
-- A�ade un valor por defecto en la misma columna. El valor es 3.

ALTER TABLE Library.Books ADD
	CONSTRAINT DF_LibraryBooks_BookPages DEFAULT (3) FOR BookPages;



-- EJERCICIO  7
-- Crea una nueva tabla llamada Library.Publishers seg�n las siguientes especificaciones:
-- PublisherID small integer, PublisherName unicode string (50 chars)
-- La clave primaria en PublisherID asi como ambos campos no aceptar�n valores nulos.
-- Tras haber creado la tabla de forma satisfactoria, crea una relaci�n entre esta tabla
-- y Library.Books (un Publisher/ Editor para varios Books/ Libros) con una restricci�n con clave externa.

CREATE TABLE Library.Publishers
(
	  PublisherID smallint NOT NULL  
    , PublisherName nvarchar(50) NOT NULL
  , CONSTRAINT PK_LibraryPublishers PRIMARY KEY
  (
	  PublisherID
  )
);

ALTER TABLE Library.Books ADD 
	CONSTRAINT FK_LibraryBooks_LibraryPublishers FOREIGN KEY (BookPublisherID) 
	REFERENCES Library.Publishers (PublisherID);



-- EJERCICIO  8
-- Crea una vista llamada Library.vw_NewestBooks que muestre los libros que se han publicado este a�o.
-- Muestra �nicamente el T�tulo (Title) y el ISBN del libro.

CREATE VIEW Library.vw_NewestBooks
AS
	SELECT
		  B.BookISBN
		, B.BookTitle
	FROM
		Library.Books		B  
	WHERE
		YEAR(BookDate) >=  YEAR(GETDATE());


-- EJERCICIO  9
-- Modifica la vista a�adiendo el campo BookID.

ALTER VIEW Library.vw_NewestBooks
AS
	SELECT
		  B.BookISBN
		, B.BookTitle
		, BookID
	FROM
		Library.Books		B  
	WHERE
		YEAR(BookDate) >=  YEAR(GETDATE());



-- EJERCICIO  10
-- Crea un sin�nimo de la tabla Library.Books y ll�malo Library.syn_Books

CREATE SYNONYM Library.syn_Books FOR Library.Books;


-- EJERCICIO  11
-- Modifica el sin�nimo Library.syn_Books. Cambia el destino del objeto a la vista vw_NewestBooks

DROP SYNONYM Library.syn_Books;
CREATE SYNONYM Library.syn_Books FOR Library.vw_NewestBooks;


-- EJERCICIO  12
-- Reinicializa la identidad en el campo BookID a 100

DBCC CHECKIDENT('Library.Books', RESEED, 100);



-- EJERCICIO  13
-- Crea un desencadenador DDL en la tabla Library.Publishers que se dispare cuando dicha tabla sea modificada y que devuelva el siguiente mensaje: "tabla MODIFICADA".  
-- si quieres sabes cu�les son los eventos permitidos, sigue este enlace: http://msdn.microsoft.com/en-us/library/bb522542.aspx
-- Prueba el desencadenador (trigger) a�adiendo una nueva columna en la tabla , ll�mala PublisherwebSite (non unicode string de 255 chars, nullable).

CREATE TRIGGER tr_TableCheck ON DATABASE FOR ALTER_TABLE
AS 
	PRINT 'TABLE MODIFIED';
GO

ALTER TABLE Library.Publishers ADD PublisherwebSite varchar(255) NULL;



-- EJERCICIO  14
-- Desactiva el desencadenador check de la tr_tabla e intenta quitar la columna PublisherwebSite. No devolver� ning�n mensaje.
-- Finalmente borra el desencadenador

DISABLE TRIGGER tr_TableCheck ON DATABASE;
ALTER TABLE Library.Publishers DROP COLUMN PublisherwebSite;

DROP TRIGGER tr_TableCheck ON DATABASE;



-- EJERCICIO  15
-- Crea un desencadenador DDL que evite borrar cualquier elemento de la tabla Library.Books.
-- El desencadenador debe devolver EL mensaje "NO PUEDE SER BORRADO NING�N REGISTRO" si un comando de borrado se ejecuta en la tabla.
-- Intenta ejecutar el siguiente comando:
-- DELETE FROM Library.Books
-- Recibir�s el mensaje enviado por el desencadenador.
-- Si recibes dicho mensaje, borra el desencadenador.

CREATE TRIGGER Library.Books_PreventDelete ON Library.Books
AFTER DELETE
AS
	PRINT 'CANNOT DELETE ANY RECORD';
	ROLLBACK TRAN;

DELETE FROM Library.Books

DROP TRIGGER Library.Books_PreventDelete;

