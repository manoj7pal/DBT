{{ config( materialized='incremental', unique_key = 'new_key') }}

SELECT * FROM (
  select DISTINCT
      h.order_no,
      h.customer_id,
      h.order_type,
      i.item_no,
      i.product_id,
      i.quantity,
      i.price,
      i.created_on created_date,
      greatest(h.updated_on,i.updated_on) updated_date,
      --DENSE_RANK() OVER (PARTITION BY h.order_no, i.item_no ORDER BY updated_date desc) as rank,
      ROW_NUMBER() OVER (PARTITION BY h.order_no, i.item_no ORDER BY i.updated_on desc, h.updated_on desc) as rank,
      concat(h.order_no, '-', i.item_no) as new_key
  from ohs as h, ois as i
  where h.order_no = i.order_no
    )
where rank = 1