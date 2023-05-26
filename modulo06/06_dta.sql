select *
from Sales.SalesOrderDetail sod
order by UnitPriceDiscount

select *
from Sales.SalesOrderDetail sod
join Sales.SalesOrderHeader soh
on sod.SalesOrderID = soh.SalesOrderID
where ProductID > 900
order by UnitPriceDiscount