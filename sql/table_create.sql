-- CRIANDO AS TABELAS NO DATABASE

-- 1. Categories
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description text,
    picture BYTEA
);

-- 2. Customers
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    company_name VARCHAR(50),
    contact_name VARCHAR(50),
    contact_title VARCHAR(50),
    address VARCHAR(100),
    city VARCHAR(50),
    region VARCHAR(50),
    postal_code VARCHAR(15),
    country VARCHAR(50),
    phone VARCHAR(50),
    fax VARCHAR(50)
);

-- 3. Employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    last_name VARCHAR(50),
    first_name VARCHAR(50),
    title VARCHAR(50),
    title_of_courtesy VARCHAR(50),
    birth_date DATE,
    hire_date DATE,
    address VARCHAR(100),
    city VARCHAR(50),
    region VARCHAR(50),
    postal_code VARCHAR(15),
    country VARCHAR(50),
    home_phone VARCHAR(50),
    extension VARCHAR(10),
    photo BYTEA,
    notes TEXT,
    reports_to INT,
    photo_path TEXT
);

-- 4. Suppliers
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    company_name VARCHAR(50),
    contact_name VARCHAR(50),
    contact_title VARCHAR(50),
    address VARCHAR(100),
    city VARCHAR(50),
    region VARCHAR(50),
    postal_code VARCHAR(15),
    country VARCHAR(50),
    phone VARCHAR(50),
    fax VARCHAR(50),
    homepage VARCHAR(100)
);

-- 5. Products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    supplier_id INT,
    category_id INT,
    quantity_per_unit VARCHAR(50),
    unit_price DECIMAL(10, 2),
    units_in_stock INT,
    units_on_order INT,
    reorder_level INT,
    discontinued BOOLEAN
);

-- 6. Shippers
CREATE TABLE shippers (
    shipper_id INT PRIMARY KEY,
    company_name VARCHAR(50),
    phone VARCHAR(50)
);

-- 7. Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id VARCHAR(5),
    employee_id INT,
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    ship_via INT,
    freight DECIMAL(10, 2),
    ship_name VARCHAR(50),
    ship_address VARCHAR(100),
    ship_city VARCHAR(50),
    ship_region VARCHAR(50),
    ship_postal_code VARCHAR(15),
    ship_country VARCHAR(50)
);

-- 8. Order Details
CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    unit_price DECIMAL(10, 2),
    quantity INT,
    discount DECIMAL(5, 2)
);

-- 9. Region
CREATE TABLE region (
    region_id INT PRIMARY KEY,
    region_description VARCHAR(50)
);

-- 10. Territories
CREATE TABLE territories (
    territory_id VARCHAR(50) PRIMARY KEY,
    territory_description VARCHAR(50),
    region_id INT
);

-- 11. Employee Territories
CREATE TABLE employee_territories (
    employee_id INT,
    territory_id INT
);

-- 12. Customer Demographics
CREATE TABLE customer_demographics (
    customer_type_id VARCHAR(50) PRIMARY KEY,
    customer_desc TEXT
);

-- 13. Customers Customer Demo
CREATE TABLE customer_customer_demo (
    customer_id VARCHAR(50),
    customer_type_id VARCHAR(50) 
);

-- 14. US States
CREATE TABLE us_states (
    state_id INT,
    state_name VARCHAR (50),
    state_abbr VARCHAR (1000),
    state_region VARCHAR (50)
);

-- TESTE DO CARREGAMENTO (feito via Jupyter)

SELECT max(order_date) FROM orders LIMIT 100;

-- DROPS DE TODAS AS 14 TABELAS CASO SEJA NECESSÁRIO

drop table products;
drop table categories;
drop table customer_demographics;
drop table customers;
drop table customer_customer_demo;
drop table us_states;
drop table employee_territories;
drop table employees;
drop table order_details;
drop table orders;
drop table region;
drop table shippers;
drop table suppliers;
drop table territories;
