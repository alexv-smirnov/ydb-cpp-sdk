use plato;

$a = select key from Input order by key limit 1;

insert into Output1 select * from Input where key <= $a;
insert into Output2 select * from Input where key >= $a;
