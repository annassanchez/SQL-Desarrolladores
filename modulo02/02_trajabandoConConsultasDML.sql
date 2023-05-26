create table dbo.Users
(
	UserId int not null,
	UserName varchar(20) not null,
	FirstName varchar(30) not null, 
	LastName varchar(30) not null,
	UserStatusId tinyint not null,
	constraint PK_AccountUsers primary key
	(
		UserId
	)
)

--INSERT
---literal

insert into dbo.Users(UserId, UserName, FirstName, LastName, UserStatusId)
values(1, 'paco', 'Francisco', 'Fernández', 1), (2, 'pepe', 'José', 'Álvarez', 1)

alter table dbo.Users
add ShortDescription nvarchar(200) not null default('');

insert into dbo.Users(UserId, UserName, FirstName, LastName, UserStatusId, ShortDescription)
values(3, 'tino', 'Florentino', 'González', 1, 'Descripción')

select * from dbo.Users

insert into dbo.Users(UserId, UserName, FirstName, LastName, UserStatusId)
values(4, 'tino2', 'Florentino', 'Gómez', 1)

select * from dbo.Users

---Variables
declare @variable nvarchar(200);
set @variable = 'Descripción por variable'

insert into dbo.Users(UserId, UserName, FirstName, LastName, UserStatusId, ShortDescription)
values(5, 'manu', 'Manuel', 'Alvarez', 1, @variable)

select * from dbo.Users

---consulta
insert into dbo.Users(UserId, UserName, FirstName, LastName, UserStatusId, ShortDescription)
select 6, UserName, FirstName, LastName, UserStatusId, ShortDescription
from dbo.Users
where UserId = 1

select * from dbo.Users

--UPDATE
---literal

update dbo.Users
set FirstName = 'Ruben'
where UserId = 1

select * from dbo.Users

--variables

declare @firstname varchar(20) = 'Nombre';
declare @lastname varchar(20) = 'Apellido';


update dbo.Users
set FirstName = @firstname,
	LastName = @lastname
where UserId = 1

select * from dbo.Users

--subconsulta
update dbo.Users
set FirstName = C.FirstName,
	LastName = C.LastName
from dbo.Users U
	inner join dbo.Customers C on U.UserId = C.CustomerID

select * from dbo.Users;
select * from dbo.Customers;

--DELETE

--literal

delete from dbo.Users where UserId = 6;

select * from dbo.Users;

--variable

declare @UserId int = 5;

delete from dbo.Users where UserId = @UserId; 

select * from dbo.Users;

--subconsulta
select * 
from dbo.Users U
	inner join dbo.Customers C on U.UserId = C.CustomerID

delete from dbo.Users
from dbo.Users U
	inner join dbo.Customers C on U.UserId = C.CustomerID


select * from dbo.Users;
select * from dbo.Customers;