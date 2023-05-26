alter table dbo.SalesOrders
add ExpireDate as (dateadd(day, 30, SalesOrderDate));

dbcc checkident('dbo.Customers', reseed, 0);