-- core_valor_medio_frete_by_country.sql

select
  a.customer_country
, round(avg(a.delivery_cost), 2) as avg_delivery_cost
from public_stage.stg_orders a
group by 1
