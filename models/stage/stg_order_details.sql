-- stg_order_details.sql

select 
  a.order_id
, a.product_id
, a.unit_price
, a.quantity
, a.discount
, a.quantity * a.unit_price * (1 - a.discount) as total_item_value
from public.order_details a

-- Base para core_top_products e core_product_performance

-- Descobrir produtos mais vendidos e aqueles com maior margem de lucro
-- Identificar padrões de desconto

-- Direciona campanhas para os produtos mais rentáveis