create view IndexedViewSample
as
	select C.FirstName, C.LastName, C.BirthDate, o.SalesOrdersID
	from dbo.Customers C
	join dbo.SalesOrders O on C.CustomerID = O.CustomerID

