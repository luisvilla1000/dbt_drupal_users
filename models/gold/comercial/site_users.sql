with users as (
    select *
    from {{ ref('drupal_users_plain') }}
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