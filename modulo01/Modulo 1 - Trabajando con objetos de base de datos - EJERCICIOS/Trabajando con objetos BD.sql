------------------------------------------------------------
-- Ejercicios del MÓDULO 1 - Trabajando con objetos de base de datos
-- 15 ejercicios 
--
-- crear esquemas 
-- crear y modificar tablas 
-- mover objetos entre esquemas 
-- añadir restricciones y relaciones
-- crear y modificar vistas
-- crear y modificar sinónimos
-- reinicializar una identidad
-- crear y modificar desencadenadores (triggers)
------------------------------------------------------------

-- AdventureWorks2012 es la base de datos de ejemplo
USE AdventureWorks2012;
GO

-- Crea un esquema para tablas nuevas, llámalo Library
CREATE SCHEMA Library;
GO

-- EJERCICIO  1
-- Crea una tabla llamada Book bajo el esquema dbo con esta estructura:
-- BookID integer, BookTitle unicode string (50 chars), BookDescription unicode string (255 chars)
-- Crea la clave primaria en el campo BookID siendo la especificación de identidad (1 valor de inizalización, 1 incremento)
-- Ninguna columna podrá aceptar valores nulos


-- EJERCICIO  2
-- Cambia el esquema de la tabla de dbo a Library


-- EJERCICIO  3
-- Añade un nuevo campo del tipo entero pequeño (small integer) en la tabla Library.Books llamado BookPages y que no acepte valores nulos (not nullable).
-- Añade un nuevo campo del tipo entero pequeño (small integer) en la tabla Library.Books llamado BookPublisherID y que no acepte valores nulos (not nullable)
-- Añade un nuevo campo el tipo fecha en la tabla Library.Books llamado BookDate y que no acepte valores nulos (not nullable)

-- EJERCICIO  4
-- Añade un nuevo campo en la tabla Library.Books, llámalo BookISBN. Que sea del tipo 'non unicode string' (10 chars), 
-- Y aplica una restricción ÚNICA sobre él. El campo no podrá ser nulo.


-- EJERCICIO  5
-- Define una restricción CHECK para la columna BookPages. Debe ser mayor que 2.


-- EJERCICIO  6
-- Añade un valor por defecto en la misma columna. El valor es 3.


-- EJERCICIO  7
-- Crea una nueva tabla llamada Library.Publishers según las siguientes especificaciones:
-- PublisherID small integer, PublisherName unicode string (50 chars)
-- La clave primaria en PublisherID asi como ambos campos no aceptarán valores nulos.
-- Tras haber creado la tabla de forma satisfactoria, crea una relación entre esta tabla
-- y Library.Books (un Publisher/ Editor para varios Books/ Libros) con una restricción con clave externa.


-- EJERCICIO  8
-- Crea una vista llamada Library.vw_NewestBooks que muestre los libros que se han publicado este año.
-- Muestra únicamente el Título (Title) y el ISBN del libro.


-- EJERCICIO  9
-- Modifica la vista añadiendo el campo BookID.


-- EJERCICIO  10
-- Crea un sinónimo de la tabla Library.Books y llámalo Library.syn_Books


-- EJERCICIO  11
-- Modifica el sinónimo Library.syn_Books. Cambia el destino del objeto a la vista vw_NewestBooks


-- EJERCICIO  12
-- Reinicializa la identidad en el campo BookID a 100


-- EJERCICIO  13
-- Crea un desencadenador DDL en la tabla Library.Publishers que se dispare cuando dicha tabla sea modificada y que devuelva el siguiente mensaje: "tabla MODIFICADA".  
-- si quieres sabes cuáles son los eventos permitidos, sigue este enlace: http://msdn.microsoft.com/en-us/library/bb522542.aspx
-- Prueba el desencadenador (trigger) añadiendo una nueva columna en la tabla , llámala PublisherwebSite (non unicode string de 255 chars, nullable).


-- EJERCICIO  14
-- Desactiva el desencadenador check de la tr_tabla e intenta quitar la columna PublisherwebSite. No devolverá ningún mensaje.
-- Finalmente borra el desencadenador


-- EJERCICIO  15
-- Crea un desencadenador DDL que evite borrar cualquier elemento de la tabla Library.Books.
-- El desencadenador debe devolver EL mensaje "NO PUEDE SER BORRADO NINGÚN REGISTRO" si un comando de borrado se ejecuta en la tabla.
-- Intenta ejecutar el siguiente comando:
-- DELETE FROM Library.Books
-- Recibirás el mensaje enviado por el desencadenador.
-- Si recibes dicho mensaje, borra el desencadenador.
