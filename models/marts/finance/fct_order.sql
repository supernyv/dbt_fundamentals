select
    customer_id,
    order_id,
    amount
from
    {{ref("stg_jaffle_shop__customer_order")}}