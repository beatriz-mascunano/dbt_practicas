{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy= 'merge')}}

with 

orders_postgres_cte as (

    select * from {{ source('postgres', 'Orders') }}

{% if is_incremental() %}
    where _FIVETRAN_SYNCED > (SELECT MAX(data_load) from {{ this }})
{% endif %}
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