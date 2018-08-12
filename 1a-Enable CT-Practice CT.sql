/*
1a Beginning to learn Change Tracking
*/
-- Enable CT at Database Level
ALTER DATABASE AdventureWorks2016CTP3
SET CHANGE_TRACKING = ON
    (CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON);

-- Enable CT at Table Level

USE [AdventureWorks2016CTP3];

ALTER TABLE Person.Person
ENABLE CHANGE_TRACKING
WITH
(TRACK_COLUMNS_UPDATED = ON);

-- Make a change to look at

USE [AdventureWorks2016CTP3];

UPDATE [Person].[Person]
SET title = 'Mr.'
WHERE BusinessEntityID = 7;

UPDATE [Person].[Person]
SET title = 'Mr.'
WHERE BusinessEntityID = 2;

-- Looking at the results

DECLARE @last_sync_version BIGINT;
SET @last_sync_version = 1;

SELECT P.BusinessEntityID, Title, c.*
FROM person.person p
    CROSS APPLY CHANGETABLE(VERSION [person].[Person], (BusinessEntityID), (p.BusinessEntityID)) AS C
WHERE SYS_CHANGE_VERSION IS NOT NULL;

