CREATE NONCLUSTERED INDEX IX_AccountsUsers_1 ON Accounts.Users
(
 FirstName ASC,
 LastName ASC
)
WITH (FILLFACTOR = 70, PAD_INDEX = ON)

CREATE NONCLUSTERED INDEX IX_AccountsUsers_1 ON Accounts.Users
(
 FirstName ASC,
 LastName ASC
)
WITH (ONLINE = ON)

CREATE NONCLUSTERED INDEX IX_AccountsUsers_2 ON Accounts.Users
(
 FirstName ASC,
 LastName ASC
)
WITH (SORT_IN_TEMPDB = ON)

ALTER INDEX IX_AccountsUsers_1 ON Accounts.Users REORGANIZE

ALTER INDEX IX_AccountsUsers_1 ON Accounts.Users REBUILD PARTITION = ALL