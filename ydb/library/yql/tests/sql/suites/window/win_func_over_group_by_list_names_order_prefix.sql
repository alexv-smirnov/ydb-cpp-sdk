/* postgres can not */
/* syntax version 1 */
use plato;

$data = (select cast(key as uint32) as age, cast(subkey as uint32) as region, value as name from Input);

--insert into Output
select
  prefix,
  region,
  region + 2 as region_2,
  avg(age) as avg_age,
  sum(age) as sum_age,
  sum(avg(age)) over w1 as sum_by_avg_age,
  lag(region) over w1 as prev_region,
  aggr_list(prefix) over w1 as prefix_list,
  lag(prefix) over w1 as prev_prefix_list,
  lag(agg_list(name)) over w1 as prev_region_list,
  'test'
from $data
group by region, SUBSTRING(name,0,1) as prefix
window w1 as (partition by region order by prefix desc)
order by region desc, prefix, sum_by_avg_age
;
