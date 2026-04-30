{{ config(
    materialized='incremental',
    unique_key= 'product_id',
    incremental_strategy= 'delete+insert')}}

with 

products_postgres_cte as (

    select * from {{ source('postgres', 'Products') }}
{% if is_incremental() %}
    where _FIVETRAN_SYNCED > (SELECT MAX( data_load) from {{ this }})
{% endif %}

),

products_postgres_renamed as (

    select
        product_id,
        price,
        name,
        inventory,
        _fivetran_deleted as data_deleted,
        _fivetran_synced as data_load

    from products_postgres_cte

)

select * from products_postgres_renamed