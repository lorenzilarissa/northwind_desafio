-- core_ticket_medio.sql

select
  a.customer_country
, a.order_year
, a.order_month
, count(a.order_id) as total_orders
, round(avg(a.delivery_cost), 2) as avg_freight_cost
, round(avg(b.quantity * b.unit_price * b.discount), 2) as avg_order_value
from public_stage.stg_orders a
left join public.order_details b
on a.order_id = b.order_id
group by 1, 2, 3
order by 2 desc, 3 desc, 4 desc
