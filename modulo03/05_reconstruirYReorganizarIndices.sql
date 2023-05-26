use [AdventureWorks2012]
go

select COUNT(*) from Sales.SalesOrderDetail

--rebuild indice existente
USE [AdventureWorks2012]
GO
ALTER INDEX [IX_SalesOrderDetail_ProductID] ON [Sales].[SalesOrderDetail] 
REBUILD PARTITION = ALL WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

USE [AdventureWorks2012]
GO
ALTER INDEX [IX_SalesOrderDetail_ProductID] ON [Sales].[SalesOrderDetail] REORGANIZE  WITH ( LOB_COMPACTION = ON )
GO

--rebuild todos los índices
USE [AdventureWorks2012]
GO
ALTER INDEX [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] ON [Sales].[SalesOrderDetail] REBUILD PARTITION = ALL WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
USE [AdventureWorks2012]
GO
ALTER INDEX [AK_SalesOrderDetail_rowguid] ON [Sales].[SalesOrderDetail] REBUILD PARTITION = ALL WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
USE [AdventureWorks2012]
GO
ALTER INDEX [IX_SalesOrderDetail_ProductID] ON [Sales].[SalesOrderDetail] REBUILD PARTITION = ALL WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

--reorganize todos los índices
USE [AdventureWorks2012]
GO
ALTER INDEX [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] ON [Sales].[SalesOrderDetail] REORGANIZE  WITH ( LOB_COMPACTION = ON )
GO
USE [AdventureWorks2012]
GO
ALTER INDEX [AK_SalesOrderDetail_rowguid] ON [Sales].[SalesOrderDetail] REORGANIZE  WITH ( LOB_COMPACTION = ON )
GO
USE [AdventureWorks2012]
GO
ALTER INDEX [IX_SalesOrderDetail_ProductID] ON [Sales].[SalesOrderDetail] REORGANIZE  WITH ( LOB_COMPACTION = ON )
GO
