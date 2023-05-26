Use [AdventureWorks2012]
go;

select * from Library.Books

set transaction isolation level read committed; -- bloque a nivel de lectura, nadie va a poder hacer nada con él, ni siquiera leerlo.

begin tran;

update Library.Books
set BookTitle = 'Nuevo título2'
where BookID = 101;

select @@TRANCOUNT

commit tran;

set transaction isolation level read uncommitted;

begin tran;

update Library.Books
set BookTitle = 'Nuevo título2 cancelado'
where BookID = 101;

select @@TRANCOUNT

rollback tran;

select BookTitle from Library.Books with(nolock)
where BookID = 101;