alter table dbo.SalesOrders
add ExpireDate as (dateadd(day, 30, SalesOrderDate));