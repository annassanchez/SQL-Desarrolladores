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


-- EJERCICIO 2
-- Ejecuta los dos comandos del ejercicio 1 y comprueba el número de error obtenido (@@ERROR number).
-- Si es mayor que 0, muestra el mensaje "ERROR" y deshaz la transacción si es necesario.


-- EJERCICIO 3
-- Abre una transacción explícita y ejecuta los siguientes comandos dentro de la transacción:
--
-- INSERT INTO Library.Publishers (PublisherID, PublisherName)
-- VALUES (11, N'Press Eleven');
-- INSERT INTO Library.Publishers (PublisherID, PublisherName)
-- VALUES (12, N'Press Eleven');
--
-- Muestra el número de las transacciones activas actualmente, dentro de la transacción y después del commit tran.


-- EJERCICIO 4
-- Abre tres transacciones vacías anidadas y deshaz la más interna. 
-- Muestra el número de transacciones en el inicio de cada una y después de revertirla.
-- El resultado esperado es: 1,2,3,0


-- EJERCICIO 5
-- Abre tres transacciones vacías (una externa, las otras dos al mismo nivel)
-- Confirma la primera transacción anidada y revierte la última transacción abierta.
-- Muestra el número de transacciones en el inicio de cada una, después de confirmarla y tras revertirla.
-- El resultado esperado es: 1,2,1,2,0


-- EJERCICIO 6
-- Maneja el error división por cero usando el bloque try catch dentro de la transacción.
-- Si el error no sucede, confirma la transacción


-- EJERCICIO 7
-- Maneja el error división por cero usando la función the XACT_STATE() para comprender si la transacción es confirmable o no.
-- Si no lo es, deshazla.


-- EJERCICIO 8
-- Abre una transacción explícita y ejecuta la siguiente declaración actualizada en la tabla Library.Books:
-- UPDATE Library.Books
-- SET BookTitle = 'Changed Book'
-- WHERE BookISBN = '111'
-- Deja la trasacción abierta. Abre una nueva ventana de consulta e intenta leer el libro con BookISBN = '111'
-- Usa el nivel de aislalmiento READ COMMITTED (el nivel por defecto).
-- Comportamiento esperado: La segunda ventana debe esperar para confirmar o deshacer la transacción a que termine la primera consulta.
-- Deshaz la transacción en la primera ventana. La segunda ventana debe mostrar el resultado del primer registro solicitado.


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


-- EJERCICIO 10
-- Repite el ejercicio 9 usando ahora las sugerencias de tabla.