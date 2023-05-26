-- ================================================
-- Template generated from Template Explorer using:
-- Create Multi-Statement Function (New Menu).SQL
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
-- Description:	Descripción para la función que devulve los valores de la tabla cuya edad está por encima de 20 años
-- =============================================
CREATE FUNCTION dbo.udf_Customers_Over20 () -- no va a tener parámetros de entrada
RETURNS 
@Table_Var TABLE 
(
	-- Add the column definitions for the TABLE variable here
	FirstName nvarchar(30), 
	LastName nvarchar(30),
	Age tinyint
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	insert into @Table_Var(FirstName,LastName,Age)
	select c.FirstName, c.LastName, c.Age
	from dbo.Customers c
	where c.Age >= 20;
	RETURN 
END
GO