pragma UseBlocks;
pragma EmitAggApply;
USE plato;

SELECT
    key
FROM Input
GROUP by key
ORDER by key;
