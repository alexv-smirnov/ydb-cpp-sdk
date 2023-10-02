PRAGMA DisableSimpleColumns;
use plato;
pragma yt.JoinMergeTablesLimit="10";
pragma yt.JoinAllowColumnRenames="true";

-- emulate monsters in big table
pragma yt.JoinMergeReduceJobMaxSize="1";

-- Input2 is smaller than Input1
select * from Input1 as a join Input2 as b on a.k1 = b.k2
order by a.v1, b.v2;

