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

create table dbo.Books
(
	BookID int not null IDENTITY(1,1) PRIMARY KEY,
	BookTitle nchar(50) not null,
	BookDescription nchar(255) not null
)

select * from dbo.Books

-- EJERCICIO  2
-- Cambia el esquema de la tabla de dbo a Library

ALTER SCHEMA Library TRANSFER dbo.Books;

select * from Books;

-- EJERCICIO  3
-- A�ade un nuevo campo del tipo entero peque�o (small integer) en la tabla Library.Books llamado BookPages y que no acepte valores nulos (not nullable).
-- A�ade un nuevo campo del tipo entero peque�o (small integer) en la tabla Library.Books llamado BookPublisherID y que no acepte valores nulos (not nullable)
-- A�ade un nuevo campo el tipo fecha en la tabla Library.Books llamado BookDate y que no acepte valores nulos (not nullable)

alter table Library.Books add BookPages smallint not null;
alter table Library.Books add BookPublisherID smallint not null;
alter table Library.Books add BookDate date not null;

-- EJERCICIO  4
-- A�ade un nuevo campo en la tabla Library.Books, ll�malo BookISBN. Que sea del tipo 'non unicode string' (10 chars), 
-- Y aplica una restricci�n �NICA sobre �l. El campo no podr� ser nulo.

alter table Library.Books add BookISBN varchar(10) not null;

alter table Library.Books 
	ADD CONSTRAINT UQ_BookISBN  UNIQUE (
		BookISBN
	);

-- EJERCICIO  5
-- Define una restricci�n CHECK para la columna BookPages. Debe ser mayor que 2.

alter table Library.Books
add constraint CK_LibraryBooks_BookPages
	check(BookPages > 2)

-- EJERCICIO  6
-- A�ade un valor por defecto en la misma columna. El valor es 3.

ALTER TABLE Library.Books ADD CONSTRAINT DF_LibraryBooks_BookPages DEFAULT 3 FOR BookPages;

-- EJERCICIO  7
-- Crea una nueva tabla llamada Library.Publishers seg�n las siguientes especificaciones:
-- PublisherID small integer, PublisherName unicode string (50 chars)
-- La clave primaria en PublisherID asi como ambos campos no aceptar�n valores nulos.
-- Tras haber creado la tabla de forma satisfactoria, crea una relaci�n entre esta tabla
-- y Library.Books (un Publisher/ Editor para varios Books/ Libros) con una restricci�n con clave externa.

create table Library.Publishers
(
	PublisherID smallint not null IDENTITY(1,1) PRIMARY KEY,
	PublisherName nchar(50) not null
)

select * from Library.Publishers

ALTER TABLE Library.Books
    ADD CONSTRAINT FK_LibraryPublishers_Publisher 
	FOREIGN KEY (BookPublisherID)
    REFERENCES Library.Publishers (PublisherID);

-- EJERCICIO  8
-- Crea una vista llamada Library.vw_NewestBooks que muestre los libros que se han publicado este a�o.
-- Muestra �nicamente el T�tulo (Title) y el ISBN del libro.

create view Library.vw_NewestBooks
as 
	select 
		B.BookTitle, 
		B.BookISBN
	from 
		Library.Books B
	where 
		Year(BookDate) >= Year(GetDate());

select * from Library.vw_NewestBooks

-- EJERCICIO  9
-- Modifica la vista a�adiendo el campo BookID.

alter view Library.vw_NewestBooks as 
	select BookTitle, BookISBN, BookID 
	from Library.Books;

-- EJERCICIO  10
-- Crea un sin�nimo de la tabla Library.Books y ll�malo Library.syn_Books

CREATE SYNONYM Library.syn_Books FOR Library.Books;

-- EJERCICIO  11
-- Modifica el sin�nimo Library.syn_Books. Cambia el destino del objeto a la vista vw_NewestBooks

drop synonym Library.syn_Books;
CREATE SYNONYM Library.syn_Books FOR Library.vw_NewestBooks;

-- EJERCICIO  12
-- Reinicializa la identidad en el campo BookID a 100

dbcc checkident('Library.Books', reseed, 100);

-- EJERCICIO  13
-- Crea un desencadenador DDL en la tabla Library.Publishers que se dispare cuando dicha tabla sea modificada y que devuelva el siguiente mensaje: "tabla MODIFICADA".  
-- si quieres sabes cu�les son los eventos permitidos, sigue este enlace: http://msdn.microsoft.com/en-us/library/bb522542.aspx
-- Prueba el desencadenador (trigger) a�adiendo una nueva columna en la tabla , ll�mala PublisherwebSite (non unicode string de 255 chars, nullable).

create trigger tr_Library_Publishers1
on DATABASE
for alter_table
as
	print 'tabla MODIFICADA';

alter table Library.Publishers add PublisherwebSite varchar(255) null;

-- EJERCICIO  14
-- Desactiva el desencadenador check de la tr_tabla e intenta quitar la columna PublisherwebSite. No devolver� ning�n mensaje.
-- Finalmente borra el desencadenador

disable trigger tr_Library_Publishers1 on database;

alter table Library.Publishers drop column PublisherwebSite;

drop trigger tr_Library_Publishers1 on DATABASE;

-- EJERCICIO  15
-- Crea un desencadenador DDL que evite borrar cualquier elemento de la tabla Library.Books.
-- El desencadenador debe devolver EL mensaje "NO PUEDE SER BORRADO NING�N REGISTRO" si un comando de borrado se ejecuta en la tabla.
-- Intenta ejecutar el siguiente comando:
-- DELETE FROM Library.Books
-- Recibir�s el mensaje enviado por el desencadenador.
-- Si recibes dicho mensaje, borra el desencadenador.

create trigger tr_Library_Books1
on AdventureWorks2012.Library.Books
for delete
as
	print 'NO PUEDE SER BORRADO NING�N REGISTRO'
	ROLLBACK TRAN;

DELETE FROM Library.Books;

drop trigger Library.tr_Library_Books1;