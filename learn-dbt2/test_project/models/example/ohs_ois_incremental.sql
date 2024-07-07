{{ config( materialized='incremental',  unique_key = 'new_key' ) }}

select DISTINCT a.*, 
    concat(a.order_no, '-', a.item_no) as new_key --, '-', date_part('dd', a.updated_date::DATE)
from (
select
    h.order_no,
    h.customer_id,
    h.order_type,
    i.item_no,
    i.product_id,
    i.quantity,
    i.price,
    i.created_on created_date,
    CASE WHEN h.updated_on >= i.updated_on THEN h.updated_on ELSE i.updated_on END updated_date
from ohs_incremental as h, ois_incremental as i
where h.order_no = i.order_no) a

{%if is_incremental()%}
where updated_date > ( select max(updated_date) from {{this}} )
{%endif%}