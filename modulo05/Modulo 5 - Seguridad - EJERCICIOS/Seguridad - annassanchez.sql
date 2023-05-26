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

USE [AdventureWorks2012] --botón derecho dentro de los logins
GO
CREATE LOGIN LoginAW2012 WITH PASSWORD=N'p4$5w0rd', DEFAULT_DATABASE=[AdventureWorks2012]
GO

-- EJERCICIO 2
-- Crea un login llamado LoginAW2012_Policy con contraseña "p4$5w0rd" y define por defecto la base de datos AdventureWorks2012.
-- Establece la caducidad y cumplir las políticas en modo ON.

USE [AdventureWorks2012] --botón derecho dentro de los logins
GO
CREATE LOGIN LoginAW2012_Policy WITH PASSWORD=N'p4$5w0rd', DEFAULT_DATABASE=[AdventureWorks2012], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO


-- EJERCICIO 3
-- Crea un usuario de la base de datos llamado UserAW2012 para el login LoginAW2012. 

CREATE USER [UserAW2012] FOR LOGIN [LoginAW2012]
GO

-- EJERCICIO 4
-- Elimina el LoginAW2012_Policy.

DROP LOGIN [LoginAW2012_Policy]

-- EJERCICIO 5
-- Añade el login LoginAW2012 a la función fija del servidor securityadmin.

ALTER SERVER ROLE securityadmin ADD MEMBER [LoginAW2012]
GO

-- EJERCICIO 6
-- Crea un nuevo rol de servidor llamado CreateAllDBServerRole y da permisos de CREATE ANY DATABASE y ALTER ANY DATABASE para el rol.

use master
go
CREATE SERVER ROLE CreateAllDBServerRole
GO
GRANT CREATE ANY DATABASE TO CreateAllDBServerRole
go
GRANT ALTER ANY DATABASE TO CreateAllDBServerRole
go

-- EJERCICIO 7
-- Añade el login LoginAW2012 al CreateAllDBServerRole.

use master
go
ALTER SERVER ROLE [CreateAllDBServerRole] ADD MEMBER LoginAW2012
GO

-- EJERCICIO 8
-- Añade el usuario UserAW2012 al rol db_backupoperator.

use AdventureWorks2012
go
ALTER ROLE db_backupoperator ADD MEMBER UserAW2012
GO

-- EJERCICIO 9
-- Crea un nuevo rol en la base de datos AdventureWorks2012 llamado AppRole.
-- Añade el usuario UserAW2012 al rol AppRole de la base datos.

use AdventureWorks2012
go
CREATE ROLE AppRole
GO
ALTER ROLE [AppRole] ADD MEMBER UserAW2012
GO

-- EJERCICIO 10
-- Otorga los permisos de definición de vista y ejecución sobre HumanResources.uspUpdateEmployeeHireInfo al AppRole.

grant view definition on HumanResources.uspUpdateEmployeeHireInfo to AppRole;
grant execute on HumanResources.uspUpdateEmployeeHireInfo to AppRole;
