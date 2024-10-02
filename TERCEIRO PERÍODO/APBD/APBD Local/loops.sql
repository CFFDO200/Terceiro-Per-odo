delimiter ##
create procedure sp_contador(p_numero tinyint)
begin
	declare v_cont tinyint unsigned default 0;
    while(v_cont<=p_numero) do
		select v_cont;
        set v_cont= v_cont+1;
    end while;
end ##
delimiter ;

/*
delimiter ##
create procedure sp_()
begin
	
end ##
delimiter ;
*/


-- Exercício(SP)
/*
	Crie Sps para:
		1 - Receber uma string e retornar o conteúdo de cada posição desta; 
        2 - Receber uma string e retornar somente as vogais contidas nela. EX: 'LKSFGOLAHFLAHGIHA;AKGLAEKHGOIHQ;ALGHAIOG'
        3 - Receber um conjunto de caracteres e retornar somente os números contidos nessas string. EX:'a-T-3-5-j-L'; 
        4 - Receber um conjunto de números e retornar somente os números pares;
*/
-- 1:
delimiter ##
create procedure sp_conteudo_string(p_string varchar(1000))
begin
	declare v_cont tinyint unsigned default 1;
    declare v_conteudo_posicao char(1);
    declare v_tamanho_string tinyint unsigned default 0;
    set v_tamanho_string=length(p_string);
	while(v_cont<=v_tamanho_string) do
		set v_conteudo_posicao=left(p_string,1);
		select (concat('Conteúdo da posição ', convert(v_cont,char),': ',v_conteudo_posicao,';')) as resposta;
        set p_string=right(p_string, (length(p_string)-1));
        set v_cont= v_cont+1;
    end while;
end ##
delimiter ;
call sp_conteudo_string('teste');

-- 2:
delimiter ##
create procedure sp_vogais_string(p_string varchar(1000))
begin
	declare v_cont tinyint unsigned default 1;
    declare v_conteudo_posicao char(1);
    declare v_tamanho_string tinyint unsigned default 0;
    set v_tamanho_string=length(p_string);
	while(v_cont<=v_tamanho_string) do
		set v_conteudo_posicao=left(p_string,1);
        if v_conteudo_posicao in ('a','e','i','o','u','A','E','I','O','U') then
			select (concat('Conteúdo da posição ', convert(v_cont,char),': ',v_conteudo_posicao,';')) as resposta;
        end if;
		set p_string=right(p_string, (length(p_string)-1));
		set v_cont= v_cont+1;
    end while;
end ##
delimiter ;
call sp_vogais_string('teste');

-- 3

delimiter ##
create procedure sp_numeros_string(p_string varchar(1000))
begin
	declare v_cont tinyint unsigned default 1;
    declare v_conteudo_posicao char(1);
    declare v_tamanho_string tinyint unsigned default 0;
    set v_tamanho_string=length(p_string);
	while(v_cont<=v_tamanho_string) do
		set v_conteudo_posicao=LEFT(p_string, LOCATE('-', p_string) - 1);
        if v_conteudo_posicao in ('a','e','i','o','u','A','E','I','O','U') then
			select (concat('Conteúdo da posição ', convert(v_cont,char),': ',v_conteudo_posicao,';')) as resposta;
        end if;
		set p_string=right(p_string, (length(p_string)-1));
		set v_cont= v_cont+1;
    end while;
end ##
delimiter ;
call sp_numeros_string('teste');

-- 4
delimiter ##
create procedure sp_pares_numeros(p_string varchar(1000))
begin
	declare v_cont, v_cont_char_esp  tinyint unsigned default 1;
    declare v_conteudo_posicao int;
    declare v_string_resultado, v_string_aux varchar(1000) default '';
    declare v_tamanho_string tinyint unsigned default 0;
    set v_tamanho_string=length(p_string);
    set v_string_aux=p_string;
    while(v_cont<=v_tamanho_string) do
		select v_string_aux, LOCATE('-', v_string_aux) as resposta_locate;
        if LOCATE('-', v_string_aux)=1 then
			set v_cont_char_esp=v_cont_char_esp+1;
        end if;
        SET v_string_aux = right(v_string_aux, length(v_string_aux)-1);
        set v_cont=v_cont+1;
    end while;
    set v_cont_char_esp=v_cont_char_esp-1;
    set v_cont=1;
	while(v_cont<=(v_tamanho_string-v_cont_char_esp)) do
		set v_conteudo_posicao=cast(LEFT(p_string, LOCATE('-', p_string) - 1) as signed int);
        if (v_conteudo_posicao%2)=0 then
			set v_string_resultado=concat(v_string_resultado,convert(v_conteudo_posicao,char),'-');
        end if;
        if v_cont=(v_tamanho_string-v_cont_char_esp) then
			set v_string_resultado=left(v_string_resultado,length(v_string_resultado)-1);
		else
			SET p_string = SUBSTRING(p_string, LOCATE('-', p_string) + 1);
		end if;
		set v_cont=v_cont+1;
        
    end while;
    select v_string_resultado, v_cont as resposta;
end ##
delimiter ;

drop procedure sp_pares_numeros;
call sp_pares_numeros('1-2-3-4-5-6-7-8-');
select cast(LEFT('1-2-3-4-5-6-7-8-', LOCATE('-', '1-2-3-4-5-6-7-8-') - 1) as signed int)%2;
select SUBSTRING('1-2-3-4-5-6-7-8-', LOCATE('-', '1-2-3-4-5-6-7-8-') + 1);
select concat('',convert(1,char),'-');

