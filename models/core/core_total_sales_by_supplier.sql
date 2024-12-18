-- core_supplier_total_orders.sql

select
  supplier_name
, supplier_country
, count(order_id) as total_quantity
, round(sum(total_item_value), 2) as total_revenue
from public_stage.stg_order_details
group by 1, 2

-- Avaliar fornecedores quanto ao volume fornecido
-- Avaliar se há países/fornecedores com desempenho problemático