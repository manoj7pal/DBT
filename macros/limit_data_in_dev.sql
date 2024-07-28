{% macro limit_data_in_dev(column_name, interval_days = -3) %}
    {% if target.name == 'dev' %}
        WHERE {{column_name}} >= current_timestamp + INTERVAL '{{interval_days}} day'
    {% endif %}
{% endmacro %}