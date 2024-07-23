-- Create the schema
CREATE SCHEMA raw;

-- Create the tables
CREATE TABLE raw.customers (
    id INTEGER,
    first_name VARCHAR,
    last_name VARCHAR
);

CREATE TABLE raw.orders (
    id INTEGER,
    user_id INTEGER,
    order_date DATE,
    status VARCHAR,
    _etl_loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE raw.payment (
    id INTEGER,
    orderid INTEGER,
    paymentmethod VARCHAR,
    status VARCHAR,
    amount INTEGER,
    created DATE,
    _batched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Assume local CSV files are available and specify the file paths
-- Copy data from local CSV files into the tables
-- Adjust the file paths as necessary
COPY raw.customers (id, first_name, last_name)
FROM '..\Others\DBT\datasets\raw_customers.csv'
DELIMITER ','
CSV HEADER;

COPY raw.orders (id, user_id, order_date, status)
FROM '..\Others\DBT\datasets\raw_orders.csv'
DELIMITER ','
CSV HEADER;

COPY raw.payment (id, orderid, paymentmethod, amount)
FROM '..\Others\DBT\datasets\raw_payments.csv'
DELIMITER ','
CSV HEADER;
