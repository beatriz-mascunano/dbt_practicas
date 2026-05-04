{% snapshot users_3_snp %}

{{
    config(
        target_schema='snapshots',
        unique_key='DNI',
        strategy='timestamp',
        updated_at='fecha_alta_sistema',
        hard_deletes='ignore'
    )
}}

SELECT
    Nombre,
    DNI,
    email,
    fecha_alta_sistema
FROM {{ source('google_sheets', 'users') }}

{% endsnapshot %}