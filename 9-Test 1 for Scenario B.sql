USE CTPOC;

-- Clear testing instance	
TRUNCATE TABLE dbo.TestRecords1;

TRUNCATE TABLE dbo.TestRecords1Dest;

UPDATE dbo.VersionTracking
SET table_version = 0
WHERE Table_Name = 'TestRecords1';

-- Set new values for testing
INSERT INTO dbo.TestRecords1 (FakeVarchar, FakeInt, FakeDate)
VALUES ('A', 1, '2018-01-01'), ('B', 2, '2018-02-01'), ('C', 3, '2018-03-01');

UPDATE dbo.TestRecords1
SET fakevarchar = 'Z'
WHERE id = 1;

DECLARE @bigint BIGINT;
DECLARE @newbigint BIGINT;

SET @newbigint = (
		SELECT CHANGE_TRACKING_CURRENT_VERSION()
		);
SET @bigint = (
		SELECT TOP 1 table_version
		FROM dbo.VersionTracking
		WHERE Table_Name = 'TestRecords1'
		);

MERGE dbo.TestRecords1Dest AS Target
USING (
	SELECT t.id, t.FakeVarchar, t.FakeInt, t.FakeDate
	FROM dbo.TestRecords1 t
	LEFT JOIN CHANGETABLE(CHANGES TestRecords1, @bigint) AS C
		ON c.id = t.ID
	WHERE sys_change_version >= (
			SELECT TOP 1 table_version
			FROM dbo.VersionTracking
			WHERE Table_Name = 'TestRecords1'
			)
	) AS Source
	ON (target.id = source.id)
WHEN MATCHED
	THEN
		UPDATE
		SET id = source.id, FakeVarchar = source.FakeVarchar, FakeInt = source.FakeInt, FakeDate = source.FakeDate
WHEN NOT MATCHED
	THEN
		INSERT (id, FakeVarchar, FakeInt, FakeDate)
		VALUES (source.id, source.FakeVarchar, source.FakeInt, source.FakeDate);

-- Set version to latest pull
UPDATE dbo.VersionTracking
SET Table_LastVersion = (@bigint), table_version = (@newbigint)
WHERE Table_Name = 'TestRecords1';

-- View result set aftewards.
-- Resolves test (1)
SELECT CHANGE_TRACKING_CURRENT_VERSION();

SELECT *
FROM dbo.VersionTracking;

SELECT *
FROM dbo.TestRecords1;

SELECT *
FROM dbo.TestRecords1Dest;