use [AdventureWorks2012]
go

select * from Library.Books

begin tran;

update Library.Books
set BookTitle = 'Proceso 1'
where BookID = 103

select @@TRANCOUNT


select * from Library.Publishers


begin tran;

update Library.Publishers
set PublisherName = 'Proceso 1'
where PublisherID = 1

select @@TRANCOUNT


rollback tran;