{{ config(materialized='view')}}

with 

orders_postgres_cte as (

    select * from {{ source('postgres', 'Orders') }}

),

orders_postgres_renamed as (

    select
        order_id,
        shipping_service,
        shipping_cost,
        address_id,
        created_at,
        promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted as data_deleted,
        _fivetran_synced as data_load

    from orders_postgres_cte

)

select * from orders_postgres_renamed