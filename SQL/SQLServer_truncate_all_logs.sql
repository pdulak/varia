-- This one will truncate all logs
-- this one is suitable for DEV environments since it is not creating any backups

DECLARE @ScriptToExecute VARCHAR(MAX);

SET @ScriptToExecute = '';

SELECT
@ScriptToExecute = @ScriptToExecute +
'USE ['+ d.name +']; alter database ['+ d.name +'] set recovery simple; alter database ['+ d.name +'] set recovery full; CHECKPOINT; DBCC SHRINKFILE (['+f.name+']);'
FROM sys.master_files f
INNER JOIN sys.databases d ON d.database_id = f.database_id
WHERE f.type = 1 AND d.database_id > 4 AND d.state_desc = 'ONLINE'

SELECT @ScriptToExecute ScriptToExecute

EXEC (@ScriptToExecute)

-- Execute twice for sure, sometimes one execution is not enough

SET @ScriptToExecute = '';

SELECT
@ScriptToExecute = @ScriptToExecute +
'USE ['+ d.name +']; alter database ['+ d.name +'] set recovery simple; alter database ['+ d.name +'] set recovery full; CHECKPOINT; DBCC SHRINKFILE (['+f.name+']);'
FROM sys.master_files f
INNER JOIN sys.databases d ON d.database_id = f.database_id
WHERE f.type = 1 AND d.database_id > 4

SELECT @ScriptToExecute ScriptToExecute

EXEC (@ScriptToExecute)
