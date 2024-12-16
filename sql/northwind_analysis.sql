-- Ticket médio

select 
  avg(total_amount) as avg_order_value 
from (
    select 
      a.order_id
    , sum(b.quantity * b.unit_price) as total_amount
    from orders a
    left join order_details b
    on a.order_id = b.order_id
    group by a.order_id
	)
;

-----------

-- Qtt sales per year

select 
  extract(year from order_date) as year
, count(order_id) as total_orders
from orders
group by year
order by year
;

--O número total de pedidos realizados por ano, permitindo ver a tendência de crescimento ou declínio das vendas.
--Pode ser interessante acompanhar esses dados por trimestre ou por mês, se for necessário um nível de detalhe maior.

-----------

-- Avg sales per year

select 
  extract(year from order_date) as sale_year
, avg(order_value) as average_sales
from (
    select 
      order_id
    , sum(unit_price * quantity * (1 - discount)) as order_value
    , order_date
    from orders
    left join order_details using (order_id)
    group by 1, 3
) as order_values
group by sale_year
order by sale_year
;

-- A média de vendas anuais por pedido, o que ajuda a identificar os anos com maior volume de vendas por transação.
-- Isso também pode ajudar a identificar se o ticket médio de venda está aumentando ou diminuindo ao longo do tempo.

-----------

-- Sum sales per year

select 
  extract(year from order_date) as sale_year
, sum(unit_price * quantity * (1 - discount)) as total_sales
from orders
left join order_details using (order_id)
group by sale_year
order by sale_year;

-- O total de vendas em cada ano, permitindo analisar a evolução das vendas ao longo do tempo e identificar padrões, 
-- como sazonalidade ou anos com picos ou quedas nas vendas.

-----------

-- Best selling products per year

select 
  extract(year from a.order_date) as sale_year
, c.product_name
, sum(b.quantity) AS total_sales
from orders a
left join order_details b 
on a.order_id = b.order_id
left join products c
on b.product_id = c.product_id
group by 1, 2
order by 1 desc, 3 desc
;

-- Quais produtos são mais populares a cada ano.
-- Isso pode ser útil para entender a demanda por categorias de produtos e definir estratégias de marketing e estoque.

-----------

-- Customer purchase frequency

select
  customer_id
, count(order_id) as total_orders
, min(order_date) as first_order
, max(order_date) as last_order
from orders
group by customer_id
having count(order_id) > 1
;

-- Identificação de clientes que compram com frequência, com base nas datas dos primeiros e últimos pedidos.
-- Isso pode ajudar a identificar os "clientes leais" e os clientes que estão inativos, o que pode ser útil para estratégias de retenção.

-----------

-- Employee performance (sales per employee)

select 
  a.first_name
, a.last_name
, COUNT(b.order_id) as total_orders
, SUM(c.quantity * c.unit_price * (1 - c.discount)) as total_sales
from employees a
left join orders b
on a.employee_id = b.employee_id
left join order_details c 
on b.order_id = c.order_id
group by a.employee_id
order by 3 desc
;

-- A contribuição de cada funcionário para as vendas (com base nos pedidos que cada um gerou).
-- Isso pode ser útil para medir o desempenho individual e potencialmente ajustar as responsabilidades de vendas.

-----------

-- Sales by region

select 
  c.region_description
, extract(year from a.order_date) as sale_year
, sum(b.quantity * b.unit_price * (1 - b.discount)) as total_sales
from orders a
left join order_details b 
on a.order_id = b.order_id
left join region c 
on a.ship_via = c.region_id
group by 1, 2
order by 2 desc, 3 desc
;

-- O desempenho de vendas em diferentes regiões, permitindo identificar áreas de alto desempenho e áreas com menor atividade.
-- Isso pode ser usado para ajustar a alocação de recursos e a estratégia de marketing.

-----------

-- Churn Rate

with last_order as (
select 
  customer_id
, max(order_date) as last_order_date
from orders
group by customer_id
)
select 
  count(a.customer_id) as churned_customers
, (count(a.customer_id) * 100.0 / 
		(
		select count(*) from customers
		)
  ) as churn_rate
from customers a
left join last_order b
on a.customer_id = b.customer_id
where b.last_order_date < '1998-01-01' 
or b.last_order_date is null
;


-- O percentual de clientes que não realizaram compras no último ano, ajudando a calcular o churn da empresa.

-----------

-- Average delivery time

select
  b.region_description
, extract(year from a.order_date) as sale_year
, avg(a.shipped_date - a.order_date)::int as avg_delivery_time
FROM orders a
left join region b
on a.ship_via = b.region_id
where a.shipped_date is not null
group by 2, 1
order by 2 desc, 3 desc
;

-- O tempo médio que a empresa leva para processar e enviar um pedido. Isso pode ajudar a melhorar a logística e o atendimento ao cliente.






