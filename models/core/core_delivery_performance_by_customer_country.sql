-- core_delivery_performance_by_customer_country.sql

select
  customer_country
, count(distinct order_id) as total_orders
, count(case when delivery_time > (required_date - order_date)::int then order_id end) as late_deliveries
, round(avg(delivery_time), 2) as avg_delivery_time
, round(avg(delivery_cost), 2) as avg_delivery_cost
from public_stage.stg_orders
group by 1

-- Dá uma visão mais granular do tempo médio de entrega por país
-- Útil para expandir análises regionais
-- Avalia como os custos de entrega variam entre países
-- Útil para planejar estratégias de custo-benefício
-- Ajuda a monitorar padrões mensais de entrega, como sazonalidade ou períodos problemáticos
-- Oferece uma visão geral de atrasos e custos ao longo do tempo