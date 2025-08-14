
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Retrieve a list of unique countries from which customers originate
select distinct 
country 
from gold.dim_customers
order by country;

-- Retrieve a list of unique categories, subcategories, and products
select distinct 
category, 
subcategory, 
product_name 
from gold.dim_products
order by category, subcategory, product_name;
