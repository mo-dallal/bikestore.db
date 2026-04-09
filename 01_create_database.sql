-- ============================================================
--  Step 1: Create Database
--  !! شغّل هاد الملف أول وحده على master !!
-- ============================================================

USE master;
GO

IF DB_ID(N'BikeStore') IS NULL
BEGIN
    CREATE DATABASE BikeStore;
    PRINT 'BikeStore created successfully.';
END
ELSE
    PRINT 'BikeStore already exists.';
GO

USE BikeStore;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Sales')
    EXEC('CREATE SCHEMA Sales');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Production')
    EXEC('CREATE SCHEMA Production');
GO

PRINT 'Schemas Sales + Production created.';
GO
