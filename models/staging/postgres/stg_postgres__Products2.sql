-- Aquí no se pone lo de unique key porque no detecta duplicados, entonces no hace falta.
{{ config(
    materialized='incremental', 
    incremental_strategy= 'append')}}

with 

--la incremental se pone dentro del select de source y después del from. El where se refiere a la tabla de donde coje los datos (en este caso BRZ) y el SELECT MAX se refiere a la tabla donde dejas los datos (en este caso SLV).
products_postgres_cte as (

    select * from {{ source('postgres', 'Products') }}

{% if is_incremental() %}
    where _FIVETRAN_SYNCED > (SELECT MAX(data_load) from {{ this }})
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