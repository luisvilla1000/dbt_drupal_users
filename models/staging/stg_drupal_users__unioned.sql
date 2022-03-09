with users as (
    select *
    from {{ source('landing', 'drupal_users') }}
),

users_field_data as (
    select uid::INTEGER,
    mail,
    name,
    changed,
    {{ epoch_to_timestamp('created') }} as created_at,
    {{ epoch_to_timestamp('changed') }} as changed_at,
    {{ epoch_to_timestamp('access') }} as access_at,
    status::INTEGER
    from {{ source('landing', 'drupal_users_field_data') }}
),

joined as (

    select u.uid,
        u.uuid,
        ud.mail,
        ud.name,
        ud.changed,
        ud.created_at,
        ud.changed_at,
        ud.access_at,
        ud.status
    from users u
        left join users_field_data ud on u.uid = ud.uid

)

select * from joined