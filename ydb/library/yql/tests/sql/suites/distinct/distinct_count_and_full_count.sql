select value, count(distinct key) as dist, count(key) as full from plato.Input2 group by value order by value;