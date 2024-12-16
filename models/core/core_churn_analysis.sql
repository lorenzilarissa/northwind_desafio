-- core_churn_analysis.sql

select
  a.customer_country
, count(distinct a.customer_id) as total_customers
, count(case when a.last_order_date < '1998-01-01' then a.customer_id end) as churned_customers
, count(case when a.last_order_date >= '1998-01-01' then a.customer_id end) as active_customers
, round((count(case when a.last_order_date < '1998-01-01' then a.customer_id end) * 100.0 / count(distinct a.customer_id)), 2) as churn_rate
from (
  select 
    customer_id
  , customer_country
  , max(order_date) as last_order_date
  from public_stage.stg_orders
  group by 1, 2
) a
group by 1

-- Qual a taxa de churn por região/país? Como podemos reduzir a perda de clientes?

-- Foco em retenção de clientes, identificando regiões com alta taxa de churn
-- Base para campanhas de reengajamento

-- Gráficos de dispersão ou mapas para identificar regiões problemáticas

-- KPIs:
-- Taxa de churn
-- Clientes ativos e inativos