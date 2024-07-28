{{
    config(
        materialized = 'view',
        schema='transformation'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'order_date']) }} as id,
    customer_id,
    order_date,
    count(*)
FROM {{ ref('stg_orders') }}
GROUP BY id, customer_id, order_date