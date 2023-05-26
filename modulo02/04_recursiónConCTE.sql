--creamos el esquema HR
create schema HR;

--generamos la tabla de empleados
create table HR.Employees
(
	EmployeeID int not null,
	ManagerID int null,
	FirstName varchar(20) not null,
	LastName varchar(20) not null,
	constraint PK_HREmployee primary key
	(
		EmployeeID
	)
)

select * from HR.Employees;

--insertamos valores en la nueva tabla
insert into HR.Employees(EmployeeID, ManagerID, FirstName, LastName)
values (1, null, 'Paco', 'Fernandez')
	, (2, 1, 'Fernando', 'Gonz�lez')
	, (3, 1, 'Marcos', '�lvarez')
	, (4, 2, 'Juan', 'D�az')
	, (5, 3, 'Jos�', 'Rubio')
	, (6, null, 'Luc�a', 'Mart�nez')
	, (7, 6, 'Manolo', 'Mart�nez')
	, (8, 6, 'Alba', 'P�rez')
	, (9, 8, 'Florentino', 'Alonso');
go

select * from HR.Employees;

--generamos la CTE
with CTE_Employees as
(
	--primero mostraremos el superior jer�rquico
	select 
		EmployeeID, ManagerID, FirstName, LastName, 1 as Pos
	from HR.Employees
	--para saber la posici�n de la jerarqu�a, a�adiremos la posici�n
	where EmployeeID = 6

	union all

	select 
		E.EmployeeID, E.ManagerID, E.FirstName, E.LastName, (C.Pos + 1) as Pos
	from HR.Employees E
		inner join CTE_Employees C on E.ManagerID = C.EmployeeID
)

select * from CTE_Employees

with CTE_Employees as
(
	--primero mostraremos el superior jer�rquico
	select 
		EmployeeID, ManagerID, FirstName, LastName, 1 as Pos
	from HR.Employees
	--para saber la posici�n de la jerarqu�a, a�adiremos la posici�n
	where EmployeeID = 1

	union all

	select 
		E.EmployeeID, E.ManagerID, E.FirstName, E.LastName, (C.Pos + 1) as Pos
	from HR.Employees E
		inner join CTE_Employees C on E.ManagerID = C.EmployeeID
)

select * from CTE_Employees