{{
    config(
        materialized='incremental',
        unique_key='changed_at',
        sort='created_at',
        dist='uid',
    )
}}

with users as (
    select *
    from {{ ref('stg_drupal_users__unioned') }}
)
select u.uid,
    u.uuid,
    u.mail,
    u.name,
    u.changed,
    u.created_at,
    u.changed_at,
    u.access_at,
    u.status
from users u
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where u.changed >= (select COALESCE(MAX(changed), 0) from {{ this }})

{% endif %}