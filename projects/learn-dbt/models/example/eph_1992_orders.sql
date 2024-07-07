{{ config(materialized='ephemeral') }}

SELECT * FROM  ANALYTICS.DBT.ORDERS 
WHERE YEAR(O_ORDERDATE) = 1992