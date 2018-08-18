/*
(1b)
CREATE THE DATABASE
*/

CREATE DATABASE [CTPOC] CONTAINMENT = NONE
ON PRIMARY
       (
           NAME = N'CTPOC',
           FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SHAULIS\MSSQL\DATA\CTPOC.mdf',
           SIZE = 3072KB,
           FILEGROWTH = 1024KB
       )
LOG ON
    (
        NAME = N'CTPOC_log',
        FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SHAULIS\MSSQL\DATA\CTPOC_log.ldf',
        SIZE = 1024KB,
        FILEGROWTH = 10%
    );
GO

USE [CTPOC];
GO
CREATE SCHEMA [archive]
GO
