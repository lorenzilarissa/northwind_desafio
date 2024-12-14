-- stg_churn_rate.sql

with last_order as (
select 
  customer_id
, max(order_date) as last_order_date
from public.orders
group by customer_id
)
select 
  a.customer_id
, case 
	when b.last_order_date < '1998-01-01'
	or b.last_order_date is null then 1
	else 0
end as is_churned
from public.customers a
left join last_order b
on a.customer_id = b.customer_id