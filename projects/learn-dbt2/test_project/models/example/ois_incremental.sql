{{ config(materialized='incremental',  unique_key = 'new_key') }}

select i.* , concat(i.order_no, '-', i.item_no) as new_key --, '-', date_part('dd', i.updated_on::DATE)
from ois as i

{% if is_incremental() %}
where i.updated_on > (select max(updated_on) from {{this}} )
{% endif %}
