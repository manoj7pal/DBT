{{config(materialized='table', database='analytics_test', schema='manojpal', alias='customer')}}

SELECT *
FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF001"."CUSTOMER"