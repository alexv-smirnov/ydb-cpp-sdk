/* syntax version 1 */
/* postgres can not */
use plato;
pragma EmitAggApply;

pragma yt.UseAggPhases = "1";

SELECT
    key,
    count(value),
    count(distinct value)
FROM Input
GROUP BY key
ORDER BY key
