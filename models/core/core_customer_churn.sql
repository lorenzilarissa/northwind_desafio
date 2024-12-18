-- core_customer_churn.sql

select
  a.customer_id
, a.customer_country
, case 
    when max(a.order_date) < '1998-01-01' then 'Inactive' 
    else 'Active' 
    end as customer_status
from public_stage.stg_orders a
group by 1, 2

-- Classifica os clientes em churn
-- Ajuda a criar campanhas de reengajamento para clientes inativos