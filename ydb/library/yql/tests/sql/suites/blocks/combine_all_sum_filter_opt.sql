pragma UseBlocks;
pragma EmitAggApply;
USE plato;

SELECT
    min(key)
FROM Input
WHERE subkey!=5