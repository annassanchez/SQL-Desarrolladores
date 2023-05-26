use [master]
go


create login CourseDBlogin with password = 'Password'

use [test]
go

create role ProcedureExecutionViewRole;

create user CourseProcedureExecViewUser for login CourseDBlogin;

alter role ProcedureExecutionViewRole add member CourseProcedureExecViewUser;

grant execute on dbo.proc_Customers_Upsert to ProcedureExecutionViewRole;

grant view definition on dbo.proc_Customers_Upsert to ProcedureExecutionViewRole;

revoke view definition on dbo.proc_Customers_Upsert to ProcedureExecutionViewRole;

deny execute on dbo.proc_Customers_Upsert to ProcedureExecutionViewRole;


create login CourseDBlogin2 with password = 'Password';
create user CourseProcedureExecViewUser2 for login CourseDBlogin2;
alter role ProcedureExecutionViewRole add member CourseProcedureExecViewUser2;