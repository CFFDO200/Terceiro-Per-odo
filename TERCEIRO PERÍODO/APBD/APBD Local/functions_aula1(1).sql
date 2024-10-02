/*
delimiter ##
create function f_() returns boolean
begin
	
end ##
delimiter ;
*/

delimiter ##
create function f_cliente_existe() returns boolean
begin
	if (select count(*) 
			from cliente)>0 then
		return true;
    else
		return false;
	end if;
end ##
delimiter ;

select f_cliente_existe();

delimiter ##
create function f_cliente_indicado_existe(p_clicodigo int(11)) returns boolean
begin
	if (select count(*) 
			from cliente
            where clicodigo=p_clicodigo)>0 then
		return true;
    else
		return false;
	end if;
end ##
delimiter ;

select f_cliente_indicado_existe(1);

delimiter ##
create function f_renda_valida(p_clicodigo int(11), p_rendamensal double(6,2)) returns boolean
begin
	if (select clirendamensal from cliente where clicodigo=p_clicodigo)>p_rendamensal then
		return false;
	else
		return true;
	end if;
end ##
delimiter ;

select f_renda_valida(1, 2000.0);
select * from cliente;

delimiter ##
create function f_renda_maior_zero(p_rendamensal double(6,2)) returns boolean
begin
	if p_rendamensal>0.0 then
		return true;
	else
		return false;
	end if;
end ##
delimiter ;

delimiter ##
create function f_bairro_existe(p_clibaicodigo int(11)) returns boolean
begin
	if (select count(*) 
			from bairro
			where baicodigo=p_clibaicodigo)>0 then
		return true;
	else
		return false;
	end if;
end ##
delimiter ;

delimiter ##
create function f_valida_estadocivil(p_estcivil int(11)) returns boolean
begin
	if (select count(*) 
			from estadocivil 
            where estcodigo=p_estcivil)>0 then
		return true;
	else
		return false;
	end if;
end ##
delimiter ;

delimiter ##
create function f_valida_sexo(p_clisexo char(1)) returns boolean
begin
	return p_clisexo in ('M', 'F');
end ##
delimiter ;

