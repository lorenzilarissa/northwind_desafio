-- core_ticket_medio_by_customer.sql

select
  a.customer_name
, a.customer_country
, round(avg(b.total_item_value), 2) as customer_avg_order_value
from public_stage.stg_orders a
left join public_stage.stg_order_details b
on a.order_id = b.order_id
group by 1, 2

-- Mostra o valor médio gasto por cliente por pedido
-- Ajuda a identificar clientes que fazem pedidos maiores