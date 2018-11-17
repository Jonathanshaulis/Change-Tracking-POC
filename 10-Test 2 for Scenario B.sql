USE CTPOC;

-- Clear testing instance	

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

INSERT INTO dbo.TestRecords1Dest
(ID, 
 FakeVarchar, 
 FakeInt, 
 FakeDate
)
       SELECT ID, 
              FakeVarchar, 
              FakeInt, 
              FakeDate
       FROM dbo.TestRecords1;

UPDATE dbo.TestRecords1
  SET 
      fakevarchar = 'Z'
WHERE id = 1;

UPDATE dbo.TestRecords1
  SET 
      fakeint = '9001'
WHERE id = 2;

DELETE dbo.TestRecords1
WHERE id = 3;

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

-- Records that need to be inserted or updated.

MERGE dbo.TestRecords1Dest AS Target
USING
(
    SELECT t.id, 
           t.FakeVarchar, 
           t.FakeInt, 
           t.FakeDate
    FROM dbo.TestRecords1 t
         LEFT JOIN CHANGETABLE(CHANGES dbo.TestRecords1, @bigint) AS C ON C.id = t.ID
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

-- Records that should be deleted

DELETE dbo.TestRecords1Dest
WHERE ID IN
(
    SELECT C.id
    FROM CHANGETABLE(CHANGES dbo.TestRecords1, @bigint) AS C
    WHERE SYS_CHANGE_OPERATION = 'D'
          AND C.id NOT IN
    (
        SELECT t.id
        FROM dbo.TestRecords1 t
             LEFT JOIN CHANGETABLE(CHANGES dbo.TestRecords1, @bigint) AS C ON C.id = t.ID
        WHERE SYS_CHANGE_VERSION >=
        (
            SELECT TOP 1 table_version
            FROM dbo.VersionTracking
            WHERE Table_Name = 'TestRecords1'
        )
    )
);

-- Set version to latest pull

UPDATE dbo.VersionTracking
  SET 
      Table_LastVersion = (@bigint), 
      table_version = (@newbigint)
WHERE Table_Name = 'TestRecords1';

-- View result set aftewards.
-- TestRecords1Dest should contain two rows

/*
(1) Scenario B: Test 2 - Change Tracking Current Version
View current tracking version
*/

SELECT CHANGE_TRACKING_CURRENT_VERSION() as 'Change Tracking Current Version';

/*
(2) Scenario B: Test 2 - Version Tracking Table
View result set afterwards
View Version Tracking table
*/

SELECT *
FROM dbo.VersionTracking;

/*
(3) Scenario B: Test 2 - TestRecords1 Table
View TestRecords1 table 
*/

SELECT *
FROM dbo.TestRecords1;

/* 
(4) Scenario B: Test 2 - TestRecords1Dest Table
View TestRecords1Dest table
*/

SELECT *
FROM dbo.TestRecords1Dest;

-- Set record for testing

SET IDENTITY_INSERT dbo.TestRecords1 ON;

INSERT INTO TestRecords1
(ID, 
 FakeVarchar, 
 FakeInt, 
 FakeDate
)
VALUES
(3, 
 'C', 
 3, 
 '2018-03-01'
);

SET IDENTITY_INSERT dbo.TestRecords1 OFF;

UPDATE dbo.TestRecords1
  SET 
      FakeDate = '2020-04-24'
WHERE id = 3;
GO

-- Run test

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

-- Records that need to be inserted or updated.

MERGE dbo.TestRecords1Dest AS Target
USING
(
    SELECT t.id, 
           t.FakeVarchar, 
           t.FakeInt, 
           t.FakeDate
    FROM dbo.TestRecords1 t
         LEFT JOIN CHANGETABLE(CHANGES dbo.TestRecords1, @bigint) AS C ON C.id = t.ID
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

-- Records that should be deleted

DELETE dbo.TestRecords1Dest
WHERE ID IN
(
    SELECT C.id
    FROM CHANGETABLE(CHANGES dbo.TestRecords1, @bigint) AS C
    WHERE SYS_CHANGE_OPERATION = 'D'
          AND C.id NOT IN
    (
        SELECT t.id
        FROM dbo.TestRecords1 t
             LEFT JOIN CHANGETABLE(CHANGES dbo.TestRecords1, @bigint) AS C ON C.id = t.ID
        WHERE SYS_CHANGE_VERSION >=
        (
            SELECT TOP 1 table_version
            FROM dbo.VersionTracking
            WHERE Table_Name = 'TestRecords1'
        )
    )
);

-- Set version to latest pull

UPDATE dbo.VersionTracking
  SET 
      Table_LastVersion = (@bigint), 
      table_version = (@newbigint)
WHERE Table_Name = 'TestRecords1';

-- View result set aftewards.
-- TestRecords1Dest should contain three rows

/*
(5) Scenario B: Test 2 - Change Tracking Current Version
View current tracking version
*/ 

SELECT CHANGE_TRACKING_CURRENT_VERSION() as 'Change Tracking Current Version';

/*
(6) Scenario B: Test 2 - Version Tracking Table
View result set afterwards
View Version Tracking table
*/

SELECT *
FROM dbo.VersionTracking;

/*
(7) Scenario B: Test 2 - TestRecords1 Table
View TestRecords1 table 
*/

SELECT *
FROM dbo.TestRecords1;

/* 
(8) Scenario B: Test 2 - TestRecords1Dest Table
View TestRecords1Dest table
*/
SELECT *
FROM dbo.TestRecords1Dest;