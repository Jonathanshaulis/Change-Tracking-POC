-- Clear testing instance	
TRUNCATE TABLE TestRecords1;

TRUNCATE TABLE TestRecords1Dest;

UPDATE VersionTracking
SET	   table_version = 0
WHERE  Table_Name = 'TestRecords1';

-- Set new values for testing
INSERT INTO TestRecords1 (FakeVarchar
						, FakeInt
						, FakeDate)
VALUES ('A', 1, '2018-01-01')
	 , ('B', 2, '2018-02-01')
	 , ('C', 3, '2018-03-01');

INSERT INTO TestRecords1Dest (ID
							, FakeVarchar
							, FakeInt
							, FakeDate)
SELECT ID
	 , FakeVarchar
	 , FakeInt
	 , FakeDate
FROM   TestRecords1;

UPDATE dbo.TestRecords1
SET	   fakevarchar = 'Z'
WHERE  id = 1;

UPDATE dbo.TestRecords1
SET	   fakeint = '9001'
WHERE  id = 2;

DELETE dbo.TestRecords1
WHERE  id = 3;

DECLARE @bigint BIGINT;
DECLARE @newbigint BIGINT;

SET @newbigint = (SELECT CHANGE_TRACKING_CURRENT_VERSION());
SET @bigint = (	  SELECT TOP 1 table_version
				  FROM	 VersionTracking
				  WHERE	 Table_Name = 'TestRecords1');

-- Records that need to be inserted or updated.
MERGE dbo.TestRecords1Dest AS Target
USING (	  SELECT	t.id
				  , t.FakeVarchar
				  , t.FakeInt
				  , t.FakeDate
		  FROM		TestRecords1 t
		  LEFT JOIN CHANGETABLE(CHANGES TestRecords1, @bigint) AS C
			  ON C.id = t.ID
		  WHERE		SYS_CHANGE_VERSION >= (	  SELECT TOP 1 table_version
											  FROM	 VersionTracking
											  WHERE	 Table_Name = 'TestRecords1')) AS Source
ON (Target.id = Source.id)
WHEN MATCHED THEN UPDATE SET id = Source.id
						   , FakeVarchar = Source.FakeVarchar
						   , FakeInt = Source.FakeInt
						   , FakeDate = Source.FakeDate
WHEN NOT MATCHED THEN INSERT (id
							, FakeVarchar
							, FakeInt
							, FakeDate)
					  VALUES (Source.id, Source.FakeVarchar, Source.FakeInt, Source.FakeDate);

-- Records that should be deleted
DELETE TestRecords1Dest
WHERE  ID IN (	 SELECT C.id
				 FROM	CHANGETABLE(CHANGES TestRecords1, @bigint) AS C
				 WHERE	SYS_CHANGE_OPERATION = 'D'
						AND C.id NOT IN (	SELECT	  t.id
											FROM	  TestRecords1 t
											LEFT JOIN CHANGETABLE(CHANGES TestRecords1, @bigint) AS C
												ON C.id = t.ID
											WHERE	  SYS_CHANGE_VERSION >= (	SELECT TOP 1 table_version
																				FROM   VersionTracking
																				WHERE  Table_Name = 'TestRecords1')));

-- Set version to latest pull
UPDATE VersionTracking
SET	   Table_LastVersion = (@bigint)
	 , table_version = (@newbigint)
WHERE  Table_Name = 'TestRecords1';

-- View result set aftewards.
-- TestRecords1Dest should contain two rows
SELECT CHANGE_TRACKING_CURRENT_VERSION();

SELECT *
FROM   VersionTracking;

SELECT *
FROM   TestRecords1;

SELECT *
FROM   TestRecords1Dest;

-- Set record for testing
SET IDENTITY_INSERT TestRecords1 ON;

INSERT INTO TestRecords1 (ID
						, FakeVarchar
						, FakeInt
						, FakeDate)
VALUES (3, 'C', 3, '2018-03-01');

SET IDENTITY_INSERT TestRecords1 OFF;

UPDATE dbo.TestRecords1
SET	   FakeDate = '2020-04-24'
WHERE  id = 3;

-- Run test
DECLARE @bigint BIGINT;
DECLARE @newbigint BIGINT;

SET @newbigint = (SELECT CHANGE_TRACKING_CURRENT_VERSION());
SET @bigint = (	  SELECT TOP 1 table_version
				  FROM	 VersionTracking
				  WHERE	 Table_Name = 'TestRecords1');

-- Records that need to be inserted or updated.
MERGE dbo.TestRecords1Dest AS Target
USING (	  SELECT	t.id
				  , t.FakeVarchar
				  , t.FakeInt
				  , t.FakeDate
		  FROM		TestRecords1 t
		  LEFT JOIN CHANGETABLE(CHANGES TestRecords1, @bigint) AS C
			  ON C.id = t.ID
		  WHERE		SYS_CHANGE_VERSION >= (	  SELECT TOP 1 table_version
											  FROM	 VersionTracking
											  WHERE	 Table_Name = 'TestRecords1')) AS Source
ON (Target.id = Source.id)
WHEN MATCHED THEN UPDATE SET id = Source.id
						   , FakeVarchar = Source.FakeVarchar
						   , FakeInt = Source.FakeInt
						   , FakeDate = Source.FakeDate
WHEN NOT MATCHED THEN INSERT (id
							, FakeVarchar
							, FakeInt
							, FakeDate)
					  VALUES (Source.id, Source.FakeVarchar, Source.FakeInt, Source.FakeDate);

-- Records that should be deleted
DELETE TestRecords1Dest
WHERE  ID IN (	 SELECT C.id
				 FROM	CHANGETABLE(CHANGES TestRecords1, @bigint) AS C
				 WHERE	SYS_CHANGE_OPERATION = 'D'
						AND C.id NOT IN (	SELECT	  t.id
											FROM	  TestRecords1 t
											LEFT JOIN CHANGETABLE(CHANGES TestRecords1, @bigint) AS C
												ON C.id = t.ID
											WHERE	  SYS_CHANGE_VERSION >= (	SELECT TOP 1 table_version
																				FROM   VersionTracking
																				WHERE  Table_Name = 'TestRecords1')));

-- Set version to latest pull
UPDATE VersionTracking
SET	   Table_LastVersion = (@bigint)
	 , table_version = (@newbigint)
WHERE  Table_Name = 'TestRecords1';

-- View result set aftewards.
-- TestRecords1Dest should contain three rows
-- Resolves test (2)
SELECT CHANGE_TRACKING_CURRENT_VERSION();

SELECT *
FROM   VersionTracking;

SELECT *
FROM   TestRecords1;

SELECT *
FROM   TestRecords1Dest;