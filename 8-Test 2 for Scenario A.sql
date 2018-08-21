-- Move onto second piece of test. Update one row in three different transactions.
UPDATE dbo.TestRecords1
  SET 
      fakevarchar = 'Z'
WHERE id = 1;

UPDATE dbo.TestRecords1
  SET 
      fakeint = '200'
WHERE id = 1;

UPDATE dbo.TestRecords1
  SET 
      FakeDate = '1900-01-01'
WHERE id = 1;

-- View CT versions from wash table, system tracking, and then records in the table we updated.
SELECT *
FROM VersionTracking;

SELECT CHANGE_TRACKING_CURRENT_VERSION();

SELECT *
FROM TestRecords1;

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
    FROM VersionTracking
    WHERE Table_Name = 'TestRecords1'
);

MERGE dbo.TestRecords1Dest AS Target
USING
(
    SELECT t.id, 
           t.FakeVarchar, 
           t.FakeInt, 
           t.FakeDate
    FROM TestRecords1 t
         LEFT JOIN CHANGETABLE(CHANGES TestRecords1, @bigint) AS C ON C.id = t.ID
    WHERE SYS_CHANGE_VERSION >=
    (
        SELECT TOP 1 table_version
        FROM VersionTracking
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

UPDATE VersionTracking
  SET 
      Table_LastVersion = (@bigint), 
      table_version = (@newbigint)
WHERE Table_Name = 'TestRecords1';

-- View result set aftewards.
-- Resolves test (2)
SELECT *
FROM VersionTracking;

SELECT *
FROM TestRecords1;

SELECT *
FROM TestRecords1Dest;