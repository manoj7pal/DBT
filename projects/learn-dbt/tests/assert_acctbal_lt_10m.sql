SELECT SUM(c_acctbal) 
FROM {{ref('playing_with_tests')}} 

having sum(c_acctbal) < 100000000
