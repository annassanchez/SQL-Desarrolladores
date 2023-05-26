-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		annas
-- Create date: 30/10/2022
-- Description:	Descripción de una función que devuelve top10 delos pediods de un cliente, por CustomerID
-- =============================================
CREATE FUNCTION udf_SalesOrders_GetTopTenByCustomerID 
(	
	-- Add the parameters for the function here
	@CustomerID int
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT top 10
		so.SalesOrderDate, so.TotalQuantity
	from dbo.SalesOrders so
	where so.CustomerID = @CustomerID
	order by so.SalesOrderDate desc
)
GO
