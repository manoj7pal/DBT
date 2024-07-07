{{config(materialized='table', alias='lookup_status', schema='manojpal', database='analytics_test')}}

SELECT Status
FROM "ANALYTICS_TEST"."MANOJPAL"."TEST"