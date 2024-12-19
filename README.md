# Northwind - Analytics Engineering Project

## 📋 **Descrição do Projeto**
Este projeto foi desenvolvido para centralizar, tratar e analisar os dados da empresa fictícia **Northwind**. Utilizando ferramentas modernas de dados, o objetivo é fornecer um dashboard integrado que permita uma visão clara e orientada por dados sobre as áreas críticas do negócio.

---

## 🧩 **Objetivo do Projeto**
O projeto foi estruturado para:
- Criar uma visão integrada dos dados da Northwind.
- Aumentar o **ticket médio**.
- Reduzir a **taxa de churn**.
- Melhorar a eficiência logística e tomada de decisão em outras áreas estratégicas da empresa.

---

## 🔧 **Ferramentas Utilizadas**
1. **PostgreSQL** - Banco de dados relacional para armazenar os dados.
2. **DBeaver** - Gerenciador de banco de dados para visualizar e gerenciar o PostgreSQL.
3. **Python (Jupyter Notebook)** - Tratamento e carregamento inicial dos dados e automatização dos updates dos arquivos schema.yml.
4. **DBT (Data Build Tool)** - Transformação e organização das tabelas em **stage** e **core**.
5. **Docker** - Criação do ambiente do Metabase.
6. **Metabase** - Ferramenta de BI para visualização e análise dos dados.

---

## 🚀 **Estrutura do Projeto**
- **Dados Brutos**: Arquivos CSV da Northwind Traders (ERP).
- **Transformação**: Realizada em duas camadas:
  - **Stage**: Dados tratados e padronizados.
  - **Core**: Dados transformados para análises específicas.
- **Visualização**: Dashboard interativo no Metabase.

---

## 🛠️ **Passo a Passo do Projeto**

### 1. **Configuração Inicial do Ambiente**

#### **1.1. Instalação do PostgreSQL**
- Baixe e instale o PostgreSQL em [PostgreSQL Downloads](https://www.postgresql.org/download/).
- Durante a instalação, configure o usuário e a senha.
- Inicialize o serviço do PostgreSQL.

#### **1.2. Criação do Banco de Dados**
- Acesse o terminal do PostgreSQL e crie o banco:
  ```sql
  CREATE DATABASE northwind;
  ```

#### **1.3. Configuração no DBeaver**
- Instale o DBeaver [aqui](https://dbeaver.io/download/).
- Adicione o banco de dados PostgreSQL.
- Configure o host, porta, nome do banco, usuário e senha.

### 2. **Importação dos Dados**
#### **2.1. Instalação do Jupyter Notebook e Bibliotecas**
- Crie um ambiente virtual:
  ```bash
  python -m venv northwind_env
  source northwind_env/bin/activate  # (Linux/macOS)
  northwind_env\Scripts\activate   # (Windows)
  ```
- Instale as bibliotecas necessárias:
  ```bash
  pip install pandas psycopg2 jupyter sqlalchemy python-dotenv dbt-core dbt-postgres
  ```
- Inicie o Jupyter Notebook:
  ```bash
  jupyter notebook
  ```

#### **2.2. Carregamento dos Dados**

-- Crie as tabelas pelo Dbeaver ou utilizando uma função no Jupyter Notebook
-- Importe os dados das tabelas .csv manualmente pelo Dbeaver ou utilize uma função no Jupyter Notebook

---

### 3. **Configuração do DBT (Data Build Tool)**
- Configure o `profiles.yml`:
  ```yaml
    name: 'northwind_desafio'
    version: '1.0'
    config-version: 2
    profile: 'northwind_desafio'
    
    models:
      northwind_desafio:
        stage:
          +schema: stage
          +materialized: view
        core:
          +schema: core
          +materialized: table
  ```

#### **3.2. Estrutura de Tabelas no DBT**
Organize os dados em duas camadas:
- **Stage**: Normalização e tratamento dos dados brutos.
- **Core**: Criação de métricas, KPIs e tabelas intermediárias para análises.

Exemplo de modelo `stg_orders.sql`:
```sql
select
  a.order_id
, a.customer_id
, a.ship_name as customer_name
, a.ship_country as customer_country
, a.employee_id
, a.order_date 
, a.required_date
, a.shipped_date
, b.company_name as shipper_name
, (a.shipped_date - a.order_date)::int as delivery_time
, a.freight as delivery_cost
, extract('year' from a.order_date) as order_year
, extract('month' from a.order_date) as order_month
from public.orders a
left join public.shippers b
on a.ship_via = b.shipper_id
```

Exemplo de modelo `core_products_sales_by_supplier.sql`:
```sql
select
  a.supplier_id
, a.supplier_name
, a.product_id
, a.product_name
, count(distinct a.order_id) as total_quantity
, round(sum(a.total_item_value), 2) as total_revenue
, round(avg(a.product_discount * 100), 2) as avg_discount_percentage
from public_stage.stg_order_details a
group by 1, 2, 3, 4
```

Rode os comandos:
```bash
dbt run
dbt test
```

---

### 4. **Criação do Metabase**
#### **4.1. Configuração do Docker**
- Instale o Docker e crie um contêiner para o Metabase seguindo essa documentação:
(https://www.metabase.com/docs/latest/installation-and-operation/running-metabase-on-docker)

#### **4.2. Conexão do Banco de Dados**
- Acesse o Metabase em `http://localhost:3000`.
- Adicione o banco de dados PostgreSQL configurando host (seu IP), porta, usuário, senha e banco.

---

### 5. **Construção do Dashboard**
Com os dados carregados no Metabase:
- Crie gráficos e dashboards organizados por área:
  - **Vendas**: Ticket médio, timeline de vendas.
  - **Clientes**: Taxa de churn, clientes ativos/inativos.
  - **Produtos**: Produtos e categorias mais rentáveis.
  - **Fornecedores**: Análise de fornecedores por país.
  - **Colaboradores**: Desempenho de vendas.
  - **Entrega**: Entregas atrasadas, valor médio de frete, eficiência de transportadoras.

**Resultado Final**:
O dashboard consolidado permite uma visão holística da Northwind.

---

## 📊 **Exemplos de Resultados**
- **Ticket Médio Geral**: $1.525,05.
- **Taxa de Churn**: 8,99%.
- **Produtos mais Rentáveis**: "Côte de Blaye" com $141.396,74.
- **Eficiência Logística**: 4,46% de entregas atrasadas.

---

## 🧭 **Próximos Passos**
1. Implementar alertas automáticos para métricas críticas.
2. Integrar dados do CRM (Salesforce) e contabilidade (ContaAzul).
3. Desenvolver previsões de vendas utilizando modelos de machine learning.

---

## 🏆 **Conclusão**
O projeto entregou uma análise robusta e estruturada, facilitando decisões estratégicas para a Northwind Traders, com foco em:
- Reduzir a taxa de churn.
- Aumentar o ticket médio.
- Melhorar a eficiência operacional e logística.

---

## 🤝 **Colaboradores**
- **Desenvolvedor Principal**: [Larissa Lorenzi]
- **Contato**: [lorenzilarissa@gmail.com]
