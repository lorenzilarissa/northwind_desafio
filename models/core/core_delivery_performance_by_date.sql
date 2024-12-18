-- core_delivery_performance.sql

select
  date_trunc('month', order_date) as order_date
, count(distinct order_id) as total_orders
, count(case when delivery_time > (required_date - order_date)::int then order_id end) as late_deliveries
, round(avg(delivery_time), 2) as avg_delivery_time
, round(avg(delivery_cost), 2) as avg_delivery_cost
from public_stage.stg_orders
group by 1

-- Ajuda a monitorar padrões mensais de entrega, como sazonalidade ou períodos problemáticos
-- Oferece uma visão geral de atrasos e custos ao longo do tempo