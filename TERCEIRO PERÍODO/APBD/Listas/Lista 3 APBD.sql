use bd2024;

/* 
1) Mostre os históricos de alterações de salários de um determinado funcionário (nome do
funcionário, data de alteração e valor do salário). Utilize o código do funcionário como parâmetro
da SP.
*/

delimiter ##
create procedure sp_alteracoes_salario_funcionario(p_funcodigo int(11))
begin
	declare v_achou_funcionario boolean default false;
    set v_achou_funcionario = (select count(*) 
										from funcionario 
                                        where funcodigo=p_funcodigo);
	if not v_achou_funcionario then
		select 'Funcionario não cadastrado' as resposta;
	else
		select funnome as 'Nome do funcionário', shdtaum as 'Data do aumento', shsalnovo as 'Novo salário'
		from funcionario 
		inner join salariohistorico on shfuncodigo = funcodigo
		where funcodigo = p_funcodigo;
    end if;
end ##
delimiter ;

call sp_alteracoes_salario_funcionario(100000);

/* 
2) Crie (em uma única stored procedures) opções para inserção, atualização e deleção de clientes.
Defina os parâmetros de forma adequada para cada operação, e valide os campos que são chaves
estrangeiras, fazendo os devidos tratamentos e envio de mensagens de erros.
*/


delimiter ##
create procedure sp_gestao_cliente(p_operacao int(1), 
									p_clicodigo int(11), 
                                    p_clisexo char(1), 
                                    p_clirendamensal double(6,2), 
                                    p_clinome varchar(60), 
                                    p_clibaicodigo int(11), 
                                    p_clifone varchar(10), 
                                    p_cliestcodigo int(11),
                                    p_clidtcadastro date,
                                    p_clidtdesativacao date)
begin
    declare  v_existe_bairro, v_existe_cliente, v_existe_estado, v_sexo_valido, v_cliente_ativo, v_existe_cliente_indicado boolean default false;
    if (select count(*) 
		from cliente) > 0 then
        set v_existe_cliente = TRUE;
        if (select count(*) 
			from cliente
            where clicodigo=p_clicodigo) > 0 then
			set v_existe_cliente_indicado = TRUE;
            if (select clidtdesativacao 
				from cliente
				where clicodigo=p_clicodigo) is null then
				set v_cliente_ativo = TRUE;
			end if;
		end if;
	end if;
    if (select count(*) 
		from bairro
        where baicodigo=p_clibaicodigo) > 0 then
        set v_existe_bairro = TRUE;
	end if;
    if (select count(*) 
		from estadocivil
        where estcodigo=p_cliestcodigo) > 0 then
        set v_existe_estado = TRUE;
	end if;
    if p_clisexo in ('M', 'F') then
        set v_sexo_valido = TRUE;
	end if;
    if (select count(*) 
		from estadocivil
        where estcodigo=p_cliestcodigo) > 0 then
        set v_sexo_valido = TRUE;
	end if;
    -- Inserção=1; Atualização=2; Deleção=3
    if not(p_operacao=1) then
		if NOT(p_operacao=2) then
			if not(p_operacao=3) then
				select 'A operação solicitada não existe' as Resposta;
            else
				if v_existe_cliente is not true then
					select 'Não existem clientes cadastrados' as Resposta;
				else
					if v_existe_cliente_indicado is not true then
						select 'O cliente indicado não existe' as Resposta;
					else
						delete from clientestatus where csclicodigo=p_clicodigo;
                        delete from venda where venclicodigo=p_clicodigo;
						delete from cliente where clicodigo=p_clicodigo;
					end if;
				end if;
			end if;
        else
			if v_existe_cliente is not true then
				select 'Não existem clientes cadastrados' as Resposta;
			else
				if v_existe_cliente_indicado is not true then
					select 'O cliente indicado não existe' as Resposta;
				else
					if v_existe_bairro is not true then
						select 'O bairro indicado não existe' as Resposta;
					else
						if v_sexo_valido is not true then
							select 'O sexo indicado é inválido' as Resposta;
						else
							if v_existe_estado is not true then
								select 'O estado indicado não existe' as Resposta;
							else 
								update cliente
								set clisexo=p_clisexo,
									clirendamensal=p_clirendamensal,
                                    clinome=p_clinome,
                                    clibaicodigo=p_clibaicodigo,
                                    clifone=p_clifone,
                                    cliestcodigo=p_cliestcodigo,
                                    clidtdesativacao=p_clidtdesativacao
                                where clicodigo=p_clicodigo;
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
    else
		if v_existe_bairro is not true then
			select 'O bairro indicado não existe' as Resposta;
		else
			if v_sexo_valido is not true then
				select 'O sexo indicado é inválido' as Resposta;
			else
				if v_existe_estado is not true then
					select 'O estado indicado não existe' as Resposta;
				else 
					INSERT INTO cliente(clisexo,clirendamensal,clinome,clibaicodigo,clifone,cliestcodigo,clidtcadastro,clidtdesativacao) 
                    VALUES (p_clisexo,p_clirendamensal,p_clinome,p_clibaicodigo,p_clifone,p_cliestcodigo,curdate(),p_clidtdesativacao);
				end if;
			end if;
		end if;
    end if;
end ##
delimiter ;

call sp_gestao_cliente(1,null,'M',2500.00,'Fulano',1,9284972085,1,null,null);

call sp_gestao_cliente(2,603,'M',6500.00,'Fulano_atualizado',1,9284972085,1,null,null);

call sp_gestao_cliente(3,604,null,null,null,null,null,null,null,null);

select * from cliente;

/*
3) Mostre o total de vendas por sexo de clientes e forma de pagamento.
*/

delimiter ##
create procedure sp_total_vendas_sexo_fpagamento()
begin
    declare  v_existe_venda, v_existe_cliente boolean default false;
    if (select count(*) 
		from venda) > 0 then
        set v_existe_venda = TRUE;
	end if;
    if (select count(*) 
		from cliente) > 0 then
        set v_existe_cliente = TRUE;
	end if;
    if v_existe_cliente is not true then
		select 'Não existem clientes cadastrados' as resposta;
    else
			if	v_existe_venda is not true then
				select 'Não existem vendas cadastradas' as resposta;
			else
				select clisexo 'Sexo do cliente', fpgdescricao 'Forma de pagamento', count(*)
				from cliente
				join venda on clicodigo=venclicodigo
				join formapagamento on vendformapagamento=fpgcodigo
				group by clisexo, fpgdescricao;
			end if;
	end if;
end ##
delimiter ;

CALL sp_total_vendas_sexo_fpagamento();

/*
4) Mostre o nome e saldo do(s) produto(s) mais vendido de um determinado grupo de produtos
(parâmetro).
*/

delimiter ##
create procedure sp_produtos_saldo(p_grpcodigo int(11))
begin
    declare v_existe_produto, v_existe_venda, v_existe_grupo boolean default false;
    if (select count(*) 
		from produto) > 0 then
        set v_existe_produto = TRUE;
	end if;
    if (select count(*) 
		from venda) > 0 then
        set v_existe_venda = TRUE;
	end if;
    if (select count(*) 
		from grupoproduto) > 0 then
        set v_existe_grupo = TRUE;
	end if;
    if v_existe_grupo is not true then
		select 'Não existem grupos de produtos cadastrados' as resposta;
    else
		if v_existe_produto is not true then
			select 'Não existem produtos cadastrados' as resposta;
		else
			if	v_existe_venda is not true then
				select 'Não existem vendas cadastradas' as resposta;
			else
				select pronome 'Nome do produto', prosaldo 'Saldo do produto'
				from venda
				join itemvenda on vencodigo=itvvencodigo
				join produto on itvprocodigo=procodigo
				join grupoproduto on progrpcodigo=grpcodigo
				where grpcodigo=p_grpcodigo
				and pronome in (select pronome
								from venda
								join itemvenda on vencodigo=itvvencodigo
								join produto on itvprocodigo=procodigo
								join grupoproduto on progrpcodigo=grpcodigo
								where grpcodigo=p_grpcodigo
								group by itvqtde, pronome
								order by sum(itvqtde) desc)
				group by pronome, prosaldo
				having sum(itvqtde)=(select sum(itvqtde)
									from venda
									join itemvenda on vencodigo=itvvencodigo
									join produto on itvprocodigo=procodigo
									join grupoproduto on progrpcodigo=grpcodigo
									where grpcodigo=p_grpcodigo
									group by pronome
									order by sum(itvqtde)
									limit 1);
			end if;
		end if;
	end if;
end ##
delimiter ;

call sp_produtos_saldo(2);

/*
5) Mostre o nome e saldo do(s) produto(s) menos vendido para clientes de um determinado sexo
(parâmetro 1) e de um estado civil (parâmetro 2).
*/

delimiter ##
create procedure sp_produtos_saldo_sexo_estado(p_clisexo char(1), p_cliestcodigo int(11))
begin
    declare v_existe_produto, v_existe_venda, v_existe_cliente boolean default false;
    if (select count(*) 
		from produto) > 0 then
        set v_existe_produto = TRUE;
	end if;
    if (select count(*) 
		from venda) > 0 then
        set v_existe_venda = TRUE;
	end if;
    if (select count(*) 
		from cliente) > 0 then
        set v_existe_cliente = TRUE;
	end if;
    if v_existe_cliente is not true then
		select 'Não existem clientes cadastrados' as resposta;
    else
		if v_existe_produto is not true then
			select 'Não existem produtos cadastrados' as resposta;
		else
			if	v_existe_venda is not true then
				select 'Não existem vendas cadastradas' as resposta;
			else
				select pronome 'Nome do produto', prosaldo 'Saldo do produto'
				from cliente
				join venda on clicodigo=venclicodigo
				join itemvenda on vencodigo=itvvencodigo
				join produto on itvprocodigo=procodigo
				where clisexo=p_clisexo 
				and cliestcodigo=p_cliestcodigo
				and pronome in (select pronome
								from cliente
								join venda on clicodigo=venclicodigo
								join itemvenda on vencodigo=itvvencodigo
								join produto on itvprocodigo=procodigo
								where clisexo=p_clisexo 
								and cliestcodigo=p_cliestcodigo
								group by pronome, prosaldo
								having sum(itvqtde)=( select sum(itvqtde)
													from cliente
													join venda on clicodigo=venclicodigo
													join itemvenda on vencodigo=itvvencodigo
													join produto on itvprocodigo=procodigo
													where clisexo=p_clisexo 
													and cliestcodigo=p_cliestcodigo
													group by pronome
													order by sum(itvqtde)
													limit 1))
				group by pronome, prosaldo;
			end if;
		end if;
	end if;
end ##
delimiter ;

call sp_produtos_saldo_sexo_estado('M', 1);

/*
6) Mostre os nomes dos clientes que tenham gerado mais de uma venda e que tenham os nomes
iniciando com determinada letra (parâmetro).
*/

INSERT INTO `venda` VALUES (1000,'2006-01-05',1,1,1,NULL,1,1);
INSERT INTO `venda` VALUES (1001,'2006-01-06',1,21,1,NULL,1,1);
INSERT INTO `venda` VALUES (1002,'2006-01-06',1,21,1,NULL,1,1);


delimiter ##
create procedure sp_compras_cliente(p_primeira_letra char(1))
begin
    declare v_existe_cliente, v_existe_venda boolean default false;
    if (select count(*) 
		from cliente) > 0 then
        set v_existe_cliente = TRUE;
	end if;
    if (select count(*) 
		from venda) > 0 then
        set v_existe_venda = TRUE;
	end if;
	if v_existe_cliente is not true then
		select 'Não existem clientes cadastrados' as resposta;
    else
		if	v_existe_venda is not true then
			select 'Não existem vendas cadastradas' as resposta;
        else
			select clinome 'Nome do Cliente', count(*) 'Número de compras'
			from cliente 
			join venda on venclicodigo=clicodigo
			where left(clinome,1)=p_primeira_letra
			group by clinome
            having count(*)>1
			order by count(*) desc;
		end if;
    end if;
end ##
delimiter ;

call sp_compras_cliente('G');

/*
7) Mostre a maior renda de cliente para uma zona (parâmetro);
*/

delimiter ##
create procedure sp_maior_renda_zona(
					p_zoncodigo int(11))
begin
    declare v_zona_existe, v_zona_existe_cliente boolean default false;
    
    set v_zona_existe = (select count(*) 
						from zona 
						where zoncodigo=p_zoncodigo);
	if (select count(*) 
		from zona 
        join bairro on baizoncodigo=zoncodigo 
        join cliente on clibaicodigo=baicodigo 
        where zoncodigo=p_zoncodigo) > 0 then
        set v_zona_existe_cliente = TRUE;
	end if;
    
    if v_zona_existe is not true then
		select 'A zona indicada não existe' as resposta;
    else 
        if v_zona_existe_cliente is not true then
			select 'A zona indicada não possui clientes cadastrados' as resposta;
		else
			select zonnome 'Nome da Zona', max(clirendamensal) 'Maior Renda' 
            from cliente 
            join bairro on clibaicodigo=baicodigo 
            join zona on baizoncodigo=zoncodigo 
            where zoncodigo=p_zoncodigo
            group by zonnome;
        end if;
	end if;
end ##
delimiter ;


/*
8) Para cada cliente, mostre seu nome e a data da primeira venda realizada.
*/

delimiter ##
create procedure sp_primeira_compra_cliente()
begin
    declare v_existe_cliente, v_existe_venda boolean default false;
    if (select count(*) 
		from cliente) > 0 then
        set v_existe_cliente = TRUE;
	end if;
    if (select count(*) 
		from venda) > 0 then
        set v_existe_venda = TRUE;
	end if;
	if v_existe_cliente is not true then
		select 'Não existem clientes cadastrados' as resposta;
    else
		if	v_existe_venda is not true then
			select 'Não existem vendas cadastradas' as resposta;
        else
			select clinome 'Nome do Cliente', min(vendata) 'Data da primeira compra' 
			from cliente 
			join venda on venclicodigo=clicodigo
			group by clinome
			order by clinome;
		end if;
    end if;
end ##
delimiter ;