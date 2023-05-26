create view dbo.TotalQuantity10
as 
	select C.FirstName, C.LastName, C.BirthDate
	from dbo.Customers C
	inner join dbo.SalesOrders S on C.CustomerID = S.CustomerID
	where S.TotalQuantity = 10

select * from dbo.TotalQuantity10

/*esto es para crear una vista particionada*/

create table PositiveNumbers
(
	number int not null primary key,
	value decimal(5,2) not null,
	check (number >=0)
)

create table NegativeNumbers
(
	number int not null primary key,
	value decimal(5,2) not null,
	check (number < 0)
)

create view PartiotinedView
as
	select number, value from dbo.PositiveNumbers
	union all
	select number, value from dbo.NegativeNumbers;

insert into dbo.PositiveNumbers(number, value)
values (1, 10.5), (2, 20.5), (3, 30.5);

insert into dbo.NegativeNumbers(number, value)
values (-1, -10.5), (-2, -20.5), (-3, -30.5);

select * from dbo.PartiotinedView where number = 2

/*esto es para crear una vista indexada*/

create view IndexedViewSample
as
	select C.FirstName, C.LastName, C.BirthDate, o.SalesOrdersID
	from dbo.Customers C
	join dbo.SalesOrders O on C.CustomerID = O.CustomerID

create view dbo.IndexedViewSample with schemabinding
as
	select C.FirstName, C.LastName, C.BirthDate, o.SalesOrdersID
	from dbo.Customers C
	join dbo.SalesOrders O on C.CustomerID = O.CustomerID