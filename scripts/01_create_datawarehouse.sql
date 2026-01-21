/****************************************************************************************
 File Name : 01_create_datawarehouse.sql
 Purpose   : 
    - Create the DataWarehouse database
    - Initialize medallion architecture schemas (bronze, silver, gold)

WARNING:
    Running The script will drop the data warehouse if it already exists and recreate
    it again

 Author    : Mohamed Sabry
****************************************************************************************/

-- Switch context to master database (required to create a new database)
USE master;
GO

-- Check if the DataWarhouse Exists Then drop it and recreate it
IF DB_ID('DataWarehouse') IS NOT NULL
BEGIN
    DROP DATABASE DataWarehouse;
END
GO

-- Recreate the datawarehouse
CREATE DATABASE Datawarehouse;

-- Switch context to the DataWarehouse database
USE DataWarehouse;
GO

-- Create Bronze schema (raw / ingestion layer)
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bronze')
BEGIN
    EXEC ('CREATE SCHEMA bronze');
END
GO

-- Create Silver schema (cleaned / transformed layer)
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'silver')
BEGIN
    EXEC ('CREATE SCHEMA silver');
END
GO

-- Create Gold schema (business / reporting layer)
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'gold')
BEGIN
    EXEC ('CREATE SCHEMA gold');
END
GO
