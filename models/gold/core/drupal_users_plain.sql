{{
    config(
        materialized='incremental',
        unique_key='changed'
    )
}}

with users as (
    select *
    from {{ ref('stg_drupal_users_plain') }}
)
select u.uid,
    u.uuid,
    u.mail,
    u.name,
    u.changed,
    u.created_date,
    u.changed_date,
    u.access_date,
    u.status
from users u
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where u.changed >= (select COALESCE(MAX(changed), 0) from {{ this }})

{% endif %}