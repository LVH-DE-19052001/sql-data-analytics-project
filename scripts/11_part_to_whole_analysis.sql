/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/
-- Which categories contribute the most to overall sales?
select
p.category,
sum(fs.sales_amount) as total_sales,
sum(sum(fs.sales_amount)) over() as overrall_sales,
cast(round(cast(sum(fs.sales_amount) as float) / sum(sum(fs.sales_amount)) over() * 100, 2) as varchar) + '%' as percentage_of_total
from gold.fact_sales as fs
left join gold.dim_products as p
on fs.product_key = p.product_key
group by p.category

-- Other Solutions
/* 
with category_sales as (
    select
        p.category,
        sum(f.sales_amount) as total_sales
    from gold.fact_sales f
    left join gold.dim_products p
        on p.product_key = f.product_key
    group by p.category
)
select
    category,
    total_sales,
    sum(total_sales) over () as overall_sales,
    round((cast(total_sales as float) / sum(total_sales) over ()) * 100, 2) as percentage_of_total
from category_sales
order by total_sales desc;
*/