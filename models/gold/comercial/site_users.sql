with users as (
    select *
    from {{ ref('drupal_users_plain') }}
)
select u.uid,
    u.uuid,
    u.mail,
    u.name,
    u.created_date,
    u.status
from users u