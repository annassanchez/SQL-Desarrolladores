------------------------------------------------------------
-- Ejercicios del MÓDULO 4 - Transacciones
-- 10 ejercicios
--
-- transacciones explícitas
-- administración de @@ERROR
-- intentando dominar el control de errores
-- XACT_ABORT
-- XACT_STATE()
-- @@TRANCOUNT
-- transacciones anidadas
-- niveles de aislamiento
-- sugerencias de tabla
------------------------------------------------------------

-- AdventureWorks2012 es la base de datos de ejemplo
USE AdventureWorks2012;
GO

-- EJERCICIO 1
-- Ejecuta dos comandos de inserción (el primero sobre Library.Publishers y el segundo sobre Library.Books)
-- Valores para el primero: PublisherID = 10, PublisherName = "Press Ten"
-- Valores para el segundo: Title = "Title Ten", Description = "Book number 10", Pages = 300, Publisher = 10, Date = GETDATE(), BookISBN = "111"
-- dentro de la misma transacción

BEGIN TRAN; -- 

	insert into Library.Publishers (PublisherID, PublisherName)
	values(10, 'Press Ten');

	insert into Library.Books (BookTitle, BookDescription, BookPages, BookPublisherID, BookDate, BookISBN)
	values('Title Ten', 'Book Number 10', 300, 10, GETDATE(), '111');

COMMIT TRAN;

-- EJERCICIO 2
-- Ejecuta los dos comandos del ejercicio 1 y comprueba el número de error obtenido (@@ERROR number).
-- Si es mayor que 0, muestra el mensaje "ERROR" y deshaz la transacción si es necesario.

BEGIN TRAN; -- 

	insert into Library.Publishers (PublisherID, PublisherName)
	values(10, 'Press Ten');

	IF @@ERROR > 0
		BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		PRINT 'ERROR'
	END;

	insert into Library.Books (BookTitle, BookDescription, BookPages, BookPublisherID, BookDate, BookISBN)
	values('Title Ten', 'Book Number 10', 300, 10, GETDATE(), '111');

	IF @@ERROR > 0
		BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		PRINT 'ERROR'
	END;


COMMIT TRAN;

-- EJERCICIO 3
-- Abre una transacción explícita y ejecuta los siguientes comandos dentro de la transacción:
--
-- INSERT INTO Library.Publishers (PublisherID, PublisherName)
-- VALUES (11, N'Press Eleven');
-- INSERT INTO Library.Publishers (PublisherID, PublisherName)
-- VALUES (12, N'Press Eleven');
--
-- Muestra el número de las transacciones activas actualmente, dentro de la transacción y después del commit tran.

select * from Library.Publishers
select * from Library.Books

BEGIN TRAN; -- 

	insert into Library.Publishers (PublisherID, PublisherName)
	values(11, 'Press Eleven');

	insert into Library.Publishers (PublisherID, PublisherName)
	values(12, 'Press Twelve');

	select @@TRANCOUNT

COMMIT TRAN;

select @@TRANCOUNT

-- EJERCICIO 4
-- Abre tres transacciones vacías anidadas y deshaz la más interna. 
-- Muestra el número de transacciones en el inicio de cada una y después de revertirla.
-- El resultado esperado es: 1,2,3,0

BEGIN TRAN; -- 

	select @@TRANCOUNT
	BEGIN TRAN; -- 

		select @@TRANCOUNT
		
		BEGIN TRAN; -- 

			select @@TRANCOUNT

			IF @@TRANCOUNT > 0 ROLLBACK TRAN;

			select @@TRANCOUNT



-- EJERCICIO 5
-- Abre tres transacciones vacías (una externa, las otras dos al mismo nivel)
-- Confirma la primera transacción anidada y revierte la última transacción abierta.
-- Muestra el número de transacciones en el inicio de cada una, después de confirmarla y tras revertirla.
-- El resultado esperado es: 1,2,1,2,0

BEGIN TRAN; -- 
	select @@TRANCOUNT
	BEGIN TRAN; -- 
		select @@TRANCOUNT
	COMMIT TRAN;
	select @@TRANCOUNT
	BEGIN TRAN; -- 
		select @@TRANCOUNT
		IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		select @@TRANCOUNT

-- EJERCICIO 6
-- Maneja el error división por cero usando el bloque try catch dentro de la transacción.
-- Si el error no sucede, confirma la transacción

BEGIN TRAN;
	begin try
		SELECT 1 / 0;
	end try	
	begin catch
		if @@TRANCOUNT > 0 rollback tran; -- esto ya pararía el commit tran posterior
		select ERROR_MESSAGE(), ERROR_STATE(), ERROR_NUMBER()
	end catch
if @@TRANCOUNT > 0 COMMIT tran;

-- EJERCICIO 7
-- Maneja el error división por cero usando la función the XACT_STATE() para comprender si la transacción es confirmable o no.
-- Si no lo es, deshazla.

SET XACT_ABORT ON;


begin try
	BEGIN TRAN;
		SELECT 1 / 0;
	COMMIT TRAN;
end try	
begin catch
	if XACT_STATE() = -1
	begin
		SELECT 'ROLLBACK'
		rollback tran;
	end
	if XACT_STATE() = 1
	begin
		SELECT 'COMMIT'
		commit tran;
	end
end catch

-- EJERCICIO 8
-- Abre una transacción explícita y ejecuta la siguiente declaración actualizada en la tabla Library.Books:
-- UPDATE Library.Books
-- SET BookTitle = 'Changed Book'
-- WHERE BookISBN = '111'
-- Deja la trasacción abierta. Abre una nueva ventana de consulta e intenta leer el libro con BookISBN = '111'
-- Usa el nivel de aislalmiento READ COMMITTED (el nivel por defecto).
-- Comportamiento esperado: La segunda ventana debe esperar para confirmar o deshacer la transacción a que termine la primera consulta.
-- Deshaz la transacción en la primera ventana. La segunda ventana debe mostrar el resultado del primer registro solicitado.

select * from Library.Books;

set identity_insert Library.Books on;

insert into Library.Books (BookID, BookTitle, BookDescription, BookPages, BookPublisherID, BookDate, BookISBN)
values (107, 'Nuevo Título', 'Otro Libro', 213, 1, '2021-11-04', 111)

--set transaction isolation level read committed;

BEGIN TRAN;
	UPDATE Library.Books
	SET BookTitle = 'Changed Book'
	WHERE BookISBN = '111'
-- rollback tran

-- segunda ventana
select * from Library.Books where BookISBN = '111'

-- EJERCICIO 9
-- Abre una transacción explícita y ejecuta la siguiente instrucción de actualización en la tablaLibrary.Books:
-- UPDATE Library.Books
-- SET BookTitle = 'Changed Book'
-- WHERE BookISBN = '111'
-- Deja la trasacción abierta. Abre una nueva ventana de consulta e intenta leer el libro con BookISBN = '111'
-- Usa el nivel de aislalmiento READ UNCOMMITTED (con un conjunto de opciones en ambas ventanas).
-- Comportamiento esperado: La segunda ventana tiene que mostrar el registro solicitado en una versión no confirmada.
-- Deshaz la transacción en la primera ventana y reintenta ejecutar el segundo comando. Los datos deben ser distintos que los de la primera lectura:
-- primera llamada: Title = "Changed Book"
-- segunda llamada: Title = "Title Ten"

BEGIN TRAN;
	UPDATE Library.Books
	SET BookTitle = 'Changed Book'
	WHERE BookISBN = '111'
 rollback tran

-- segunda ventana
set transaction isolation level read uncommitted;
select * from Library.Books where BookISBN = '111'

-- EJERCICIO 10
-- Repite el ejercicio 9 usando ahora las sugerencias de tabla.

BEGIN TRAN;
	UPDATE Library.Books
	SET BookTitle = 'Changed Book'
	WHERE BookISBN = '111'
 rollback tran

-- segunda ventana
select * from Library.Books with (NOLOCK)
where BookISBN = '111' ;