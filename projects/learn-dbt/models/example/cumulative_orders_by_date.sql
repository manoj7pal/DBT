{{ config(materialized='table') }}

SELECT o.o_orderdate, sum(o_totalprice) total_sales
FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" o
group by o.o_orderdate
ORDER BY 1

