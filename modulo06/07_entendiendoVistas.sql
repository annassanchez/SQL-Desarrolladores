--DMF Y DMV RELACIONADAS CON EJECUCIONES
--sys.dm_exec_sessions
SELECT
 session_id
 , login_name
 , last_request_end_time
 , cpu_time
FROM 
 sys.dm_exec_sessions
WHERE session_id > 50;

--sys.dm_exec_connections
SELECT
 connection_id
 , session_id
 , client_net_address
 , auth_scheme
FROM 
 sys.dm_exec_connections
WHERE session_id > 50;

--sys.dm_exec_requests
SELECT
 session_id
 , status
 , command
 , sql_handle
 , database_id
FROM
 sys.dm_exec_requests
WHERE session_id > 50;

--sys.dm_exec_sql_text
SELECT
 r.session_id
 , r.status
 , r.command
 , r.database_id
 , st.text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) st
WHERE session_id > 50;

--DMV Y DFM RELACIONADAS CON TRANSACCIONES
--sys.dm_tran_locks
SELECT 
 resource_type
 , resource_associated_entity_id
 , request_status
 , request_mode,request_session_id
 , resource_description 
FROM 
 sys.dm_tran_locks
WHERE resource_database_id = <dbid>;

--DMV y DMF relacionadas con entrada y salida
--sys.dm_io_pending_io_requests
SELECT 
 io_completion_request_address
 , io_type
 , io_pending_ms_ticks
 , io_pending
 , io_completion_routine_address
 , io_user_data_address
 , scheduler_address
 , io_handle
 , io_offset 
FROM 
 sys.dm_io_pending_io_requests;
 --sys.dm_io_virtual_file_stats
 SELECT
 database_id
 , file_id
 , sample_ms
 , num_of_reads
 , num_of_bytes_read
 , io_stall_read_ms
 , num_of_writes
 , num_of_bytes_written
 , io_stall_write_ms
 , size_on_disk_bytes
FROM 
 sys.dm_io_virtual_file_stats(DB_ID(N'CourseDatabase'), null);
GO
--sys.dm_db_index_usage_stats
SELECT 
 object_id
 , index_id
 , user_seeks
 , user_scans
 , user_lookups 
FROM 
 sys.dm_db_index_usage_stats 
ORDER BY 
 object_id
 , index_id;

 SELECT 
 s.object_id
 , s.index_id
 , s.user_seeks
 , s.user_scans
 , s.user_lookups 
 , i.name
FROM 
 sys.dm_db_index_usage_stats s
 JOIN sys.indexes i ON s.object_id = i.object_id AND s.index_id = i.index_id
WHERE
 (s.user_seeks + s.user_scans + s.user_lookups) = 0
 AND OBJECTPROPERTY(s.object_id, 'IsUserTable') = 1 
 AND i.type_desc = 'nonclustered'
 AND i.is_primary_key = 0
 AND i.is_unique_constraint = 0;
 --sys.dm_db_missing_index_details
 -- Missing Index Script
-- Original Author: Pinal Dave (C) 2011
-- http://blog.sqlauthority.com
SELECT TOP 25
dm_mid.database_id AS DatabaseID, 
dm_migs.avg_user_impact*(dm_migs.user_seeks+dm_migs.user_scans) Avg_Estimated_Impact,
dm_migs.last_user_seek AS Last_User_Seek,
object_name(dm_mid.object_id,dm_mid.database_id) AS [TableName],
'CREATE INDEX [IX_' + object_name(dm_mid.object_id,dm_mid.database_id) + '_'
+ REPLACE(REPLACE(REPLACE(ISNULL(dm_mid.equality_columns,''),', ','_'),'[',''),']','') +
CASE
WHEN dm_mid.equality_columns IS NOT NULL AND dm_mid.inequality_columns IS NOT NULL THEN '_'
ELSE ''
END
+ REPLACE(REPLACE(REPLACE(ISNULL(dm_mid.inequality_columns,''),', ','_'),'[',''),']','')
+ ']'
+ ' ON ' + dm_mid.statement
+ ' (' + ISNULL (dm_mid.equality_columns,'')
+ CASE WHEN dm_mid.equality_columns IS NOT NULL AND dm_mid.inequality_columns IS NOT NULL THEN ',' ELSE
'' END
+ ISNULL (dm_mid.inequality_columns, '')
+ ')'
+ ISNULL (' INCLUDE (' + dm_mid.included_columns + ')', '') AS Create_Statement
FROM sys.dm_db_missing_index_groups dm_mig
INNER JOIN sys.dm_db_missing_index_group_stats dm_migs
ON dm_migs.group_handle = dm_mig.index_group_handle
INNER JOIN sys.dm_db_missing_index_details dm_mid
ON dm_mig.index_handle = dm_mid.index_handle
WHERE dm_mid.database_ID = DB_ID()
ORDER BY Avg_Estimated_Impact DESC 
GO