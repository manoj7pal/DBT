{{ config(materialized='incremental', unique_key='TIME_VALUE') }}

WITH data AS
(
    SELECT 
        A.* , 
        to_time(concat(T_HOUR, ':', T_MINUTE, ':', T_SECOND), 'HH24:MI:SS') TIME_VALUE
    FROM "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."TIME_DIM" A
)

SELECT * 
FROM data
WHERE TIME_VALUE  <= CURRENT_TIME

{% if is_incremental() %}
AND TIME_VALUE > ( SELECT MAX(TIME_VALUE) FROM {{this}} )
{% endif %}