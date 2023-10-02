/* syntax version 1 */
/* postgres can not */

PRAGMA DisableAnsiInForEmptyOrNullableItemsCollections;

SELECT
    1         IN (2, 3, null),          -- false
    null      IN (),                    -- Nothing<Bool?>
    null      IN (null),                -- Nothing<Bool?>
    null      IN (1),                   -- Nothing<Bool?>
    (1, null) IN ((1, 1), (2, 2)),      -- Nothing<Bool?>
    (1, null) IN ((2, 2), (3, 3)),      -- Nothing<Bool?>
    (1, 2)    IN ((1, null), (2, 2)),   -- false
    (1, 2)    IN ((null, 1), (2, 1)),   -- false
    (1, 2)    IN ((1, null), (2, 1)),   -- false
    128       IN (128ut, 1t),           -- true
;

SELECT
    Just(1)   IN (1, 2, 3),             -- true?
    1         IN (Just(2), Just(3)),    -- false
;

