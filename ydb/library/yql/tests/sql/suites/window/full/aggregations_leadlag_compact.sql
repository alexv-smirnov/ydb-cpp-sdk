/* syntax version 1 */
/* postgres can not */

SELECT
    value,
    SUM(unwrap(cast(subkey as uint32))) over w1 as sum1,
    LEAD(value || value, 3)             over w1 as dvalue_lead1,

    SUM(cast(subkey as uint32))         over w2 as sum2,
    LAG(cast(value as uint32))          over w2 as value_lag2,
FROM (SELECT * FROM plato.Input WHERE key = '1')
WINDOW
    w1 as (PARTITION COMPACT BY ()  ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
    w2 as (PARTITION COMPACT BY key ORDER BY value DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER BY value;
