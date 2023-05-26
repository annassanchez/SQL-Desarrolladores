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
	, (2, 1, 'Fernando', 'González')
	, (3, 1, 'Marcos', 'Álvarez')
	, (4, 2, 'Juan', 'Díaz')
	, (5, 3, 'José', 'Rubio')
	, (6, null, 'Lucía', 'Martínez')
	, (7, 6, 'Manolo', 'Martínez')
	, (8, 6, 'Alba', 'Pérez')
	, (9, 8, 'Florentino', 'Alonso');
go

select * from HR.Employees;

--generamos la CTE
with CTE_Employees as
(
	--primero mostraremos el superior jerárquico
	select 
		EmployeeID, ManagerID, FirstName, LastName, 1 as Pos
	from HR.Employees
	--para saber la posición de la jerarquía, añadiremos la posición
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
	--primero mostraremos el superior jerárquico
	select 
		EmployeeID, ManagerID, FirstName, LastName, 1 as Pos
	from HR.Employees
	--para saber la posición de la jerarquía, añadiremos la posición
	where EmployeeID = 1

	union all

	select 
		E.EmployeeID, E.ManagerID, E.FirstName, E.LastName, (C.Pos + 1) as Pos
	from HR.Employees E
		inner join CTE_Employees C on E.ManagerID = C.EmployeeID
)

select * from CTE_Employees