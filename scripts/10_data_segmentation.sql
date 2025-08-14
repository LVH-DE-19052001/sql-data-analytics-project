/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

/*Segment products into cost ranges and 
count how many products fall into each segment*/
with ctex as(
	select 
	p.product_name,
	fs.price,
	case
	when fs.price < 100 then 'Low'
	when fs.price >= 100 and fs.price <= 1000 then 'Medium'
	else 'Hight'
	end as cost_range
	from gold.fact_sales as fs
	left join gold.dim_products as p
	on fs.product_key = p.product_key
)
select 
cost_range,
count(product_name) as total_products
from ctex
group by cost_range
order by total_products desc;

/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/
with cte1 as(
			select
			c.customer_id,
			min(order_date) as first_date,
			max(order_date) as last_date,
			datediff(month, min(order_date), max(order_date)) as lifespan,
			sum(sales_amount) as total_spending
			from gold.fact_sales as fs
			left join gold.dim_customers as c
			on fs.customer_key = c.customer_key
			group by c.customer_id
)	
select
customer_segment,
count(*) as total_customers
from(
	select 
	lifespan,
	total_spending,
	case
	when lifespan >= 12 and total_spending >  5000 then 'Vip'
	when lifespan >= 12 and total_spending <= 5000 then 'Regular'
	else 'New'
	end as customer_segment
	from cte1
)t
group by customer_segment
order by total_customers desc;
