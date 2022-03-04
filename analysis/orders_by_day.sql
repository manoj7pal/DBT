WITH 

orders as
(
    select * from {{ref('stg_orders')}}
),

daily as
(
    select 
        order_date, 
        count(*) total_orders,
        coalesce(lag(total_orders) over (order by order_date), 0) prev_day_orders,
        sum(total_orders) over (order by order_date rows between unbounded preceding and current row) ytd_orders,
        sum(total_orders) over (partition by month(order_date)) monthly_total_orders,
        avg(total_orders) over (partition by month(order_date)) monthly_avg_orders,
        
        -- Pivot: For Every Status returns number of orders
        {% for order_status in ['returned', 'completed', 'return_pending', 'shipped', 'placed'] %}
            sum( case when status = '{{order_status}}' then 1 else 0 end ) as {{order_status}}_total 
                {{ ',' if not loop.last }} -- adds ',' to every line, except the last line
        {% endfor %}

    from orders
    group by order_date
)

select * from daily