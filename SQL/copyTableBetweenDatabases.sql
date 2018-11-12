-- show min and max id in the production DB
SELECT min([rowID]), max([rowID])
  FROM [productionDB].[dbo].[databaseTable];
GO  

-- show min and max id in the restored DB
SELECT min([rowID]), max([rowID])
  FROM backupRestored.[dbo].[databaseTable];
GO  

-- remove the data from the production DB
DELETE FROM [productionDB].[dbo].[databaseTable];

-- allow identity insert
SET IDENTITY_INSERT [productionDB].[dbo].[databaseTable] ON;  
GO  

-- actual copying of the data
INSERT INTO [productionDB].[dbo].[databaseTable] (
	[rowID]
      ,[data]
) 
SELECT [rowID]
      ,[data]
  FROM backupRestored.[dbo].[databaseTable];
GO

-- show min and max id in the production DB - to compare before and after
 SELECT min([rowID]), max([rowID])
  FROM [productionDB].[dbo].[databaseTable];
GO  
