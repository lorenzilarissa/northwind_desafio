-- core_ticket_medio_by_date.sql

select
  date_trunc('month', a.order_date) as order_date
, round(sum(b.total_item_value) / count(distinct b.order_id), 2) as avg_order_value
from public_stage.stg_orders a
left join public_stage.stg_order_details b
on a.order_id = b.order_id
group by 1
