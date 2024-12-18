-- core_products_sales_by_date.sql

select
  date_trunc('month', a.order_date) as order_date
, b.product_id
, b.product_name
, sum(b.product_quantity) as total_quantity
, round(sum(b.total_item_value), 2) as total_revenue
from public_stage.stg_orders a
left join public_stage.stg_order_details b
on a.order_id = b.order_id
group by 1, 2, 3

-- Analisa a sazonalidade de vendas por produto, útil para planejar promoções em períodos de baixa ou alta demanda