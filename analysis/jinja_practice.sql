select * from {{ref('dim_customers')}};

select * from employees;

select * from {{ref('stg_payments')}};

{# --Comment start
    {% set a = 'wow!!!' %}
    {{a}}


{% set my_animals = ['Lion', 'Tiger', 'Deer', 'Rabbit'] %}
{{ my_animals }}
{{ my_animals[0] }}
{{ my_animals[-1] }}
{{ my_animals[0:2] }}
{{ my_animals[-3:-1] }}

{% for animal in my_animals %}
    My favorite animal is {{animal}}
{% endfor %}


{% set temp = 45%}

{% if temp < 65 %}
    Time for a cappucino
{% else %}    
    Time for a cold brew!!!!
{% endif %}



{%- set foods = ['carrot', 'hotdog', 'cucumber', 'bellpepper'] -%}

{%- for food in foods -%}
    {%- if food == 'hotdog' -%}
        {%- set food_type = 'snack' -%}
    {%- else %}
        {%- set food_type = 'vegetable' -%}
    {% endif %}
    The humble {{food}} is my favorite {{food_type}}
{% endfor %}


{% set dict = {1:'One', 2:'Two', 3:'Three', 4: 'Four'} %}

{%- for key in dict -%}
    {{key}}: {{dict[key]}}
{% endfor %}

{{ '' }}

{%- for key, value in dict.items() -%}
    {{key}}: {{value}}
{% endfor %}

#} --Comment end
