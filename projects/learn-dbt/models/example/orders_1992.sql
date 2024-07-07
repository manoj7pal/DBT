{{ config(materialized='view') }}

select * from {{ ref('eph_1992_orders') }}