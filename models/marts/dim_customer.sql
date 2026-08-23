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


final as (

    select
        customer.customer_id,
        customer.first_name,
        customer.last_name,
        customer_order_summary.first_order_date,
        customer_order_summary.most_recent_order_date,
        coalesce(customer_order_summary.number_of_orders, 0) as number_of_orders

    from 
        {{ref("stg_jaffle_shop__customer")}} as customer

    left join customer_order_summary using (customer_id)

)

select * from final
