-- core_employee_performance_by_title.sql

select
  a.employee_title
, count(distinct b.order_id) as total_orders
, round(sum(c.total_item_value), 2) as total_revenue
, round(avg(c.total_item_value), 2) as avg_order_value
from public_stage.stg_employees a
left join public_stage.stg_orders b
on a.employee_id = b.employee_id
left join public_stage.stg_order_details c
on b.order_id = c.order_id
group by 1

-- Analisa o desempenho por cargo, identificando títulos com mais impacto nas vendas