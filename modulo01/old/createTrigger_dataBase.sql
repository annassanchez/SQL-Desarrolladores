CREATE TRIGGER tDatabaseCheck ON DATABASE FOR CREATE_TABLE, CREATE_VIEW AS 
 DECLARE @data xml = EVENTDATA();
 DECLARE @object_name varchar(100) = @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'varchar(100)')
 PRINT 'OBJECT CREATED WITH SCRIPT:' + @object_name;
GO

CREATE VIEW dbo.FooView AS
 SELECT * FROM test.dbo.Customers C;
GO