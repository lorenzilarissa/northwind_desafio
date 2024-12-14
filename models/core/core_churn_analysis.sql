-- core_churn_analysis.sql

select
  b.country
, count(case when a.is_churned = 1 then a.customer_id end) as churned_customers
, round((count(case when a.is_churned = 1 then a.customer_id end) * 100.0 / count(a.customer_id)), 2) as churn_rate
from public_stage.stg_churn_rate a
left join public_stage.stg_customers b
on a.customer_id = b.customer_id
group by 1