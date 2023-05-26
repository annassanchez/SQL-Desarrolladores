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