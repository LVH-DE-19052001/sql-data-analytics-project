/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Which 5 products Generating the Highest Revenue?
-- Simple Ranking
select top 5
p.product_name, 
sum(fs.sales_amount) as total_revenue
from gold.dim_products as p
right join gold.fact_sales as fs
on p.product_key = fs.product_key
group by p.product_name
order by total_revenue desc;

-- Complex but Flexibly Ranking Using Window Functions
select
*
from(
	select
	p.product_name, 
	sum(fs.sales_amount) as total_revenue,
	rank() over(order by sum(fs.sales_amount) desc) as ranking
	from gold.fact_sales as fs
	left join gold.dim_products as p
	on fs.product_key = p.product_key
	group by p.product_name
	)t
where t.ranking <= 5;

-- What are the 5 worst-performing products in terms of sales?
select top 5
p.product_name, 
sum(fs.sales_amount) as total_revenue
from gold.dim_products as p
right join gold.fact_sales as fs
on p.product_key = fs.product_key
group by p.product_name
order by total_revenue;

-- Find the top 10 customers who have generated the highest revenue
select top 10
c.customer_key,
c.first_name,
c.last_name,
sum(fs.sales_amount) as highest_revenue
from gold.fact_sales as fs
left join gold.dim_customers as c
on fs.customer_key = c.customer_key
group by c.customer_key, c.first_name, c.last_name
order by highest_revenue desc;

-- The 3 customers with the fewest orders placed
select top 3
c.customer_key,
c.first_name,
c.last_name,
count(distinct fs.order_number) as total_orders
from gold.fact_sales as fs
left join gold.dim_customers as c
on fs.customer_key = c.customer_key
group by c.customer_key, c.first_name, c.last_name
order by total_orders;