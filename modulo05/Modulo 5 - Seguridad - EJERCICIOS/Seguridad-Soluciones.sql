------------------------------------------------------------
-- Ejercicios del MÓDULO 5 - Seguridad
-- 10 ejercicios
--
-- administrar logins
-- funciones fijas de servidor
-- roles de servidor del usuario
-- roles fijos de la base de datos
-- roles de usuario de la base de datos
-- miembros del rol
-- permisos sobre objetos
------------------------------------------------------------

-- EJERCICIO 1
-- Crea un login llamado LoginAW2012 con contraseña "p4$5w0rd" y establece por defecto la base de datos AdventureWorks2012.

USE [master]
GO
CREATE LOGIN LoginAW2012 WITH PASSWORD=N'p4$5w0rd', DEFAULT_DATABASE=AdventureWorks2012;
GO
--


-- EJERCICIO 2
-- Crea un login llamado LoginAW2012_Policy con contraseña "p4$5w0rd" y define por defecto la base de datos AdventureWorks2012.
-- Establece la caducidad y cumplir las políticas en modo ON.

USE [master]
GO
CREATE LOGIN LoginAW2012_Policy WITH PASSWORD=N'p4$5w0rd', DEFAULT_DATABASE=AdventureWorks2012, CHECK_EXPIRATION=ON, CHECK_POLICY=ON;
GO
--


-- EJERCICIO 3
-- Crea un usuario de la base de datos llamado UserAW2012 para el login LoginAW2012. 

GO
CREATE USER UserAW2012 FOR LOGIN LoginAW2012;
GO
--


-- EJERCICIO 4
-- Elimina el LoginAW2012_Policy.

USE [master];
GO
DROP LOGIN LoginAW2012_Policy;
GO
--


-- EJERCICIO 5
-- Añade el login LoginAW2012 a la función fija del servidor securityadmin.

USE [master];
GO
ALTER SERVER ROLE securityadmin ADD MEMBER LoginAW2012;
GO
--


-- EJERCICIO 6
-- Crea un nuevo rol de servidor llamado CreateAllDBServerRole y da permisos de CREATE ANY DATABASE y ALTER ANY DATABASE para el rol.

USE [master];
GO
CREATE SERVER ROLE CreateAllDBServerRole;
GO
GRANT CREATE ANY DATABASE TO CreateAllDBServerRole;
GO
GRANT ALTER ANY DATABASE TO CreateAllDBServerRole;
GO
--

-- EJERCICIO 7
-- Añade el login LoginAW2012 al CreateAllDBServerRole.

USE [master];
GO
ALTER SERVER ROLE CreateAllDBServerRole ADD MEMBER LoginAW2012;
GO
--


-- EJERCICIO 8
-- Añade el usuario UserAW2012 al rol db_backupoperator.

USE AdventureWorks2012;
GO
ALTER ROLE db_backupoperator ADD MEMBER UserAW2012;
GO
--


-- EJERCICIO 9
-- Crea un nuevo rol en la base de datos AdventureWorks2012 llamado AppRole.
-- Añade el usuario UserAW2012 al rol AppRole de la base datos.

USE AdventureWorks2012;
GO
CREATE ROLE AppRole;
GO
ALTER ROLE AppRole ADD MEMBER UserAW2012;
GO
--


-- EJERCICIO 10
-- Otorga los permisos de definición de vista y ejecución sobre HumanResources.uspUpdateEmployeeHireInfo al AppRole.

USE AdventureWorks2012;
GO
GRANT EXECUTE ON HumanResources.uspUpdateEmployeeHireInfo TO AppRole;
GO
GRANT VIEW DEFINITION ON HumanResources.uspUpdateEmployeeHireInfo TO AppRole;
GO
--
