/* postgres can not */
select AsStruct(1 as x) in AsList(AsStruct(1 as x), AsStruct(2 as x));
