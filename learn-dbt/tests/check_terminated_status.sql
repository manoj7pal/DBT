
SELECT COUNT(*)
FROM {{ref('tests')}}
WHERE STATUS = 'Terminated'

-- Test Failure condition
having count(*) >= 1