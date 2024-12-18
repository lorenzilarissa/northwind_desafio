-- core_ticket_medio_by_country.sql

select
  a.customer_country
, round(sum(b.total_item_value) / count(distinct b.order_id), 2) as avg_order_value
from public_stage.stg_orders a
left join public_stage.stg_order_details b
on a.order_id = b.order_id
group by 1
