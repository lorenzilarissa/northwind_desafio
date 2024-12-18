-- core_product_sales.sql

select
  a.product_id
, a.product_name
, sum(a.product_quantity) as total_quantity
, round(sum(a.total_item_value), 2) as total_revenue
from public_stage.stg_order_details a
group by 1, 2

-- Identifica produtos líderes em receita e volume, destacando oportunidades para promoções ou expansão