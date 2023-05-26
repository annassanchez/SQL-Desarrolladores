/*trigger DDL: servidor como ámbito*/
CREATE TRIGGER tServerCheck ON ALL SERVER FOR CREATE_TABLE AS PRINT 'TABLE SUCCESFULLY CREATED'
GO

CREATE TABLE dbo.FooData 
(
 IDFooData int
 , FooDataValue varchar(10)
)
GO

/*trigger DDL: base de datos como ámbito*/


CREATE TRIGGER tDatabaseCheck ON DATABASE FOR CREATE_TABLE, CREATE_VIEW AS 
 DECLARE @data xml = EVENTDATA();
 DECLARE @object_name varchar(100) = @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'varchar(100)')
 PRINT 'OBJECT CREATED WITH SCRIPT:' + @object_name;
GO

CREATE VIEW dbo.FooView AS
 SELECT * FROM dbo.Customers C;
GO

/*trigger de tipo logon*/
USE [master];
GO

CREATE TABLE dbo.UserLogins 
(
 LoginName varchar(512)
 , DatabaseUserName varchar(512)
 , SPID int
 , LoginTimestamp datetime
);
GO

CREATE TRIGGER log_users ON ALL SERVER FOR LOGON AS
 INSERT INTO dbo.UserLogins (LoginName, DatabaseUserName, SPID, LoginTimestamp)
 SELECT SYSTEM_USER,USER,@@SPID,GETDATE();
GO
