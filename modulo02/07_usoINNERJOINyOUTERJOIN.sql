--INNER JOIN

select
	C.FirstName,
	C.LastName,
	C.BirthDate,
	COUNT(*)
from dbo.Customers C
	join dbo.SalesOrders O on C.CustomerID = O.CustomerID --sino especificamos, el join por defecto es inner join
group by
	C.FirstName,
	C.LastName,
	C.BirthDate

--LEFT OUTER JOIN

select
	C.FirstName,
	C.LastName,
	C.BirthDate,
	COUNT(O.SalesOrdersID)
from dbo.Customers C
	left join dbo.SalesOrders O on C.CustomerID = O.CustomerID --sino especificamos, el join por defecto es inner join
group by
	C.FirstName,
	C.LastName,
	C.BirthDate

--CROSS JOIN

create table HR.Departments
(
	DepartmentID int not null,
	DepartmentName varchar(30) not null
)

insert into HR.Departments(DepartmentID,DepartmentName)
values (1, 'Administración')
	, (2, 'IT')
	, (3, 'RRHH')

select
	E.FirstName,
	E.LastName,
	D.DepartmentName
from HR.Employees E
	cross join HR.Departments D