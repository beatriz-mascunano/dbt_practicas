{{ config(materialized='view') }}

with 

address_postgres_cte as (

    select * from {{ source('postgres', 'Adresses') }}

),

address_postgres_renamed as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted as date_load,
        _fivetran_synced as date_deleted

    from address_postgres_cte

)

select * from address_postgres_renamed