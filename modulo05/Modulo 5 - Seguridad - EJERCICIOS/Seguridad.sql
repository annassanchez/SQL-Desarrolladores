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


-- EJERCICIO 2
-- Crea un login llamado LoginAW2012_Policy con contraseña "p4$5w0rd" y define por defecto la base de datos AdventureWorks2012.
-- Establece la caducidad y cumplir las políticas en modo ON.


-- EJERCICIO 3
-- Crea un usuario de la base de datos llamado UserAW2012 para el login LoginAW2012. 


-- EJERCICIO 4
-- Elimina el LoginAW2012_Policy.


-- EJERCICIO 5
-- Añade el login LoginAW2012 a la función fija del servidor securityadmin.


-- EJERCICIO 6
-- Crea un nuevo rol de servidor llamado CreateAllDBServerRole y da permisos de CREATE ANY DATABASE y ALTER ANY DATABASE para el rol.


-- EJERCICIO 7
-- Añade el login LoginAW2012 al CreateAllDBServerRole.


-- EJERCICIO 8
-- Añade el usuario UserAW2012 al rol db_backupoperator.


-- EJERCICIO 9
-- Crea un nuevo rol en la base de datos AdventureWorks2012 llamado AppRole.
-- Añade el usuario UserAW2012 al rol AppRole de la base datos.


-- EJERCICIO 10
-- Otorga los permisos de definición de vista y ejecución sobre HumanResources.uspUpdateEmployeeHireInfo al AppRole.
