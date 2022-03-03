{% macro epoch_to_timestamp(column_name) %}
    (TIMESTAMP 'epoch' + ({{ column_name }}::int) * INTERVAL '1 second')
{% endmacro %}
