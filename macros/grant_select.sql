{% macro grant_select(schema = target.schema, user = target.user) %}

    {% set query %}
      GRANT USAGE ON SCHEMA {{schema}} TO {{user}};
      GRANT SELECT ON ALL TABLES IN SCHEMA {{schema}} TO {{user}};
    {% endset %}
    
    {% if target.name == 'dev' %}
        {{ log('Granting select on all tables in schema' ~schema ~ 'to user '~user , info=True) }}
        {% do run_query(query) %}
        {{ log(' Privileges granted.', info=True) }}
    {% endif %}

{% endmacro %} 