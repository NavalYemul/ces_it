-- gold 
create materialized view gold.customers_active
select customer_id,customer_name,customer_email,customer_city, customer_state
from silver.customers_silver where `__END_AT` is NULL;


--Top 3 customers based on total sales with their email, city 

create materialized view gold.top_customers as 
select s.customer_id, c.customer_email, c.customer_city, round(sum(total_amount)) as total_sales
from silver.sales_cleaned s
join gold.customers_active c
using(customer_id)
group by customer_id,customer_email,customer_city
order by total_sales desc;



create view gold.three_tables as
select
  s.customer_id,
  c.customer_email,
  c.customer_city,  
  p.product_id,
  p.product_name,
  round(sum(s.total_amount)) as total_sales
from silver.sales_cleaned s
join gold.customers_active c
  on s.customer_id = c.customer_id
join silver.products_silver p
  on s.product_id = p.product_id
group by s.customer_id, c.customer_email, c.customer_city, p.product_id, p.product_name
order by total_sales desc
 