with users as (
    select *
    from {{ source('public', 'drupal_users') }}
),
users_field_data as (
    select *
    from {{ source('public', 'drupal_users_field_data') }}
)
select u.uid,
    u.uuid,
    ud.mail,
    ud.name,
    ud.created,
    ud.changed,
    ud.access,
    ud.status
from users u
    join users_field_data ud on u.uid = ud.uid