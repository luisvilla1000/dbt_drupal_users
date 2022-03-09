with users as (
    select *
    from {{ ref('dim_drupal_users') }}
)
select u.uid,
    u.mail,
    u.name,
    u.created_at,
    u.status
from users u