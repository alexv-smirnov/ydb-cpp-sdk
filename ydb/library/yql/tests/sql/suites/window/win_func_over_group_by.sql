/* postgres can not */
use plato;

$data = (select cast(key as uint32) as age, cast(subkey as uint32) as region, value as name from Input);

--insert into Output
select
  prefix,
  region,
  avg(age) as avg_age,
  sum(avg(age)) over w1 as sum_by_avg_age
from $data
group by region, SUBSTRING(name,0,1) as prefix
-- how to use single avg_age?
window w1 as (partition by region order by avg(age))
order by region, avg_age
;
