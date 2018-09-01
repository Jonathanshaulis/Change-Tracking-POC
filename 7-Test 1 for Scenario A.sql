-- Clear testing instance	
USE CTPOC;
TRUNCATE TABLE dbo.TestRecords1;
TRUNCATE TABLE dbo.TestRecords1Dest;
UPDATE dbo.VersionTracking
  SET 
      table_version = 0
WHERE Table_Name = 'TestRecords1';

-- Set new values for testing
INSERT INTO dbo.TestRecords1
(FakeVarchar, 
 FakeInt, 
 FakeDate
)
VALUES
('A', 
 1, 
 '2018-01-01'
),
('B', 
 2, 
 '2018-02-01'
),
('C', 
 3, 
 '2018-03-01'
);

-- Run CT process, expect three rows to migrate over.
-- Declaring variables to hold CT information
DECLARE @bigint BIGINT;
DECLARE @newbigint BIGINT;
-- Setting CT variable to database current version
SET @newbigint =
(
    SELECT CHANGE_TRACKING_CURRENT_VERSION()
);
-- Setting another CT variable but to the table version.
SET @bigint =
(
    SELECT TOP 1 table_version
    FROM dbo.VersionTracking
    WHERE Table_Name = 'TestRecords1'
);
-- Allows us to insert or update with the merge statement
MERGE dbo.TestRecords1Dest AS Target
USING
(
    SELECT t.id, 
           t.FakeVarchar, 
           t.FakeInt, 
           t.FakeDate
    FROM dbo.TestRecords1 t
         -- Join to system table allows us to filter results
         LEFT JOIN CHANGETABLE(CHANGES dbo.TestRecords1, @bigint) AS C ON C.id = t.ID
    -- Limit information back to most current version of change in table
    WHERE SYS_CHANGE_VERSION >=
    (
        SELECT TOP 1 table_version
        FROM dbo.VersionTracking
        WHERE Table_Name = 'TestRecords1'
    )
) AS Source
ON(Target.id = Source.id)
    WHEN MATCHED
    THEN UPDATE SET 
                    id = Source.id, 
                    FakeVarchar = Source.FakeVarchar, 
                    FakeInt = Source.FakeInt, 
                    FakeDate = Source.FakeDate
    WHEN NOT MATCHED
    THEN
      INSERT(id, 
             FakeVarchar, 
             FakeInt, 
             FakeDate)
      VALUES
(Source.id, 
 Source.FakeVarchar, 
 Source.FakeInt, 
 Source.FakeDate
);

-- Set VersionTracking to last update of table.
UPDATE dbo.VersionTracking
  SET 
      Table_LastVersion = (@bigint), 
      table_version = (@newbigint)
WHERE Table_Name = 'TestRecords1';

/*
(1) Scenario A: Test 1 - Version Tracking Table
View result set afterwards
View Version Tracking table
*/

SELECT *
FROM dbo.VersionTracking;

/*
(2) Scenario A: Test 1 - TestRecords1 Table
View TestRecords1 table
*/

SELECT *
FROM dbo.TestRecords1;

/* 
(3) Scenario A: Test 1 - TestRecords1Dest Table
View TestRecords1Dest table
*/

SELECT *
FROM dbo.TestRecords1Dest;

-- Change two records, setting us up for the third objective for Test 1.
UPDATE dbo.TestRecords1
SET FakeDate = '2020-04-14'
WHERE ID = '2';

UPDATE dbo.TestRecords1
SET FakeDate = '2020-08-18'
WHERE ID = '3';

-- Set VersionTracking to 0 to indicate a full pull
UPDATE dbo.VersionTracking
  SET 
      table_version = 0
WHERE Table_Name = 'TestRecords1';

-- Run CT process, expect three rows to migrate over.
-- Declaring variables to hold CT information
--If you run this script in pieces, uncomment the DECLARES below.
--DECLARE @bigint BIGINT;
--DECLARE @newbigint BIGINT;
-- Setting CT variable to database current version
SET @newbigint =
(
    SELECT CHANGE_TRACKING_CURRENT_VERSION()
);
-- Setting another CT variable but to the table version.
SET @bigint =
(
    SELECT TOP 1 table_version
    FROM dbo.VersionTracking
    WHERE Table_Name = 'TestRecords1'
);

-- Allows us to insert or update with the merge statement
MERGE dbo.TestRecords1Dest AS Target
USING
(
    SELECT t.id, 
           t.FakeVarchar, 
           t.FakeInt, 
           t.FakeDate
    FROM dbo.TestRecords1 t
         -- Join to system table allows us to filter results
         LEFT JOIN CHANGETABLE(CHANGES dbo.TestRecords1, @bigint) AS C ON C.id = t.ID
    -- Limit information back to most current version of change in table
    WHERE SYS_CHANGE_VERSION >=
    (
        SELECT TOP 1 table_version
        FROM dbo.VersionTracking
        WHERE Table_Name = 'TestRecords1'
    )
) AS Source
ON(Target.id = Source.id)
    WHEN MATCHED
    THEN UPDATE SET 
                    id = Source.id, 
                    FakeVarchar = Source.FakeVarchar, 
                    FakeInt = Source.FakeInt, 
                    FakeDate = Source.FakeDate
    WHEN NOT MATCHED
    THEN
      INSERT(id, 
             FakeVarchar, 
             FakeInt, 
             FakeDate)
      VALUES
(Source.id, 
 Source.FakeVarchar, 
 Source.FakeInt, 
 Source.FakeDate
);
-- Set VersionTracking to last update of table.
UPDATE dbo.VersionTracking
  SET 
      Table_LastVersion = (@bigint), 
      table_version = (@newbigint)
WHERE Table_Name = 'TestRecords1';

/*
(4) Scenario A: Test 1 - Version Tracking Table
View result set afterwards
Resolves Test 1
View Version Tracking table
*/

SELECT *
FROM dbo.VersionTracking;

/*
(5) Scenario A: Test 1 - TestRecords1 Table
View TestRecords1 table
*/

SELECT *
FROM dbo.TestRecords1;

/* 
(6) Scenario A: Test 1 - TestRecords1Dest Table
View TestRecords1Dest table
*/

SELECT *
FROM dbo.TestRecords1Dest;

