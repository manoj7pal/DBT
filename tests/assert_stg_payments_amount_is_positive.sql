-- User Defined Test cases: write case to return invalid/bad records

WITH
payments as
(
    select * from {{ ref('stg_payments') }}
)

select 
    order_id,
    sum(amount) as total_amount
from payments
group by order_id
having total_amount < 0 