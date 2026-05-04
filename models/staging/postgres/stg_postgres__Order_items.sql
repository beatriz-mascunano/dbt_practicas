
with 

order_items_postgres_cte as (

    select * from {{ source('postgres', 'Order_items') }}

),

order_items_postgres_renamed as (

    select
        order_id,
        product_id,
        quantity,
        _fivetran_deleted,
        _fivetran_synced

    from order_items_postgres_cte

)

select * from order_items_postgres_renamed