/* postgres can not */
PRAGMA DisableSimpleColumns;
use plato;

-- should pushdown
select * from Input1 as a inner join Input2 as b on a.key = b.key where AssumeStrict(Unwrap(cast(a.key as Int32))) > 100 order by a.key;
