/* syntax version 1 */
/* postgres can not */

$json = CAST(@@{
    "key": 123
}@@ as Json);

-- Check all supported types for variables
SELECT
    -- Numeric types
    JSON_QUERY(
        $json,
        "strict $var1 + $var2 + $var3 + $var4 + $var5 + $var6 + $var7 + $var8 + $var9 + $var10"
        PASSING
            CAST(1 as Int8) as var1,
            CAST(2 as Uint8) as var2,
            CAST(3 as Int16) as var3,
            CAST(4 as Uint16) as var4,
            CAST(5 as Int32) as var5,
            CAST(6 as Uint32) as var6,
            CAST(7 as Int64) as var7,
            CAST(8 as Uint64) as var8,
            CAST(9 as Double) as var9,
            CAST(10 as Float) as var10
        WITH UNCONDITIONAL ARRAY WRAPPER
    ),
    -- Time types
    JSON_QUERY(
        $json,
        "strict $var"
        PASSING
            CAST(1582044622 as Datetime) as var
        WITH UNCONDITIONAL ARRAY WRAPPER
    ),
    JSON_QUERY(
        $json,
        "strict $var"
        PASSING
            CAST(1582044622 as Timestamp) as var
        WITH UNCONDITIONAL ARRAY WRAPPER
    ),
    JSON_QUERY(
        $json,
        "strict $var"
        PASSING
            CAST("2020-02-18" as Date) as var
        WITH UNCONDITIONAL ARRAY WRAPPER
    ),
    -- Utf8
    JSON_QUERY(
        $json,
        "strict $var"
        PASSING
            CAST("привет" as Utf8) as var
        WITH UNCONDITIONAL ARRAY WRAPPER
    ),
    -- Bool
    JSON_QUERY(
        $json,
        "strict $var"
        PASSING
            true as var
        WITH UNCONDITIONAL ARRAY WRAPPER
    ),
    -- Json
    JSON_QUERY(
        $json,
        "strict $var"
        PASSING
            $json as var
    ),
    -- Nulls
    JSON_QUERY(
        $json,
        "strict $var"
        PASSING
            Nothing(Int64?) as var
        WITH UNCONDITIONAL ARRAY WRAPPER
    ),
    JSON_QUERY(
        $json,
        "strict $var"
        PASSING
            NULL as var
        WITH UNCONDITIONAL ARRAY WRAPPER
    );

-- Check various ways to pass variable name
SELECT
    JSON_QUERY(
        $json, "strict $var1"
        PASSING
            123 as var1
        WITH UNCONDITIONAL ARRAY WRAPPER
    ),
    -- NOTE: VaR1 is not casted to upper-case VAR1 as standard expects
    JSON_QUERY(
        $json, "strict $VaR1"
        PASSING
            123 as VaR1
        WITH UNCONDITIONAL ARRAY WRAPPER
    ),
    JSON_QUERY(
        $json, "strict $var1"
        PASSING
            123 as "var1"
        WITH UNCONDITIONAL ARRAY WRAPPER
    ),
    JSON_QUERY(
        $json, "strict $VaR1"
        PASSING
            123 as "VaR1"
        WITH UNCONDITIONAL ARRAY WRAPPER
    );