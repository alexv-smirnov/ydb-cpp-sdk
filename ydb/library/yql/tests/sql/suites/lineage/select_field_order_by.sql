insert into plato.Output
select key, value from plato.Input
order by key;

