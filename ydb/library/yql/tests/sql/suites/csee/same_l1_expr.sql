SELECT
    AsList(
        ListMap(AsList(1,2),($x)->{return $x+1}),
        ListMap(AsList(1,2),($x)->{return $x+1})
    );