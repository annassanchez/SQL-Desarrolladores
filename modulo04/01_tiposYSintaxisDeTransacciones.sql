SET IMPLICIT_TRANSACTION ON;

BEGIN TRANSACTION
INSERT INTO dbo.Foo (idFoo, value)
VALUES (1, 'hello');
UPDATE dbo.TableData
SET percentage = 30
WHERE
idTableData = 5
COMMIT TRANSACTION


--BEGIN TRANSACTION
BEGIN TRAN FirstTransaction WITH MARK N'Restore From Here!';


--BEGIN DISTRIBUTED TRANSACTION
BEGIN DISTRIBUTED TRAN;


--COMMIT TRAN
COMMIT TRAN FirstTransaction;


--ROLLBACK TRANSACTION
DECLARE @TranName varchar(30) = 'This is a simple transaction';
BEGIN TRAN @TranName;

 CREATE TABLE dbo.Foo (id int, VALUE decimal(8,2) NOT NULL);

ROLLBACK TRAN @TranName; -- la tabla es desechada


--SAVE TRANSACTION
SAVE TRAN 'This is a savepoint';