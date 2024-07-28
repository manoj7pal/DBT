
{% set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] %}

WITH payments as (
    SELECT *
    FROM {{ ref('stg_payments') }}
),

pivoted as (
    SELECT 
        order_id,
        {% for payment_method in payment_methods -%}
            sum(case when payment_method='{{payment_method}}' then amount else 0 end) as {{payment_method}}_amount
            {%- if not loop.last -%}
                ,
            {%- endif %}
        {% endfor -%}
    FROM payments
    WHERE status = 'success'
    GROUP BY order_id
)

SELECT *
FROM pivoted