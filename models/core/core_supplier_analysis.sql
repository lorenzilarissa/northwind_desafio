-- core_supplier_analysis.sql

select
  order_year
, order_month
, supplier_name
, ship_country
, count(order_id) as total_orders_supplied
, round(avg(delivery_time), 2) as avg_delivery_time
, round(sum(delivery_cost), 2) as total_freight_cost
from public_stage.stg_orders
group by 1, 2, 3, 4
order by 1, 2, 4

-- Avaliar fornecedores quanto ao volume fornecido e rapidez em atender pedido

-- Identificar fornecedores mais confiáveis em termos de rapidez e custos
-- Avaliar se há países/fornecedores com desempenho problemático