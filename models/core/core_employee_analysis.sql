-- core_employee_performance.sql

select
  a.order_year
, a.order_month
, a.employee_id
, a.employee_name
, a.employee_title
, a.employee_region
, a.employee_country
, a.employee_company_time
, a.employee_age
, count(a.order_id) as total_orders
, round(avg(b.quantity * b.unit_price * b.discount), 2) as avg_order_value
from public_stage.stg_orders a
left join public_stage.stg_order_details b using (order_id)
group by 1, 2, 3, 4, 5, 6, 7, 8, 9

-- Quais funcionários têm o melhor desempenho? Existem diferenças significativas entre equipes?

-- Base para avaliar e recompensar o desempenho de vendas

-- Gráficos de barras para vendas e pedidos por funcionário

-- KPIs:
-- Receita por funcionário
-- Número de pedidos por funcionário