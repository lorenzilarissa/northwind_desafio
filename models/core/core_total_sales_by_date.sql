-- core_monthly_revenue.sql

select
  date_trunc('month', a.order_date) as order_date
, count(distinct a.order_id) as total_quantity
, round(sum(b.total_item_value), 2) as total_revenue
from public_stage.stg_orders a
left join public_stage.stg_order_details b
on a.order_id = b.order_id
group by 1

-- Ajuda a identificar sazonalidade na demanda, como meses de pico de vendas em termos de volume
-- Mostra a receita mensal total gerada, essencial para avaliar crescimento ou declínio nas vendas