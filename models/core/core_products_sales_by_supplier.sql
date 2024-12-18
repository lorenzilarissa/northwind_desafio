-- core_products_sales_by_supplier.sql

select
  a.supplier_id
, a.supplier_name
, a.product_id
, a.product_name
, count(distinct a.order_id) as total_quantity
, round(sum(a.total_item_value), 2) as total_revenue
, round(avg(a.product_discount * 100), 2) as avg_discount_percentage
from public_stage.stg_order_details a
group by 1, 2, 3, 4

-- Identifica os produtos mais frequentemente pedidos para cada fornecedor
-- Permite priorizar fornecedores com alta demanda em seus produtos