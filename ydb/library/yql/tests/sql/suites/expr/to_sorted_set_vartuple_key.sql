/* postgres can not */
$vt = ParseType("Variant<Int32,Uint32>");
$v1 = Variant(1,"0",$vt);
$v2 = Variant(2u,"1",$vt);
$v3 = Variant(2,"0",$vt);

$l = AsList(
    AsTuple($v1,Void()),
    AsTuple($v2,Void()),
);

$d = ToSortedDict($l);
select $d,DictKeys($d),DictPayloads($d),DictItems($d);
select DictLookup($d,$v1), DictLookup($d,$v3);
select DictContains($d,$v1), DictContains($d,$v3);
