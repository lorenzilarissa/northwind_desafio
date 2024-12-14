-- stg_orders.sql

select 
  a.order_id
, a.customer_id
, extract('year' from a.order_date) as order_year
, extract('month' from a.order_date) as order_month
, round(sum(b.quantity * b.unit_price), 2) as total_amount
from public.orders a
left join public.order_details b
on a.order_id = b.order_id
group by 1, 2, 3