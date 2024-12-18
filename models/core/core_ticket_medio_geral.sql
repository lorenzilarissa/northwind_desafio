-- core_ticket_medio_geral.sql

select
  round(sum(a.total_item_value) / count(distinct a.order_id), 2) as avg_order_value
from public_stage.stg_order_details a
