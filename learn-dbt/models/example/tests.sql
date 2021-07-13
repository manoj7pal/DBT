{{ config(materialized='incremental', unique_key='Status', alias='test', schema='manojpal', database='analytics_test') }}

select 'Active' as Status
union all
select 'Inactive' as Status
union all
select 'Suspended' as Status

{% if is_incremental() %}
union all
select 'Terminated' as Status
{% endif %}