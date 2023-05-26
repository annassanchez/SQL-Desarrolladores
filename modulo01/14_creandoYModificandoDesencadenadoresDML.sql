create trigger tr_SalesOrders_CustomerId1
on test.dbo.SalesOrders
for delete
as
	declare @CustomerId int;
	
	select @CustomerId = CustomerID from deleted;

	if @CustomerId <> 1
	begin
		print 'Este registro no puede ser eliminado'
		rollback tran;
	end;

delete from dbo.SalesOrders where CustomerID = 1;
delete from dbo.SalesOrders where CustomerID = 21;