/* syntax version 1 */
/* postgres can not */
select sum(length(value)), key, subkey from plato.Input group by grouping sets ((key),(subkey)) order by key, subkey;
