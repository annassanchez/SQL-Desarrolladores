CREATE STATISTICS AccountsUserUsername
ON Accounts.Users (Username)
WITH SAMPLE 5 PERCENT;

CREATE STATISTICS AccountsUserUsername
ON Accounts.Users (Username)
WITH FULLSCAN;

CREATE STATISTICS AccountsUserUsername
ON Accounts.Users (Username)
WHERE Username like 'a%'
WITH SAMPLE 50 PERCENT;

UPDATE STATISTICS Accounts.Users -- toda la tabla

UPDATE STATISTICS Accounts.Users Accounts.Users.IX_AccountsUsers_1 -- estadística concreta

SELECT 
 U.Username
 , U.FirstName
 , U.LastName
FROM 
 Accounts.Users U
 JOIN Sales.Customers C ON U.UserId = C.CustomerID
WHERE
 U.LastName LIKE 'a%'