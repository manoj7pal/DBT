{{ config(materialized='table') }}

SELECT c.c_custkey, c.c_name, c.c_nationkey, sum(o.o_totalprice) total_order_price
FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."CUSTOMER" C, "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" O
WHERE c.c_custkey = o.o_custkey(+)
GROUP BY c.c_custkey, c.c_name, c.c_nationkey 
ORDER BY 4 DESC NULLS LAST