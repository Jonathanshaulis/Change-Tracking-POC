/*
(5)
POPULATE THE VERSION TRACKING TABLE
*/

-- Set Database
USE CTPOC;

-- Declare variable table to hold table names
DECLARE @variablenametable TABLE
(Id           INT
 PRIMARY KEY IDENTITY(1, 1), 
 variablename VARCHAR(255)
);
-- Holds the table name to stop
DECLARE @variablename VARCHAR(255);
-- Dynamic SQL holder
DECLARE @variablenamekill NVARCHAR(MAX);
-- Holds the ID of the table in the loop
DECLARE @ID INT= 0;

-- Insert names of table into the table variable
INSERT INTO @variablenametable(variablename)
       SELECT name
       FROM CTPOC.dbo.sysobjects
       WHERE xtype = 'U';
MERGE dbo.VersionTracking AS Target
USING
(
    SELECT DISTINCT 
           variablename AS table_name,
           CASE
               WHEN tt.min_valid_version >= 0
               THEN 0
               ELSE 1
           END AS CT_Disabled
    FROM @variablenametable vn
         LEFT JOIN dbo.VersionTracking vt ON vn.variablename = vt.Table_Name
         LEFT JOIN sys.objects o ON vn.variablename = o.name
         LEFT JOIN sys.change_tracking_tables tt ON o.object_id = tt.object_id
) AS Source
ON(Target.table_name = Source.table_name)
    WHEN MATCHED
    THEN UPDATE SET 
                    CT_Disabled = Source.CT_Disabled
    WHEN NOT MATCHED
    THEN
      INSERT(table_name, 
             CT_Disabled)
      VALUES
(Source.table_name, 
 Source.CT_Disabled
);