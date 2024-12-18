-- stg_order_details.sql

select
  a.order_id
, a.product_id
, b.product_name
, a.unit_price as product_price
, a.quantity as product_quantity
, a.discount as product_discount
, (a.quantity * a.unit_price * (1 - a.discount)) as total_item_value
, b.category_id
, c.category_name
, b.supplier_id
, d.company_name as supplier_name
, d.country as supplier_country
from public.order_details a
left join public.products b
on a.product_id = b.product_id
left join public.categories c
on b.category_id = c.category_id
left join public.suppliers d
on b.supplier_id = d.supplier_id

-- Base para core_top_products e core_product_performance

-- Descobrir produtos mais vendidos e aqueles com maior margem de lucro
-- Identificar padrões de desconto

-- Direciona campanhas para os produtos mais rentáveis