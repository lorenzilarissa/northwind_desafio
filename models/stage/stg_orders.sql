-- stg_orders.sql

with cte as (
select 
  territory_id::int
, region_id
from public.territories a
)
, cte2 as ( 
select 
  a.employee_id
, a.first_name || ' ' || a.last_name as employee_name
, a.title as employee_title
, d.region_description as employee_region
, (1998 - extract(year from a.hire_date)) as employee_company_time
, (1998 - extract(year from a.birth_date)) as employee_age
, a.country as employee_country
from public.employees a
left join public.employee_territories b
on a.employee_id = b.employee_id
left join cte c
on b.territory_id = c.territory_id
left join public.region d
on c.region_id = d.region_id
group by 1, 2, 3, 4
)
select 
  a.order_id
, a.customer_id
, f.company_name as customer_name
, f.country as customer_country
, a.employee_id
, c.employee_name
, c.employee_title
, c.employee_region
, c.employee_country
, c.employee_company_time
, c.employee_age
, d.company_name as shipper_name
, a.ship_country
, b.region_description as shipment_region
, e.company_name as supplier_name
, e.country as supplier_country
, a.freight as delivery_cost
, a.order_date
, a.required_date
, a.shipped_date
, (a.shipped_date - a.order_date)::int as delivery_time
, extract('year' from a.order_date) as order_year
, extract('month' from a.order_date) as order_month
from public.orders a
left join public.region b
on a.ship_via = b.region_id
left join cte2 c
on a.employee_id = c.employee_id
left join public.shippers d
on a.ship_via = d.shipper_id
left join public.suppliers e
on a.ship_via = e.supplier_id
left join public.customers f
on a.customer_id = f.customer_id

-- Base para core_sales_trends (tendências de vendas)
-- Base para core_customer_activity e core_shipments

-- Analisar sazonalidade de vendas
-- Relacionar entregas com atrasos
