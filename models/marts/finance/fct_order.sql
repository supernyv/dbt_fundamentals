select
    customer_order.customer_id,
    customer_order.order_id,
    payment.amount
from
    {{ref("stg_jaffle_shop__customer_order")}} as customer_order
    inner join {{ref("stg_stripe__payment")}} as payment
    using (order_id)