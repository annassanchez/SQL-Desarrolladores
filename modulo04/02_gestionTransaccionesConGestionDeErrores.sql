USE [AdventureWorks2012]
GO 

select * from Library.Books;

select * from Library.Publishers;

delete from Library.Publishers where PublisherID = 1;

select * from Library.Books;

select * from Library.Publishers;

begin try
	delete from Library.Publishers where PublisherID = 1;
end try
begin catch
	print 'Error';
end catch

begin try
	insert into Library.Publishers (PublisherID, PublisherName)
	values(4, N'Editorial 4');
	delete from Library.Publishers where PublisherID = 1;
end try
begin catch
	print 'Error';
end catch

select * from Library.Books;

select * from Library.Publishers;

--con transacciones
BEGIN TRAN; -- 

	begin try
		insert into Library.Publishers (PublisherID, PublisherName)
		values(4, N'Editorial 4');

		delete from Library.Publishers where PublisherID = 1;
	end try
	begin catch
		if @@TRANCOUNT > 0 rollback tran; -- esto ya pararía el commit tran posterior
		print 'Error';
	end catch
if @@TRANCOUNT > 0 commit tran;

select * from Library.Publishers;

--mirando mensajes personalizados
BEGIN TRAN; -- 

	begin try
		insert into Library.Publishers (PublisherID, PublisherName)
		values(4, N'Editorial 4');

		delete from Library.Publishers where PublisherID = 1;
	end try
	begin catch
		if @@TRANCOUNT > 0 rollback tran; -- esto ya pararía el commit tran posterior
		select ERROR_MESSAGE(),
			ERROR_STATE(),
			ERROR_NUMBER()
	end catch
if @@TRANCOUNT > 0 commit tran;

select * from Library.Publishers;

--con xact

SET XACT_ABORT ON;

begin try

	BEGIN TRAN; -- 

	insert into Library.Publishers (PublisherID, PublisherName)
	values(4, N'Editorial 4');

	delete from Library.Publishers where PublisherID = 1;

	COMMIT TRAN;
end try
begin catch
	if XACT_STATE() = -1
	begin
		print 'Error FK';
		rollback tran;
	end
	if XACT_STATE() = 1
	begin
		commit tran;
	end
end catch

select * from Library.Publishers;