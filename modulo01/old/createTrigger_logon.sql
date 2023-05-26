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