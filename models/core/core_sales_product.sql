-- core_sales_product.sql

select
  sales_year
, sales_month
, category_name
, product_name
, sum(total_quantity) as total_quantity
, sum(total_revenue) as total_revenue
from public_stage.stg_sales
group by 1, 2, 3, 4
order by 1 desc, 2 desc, 5 desc

-- Quais produtos e categorias lideram as vendas? Como isso varia ao longo do tempo?

-- Auxilia no planejamento de estoque e promoções
-- Destaca oportunidades para expandir linhas de produtos populares

-- Gráficos de barras para produtos mais vendidos e análise de categorias

-- KPIs:
-- Produto/categoria com maior receita
-- Produto/categoria com maior quantidade vendida