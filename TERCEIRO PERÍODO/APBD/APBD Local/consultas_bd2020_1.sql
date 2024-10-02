use bd2020;

select ger.funcodigo, ger.funnome, sub.funcodigo, sub.funnome
from funcionario sub
join funcionario ger 
	on ger.funcodigo=sub.funcodgerente
order by ger.funcodigo;

select ger.funcodigo, ger.funnome, count(*) as "Total de Subordinados"
from funcionario sub
join funcionario ger 
	on ger.funcodigo=sub.funcodgerente
group by ger.funcodigo, ger.funnome;

update cliente c
set c.clirendamensal=1207.00
where c.clicodigo=528;

select clicodigo, clinome, count(*)
from cliente
where clinome = "Marcelo Chamy Machado";

select clinome, clirendamensal
from cliente
where clirendamensal=(select min(clirendamensal)
						from cliente)
order by clinome;

select clinome, clirendamensal
from cliente
where clirendamensal>=(select avg(clirendamensal)
						from cliente)
order by clinome;

select clinome, clirendamensal
from cliente
where clirendamensal<(select avg(clirendamensal)
						from cliente)
order by clinome;



desc cliente;


select left('BANCO DE DADOS', 4) 'LEFT'; 
select right('BANCO DE DADOS', 4) 'RIGHT'; 
select substring('BANCO DE DADOS', 4) 'SUBSTRING 1'; 
select substring('BANCO DE DADOS', 4, 5) 'SUBSTRING 2'; 
select locate('B', 'BANCO DE DADOS') 'LOCATE';
select length('BANCO DE DADOS') 'LENGTH';
select concat('Quantidade de letras:', convert (length('BANCO DE DADOS'), char)) 'CONCAT';

select right(left('BANCO DE DADOS', 10), 4) 'LEFT-RIGHT'; 

select clinome, left(clinome,5) 'left'
from cliente; 

select clinome
from cliente
where left(clinome,1)='a';

select clinome, left(clinome, locate(' ', clinome)-1) as 'Primeiro nome', locate(' ', clinome)-1 'Quantidades de letras no primeiro nome'
from cliente; 

select clinome 'Nome do Cliente', reverse(left(reverse(clinome), locate(' ', reverse(clinome))-1)) 'Último nome', locate(' ', reverse(clinome))
from cliente;

select clinome 'Nome do Cliente', reverse(left(reverse(clinome), locate(' ', reverse(clinome))-1)) 'Último nome', locate(' ', reverse(clinome))
from cliente;
-- (length(clinome)-locate(' ', reverse(clinome)))
select clinome 'Nome do Cliente', substring(clinome, locate(' ', clinome)+1, ((length(clinome)-locate(' ', clinome))-locate(' ', reverse(clinome))))
from cliente;
-- (length(substring(clinome, locate(' ', clinome)))-(locate('', substring(clinome, locate(' ', clinome)))))
select clinome 'Nome do Cliente', left(right(clinome, (length(clinome)-locate(' ', clinome))), locate(' ', right(clinome, (length(clinome)-locate(' ', clinome)))))
from cliente;

select clinome, right(clinome, (length(clinome)-locate(' ', clinome)))
from cliente;

SELECT 
    left(right(fundtdem, (length(fundtdem)-locate('-', fundtdem))), locate('-', right(fundtdem, (length(fundtdem)-locate('-', fundtdem))))-1)
FROM
    funcionario
WHERE
    fundtdem IS NOT NULL;

select concat(reverse(left(reverse(fundtdem), locate('-', reverse(fundtdem))-1)),'/', left(right(fundtdem, (length(fundtdem)-locate('-', fundtdem))), locate('-', right(fundtdem, (length(fundtdem)-locate('-', fundtdem))))-1),'/',left(fundtdem, locate('-', fundtdem)-1))
from funcionario
where fundtdem is not null;


