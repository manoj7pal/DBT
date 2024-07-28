{# 
    Develop a macro:
    1. Queries the information schema of the database.
    2. Finds objects that are >1 week old - no longer maintained
    3. Generate automated drop statements
    4. Has the ability of execute those drop statments.
 #}

 {% macro clean_stale_models(database = target.database, schema=target.schema, dry_run=true) %}
   {% set drop_ddl_queries %}
        WITH DATA AS (
            SELECT 
                table_type ,
                table_schema ,
                table_name,
                CASE table_type
                    WHEN 'VIEW' THEN table_type
                    ELSE 'TABLE'
                END AS drop_type
            FROM information_schema.TABLES
            WHERE upper(table_catalog) = upper('{{database}}')
            AND upper(table_schema) = upper('{{schema}}')
        )

        SELECT 
            'DROP ' || d.drop_type || ' ' ||d.table_schema|| '.' ||d.table_name|| ';' as drop_query
        FROM DATA d;	
    
   {% endset %}

    {{ log('Generating cleanup queries', info=True) }}
    {% set drop_queries = run_query(drop_ddl_queries).columns[0].values() %}

    {% for query in drop_queries %}
      {% if dry_run %}
        {{ log(query, info=True) }}  
      {% else %}
        {{ log('Droppping db object with command: '~query, info=True) }}  
        {# {% do run_query(query) %} #}
      {% endif %}  
      
    {% endfor %} 

 {% endmacro %}