-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
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
-- Description:	Descripción de la función
-- =============================================
CREATE FUNCTION dbo.udf_Customer_GetFullName 
(
	-- Add the parameters for the function here
	@CustomerID int
)
RETURNS nvarchar(61)
AS
BEGIN

	-- Declare the return variable here

	DECLARE @Result nvarchar(61)

	-- Add the T-SQL statements to compute the return value here

	SELECT @Result = CONCAT(FirstName , ' ' , LastName)
	from dbo.Customers
	where CustomerID = @CustomerID

	-- Return the result of the function

	RETURN @Result

END
GO

