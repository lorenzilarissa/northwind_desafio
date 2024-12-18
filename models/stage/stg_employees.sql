-- stg_employees.sql

select 
  a.employee_id
, a.first_name || ' ' || a.last_name as employee_name
, a.title as employee_title
, a.country as employee_country
, d.region_description as employee_region
, (1998 - extract(year from a.hire_date)) as employee_company_time
, (1998 - extract(year from a.birth_date)) as employee_age
from public.employees a
left join public.employee_territories b
on a.employee_id = b.employee_id
left join public.territories c
on b.territory_id = c.territory_id
left join public.region d
on c.region_id = d.region_id
group by 1, 2, 3, 4, 5, 6, 7