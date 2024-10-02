-- stored procedure
## Aula 28/02/2024
use bd2020;

delimiter ##
create procedure sp_lista_bairro()
begin
    select bainome, clinome
    from bairro
    inner join cliente
        on baicodigo = clibaicodigo;
end ##
delimiter ;

call sp_lista_bairro()

delimiter ##
create procedure sp_cliente_por_bairro(
                                        p_bairro varchar(30))
    begin
    select bainome, clinome
    from bairro
    inner join cliente
        on baicodigo = clibaicodigo
    where bainome = p_bairro;
end ##
delimiter ;

call sp_cliente_por_bairro('centro');
/*
delimiter ##
create procedure sp_cliente_por_bairrosexo(
                                        p_bairro varchar(30),
                                        p_sexo char(1))
    begin
    select bainome, clinome, clisexo
    from bairro
    inner join cliente
        on baicodigo = clibaicodigo
    where bainome = p_bairro
    and clisexo = p_sexo;
end ##
delimiter ;

call sp_cliente_por_bairrosexo('parque 10','f');]

delimiter ##
	create procedure sp_cliente_por_bairro_sexo(
												p_bairro varchar(30), 
                                                p_sexo char(1))
		begin   
		   declare v_achou_bairro boolean default false;
           set v_achou_bairro = (select count(*)
								from bairro
                                where bainome=p_bairro);
			if v_achou_bairro then
				select bainome, clinome
				from bairro
				inner join cliente on baicodigo= clibaicodigo
				where bainome = p_bairro
				and clisexo = p_sexo;
            else 
				select 'Bairro inexistente' as resposta;
            end if;
	end ##
delimiter ;
*/

select clisexo
							from cliente
                            inner join bairro
                            on baicodigo= clibaicodigo
                            group by clisexo
                            limit 2;

delimiter ##
	create procedure sp_cliente_por_bairro_sexo(
												p_bairro varchar(30), 
                                                p_sexo char(1))
		begin   
		   declare v_achou_bairro, v_achou_sexo boolean default false;
           set v_achou_bairro = (select count(*)
								from bairro
                                where bainome=p_bairro);
            if p_sexo in ('M', 'F') then
				if p_sexo = (select clisexo
							from cliente
                            inner join bairro
                            on baicodigo= clibaicodigo
                            where bainome=p_bairro
                            group by clisexo
                            order by clisexo
                            limit 1
                            ) then
					set v_achou_sexo = true;
				else
					if p_sexo = (select clisexo
							from cliente
                            inner join bairro
                            on baicodigo= clibaicodigo
                            where bainome=p_bairro
                            group by clisexo
                            order by clisexo
                            limit 1
                            ) then
						set v_achou_sexo = true;
					else
						select 'Não possuem clientes desse sexo nesse bairro' as resposta;
                    end if;
				end if;
            else
				select 'Sexo inválido' as resposta;
            end if;
			if v_achou_bairro and v_achou_sexo then
				select bainome as 'Nome do bairro', clinome as 'Nome do cliente', clisexo as 'Sexo do cliente'
				from bairro
				inner join cliente on baicodigo= clibaicodigo
				where bainome = p_bairro
				and clisexo = p_sexo;
            else 
				if not v_achou_bairro and not v_achou_sexo then
					select 'Bairro inexistente e sexo inválido' as resposta;
				else 
					if  not v_achou_bairro then
						select 'Bairro inexistente' as resposta;
					else 
						select 'Sexo inválido' as resposta;
                    end if;
				end if;
            end if;
	end ##
delimiter ;

select * from bairro;

call sp_cliente_por_bairro_sexo('PONTA NEGRA', 'F');

/*
	Crie uma so para alterar o slário de um funcionário
    obs: caso ele esteja demoitido retornar erro
    não pode diminuir o salário
*/
select * from funcionario;
select count(*) from funcionario where funcodigo=1;
select fundtdem from funcionario where funcodigo=1 and fundtdem is null;
delimiter ##
	create procedure sp_alterar_salario_funcionario(p_codigo int(11),p_salario double(6,2))
		begin   
			declare v_achou_funcionario, v_funcionario_ativo boolean default false;
            declare v_data_demissao date default null;
            set v_data_demissao = (select fundtdem 
									from funcionario 
									where funcodigo=p_codigo);
            set v_achou_funcionario = (select count(*) 
										from funcionario 
                                        where funcodigo=p_codigo);
			if not v_achou_funcionario then
				select 'Funcionario não cadastrado' as resposta;
			else
				if v_data_demissao is null then
					set v_funcionario_ativo = true;
                    if p_salario < (select funsalario 
									from funcionario 
									where funcodigo=p_codigo) then
						select 'Não é possível diminuir o salário de um funcionário' as resposta;
					else 
						if p_salario > (select funsalario 
										from funcionario 
										where funcodigo=p_codigo) then
							update funcionario set funsalario=p_salario where funcodigo=p_codigo;
							select 'Salário do funcionario alterado' as resposta;
						else 
							if p_salario = (select funsalario 
										from funcionario 
										where funcodigo=p_codigo) then
							select 'Esse já é o salário do funcionário' as resposta;
							end if;
						end if;
					end if;
				else
					select 'Funcionário demitido' as resposta;
				end if;
			end if;
		end ##
delimiter ;

