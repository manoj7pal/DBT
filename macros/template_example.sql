{% macro template_example() %}
    {% set query %}
      SELECT True as bool
    {% endset %}

    {% if execute %}
      
        {% set result = run_query(query).columns[0].values()[0] %}
        {{ log('SQL Results: '~result, info=True) }}

        SELECT {{result}} as is_real

    {% endif %}

{% endmacro %}