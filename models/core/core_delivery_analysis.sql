-- core_delivery_analysis.sql

select
  order_year
, order_month
, shipper_name
, ship_country
, shipment_region
, count(order_id) as total_orders
, count(case when delivery_time > (required_date - order_date)::int then order_id end) as late_deliveries
, round(min(delivery_time), 2) as min_delivery_time
, round(max(delivery_time), 2) as max_delivery_time
, round(avg(delivery_time), 2) as avg_delivery_time
, round(min(delivery_cost), 2) as min_delivery_cost
, round(max(delivery_cost), 2) as max_delivery_cost
, round(avg(delivery_cost), 2) as avg_delivery_cost
from public_stage.stg_orders
group by 1, 2, 3, 4, 5
order by order_year, order_month, ship_country, shipment_region desc

-- Identificar transportadoras mais eficientes em termos de custo e tempo de entrega

-- Identificar transportadoras/regiões com maior tempo ou custo
-- Sugerir mudanças estratégicas para melhorar logística e atendimento ao cliente

-- Qual é o tempo médio de entrega por região? Existem custos excessivos associados a atrasos?

-- Melhora logística e atendimento ao cliente, identificando gargalos

-- Mapas e gráficos para comparar regiões com tempos de entrega/custos altos

-- KPIs:
-- Tempo médio de entrega
-- Custo médio por entrega