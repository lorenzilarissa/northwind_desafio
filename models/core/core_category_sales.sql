-- core_category_sales.sql

select
  a.category_id
, a.category_name
, sum(a.product_quantity) as total_quantity
, round(sum(a.total_item_value), 2) as total_revenue
from public_stage.stg_order_details a
group by 1, 2

-- Ajuda a entender o desempenho de categorias como um todo, essencial para planejamento estratégico e alocação de recursos