




/*
(4)
CREATE THE TEST TABLES
*/

USE [CTPOC];
GO

IF OBJECT_ID('dbo.TestRecords1', 'U') IS NOT NULL
    DROP TABLE dbo.TestRecords1;

GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[TestRecords1]
(
    [ID] [INT] IDENTITY(1, 1) NOT NULL,
    [FakeVarchar] [VARCHAR](255) NULL,
    [FakeInt] [INT] NULL,
    [FakeDate] [DATE] NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
          ALLOW_PAGE_LOCKS = ON
         ) ON [PRIMARY]
) ON [PRIMARY];
GO
SET ANSI_PADDING OFF;
GO

USE [CTPOC];
GO

IF OBJECT_ID('dbo.TestRecords2', 'U') IS NOT NULL
    DROP TABLE dbo.TestRecords2;

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[TestRecords2]
(
    [ID] [INT] IDENTITY(1, 1) NOT NULL,
    [FakeVarchar] [VARCHAR](255) NULL,
    [FakeInt] [INT] NULL,
    [FakeDate] [DATE] NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
          ALLOW_PAGE_LOCKS = ON
         ) ON [PRIMARY]
) ON [PRIMARY];
GO

SET ANSI_PADDING OFF;
GO
USE [CTPOC];
GO

IF OBJECT_ID('dbo.TestRecords3', 'U') IS NOT NULL
    DROP TABLE dbo.TestRecords3;

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[TestRecords3]
(
    [ID] [INT] IDENTITY(1, 1) NOT NULL,
    [FakeVarchar] [VARCHAR](255) NULL,
    [FakeInt] [INT] NULL,
    [FakeDate] [DATE] NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
          ALLOW_PAGE_LOCKS = ON
         ) ON [PRIMARY]
) ON [PRIMARY];
GO

SET ANSI_PADDING OFF;
GO
USE [CTPOC];
GO

IF OBJECT_ID('dbo.TestRecords4', 'U') IS NOT NULL
    DROP TABLE dbo.TestRecords4;

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[TestRecords4]
(
    [ID] [INT] IDENTITY(1, 1) NOT NULL,
    [FakeVarchar] [VARCHAR](255) NULL,
    [FakeInt] [INT] NULL,
    [FakeDate] [DATE] NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
          ALLOW_PAGE_LOCKS = ON
         ) ON [PRIMARY]
) ON [PRIMARY];
GO

SET ANSI_PADDING OFF;
GO
USE [CTPOC];
GO
IF OBJECT_ID('dbo.TestRecords5', 'U') IS NOT NULL
    DROP TABLE dbo.TestRecords5;

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[TestRecords5]
(
    [ID] [INT] IDENTITY(1, 1) NOT NULL,
    [FakeVarchar] [VARCHAR](255) NULL,
    [FakeInt] [INT] NULL,
    [FakeDate] [DATE] NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
          ALLOW_PAGE_LOCKS = ON
         ) ON [PRIMARY]
) ON [PRIMARY];
GO

SET ANSI_PADDING OFF;
GO

USE [CTPOC];
GO
IF OBJECT_ID('dbo.TestRecords1Dest', 'U') IS NOT NULL
    DROP TABLE dbo.TestRecords1Dest;
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[TestRecords1Dest]
(
    [DestID] [INT] IDENTITY(1, 1) NOT NULL,
    [ID] [INT] NULL,
    [FakeVarchar] [VARCHAR](255) NULL,
    [FakeInt] [INT] NULL,
    [FakeDate] [DATE] NULL,
    PRIMARY KEY CLUSTERED ([DestID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
          ALLOW_PAGE_LOCKS = ON
         ) ON [PRIMARY]
) ON [PRIMARY];
GO

SET ANSI_PADDING OFF;
GO
USE [CTPOC];
GO

IF OBJECT_ID('dbo.TestRecords2Dest', 'U') IS NOT NULL
    DROP TABLE dbo.TestRecords2Dest;
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[TestRecords2Dest]
(
    [DestID] [INT] IDENTITY(1, 1) NOT NULL,
    [ID] [INT] NULL,
    [FakeVarchar] [VARCHAR](255) NULL,
    [FakeInt] [INT] NULL,
    [FakeDate] [DATE] NULL,
    PRIMARY KEY CLUSTERED ([DestID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
          ALLOW_PAGE_LOCKS = ON
         ) ON [PRIMARY]
) ON [PRIMARY];
GO

SET ANSI_PADDING OFF;
GO
USE [CTPOC];
GO

IF OBJECT_ID('dbo.TestRecords3Dest', 'U') IS NOT NULL
    DROP TABLE dbo.TestRecords3Dest;
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[TestRecords3Dest]
(
    [DestID] [INT] IDENTITY(1, 1) NOT NULL,
    [ID] [INT] NULL,
    [FakeVarchar] [VARCHAR](255) NULL,
    [FakeInt] [INT] NULL,
    [FakeDate] [DATE] NULL,
    PRIMARY KEY CLUSTERED ([DestID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
          ALLOW_PAGE_LOCKS = ON
         ) ON [PRIMARY]
) ON [PRIMARY];
GO

SET ANSI_PADDING OFF;
GO
USE [CTPOC];
GO

IF OBJECT_ID('dbo.TestRecords4Dest', 'U') IS NOT NULL
    DROP TABLE dbo.TestRecords4Dest;
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[TestRecords4Dest]
(
    [DestID] [INT] IDENTITY(1, 1) NOT NULL,
    [ID] [INT] NULL,
    [FakeVarchar] [VARCHAR](255) NULL,
    [FakeInt] [INT] NULL,
    [FakeDate] [DATE] NULL,
    PRIMARY KEY CLUSTERED ([DestID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
          ALLOW_PAGE_LOCKS = ON
         ) ON [PRIMARY]
) ON [PRIMARY];
GO

SET ANSI_PADDING OFF;
GO
USE [CTPOC];
GO

IF OBJECT_ID('dbo.TestRecords5Dest', 'U') IS NOT NULL
    DROP TABLE dbo.TestRecords5Dest;
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[TestRecords5Dest]
(
    [DestID] [INT] IDENTITY(1, 1) NOT NULL,
    [ID] [INT] NULL,
    [FakeVarchar] [VARCHAR](255) NULL,
    [FakeInt] [INT] NULL,
    [FakeDate] [DATE] NULL,
    PRIMARY KEY CLUSTERED ([DestID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
          ALLOW_PAGE_LOCKS = ON
         ) ON [PRIMARY]
) ON [PRIMARY];
GO

SET ANSI_PADDING OFF;
GO

/*
(5)
POPULATE THE VERSION TRACKING TABLE
*/

-- Set Database
USE CTPOC;

-- Declare variable table to hold table names
DECLARE @variablenametable TABLE
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    variablename VARCHAR(255)
);
-- Holds the table name to stop
DECLARE @variablename VARCHAR(255);
-- Dynamic SQL holder
DECLARE @variablenamekill NVARCHAR(MAX);
-- Holds the ID of the table in the loop
DECLARE @ID INT = 0;

-- Insert names of table into the table variable
INSERT INTO @variablenametable
(
    variablename
)
SELECT name
FROM CTPOC.dbo.sysobjects
WHERE xtype = 'U';

MERGE dbo.VersionTracking AS Target
USING
(
    SELECT DISTINCT
           variablename AS table_name,
           CASE
               WHEN tt.min_valid_version >= 0 THEN
                   0
               ELSE
                   1
           END AS CT_Disabled
    FROM @variablenametable vn
        LEFT JOIN dbo.VersionTracking vt
            ON vn.variablename = vt.Table_Name
        LEFT JOIN sys.objects o
            ON vn.variablename = o.name
        LEFT JOIN sys.change_tracking_tables tt
            ON o.object_id = tt.object_id
) AS Source
ON (Target.table_name = Source.table_name)
WHEN MATCHED THEN
    UPDATE SET CT_Disabled = Source.CT_Disabled
WHEN NOT MATCHED THEN
    INSERT
    (
        table_name,
        CT_Disabled
    )
    VALUES
    (Source.table_name, Source.CT_Disabled);
--truncate table versiontracking

/*
(6)
CREATE TEST RECORDS
*/

INSERT INTO TestRecords1
(
    FakeVarchar,
    FakeInt,
    FakeDate
)
VALUES
('A', 1, '2018-01-01'),
('B', 2, '2018-02-01'),
('C', 3, '2018-03-01');

INSERT INTO TestRecords2
(
    FakeVarchar,
    FakeInt,
    FakeDate
)
VALUES
('A', 1, '2018-01-01'),
('B', 2, '2018-02-01'),
('C', 3, '2018-03-01');

INSERT INTO TestRecords3
(
    FakeVarchar,
    FakeInt,
    FakeDate
)
VALUES
('A', 1, '2018-01-01'),
('B', 2, '2018-02-01'),
('C', 3, '2018-03-01');

INSERT INTO TestRecords4
(
    FakeVarchar,
    FakeInt,
    FakeDate
)
VALUES
('A', 1, '2018-01-01'),
('B', 2, '2018-02-01'),
('C', 3, '2018-03-01');

INSERT INTO TestRecords5
(
    FakeVarchar,
    FakeInt,
    FakeDate
)
VALUES
('A', 1, '2018-01-01'),
('B', 2, '2018-02-01'),
('C', 3, '2018-03-01');