-- core_customer_value.sql

select
  a.customer_id
, a.customer_country
, count(a.order_id) as customer_total_orders
, round(sum(b.quantity * b.unit_price), 2) as customer_total_revenue
, round(avg(b.quantity * b.unit_price * b.discount), 2) as customer_avg_order_value
, round(sum(b.quantity * b.unit_price * b.discount), 2) as customer_total_discounts
, case when max(a.order_date) < '1998-01-01' then 'Inactive' else 'Active' end as customer_status
from public_stage.stg_orders a
left join public_stage.stg_order_details b
on a.order_id = b.order_id
group by 1, 2
order by 3 desc

-- Quais clientes são mais valiosos para a empresa? Quais têm o maior potencial de crescimento?

-- Permite segmentar clientes por valor e priorizar investimentos em retenção e vendas cruzadas

-- Segmentação de clientes por receita gerada

-- KPIs:
-- Receita total por cliente
-- Ticket médio por cliente