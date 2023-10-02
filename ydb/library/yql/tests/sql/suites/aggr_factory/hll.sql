/* syntax version 1 */
/* postgres can not */
$t = AsList(AsStruct(1 as a),AsStruct(2 as a));
$f = AGGREGATION_FACTORY("hll");

select Yql::Aggregate($t, AsTuple(), AsTuple(AsTuple(AsAtom("res"), $f(
    ListItemType(TypeOf($t)), ($z)->{return $z.a}))));

$f = AGGREGATION_FACTORY("hll", 4);

select Yql::Aggregate($t, AsTuple(), AsTuple(AsTuple(AsAtom("res"), $f(
    ListItemType(TypeOf($t)), ($z)->{return $z.a}))));

use plato;
insert into @a select * from as_table($t);
commit;
select AGGREGATE_BY(a,$f) from @a;
select AGGREGATE_BY(distinct a,$f) from @a;
