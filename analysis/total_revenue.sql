WITH
payments as
(
    select * from {{ref('stg_payments')}}
)

select 
    to_char(created_at, 'mm-yyyy') as month_year,
    --count(*) as successful_transactions,

    {% for payment_status in ['success', 'fail'] %}
        sum( case when status = '{{payment_status}}' then 1 else 0 end ) as total_{{payment_status}} 
            {{ ',' if not loop.last}}
    {% endfor %}

from payments
group by 1