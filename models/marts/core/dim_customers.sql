WITH

/*
customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from raw.jaffle_shop.customers

)


orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from raw.jaffle_shop.orders
*/


customers as 
(
    select * 
    from {{ ref('stg_customers') }} c
),

orders as 
(
    select * from {{ ref('fct_orders') }}
),

employees as
(
    select * from {{ref('employees')}}
),

new_employees as 
(
    select * from {{ref('new_employees')}}
),

customer_orders as (

    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(amount) as life_time_value
    from orders
    group by 1

),



final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        (case when employees.employee_id is not NULL or new_employees.employee_id is not NULL then 1 else 0 end ) as is_employee, 
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        customer_orders.life_time_value
    from customers 
        left join customer_orders  using (customer_id)
        left join employees using (customer_id)
        left join new_employees using (customer_id)

)

select * from final