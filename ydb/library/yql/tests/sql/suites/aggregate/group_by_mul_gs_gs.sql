/* syntax version 1 */
/* postgres can not */
select count(1), kf, kl, vf, vl, grouping(kf, kl, vf, vl) from plato.Input group by grouping sets(cast(key as uint32) / 100 as kf, cast(key as uint32) % 10 as kl), grouping sets(Substring(value, 0, 1) as vf, Substring(value, 2, 1) as vl)
order by kf, kl, vf, vl;
