/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

-- Retrieve a list of all tables in the database
select 
    table_catalog, 
    table_schema, 
    table_name, 
    table_type
from information_schema.tables;

-- Retrieve all columns for a specific table (dim_customers)
select 
    column_name, 
    data_type, 
    is_nullable, 
    character_maximum_length
from information_schema.columns
where table_name = 'dim_customers';