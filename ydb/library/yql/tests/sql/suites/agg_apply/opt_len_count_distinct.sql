/* syntax version 1 */
/* postgres can not */
pragma EmitAggApply;

SELECT
    count(distinct key)
FROM (values (1),(null),(3)) as a(key)
