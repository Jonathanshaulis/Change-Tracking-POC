/*
(3)
CREATE THE VERSION TRACKING HISTORY TABLE
*/

USE [CTPOC];
GO
/****** Object:  Table [archive].[VersionTracking]    Script Date: 7/2/2018 10:44:29 AM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_PADDING ON;
GO

CREATE TABLE [archive].[VersionTracking]
(
    [ArchiveID] [BIGINT] IDENTITY(1, 1) NOT NULL,
    [ID] [BIGINT] NOT NULL,
    [Table_Name] [VARCHAR](255) NOT NULL,
    [Table_Version] [BIGINT] NOT NULL,
    [Table_LastVersion] [BIGINT] NOT NULL,
    [Ignore_Table] [BIT] NOT NULL,
    [CT_Disabled] [BIT] NOT NULL,
    [CreatedDate] [DATETIME2](2) NOT NULL,
    [CreatedBy] [VARCHAR](255) NOT NULL,
    [UpdatedDate] [DATETIME2](2) NOT NULL,
    [UpdatedBy] [VARCHAR](255) NOT NULL,
    [HostName] [VARCHAR](255) NOT NULL,
    [AppName] [VARCHAR](255) NOT NULL,
    PRIMARY KEY CLUSTERED ([ArchiveID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
          ALLOW_PAGE_LOCKS = ON
         ) ON [PRIMARY]
) ON [PRIMARY];
GO
SET ANSI_PADDING OFF;
GO