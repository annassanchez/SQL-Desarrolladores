--consulta inicial
select
	H.DueDate,
	H.Comment,
	A.AddressLine1,
	A.AddressLine2,
	A.City,
	PR.FirstName,
	PR.LastName,
	D.UnitPrice,
	D.UnitPriceDiscount,
	SUM(D.UnitPrice) as TotalPrice
from Sales.SalesOrderHeader H
	join Sales.SalesOrderDetail D on H.SalesOrderID = D.SalesOrderID 
	join Production.Product P on D.ProductID = P.ProductID 
	left join Sales.Customer C on H.CustomerID = C.CustomerID 
	left join Person.Person PR on C.PersonID = PR.BusinessEntityID 
	left join Person.Address A on A.AddressID = H.BillToAddressID 
where 
	H.ModifiedDate >= '20010101'
	and P.SellEndDate >= '20010101'
	and PR.LastName like 'a%'
group by
	H.DueDate,
	H.Comment,
	A.AddressLine1,
	A.AddressLine2,
	A.City,
	PR.FirstName,
	PR.LastName,
	D.UnitPrice,
	D.UnitPriceDiscount

--declaración variable
declare @TempOrders table
(
	DueDate datetime,
	Comment nvarchar(128),
	UnitPrice money,
	UnitPriceDiscount money,
	ProductID int,
	CustomerID int,
	BillToAdressID int
);

--simplificación
select
	TMP.DueDate,
	TMP.Comment,
	A.AddressLine1,
	A.AddressLine2,
	A.City,
	PR.FirstName,
	PR.LastName,
	TMP.UnitPrice,
	TMP.UnitPriceDiscount,
	TMP.BillToAdressID,
	SUM(TMP.UnitPrice) as TotalPrice
from @TempOrders TMP
	join Sales.SalesOrderDetail D on TMP.ProductID = D.SalesOrderID 
	join Production.Product P on D.ProductID = P.ProductID 
	left join Sales.Customer C on TMP.CustomerID = C.CustomerID 
	left join Person.Person PR on C.PersonID = PR.BusinessEntityID 
	left join Person.Address A on A.AddressID = TMP.BillToAdressID 
where 
	P.SellEndDate >= '20010101'
	and PR.LastName like 'a%'
group by
	TMP.DueDate,
	TMP.Comment,
	A.AddressLine1,
	A.AddressLine2,
	A.City,
	PR.FirstName,
	PR.LastName,
	TMP.UnitPrice,
	TMP.UnitPriceDiscount
