-- core_employee_performance_by_company_time.sql

select
  case 
    when a.employee_company_time < 5 then 'Less than 5 years'
    when a.employee_company_time between 5 and 10 then '5-10 years'
    else 'Over 10 years'
  end as company_time_group
, count(b.order_id) as total_orders
, round(sum(c.total_item_value), 2) as total_revenue
, round(avg(c.total_item_value), 2) as avg_order_value
from public_stage.stg_employees a
left join public_stage.stg_orders b
on a.employee_id = b.employee_id
left join public_stage.stg_order_details c
on b.order_id = c.order_id
group by 1

-- Avalia se o tempo na empresa influencia o desempenho dos funcionários