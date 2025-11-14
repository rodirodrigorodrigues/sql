with
  camisas as (
    select 1 as "id", 'social' as "nome" from dual
    union all
    select 2 as "id", 'regata' as "nome" from dual
    union all
    select 3 as "id", 'polo' as "nome" from dual
  ),
  cores as (
    select 1 as "id", 'azul' as "cor" from dual
    union all
    select 2 as "id", 'vermelho' as "cor" from dual
    union all
    select 3 as "id", 'preto' as "cor" from dual
    union all
    select 4 as "id", 'branco' as "cor" from dual
  )
select
  c."nome" as "camisa",
  o."cor" as "cor"
from camisas c
  cross join cores o;
