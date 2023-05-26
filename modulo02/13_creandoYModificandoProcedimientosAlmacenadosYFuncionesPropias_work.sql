select * from dbo.Customers

exec dbo.proc_Customers_Upsert @CustomerID = 101
	, @FirstName = 'Pepe'
	, @LastName = 'Estrada'
	, @BirthDate = '1988-05-09'
	, @CustomerStatusID = 1

exec dbo.proc_Customers_Upsert @CustomerID = 101
	, @FirstName = 'Francisco'
	, @LastName = 'Estrada'
	, @BirthDate = '1988-05-09'
	, @CustomerStatusID = 1

select c.CustomerID, c.FirstName, c.LastName, dbo.udf_Customer_GetFullName(c.CustomerID)
from dbo.Customers c

select * from dbo.udf_Customers_Over20()

select *
from dbo.Customers C
	outer apply dbo.udf_SalesOrders_GetTopTenByCustomerID(C.CustomerID);