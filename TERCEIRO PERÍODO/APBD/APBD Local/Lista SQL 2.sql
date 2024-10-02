use bd2024;
# QUESTÃO 1
#CRIANDO TABELA QUE REGISTRA O AUMENTO DE SALARIO
create table historicosalario(
hiscodigo int(11) not null unique auto_increment,
hisfuncodigo int(11) not null,
hisantigosalario double(6,2) not null,
hisnovosalario double(6,2) not null,
hisdtaumento date default current_timestamp,
primary key (hiscodigo),
foreign key (hisfuncodigo) references funcionario(funcodigo)
);
#CRIANDO GATILHO QUE, AO ATUALIZAR O SALARIO NA TABELA FUNCIONARIO, REGISTRA O AUMENTO NA TABELA historicosalario
DELIMITER //

CREATE TRIGGER historicosalario AFTER UPDATE ON funcionario
FOR EACH ROW
BEGIN
    IF NEW.funsalario <> OLD.funsalario THEN
        INSERT INTO historicosalario (hisfuncodigo, hisantigosalario, hisnovosalario)
        VALUES (NEW.funcodigo, OLD.funsalario, NEW.funsalario);
    END IF;
END;
//

DELIMITER ;


select * from funcionario;
# QUESTÃO 2
UPDATE funcionario SET funsalario = 5000.00 WHERE funcodigo = 4;
UPDATE funcionario SET funsalario = 5070.00 WHERE funcodigo = 5;
UPDATE funcionario SET funsalario = 8500.00 WHERE funcodigo = 7;

select * from historicosalario;

#Questão 3
select funnome as 'Nome', hisantigosalario as 'Salario Antigo', hisnovosalario as 'Novo Salario'
from funcionario
inner join historicosalario
on funcodigo = hisfuncodigo;

# Questão 4
select clisexo as 'Sexo', fpgdescricao as 'Forma de Pagamento', count(*) as 'Total'
from cliente inner join (select venclicodigo, vendformapagamento, fpgdescricao from venda
	inner join formapagamento on fpgcodigo=vendformapagamento) subselecao 
on clicodigo = subselecao.venclicodigo
group by clisexo;

#QUESTÃO 5

select clisexo as 'Sexo', pronome as 'Produto', count(*) as 'Total Vendido'
from cliente inner join
	(select venclicodigo, pronome from venda inner join 
		(select itvvencodigo, pronome from itemvenda inner join produto on itvprocodigo = procodigo ) itvproduto
		on  itvproduto.itvvencodigo = vencodigo ) 
	venda_item on clicodigo = venda_item.venclicodigo
where clisexo='F'
group by pronome
order by count(*) desc;

#QUESTÃO 6
select clisexo as 'Sexo', estdescricao as 'Estado Civil', pronome as 'Produto', count(*) 'Total vendidos'
from cliente inner join estadocivil on cliestcodigo = estcodigo
inner join (select venclicodigo, pronome from venda inner join
	(select itvvencodigo, pronome from itemvenda inner join produto
		on itvprocodigo=procodigo) itvproduto
	on itvproduto.itvvencodigo = vencodigo) venda_item
on venda_item.venclicodigo = clicodigo
where clisexo = 'M' and estdescricao in ('solteiro', 'divorciado')
group by estdescricao
order by count(*);

#QUESTÃO 7
SELECT fpgdescricao as 'Forma de Pagamento', sum(propreco) as 'Valor Total', count(*) 'Total da Forma de Pagamento'
from formapagamento
inner join (select vendformapagamento, propreco from venda
			inner join (select itvvencodigo, propreco from itemvenda
						inner join produto on itvprocodigo = procodigo) itvproduto
                        on itvproduto.itvvencodigo=vencodigo
)venda_item on fpgcodigo= venda_item.vendformapagamento
group by fpgdescricao;
		
# QUESTÃO 8
select ger.funnome, count(*) as 'Total de subordinados' from
funcionario ger, funcionario sub where ger.funcodigo = sub.funcodgerente
group by ger.funnome
having count(*)>3
order by count(*) desc;

#Questão 9

select funnome as 'Nome do vendendor', year(curdate()) - year(fundtnascto) as 'Idade', count(*) as 'Total de Vendas'
from funcionario inner join
	(select vdnfuncodigo from vendedor inner join venda on vdnfuncodigo = venfuncodigo) venda_vendedor
on venda_vendedor.vdnfuncodigo = funcodigo
group by funnome
order by count(*) desc;

#Questão 10
select funnome as 'Nome do Funcionario', 
	reverse(left(
		reverse(funnome), locate(' ', reverse(funnome))-1)) 'Ultimo Nome'
from funcionario left outer join
	(select vdnfuncodigo from vendedor inner join venda
		on vdnfuncodigo = venfuncodigo) venda_vendedor
on funcodigo = venda_vendedor.vdnfuncodigo 
where venda_vendedor.vdnfuncodigo is null;
select distinct * from funcionario left outer join
	(select vdnfuncodigo from vendedor inner join venda
		on vdnfuncodigo = venfuncodigo) venda_vendedor
on funcodigo = venda_vendedor.vdnfuncodigo ;

#Questão 11
select zonnome 'Zona', sum(clirendamensal) as 'Renda Total' from
zona inner join
(select baizoncodigo, clirendamensal from
	cliente inner join bairro on clibaicodigo = baicodigo) clibairro
on clibairro.baizoncodigo = zoncodigo
group by zonnome
order by sum(clirendamensal);
#Questão 12
select clinome as 'Nome do Cliente', min(vendata) as 'Data da Primeira Compra' from
cliente inner join venda on clicodigo = venclicodigo
group by clinome
order by clinome;

#Questão 13
select clinome as 'Cliente', clirendamensal as 'Renda Mensal' from cliente
order by clirendamensal limit 3;

#Questão 14
select clinome as 'Cliente', clirendamensal as 'Renda Mensal' from cliente
order by clirendamensal desc limit 5;

