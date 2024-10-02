USE bd2024;

SHOW TABLES;

SELECT *
FROM cliente;

DESC cliente;

SELECT COUNT(*)
from cliente;

-- cliente DO sexo feminino com renda mensal maior que R$2000,00
SELECT *
FROM cliente
WHERE clisexo='F' AND clirendamensal >= 2000.00;

-- Qual o bairro desses clientes?

SELECT clinome, bainome
FROM cliente
INNER JOIN bairro ON clibaicodigo=baicodigo
WHERE clisexo='F' AND clirendamensal >= 2000.00;

SELECT distinct(bainome)
FROM cliente
INNER JOIN bairro ON clibaicodigo=baicodigo
WHERE clisexo='F' AND clirendamensal >= 2000.00
ORDER BY bainome;

SELECT clinome
FROM cliente
INNER JOIN bairro ON clibaicodigo=baicodigo
WHERE clisexo='F' AND clirendamensal >= 2000.00 AND bainome IN ('ALEIXO', 'PLANALTO', 'PONTA NEGRA')
ORDER BY clinome;

SELECT bainome AS 'Bairro', COUNT(*) AS 'Total de Clientes'
FROM cliente
INNER JOIN bairro ON clibaicodigo=baicodigo
GROUP BY bainome
ORDER BY bainome;

SELECT bainome AS 'Bairro', COUNT(*) AS 'Total de Clientes'
FROM cliente
INNER JOIN bairro ON clibaicodigo=baicodigo
GROUP BY bainome
HAVING COUNT(*)>=49
ORDER BY bainome;

-- mostrar nomes, rendas e sexo dos clientes que tem nome iniciando com 'A' e terminando com 'o'

SELECT clinome AS 'Nome', clirendamensal AS 'Renda Mensal', clisexo AS 'Sexo'
FROM cliente 
WHERE clinome LIKE 'A%o'
ORDER BY clinome;

SELECT bainome AS 'Bairro', COUNT(*) AS 'Total de Clientes'
FROM cliente
INNER JOIN bairro ON clibaicodigo=baicodigo
GROUP BY bainome
ORDER BY bainome;

SELECT bainome, clicodigo
FROM bairro 
LEFT OUTER JOIN cliente ON baicodigo = clicodigo
where clicodigo IS NULL;

SELECT bainome 
FROM bairro
WHERE baicodigo NOT IN(SELECT clibaicodigo
								FROM cliente);
								
SELECT ger.funcodigo AS 'Código do Gerente', ger.funnome AS 'Nome do Gerente', sub.funcodgerente AS 'Código do Gerente do Subordinado', sub.funnome AS 'Nome Subordinado'
FROM funcionario ger
INNER JOIN funcionario sub ON ger.funcodigo=sub.funcodgerente
ORDER BY ger.funnome;

SELECT ger.funcodigo AS 'Código do Gerente', ger.funnome AS 'Nome do Gerente', COUNT(*) AS 'Total de Subordinados'
FROM funcionario ger
INNER JOIN funcionario sub ON ger.funcodigo=sub.funcodgerente
GROUP BY ger.funcodigo
ORDER BY ger.funcodigo;

