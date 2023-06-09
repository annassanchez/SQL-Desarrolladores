USE [test]
GO
/****** Object:  StoredProcedure [dbo].[proc_Customers_Upsert]    Script Date: 30/10/2022 10:47:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		AnnaS
-- Create date: 29/10/2022
-- Description:	Procedimiento de prueba
-- =============================================
ALTER PROCEDURE [dbo].[proc_Customers_Upsert] 
	-- Add the parameters for the stored procedure here
	@CustomerID int = NULL, 
	@FirstName nvarchar(30),
	@LastName nvarchar(30),
	@BirthDate date,
	@CustomerStatusID tinyint = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET IDENTITY_INSERT dbo.Customers ON;

	if exists(select 1 from dbo.Customers where CustomerID = @CustomerID)
	begin
		update dbo.Customers
		set FirstName = @Firstname
			, LastName = @LastName
			, BirthDate = @BirthDate
			, CustomerStatusID = @CustomerStatusID 
		where CustomerID = @CustomerID
	end
	else
	begin
		insert into dbo.Customers(CustomerID,FirstName, LastName, BirthDate,CustomerStatusID)
		values(@CustomerID,@FirstName,@LastName,@BirthDate,@CustomerStatusID)
	end
    -- Insert statements for procedure here
END
