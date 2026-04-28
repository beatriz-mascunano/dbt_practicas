{{ config(materialized='view')}}

with 

promos_postgres_cte as (

    select * from {{ source('postgres', 'Promos') }}

),

promos_postgres_renamed as (

    select
        promo_id,
        discount,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from promos_postgres_cte

)

select * from promos_postgres_renamed