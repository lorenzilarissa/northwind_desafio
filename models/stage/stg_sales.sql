-- stg_sales.sql

select
  c.product_id
, c.product_name
, d.category_id
, d.category_name
, extract('year' from b.order_date) as sales_year
, extract('month' from b.order_date) as sales_month
, sum(a.quantity) as total_quantity
, round(sum(a.quantity * a.unit_price), 2) as total_revenue
from public.order_details a
left join public.orders b
on a.order_id = b.order_id
left join public.products c
on a.product_id = c.product_id
left join public.categories d
on c.category_id = d.category_id
group by 1, 2, 3, 4, 5, 6
order by sales_year desc, sales_month desc, total_revenue desc