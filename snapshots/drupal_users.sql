{% snapshot drupal_users_data_snapshot %}

{{
    config(
      target_database='axioma',
      target_schema='snapshots',
      unique_key='uid',

      strategy='timestamp',
      updated_at='changed',
    )
}}

select * from {{ source('landing', 'drupal_users_field_data') }}

{% endsnapshot %}