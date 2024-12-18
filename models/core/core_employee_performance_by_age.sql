-- core_employee_performance_by_age.sql

select
  case 
    when a.employee_age < 30 then 'Under 30'
    when a.employee_age between 30 and 40 then '30-40'
    when a.employee_age between 41 and 50 then '41-50'
    else 'Over 50'
  end as age_group
, count(b.order_id) as total_orders
, round(sum(c.total_item_value), 2) as total_revenue
, round(avg(c.total_item_value), 2) as avg_order_value
from public_stage.stg_employees a
left join public_stage.stg_orders b
on a.employee_id = b.employee_id
left join public_stage.stg_order_details c
on b.order_id = c.order_id
group by 1

-- Permite entender como a idade dos funcionários pode impactar as vendas