#Adiconando formas de pagamento na tabela venda
update venda set vendformapagamento = '1' where vendformapagamento ='0';
#Criando relacionamento de forma de pagamento com venda
alter table venda
add constraint foreign key(vendformapagamento)
references formapagamento(fpgcodigo);
#Criando especialização do funcionario - vendedor
create table vendedor(
vdnfuncodigo int(11) not null unique,
primary key(vdnfuncodigo)
);

insert into vendedor (vdnfuncodigo)
select distinct venfuncodigo from venda;

alter table venda 
add constraint foreign key (venfuncodigo)
references vendedor(vdnfuncodigo);

alter table vendedor
add constraint foreign key(vdnfuncodigo) 
references funcionario(funcodigo);

select funcodigo from funcionario order by funcodigo;
desc formapagamento;