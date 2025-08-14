/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Determine the first and last order date and the total duration in months
select 
    min(order_date) as first_order_date,
    max(order_date) as last_order_date,
    datediff(month, min(order_date), max(order_date)) as order_range_months
from gold.fact_sales;


-- Find the youngest and oldest customer based on birthdate
select
    min(birthdate) as oldest_birthdate,
    datediff(year, min(birthdate), getdate()) as oldest_age,
    max(birthdate) as youngest_birthdate,
    datediff(year, max(birthdate), getdate()) as youngest_age
from gold.dim_customers;
