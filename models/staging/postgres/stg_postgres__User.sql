{{ config(materialized='view')}}

with 

user_postgres_cte as (

    select * from {{ source('postgres', 'User') }}

),

user_postgres_renamed as (

    select
        user_id,
        updated_at,
        address_id,
        last_name,
        created_at,
        phone_number,
        total_orders,
        first_name,
        email,
        _fivetran_deleted as data_deleted,
        _fivetran_synced as data_load

    from user_postgres_cte

)

select * from user_postgres_renamed