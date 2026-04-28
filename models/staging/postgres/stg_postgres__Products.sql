{{ config(materialized='view')}}

with 

products_postgres_cte as (

    select * from {{ source('postgres', 'Products') }}

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