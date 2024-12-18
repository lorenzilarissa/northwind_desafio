select * 
from public_stage.stg_churn_rate

select * 
from public_stage.stg_orders 


SELECT * FROM public_stage.stg_ticket_medio;


with last_order as (
select 
  customer_id
, max(order_date) as last_order_date
from public.orders
group by customer_id
)
select 
  a.customer_id
, a.country
, case 
	when b.last_order_date < '1998-01-01' 
	or b.last_order_date is null then 1
	else 0
end as is_churned
from public.customers a
left join last_order b
on a.customer_id = b.customer_id

select *
from customers

select *
from region

select *
from us_states

select *
from territories

select *
from customer_customer_demo

select
  a.customer_id
, a.company_name 
, a.contact_name
, a.contact_title 
, a.country 
from public.customers a

select *
from public.orders o 

with cte as (

select
  c.product_id
, c.product_name
, d.category_id
, d.category_name
, extract('year' from b.order_date) as sales_year
, extract('month' from b.order_date) as sales_month
, sum(a.quantity) as total_quantity
, round(sum(a.quantity * a.unit_price), 2) as total_revenue
from order_details a
join orders b
    on a.order_id = b.order_id
join products c
    on a.product_id = c.product_id
join categories d
    on c.category_id = d.category_id
group by 1, 2, 3, 4, 5, 6
order by sales_month, sales_year, total_revenue

)
select product_name, sales_year, sales_month, total_quantity, total_revenue
from cte
where product_id = 38



select
  a.order_id
, b.company_name
, c.region_description
, avg(a.shipped_date - a.order_date)::int as delivery_time
, a.freight as delivery_cost
from public.orders a
left join public.shippers b
on a.ship_via = b.shipper_id
left join public.region c
on a.ship_via = c.region_id
where a.shipped_date is not null
group by 1, 2, 3
order by delivery_time desc

select *
from shippers s 

select *
from region o 

with cte as (

select
  a.customer_id
, b.country
, count(order_id) as total_orders
, min(order_date) as first_order
, max(order_date) as last_order
, case 
    when max(order_date) < '1998-01-01' then 1
    else 0
	end as is_inactive
from public.orders a
left join public.customers b
on a.customer_id = b.customer_id
group by 1, 2
order by total_orders desc, country desc


)

select 
  b.country
, c.region_description as shipment_region
, extract(year from a.order_date) as sale_year
, count(a.order_id) as total_orders
, round(avg(d.quantity * d.unit_price), 2) as avg_order_value
, round(sum(d.quantity * d.unit_price), 2) as total_sales
from public.orders a
left join public.customers b
on a.customer_id = b.customer_id
left join public.region c
on a.ship_via = c.region_id
left join public.order_details d
on a.order_id = d.order_id
group by 1, 2, 3
order by sale_year, total_sales desc;


select *
from employees e 

select
  a.order_id
, a.order_date
, a.required_date
, a.shipped_date
, b.company_name as supplier_name
, b.country as supplier_country
, c.company_name as shipper_name
, d.region_description as shipment_region
, a.freight as delivery_cost
, extract('year' from a.order_date) as order_year
, extract('month' from a.order_date) as order_month
, (a.shipped_date - a.order_date)::int as delivery_time
from public.orders a
left join public.suppliers b
on a.ship_via = b.supplier_id
left join public.shippers c
on a.ship_via = c.shipper_id
left join public.region d
on a.ship_via = d.region_id
where a.shipped_date is not null


with cte as (
select 
  a.order_id
, a.customer_id
, a.employee_id
, c.first_name || ' ' || c.last_name as employee_name
, c.title as employee_title
, a.order_date
, a.required_date
, a.shipped_date
, d.company_name as shipper_name
, b.region_description as shipment_region
, e.company_name as supplier_name
, e.country as supplier_country
, a.freight as delivery_cost
, (a.shipped_date - a.order_date)::int as delivery_time
from public.orders a
left join public.region b
on a.ship_via = b.region_id
left join public.employees c
on a.employee_id = c.employee_id
left join public.shippers d
on a.ship_via = d.shipper_id
left join public.suppliers e
on a.ship_via = e.supplier_id
)
select count(*)
from cte

select count(*)
from orders o 

select count(distinct customer_id) from customers c 

select *
from employees e

select * from territories t 

select * from employee_territories et 


select *
from products p 


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
--, cte3 as (
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

)
select count(*)
from cte3



with cte as (
select
  c.product_id
, c.product_name
, d.category_id
, d.category_name
, extract('year' from b.order_date) as sales_year
, extract('month' from b.order_date) as sales_month
, sum(a.quantity) as total_quantity
, round(sum(a.quantity * a.unit_price), 2) as total_revenue
from public.order_details a
left join public.orders b
on a.order_id = b.order_id
left join public.products c
on a.product_id = c.product_id
left join public.categories d
on c.category_id = d.category_id
group by 1, 2, 3, 4, 5, 6
order by sales_year desc, total_revenue desc, sales_month
)
select count(distinct product_id)
from cte
where sales_year = 1998

select count(*)
from products p 

select
  a.customer_id
, b.country
, count(order_id) as total_orders
, min(order_date) as first_order
, max(order_date) as last_order
, case 
    when max(order_date) < '1998-01-01' then 1
    else 0
	end as is_inactive
from public.orders a
left join public.customers b
on a.customer_id = b.customer_id
group by 1, 2
order by total_orders desc, country desc



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


left join last_order b
on a.customer_id = b.customer_id

select count(*)
from public_stage.stg_orders so 

select *
from public_stage.stg_order_details sod 



