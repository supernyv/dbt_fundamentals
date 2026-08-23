with customer_order_summary as (
select
    customer_id,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date,
    count(order_id) as number_of_orders

from
    {{ref("stg_jaffle_shop__customer_order")}}
group by 1
),

customer_spending AS (
select
    customer_order.customer_id,
    sum(payment.amount) as lifetime_spending
from
    {{ref("stg_stripe__payment")}} as payment
    left join {{ref("stg_jaffle_shop__customer_order")}} as customer_order
    using (order_id)
group by 1
),


final as (
select
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    customer_order_summary.first_order_date,
    customer_order_summary.most_recent_order_date,
    coalesce(customer_order_summary.number_of_orders, 0) as number_of_orders,
    coalesce(customer_spending.lifetime_spending, 0) as lifetime_spending
from 
    {{ref("stg_jaffle_shop__customer")}} as customer
    left join customer_order_summary
    using (customer_id)
    left join customer_spending
    using (customer_id)

)

select * from final
