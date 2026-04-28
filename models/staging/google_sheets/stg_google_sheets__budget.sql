{{ config(materialized='view') }}

with 

google_sheets_cte as (

    select * from {{ source('google_sheets', 'google_sheets_budget') }}

),

cte_renamed as (

    select
        _row,
        quantity,
        month,
        product_id,
        _fivetran_synced as date_load
    from google_sheets_cte

)

select * from cte_renamed