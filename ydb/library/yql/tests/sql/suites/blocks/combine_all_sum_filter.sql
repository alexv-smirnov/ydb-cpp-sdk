pragma UseBlocks;
pragma EmitAggApply;
USE plato;

SELECT
    sum(key)
FROM Input
WHERE subkey!=5