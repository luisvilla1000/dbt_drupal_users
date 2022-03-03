with users as (
    select *
    from {{ source('landing', 'drupal_users') }}
),
users_field_data as (
    select uid,
    mail,
    name,
    changed,
    {{ epoch_to_timestamp('created') }} as created_date,
    {{ epoch_to_timestamp('changed') }} as changed_date,
    {{ epoch_to_timestamp('access') }} as access_date,
    status
    from {{ source('landing', 'drupal_users_field_data') }}
)

select u.uid,
    u.uuid,
    ud.mail,
    ud.name,
    ud.changed,
    ud.created_date,
    ud.changed_date,
    ud.access_date,
    ud.status
from users u
    left join users_field_data ud on u.uid = ud.uid