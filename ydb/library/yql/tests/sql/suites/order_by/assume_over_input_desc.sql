/* postgres can not */
/* multirun can not */
/* syntax version 1 */
USE plato;

insert into Output
select * from concat(`Input[#3]`, `Input[#0]`, `Input[#2]`)
assume order by key desc;
