with users as (
    select *
    from {{ source('landing', 'drupal_users') }}
),
users_field_data as (
    select *
    from {{ source('landing', 'drupal_users_field_data') }}
)
select u.uid,
    u.uuid,
    ud.mail,
    ud.name,
    ud.created,
    ud.changed as changed,
    ud.access,
    ud.status
from users u
    left join users_field_data ud on u.uid = ud.uid