-- stg_orders.sql

select
  a.order_id
, a.customer_id
, a.ship_name as customer_name
, a.ship_country as customer_country
, a.employee_id
, a.order_date 
, a.required_date
, a.shipped_date
, b.company_name as shipper_name
, (a.shipped_date - a.order_date)::int as delivery_time
, a.freight as delivery_cost
, extract('year' from a.order_date) as order_year
, extract('month' from a.order_date) as order_month
from public.orders a
left join public.shippers b
on a.ship_via = b.shipper_id

-- Base para core_sales_trends (tendências de vendas)
-- Base para core_customer_activity e core_shipments

-- Analisar sazonalidade de vendas
-- Relacionar entregas com atrasos
