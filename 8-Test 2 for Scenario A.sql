USE CTPOC;

-- Move onto second piece of test. Update three rows in three different transactions.

UPDATE dbo.TestRecords1
  SET 
      fakevarchar = 'Z'
WHERE id = 1;
GO

UPDATE dbo.TestRecords1
  SET 
      fakevarchar = 'Y'
WHERE id = 2;
GO

UPDATE dbo.TestRecords1
  SET 
      fakevarchar = 'X'
WHERE id = 3;
GO

/*
(1) Scenario A: Test 2 - Version Tracking Table
View result set afterwards
View Version Tracking table
*/
SELECT *
FROM dbo.VersionTracking;

/*
(2) Scenario A: Test 2 - Change Tracking Current Version
View current tracking version
*/
SELECT CHANGE_TRACKING_CURRENT_VERSION() AS 'Tracking Current Version';

/*
(3) Scenario A: Test 2 - TestRecords1 Table
View TestRecords1 table - shows records we updated
*/
SELECT *
FROM dbo.TestRecords1;

-- Run CT process, expect one row to migrate over.

DECLARE @bigint BIGINT;

DECLARE @newbigint BIGINT;

SET @newbigint =
(
    SELECT CHANGE_TRACKING_CURRENT_VERSION()
);

SET @bigint = 
(
    SELECT TOP 1 table_version
    FROM dbo.VersionTracking
    WHERE Table_Name = 'TestRecords1'
);

MERGE dbo.TestRecords1Dest AS Target
USING
(
    SELECT t.id, 
           t.FakeVarchar, 
           t.FakeInt, 
           t.FakeDate
    FROM dbo.TestRecords1 t
         LEFT JOIN CHANGETABLE(CHANGES TestRecords1, @bigint) AS C ON C.id = t.ID
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

UPDATE dbo.VersionTracking
  SET 
      Table_LastVersion = (@bigint), 
      table_version = (@newbigint)
WHERE Table_Name = 'TestRecords1';

/*
(4) Scenario A: Test 2 - Version Tracking Table
View result set afterwards
View Version Tracking table
*/

SELECT *
FROM dbo.VersionTracking;

/*
(5) Scenario A: Test 2 - TestRecords1 Table
View TestRecords1 table
*/

SELECT *
FROM dbo.TestRecords1;

/*
(6) Scenario A: Test 2 - TestRecords1Dest Table
View TestRecords1Dest table
*/

SELECT *
FROM dbo.TestRecords1Dest;

-- Update one row in the source table three times on different columns to 
-- see what data is moved over to the destination. It is expected to 
-- look like exact copies of each other.

UPDATE dbo.TestRecords1
  SET 
      fakevarchar = 'Q'
WHERE id = 1;
GO

UPDATE dbo.TestRecords1
  SET 
      FakeInt = 1337
WHERE id = 1;
GO

UPDATE dbo.TestRecords1
  SET 
      FakeDate = '1915-1-1'
WHERE id = 1;
GO

-- Run CT process, expect one row to migrate over.

DECLARE @bigint BIGINT;
DECLARE @newbigint BIGINT;

SET @newbigint =
(
    SELECT CHANGE_TRACKING_CURRENT_VERSION()
);

SET @bigint =
(
    SELECT TOP 1 table_version
    FROM dbo.VersionTracking
    WHERE Table_Name = 'TestRecords1'
);

MERGE dbo.TestRecords1Dest AS Target
USING
(
    SELECT t.id, 
           t.FakeVarchar, 
           t.FakeInt, 
           t.FakeDate
    FROM dbo.TestRecords1 t
         LEFT JOIN CHANGETABLE(CHANGES TestRecords1, @bigint) AS C ON C.id = t.ID
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

UPDATE dbo.VersionTracking
  SET 
      Table_LastVersion = (@bigint), 
      table_version = (@newbigint)
WHERE Table_Name = 'TestRecords1';

/*
(7) Scenario A: Test 2 - Version Tracking Table
View result set afterwards
View Version Tracking table
*/

SELECT *
FROM dbo.VersionTracking;

/*
(8) Scenario A: Test 2 - TestRecords1 Table
View TestRecords1 table
*/

SELECT *
FROM dbo.TestRecords1;

/*
(9) Scenario A: Test 2 - TestRecords1Dest Table
View TestRecords1Dest table
*/

SELECT *
FROM dbo.TestRecords1Dest;