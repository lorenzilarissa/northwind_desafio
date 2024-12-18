-- core_customer_by_country.sql

select
  a.customer_id
, a.customer_country
, count(a.order_id) as customer_total_orders
, round(sum(b.total_item_value), 2) as customer_total_revenue
, round(sum(b.product_quantity * b.product_price * b.product_discount), 2) as customer_total_discounts
, round(sum(b.total_item_value) / count(distinct a.order_id)) as customer_avg_order_value
from public_stage.stg_orders a
left join public_stage.stg_order_details b
on a.order_id = b.order_id
group by 1, 2

-- Identifica os clientes que geram mais receita
-- Útil para segmentação e estratégias de retenção
-- Identifica clientes que aproveitaram mais descontos
-- Útil para analisar impacto de promoções
-- Mostra quais clientes fizeram mais pedidos
-- Ajuda a identificar clientes fiéis
