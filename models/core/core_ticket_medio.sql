-- core_ticket_medio.sql

select
  b.country
, a.order_year
, a.order_month
, round(avg(a.total_amount), 2) as avg_order_value
from public_stage.stg_orders a
left join public_stage.stg_customers b
on a.customer_id = b.customer_id
group by 1, 2, 3