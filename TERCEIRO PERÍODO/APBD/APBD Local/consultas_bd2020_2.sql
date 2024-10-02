drop view vw_cliente_bai_estcivil;
create or replace view vw_cliente_bai_estcivil
as
select clicodigo, clinome, clisexo, bainome, estdescricao, baizoncodigo, clidtcadastro
from bairro
inner join cliente on baicodigo=clibaicodigo
inner join estadocivil on estcodigo=cliestcodigo;

select *
from vw_cliente_bai_estcivil
inner join zona on zoncodigo=baizoncodigo;