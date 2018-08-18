
/*
(2)
CREATE THE VERSION TRACKING TABLE
*/

USE CTPOC;

CREATE TABLE [dbo].[VersionTracking]
([ID]                [BIGINT] IDENTITY(1, 1) NOT NULL, 
 [Table_Name]        [VARCHAR](255) NOT NULL, 
 [Table_Version]     [BIGINT] NOT NULL, 
 [Table_LastVersion] [BIGINT] NOT NULL, 
 [Ignore_Table]      [BIT] NOT NULL, 
 [CT_Disabled]       [BIT] NOT NULL, 
 [CreatedDate]       [DATETIME2](2) NOT NULL, 
 [CreatedBy]         [VARCHAR](255) NOT NULL, 
 [UpdatedDate]       [DATETIME2](2) NOT NULL, 
 [UpdatedBy]         [VARCHAR](255) NOT NULL, 
 [HostName]          [VARCHAR](255) NOT NULL, 
 [AppName]           [VARCHAR](255) NOT NULL, 
 PRIMARY KEY CLUSTERED([ID] ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO
SET ANSI_PADDING OFF;
GO
ALTER TABLE [dbo].[VersionTracking]
ADD DEFAULT((0)) FOR [Table_Version];
GO
ALTER TABLE [dbo].[VersionTracking]
ADD DEFAULT((0)) FOR [Table_LastVersion];
GO
ALTER TABLE [dbo].[VersionTracking]
ADD DEFAULT((1)) FOR [Ignore_Table];
GO
ALTER TABLE [dbo].[VersionTracking]
ADD DEFAULT((1)) FOR [CT_Disabled];
GO
ALTER TABLE [dbo].[VersionTracking]
ADD DEFAULT(GETDATE()) FOR [CreatedDate];
GO
ALTER TABLE [dbo].[VersionTracking]
ADD DEFAULT(SUSER_SNAME()) FOR [CreatedBy];
GO
ALTER TABLE [dbo].[VersionTracking]
ADD DEFAULT(GETDATE()) FOR [UpdatedDate];
GO
ALTER TABLE [dbo].[VersionTracking]
ADD DEFAULT(SUSER_SNAME()) FOR [UpdatedBy];
GO
ALTER TABLE [dbo].[VersionTracking]
ADD DEFAULT(HOST_NAME()) FOR [HostName];
GO
ALTER TABLE [dbo].[VersionTracking]
ADD DEFAULT(APP_NAME()) FOR [AppName];
GO