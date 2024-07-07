{{ config(materialized='incremental', unique_key = 'order_no') }}
select * 
from ohs
{% if is_incremental() %}
where updated_on > (select max(updated_on) from {{this}} )
{% endif %}