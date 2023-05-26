insert into dbo.Customers (FirstName, LastName, BirthDate)
values('Loles', 'Leon', '19750508')

alter table dbo.SalesOrders 
add constraint CK_SalesOrders_SalesOrderDate
	check(SalesOrderDate > '19800101')

alter table dbo.SalesOrders
add CustomerID int null

insert into dbo.SalesOrders(SalesOrderDate, TotalQuantity, CustomerID)
values('19840508', 5, 666)

insert into dbo.SalesOrders(SalesOrderDate, TotalQuantity, CustomerID)
values('19840508', 5, 21)