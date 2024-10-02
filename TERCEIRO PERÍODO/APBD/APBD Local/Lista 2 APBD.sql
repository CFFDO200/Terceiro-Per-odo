use bd2024;
-- 1
create table salariohistorico(
shcodigo int(11) not null auto_increment,
shfuncodigo int(11) not null,
shsalant double(6,2) not null,
shsalnovo double(6,2) not null,
shdtaum date,
primary key (shcodigo),
foreign key (shfuncodigo) references funcionario(funcodigo)
);

-- 2
-- select funcodigo, funsalario from funcionario where funcodigo in (4,5,7);
UPDATE funcionario SET funsalario = 5000.00 WHERE funcodigo = 4;
INSERT INTO salariohistorico (shfuncodigo, shsalant, shsalnovo, shdtaum) VALUES (4, 5000, 1836.00, curdate());
UPDATE funcionario SET funsalario = 5070.00 WHERE funcodigo = 5;
INSERT INTO salariohistorico (shfuncodigo, shsalant, shsalnovo, shdtaum) VALUES (5, 2065.50, 1836.00, curdate());
UPDATE funcionario SET funsalario = 8500.00 WHERE funcodigo = 7;
INSERT INTO salariohistorico (shfuncodigo, shsalant, shsalnovo, shdtaum) VALUES (7, 8500.00, 2489.11, curdate());

-- select * from salariohistorico;


-- 3
/*select funnome, shsalant shsalnovo
from funcionario
inner join salariohistorico
on funcodigo = shfuncodigo;

-- 4
select clisexo, fgdescricao, count(*)
from cliente inner join (select venclicodigo, vendformapagamento, fgdescricao from venda inner join formapagamento on fgcodigo=vendformapagamento) aux  on clicodigo = aux.venclicodigo
group by clisexo, fgdescricao;

-- 5

select clisexo, pronome, count(*)
from cliente inner join
	(select venclicodigo, pronome from venda inner join  (select itvvencodigo, pronome from itemvenda inner join produto on itvprocodigo = procodigo ) itvproduto on  itvproduto.itvvencodigo = vencodigo ) aux_venit on clicodigo = aux_venit.venclicodigo
where clisexo='F'
group by pronome
order by count(*) desc;

-- 6
select clisexo, estdescricao, pronome, count(*)
from cliente inner join estadocivil on cliestcodigo = estcodigo
inner join (select venclicodigo, pronome from venda inner join
	(select itvvencodigo, pronome from itemvenda inner join produto on itvprocodigo=procodigo) itvproduto on itvproduto.itvvencodigo = vencodigo) aux_venit
on aux-venit.venclicodigo = clicodigo
where clisexo = 'M' and estdescricao in ('solteiro', 'divorciado')
group by estdescricao
order by count(*);

-- 7
SELECT fgdescricao, sum(propreco), count(*)
from formapagamento
inner join (select vendformapagamento, propreco from venda inner join (select itvvencodigo, propreco from itemvenda inner join produto on itvprocodigo = procodigo) itvproduto on itvproduto.itvvencodigo=vencodigo )aux_venit on fgcodigo= aux-venit.vendformapagamento
group by fgdescricao;
		
-- 8
select ger.funnome, count(*)
from funcionario ger, funcionario sub 
where ger.funcodigo = sub.funcodgerente
group by ger.funnome
having count(*)>3
order by count(*) desc;

-- 9

select funnome, year(curdate()) - year(fundtnascto), count(*)
from funcionario 
inner join (select vdnfuncodigo from vendedor inner join venda on vdnfuncodigo = venfuncodigo) aux_ven on aux_ven.vdnfuncodigo = funcodigo
group by funnome
order by count(*) desc;

-- 10
select funnome, reverse(left(reverse(funnome), locate(' ', reverse(funnome))-1))
from funcionario left outer join
	(select vdnfuncodigo from vendedor inner join venda on vdnfuncodigo = venfuncodigo) aux_ven on funcodigo = aux_ven.vdnfuncodigo 
where aux_ven.vdnfuncodigo is null;
-- 11
select zonnome, sum(clirendamensal) 
from zona 
inner join (select baizoncodigo, clirendamensal from cliente inner join bairro on clibaicodigo = baicodigo) aux_bar1 on aux_bar1.baizoncodigo = zoncodigo
group by zonnome
order by sum(clirendamensal);
-- 12
select clinome, min(vendata) from
cliente inner join venda on clicodigo = venclicodigo
group by clinome
order by clinome;

-- 13
select clinome, clirendamensal from cliente
order by clirendamensal limit 3;

-- 14
select clinome, clirendamensal from cliente
order by clirendamensal desc limit 5;
*/
