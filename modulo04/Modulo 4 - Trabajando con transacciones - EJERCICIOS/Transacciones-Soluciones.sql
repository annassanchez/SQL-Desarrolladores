------------------------------------------------------------
-- Ejercicios del M�DULO 4 - Transacciones
-- 10 ejercicios
--
-- transacciones expl�citas
-- administraci�n de @@ERROR
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
-- Ejecuta dos comandos de inserci�n (el primero sobre Library.Publishers y el segundo sobre Library.Books)
-- Valores para el primero: PublisherID = 10, PublisherName = "Press Ten"
-- Valores para el segundo: Title = "Title Ten", Description = "Book number 10", Pages = 300, Publisher = 10, Date = GETDATE(), BookISBN = "111"
-- dentro de la misma transacci�n

BEGIN TRAN;

	INSERT INTO Library.Publishers (PublisherID, PublisherName)
	VALUES (10, N'Press Ten');

	INSERT INTO Library.Books (BookTitle, BookDescription, BookPages, BookPublisherID, BookDate, BookISBN)
	VALUES (N'Title Ten', N'Book number 10', 300, 10, GETDATE(), '111');

COMMIT TRAN;
--


-- EJERCICIO 2
-- Ejecuta los dos comandos del ejercicio 1 y comprueba el n�mero de error obtenido (@@ERROR number).
-- Si es mayor que 0, muestra el mensaje "ERROR" y deshaz la transacci�n si es necesario.

BEGIN TRAN

	INSERT INTO Library.Publishers (PublisherID, PublisherName)
	VALUES (10, N'Press Ten');

	IF @@ERROR > 0
	BEGIN
		IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		PRINT 'ERROR'
	END;

	INSERT INTO Library.Books (BookTitle, BookDescription, BookPages, BookPublisherID, BookDate, BookISBN)
	VALUES (N'Title Ten', N'Book number 10', 300, 10, GETDATE(), '111')

	IF @@ERROR > 0
	BEGIN
		IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		PRINT 'ERROR'
	END;

IF @@TRANCOUNT > 0 COMMIT TRAN;
--


-- EJERCICIO 3
-- Abre una transacci�n expl�cita y ejecuta los siguientes comandos dentro de la transacci�n:
--
-- INSERT INTO Library.Publishers (PublisherID, PublisherName)
-- VALUES (11, N'Press Eleven');
-- INSERT INTO Library.Publishers (PublisherID, PublisherName)
-- VALUES (12, N'Press Eleven');
--
-- Muestra el n�mero de las transacciones activas actualmente, dentro de la transacci�n y despu�s del commit tran.

BEGIN TRAN;

	INSERT INTO Library.Publishers (PublisherID, PublisherName)
	VALUES (11, N'Press Eleven');

	INSERT INTO Library.Publishers (PublisherID, PublisherName)
	VALUES (12, N'Press Eleven');

	SELECT @@TRANCOUNT;

COMMIT TRAN;

SELECT @@TRANCOUNT;
--


-- EJERCICIO 4
-- Abre tres transacciones vac�as anidadas y deshaz la m�s interna. 
-- Muestra el n�mero de transacciones en el inicio de cada una y despu�s de revertirla.
-- El resultado esperado es: 1,2,3,0

BEGIN TRAN;
	SELECT @@TRANCOUNT;
	BEGIN TRAN;
		SELECT @@TRANCOUNT;
		BEGIN TRAN;  
			SELECT @@TRANCOUNT;

			IF @@TRANCOUNT > 0 ROLLBACK TRAN;
			SELECT @@TRANCOUNT;
--


-- EJERCICIO 5
-- Abre tres transacciones vac�as (una externa, las otras dos al mismo nivel)
-- Confirma la primera transacci�n anidada y revierte la �ltima transacci�n abierta.
-- Muestra el n�mero de transacciones en el inicio de cada una, despu�s de confirmarla y tras revertirla.
-- El resultado esperado es: 1,2,1,2,0

BEGIN TRAN;
	SELECT @@TRANCOUNT;
	BEGIN TRAN;
		SELECT @@TRANCOUNT;
	COMMIT TRAN;
	SELECT @@TRANCOUNT;
	BEGIN TRAN;  
		SELECT @@TRANCOUNT;

		IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		SELECT @@TRANCOUNT;
--


-- EJERCICIO 6
-- Maneja el error divisi�n por cero usando el bloque try catch dentro de la transacci�n.
-- Si el error no sucede, confirma la transacci�n

BEGIN TRAN;

	BEGIN TRY
		SELECT 1/0;
	END TRY
	BEGIN CATCH
		SELECT ERROR_NUMBER(), ERROR_MESSAGE();
		IF @@TRANCOUNT > 0 ROLLBACK TRAN;
	END CATCH

IF @@TRANCOUNT > 0 COMMIT TRAN;
--


-- EJERCICIO 7
-- Maneja el error divisi�n por cero usando la funci�n the XACT_STATE() para comprender si la transacci�n es confirmable o no.
-- Si no lo es, deshazla.

SET XACT_ABORT ON;

BEGIN TRY
	BEGIN TRAN;
		SELECT 1/0;
	COMMIT TRAN;
END TRY
BEGIN CATCH
	IF XACT_STATE() = -1
	BEGIN 
		SELECT 'ROLLBACK'
		ROLLBACK TRAN;
	END;

	IF XACT_STATE() = 1
	BEGIN 
		SELECT 'COMMIT'
		COMMIT TRAN;
	END;
END CATCH
--


-- EJERCICIO 8
-- Abre una transacci�n expl�cita y ejecuta la siguiente declaraci�n actualizada en la tabla Library.Books:
-- UPDATE Library.Books
-- SET BookTitle = 'Changed Book'
-- WHERE BookISBN = '111'
-- Deja la trasacci�n abierta. Abre una nueva ventana de consulta e intenta leer el libro con BookISBN = '111'
-- Usa el nivel de aislalmiento READ COMMITTED (el nivel por defecto).
-- Comportamiento esperado: La segunda ventana debe esperar para confirmar o deshacer la transacci�n a que termine la primera consulta.
-- Deshaz la transacci�n en la primera ventana. La segunda ventana debe mostrar el resultado del primer registro solicitado.

-- Consulta en la primera ventana
BEGIN TRAN;
	 UPDATE Library.Books
	 SET BookTitle = 'Changed Book'
	 WHERE BookISBN = '111';
-- ROLLBACK TRAN

-- Segunda ventana
SELECT * FROM Library.Books WHERE BookISBN = '111';
--


-- EJERCICIO 9
-- Abre una transacci�n expl�cita y ejecuta la siguiente instrucci�n de actualizaci�n en la tablaLibrary.Books:
-- UPDATE Library.Books
-- SET BookTitle = 'Changed Book'
-- WHERE BookISBN = '111'
-- Deja la trasacci�n abierta. Abre una nueva ventana de consulta e intenta leer el libro con BookISBN = '111'
-- Usa el nivel de aislalmiento READ UNCOMMITTED (con un conjunto de opciones en ambas ventanas).
-- Comportamiento esperado: La segunda ventana tiene que mostrar el registro solicitado en una versi�n no confirmada.
-- Deshaz la transacci�n en la primera ventana y reintenta ejecutar el segundo comando. Los datos deben ser distintos que los de la primera lectura:
-- primera llamada: Title = "Changed Book"
-- segunda llamada: Title = "Title Ten

-- Consulta en la primera ventana
BEGIN TRAN;
	 UPDATE Library.Books
	 SET BookTitle = 'Changed Book'
	 WHERE BookISBN = '111';
-- ROLLBACK TRAN

-- Segunda ventana
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT * FROM Library.Books WHERE BookISBN = '111';
--


-- EJERCICIO 10
-- Repite el ejercicio 9 usando ahora las sugerencias de tabla.

-- Consulta en la primera ventana
BEGIN TRAN;
	 UPDATE Library.Books
	 SET BookTitle = 'Changed Book'
	 WHERE BookISBN = '111';
-- ROLLBACK TRAN

-- Segunda ventana
SELECT * FROM Library.Books WITH(NOLOCK)
WHERE BookISBN = '111';
--
