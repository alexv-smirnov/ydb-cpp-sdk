/* syntax version 1 */
/* multirun can not */
/* postgres can not */
/* kikimr can not */
use plato;

pragma yt.UseNativeYtTypes="1";

insert into @a with truncate
select * from concat(Input1, Input2);

commit;

insert into @a with truncate
select * from Input1;

commit;

insert into @a
select * from Input2;

commit;

insert into @a
select * from concat(Input1, Input2);
