begin tran;

update Library.Publishers
set PublisherName = 'Proceso 2'
where PublisherID = 1

select @@TRANCOUNT


begin tran;

update Library.Books
set BookTitle = 'Proceso 2'
where BookID = 103

select @@TRANCOUNT