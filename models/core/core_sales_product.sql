-- core_sales_product.sql

select
  product_name
, sales_month
, sum(total_quantity) as total_quantity
, round(sum(total_revenue), 2) as total_revenue
from public_stage.stg_sales
group by 1, 2
order by sales_month, total_revenue desc