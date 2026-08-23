select
    payment_id,
    order_id,
    payment_method,
    status,
    amount/100 as amount, -- convert cents to dollars
    created as created_at
from
    raw.stripe.payment