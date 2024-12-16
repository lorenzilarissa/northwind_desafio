-- core_sales_trends.sql

select
  sales_year
, sales_month
, sum(total_revenue) as total_sales
, sum(total_quantity) as total_quantity
, round(avg(total_revenue), 2) as avg_ticket
from public_stage.stg_sales
group by 1, 2
order by 1, 2

-- Identificar tendências de crescimento, sazonalidade e ticket médio ao longo do tempo

-- Como as vendas mudaram ao longo do tempo? Existem tendências sazonais ou de crescimento/declínio?

-- Ajuda a identificar padrões anuais ou mensais de vendas
-- Auxilia na projeção de demanda e planejamento estratégico

-- Visualizações de linha ou barras para vendas totais, quantidade de pedidos, ticket médio ao longo do tempo

-- KPIs:
-- Receita anual/mensal.
-- Crescimento ou declínio das vendas.