/* syntax version 1 */
/* postgres can not */
pragma EmitAggApply;

SELECT
    max(key)
FROM (values (1),(2),(3)) as a(key)