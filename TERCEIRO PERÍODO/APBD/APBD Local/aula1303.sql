use bd2024;
set global log_bin_trust_function_creators=1;
desc bairro;
/*
DELIMITER ##
CREATE TRIGGER  AFTER UPDATE ON 
FOR EACH ROW
BEGIN
    
END; ##
DELIMITER ;
*/

DELIMITER ##
CREATE TRIGGER tg_alterar_qtde_moradores AFTER insert ON cliente 
FOR EACH ROW
BEGIN
    update bairro 
    set baiqtdepessoas = baiqtdepessoas+1
    where baicodigo=new.clibaicodigo;
END; ##
DELIMITER ;
drop trigger tg_alterar_qtde_moradores;

select baicodigo,bainome,baiqtdepessoas from bairro where baicodigo = 2;
select baicodigo,bainome,baiqtdepessoas from bairro where baicodigo = 3;

INSERT INTO cliente(clisexo,clirendamensal,clinome,clibaicodigo,clifone,cliestcodigo,clidtcadastro) VALUES ('M',2650.00,'GANDERSON DOS TESTES',2,'',1,NULL);


-- 1) Trigger para moniorar mudança de bairro de funcionários;
DELIMITER ##
CREATE TRIGGER tg_mudança_bairro_funcionario AFTER UPDATE ON funcionario
FOR EACH ROW
BEGIN
	if not new.funbaicodigo = old.funbaicodigo then
		update bairro 
		set baiqtdepessoas = baiqtdepessoas+1
		where baicodigo=new.funbaicodigo;
        
        update bairro 
		set baiqtdepessoas = baiqtdepessoas-1
		where baicodigo=old.funbaicodigo;
	end if;
END; ##
DELIMITER ;
drop trigger tg_mudança_bairro_funcionario;
select * from funcionario where funcodigo=606;
update funcionario 
set funbaicodigo=3
where funcodigo=1;


-- 2)
--  a) Trigger para monitorar exclusão de cliente;
DELIMITER ##
CREATE TRIGGER tg_exclusao_cliente before delete ON cliente 
FOR EACH ROW
BEGIN
	update bairro 
	set baiqtdepessoas = baiqtdepessoas-1
	where baicodigo=old.clibaicodigo;
    delete from clientestatus where csclicodigo=old.clicodigo;
	delete from venda where venclicodigo=old.clicodigo;
END; ##
DELIMITER ;
drop trigger tg_exclusao_cliente;
select * from cliente where clicodigo=606;
delete from cliente where clicodigo=605;

delimiter ##
create procedure sp_desativa_cliente(in p_clicodigo int)
begin
    update cliente 
    set clidtdesativacao = current_date()
    where clicodigo=p_clicodigo;
end ##
delimiter ;
drop procedure sp_desativa_cliente;
-- b) Trigger para impedir a exclusão de cliente;
DELIMITER ##
CREATE TRIGGER tg_desativacao_cliente after update ON cliente 
FOR EACH ROW
BEGIN
	if old.clidtdesativacao is null and new.clidtdesativacao is not null then
		update bairro 
		set baiqtdepessoas = baiqtdepessoas-1
		where baicodigo=old.clibaicodigo;
    end if;
END; ##
DELIMITER ;
drop trigger tg_desativacao_cliente;
select * from cliente where clicodigo=606;
update cliente set clidtdesativacao=current_date() where clicodigo=606;
update bairro set baiqtdepessoas=baiqtdepessoas+1 where baicodigo=2;




-- 3) Trigger para atualizar slado de estoque no caso de vanda de produto.

DELIMITER ##
CREATE TRIGGER tg_controle_estoque AFTER insert ON venda
FOR EACH ROW
BEGIN
	update produto
    set prosaldo = prosaldo-new.itvqtde
    where procodigo=new.itvprocodigo;
END; ##
DELIMITER ;
drop trigger tg_controle_estoque;
delete from itemvenda where itvprocodigo=2 and itvvencodigo=1;

select * from venda where vencodigo=1;
select * from itemvenda where itvvencodigo=1;
select * from produto where procodigo=2;
update produto set prosaldo=23 where procodigo=2;


-- ---------------------------------
--  Trigger para cancelar venda de produto caso não haja saldo de estoque dele.
DELIMITER ##
CREATE TRIGGER tg_valida_estoque before insert ON itemvenda
FOR EACH ROW
BEGIN
	declare v_saldo int;
    set v_saldo = (select prosaldo from produto where procodigo=new.itvprocodigo);
    if v_saldo < new.itvqtde then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não existe saldo suficiente desse produto em estoque';
	else
		update produto
		set prosaldo = prosaldo-new.itvqtde
		where procodigo=new.itvprocodigo;	
    end if;
END; ##
DELIMITER ;
drop TRIGGER tg_valida_estoque;
update produto set prosaldo=4 where procodigo=2;
insert into itemvenda values (1,2,5);
