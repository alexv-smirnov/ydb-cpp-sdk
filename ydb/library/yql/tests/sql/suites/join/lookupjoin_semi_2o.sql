PRAGMA DisableSimpleColumns;

use plato;
pragma yt.LookupJoinLimit="64k";
pragma yt.LookupJoinMaxRows="100";

-- prefix of sort keys
select * from Input1 as a
left semi join Input2 as b on a.k1 = b.k2
order by a.k1;
