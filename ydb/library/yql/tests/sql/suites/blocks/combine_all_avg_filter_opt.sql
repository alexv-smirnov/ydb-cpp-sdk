pragma UseBlocks;
pragma EmitAggApply;
USE plato;

SELECT
    avg(key)
FROM Input
WHERE subkey!=5