{{ config(materialized='incremental', unique_key='o_orderkey') }}

SELECT * 
FROM ANALYTICS.DBT.ORDERS
WHERE O_ORDERDATE <= CURRENT_DATE

{% if is_incremental() %}
OR O_ORDERDATE > ( SELECT MAX(O_ORDERDATE) FROM {{ this }} )
-- Ideally in production we use 
-- AND condition to load only the new/updated records, here, I had to check right now so used OR - which was not possible due to CURRENT_DATE
{% endif %}