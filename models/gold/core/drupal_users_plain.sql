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
    u.created,
    u.changed,
    u.access,
    u.status
from users u
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where u.changed >= (select max(u.changed) from {{ this }})

{% endif %}