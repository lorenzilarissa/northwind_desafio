-- core_category_sales_by_date.sql

select
  date_trunc('month', a.order_date) as order_date
, b.category_id
, b.category_name
, sum(b.product_quantity) as total_quantity
, round(sum(b.total_item_value), 2) as total_revenue
from public_stage.stg_orders a
left join public_stage.stg_order_details b
on a.order_id = b.order_id
group by 1, 2, 3

-- Ajuda a identificar padrões de desempenho em categorias ao longo do tempo, permitindo ajustes no portfólio