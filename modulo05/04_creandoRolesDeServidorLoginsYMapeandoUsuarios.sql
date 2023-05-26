USE [master]
GO

CREATE SERVER ROLE [SampleServerRole]

GO

use [master]
go

grant case any database to [SampleServerRole]

go

ALTER SERVER ROLE [SampleServerRole] ADD MEMBER [MyLogin]
GO


USE [master] --botón derecho dentro de los logins
GO
CREATE LOGIN [MyFirstLogin] WITH PASSWORD=N'postgres' MUST_CHANGE, DEFAULT_DATABASE=[test], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
ALTER SERVER ROLE [SampleServerRole] ADD MEMBER [MyFirstLogin]
GO
CREATE USER [MyFirstLogin] FOR LOGIN [MyFirstLogin]
GO
USE [test]
GO
ALTER ROLE [MyDatabaseUserRole] ADD MEMBER [MyFirstLogin]
GO