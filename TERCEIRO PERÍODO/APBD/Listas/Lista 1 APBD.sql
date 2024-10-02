USE bd2024;

-- PARTE II

-- QUESTÃO 1
ALTER TABLE funcionario ADD COLUMN fundtnascto DATE;
ALTER TABLE funcionario ADD COLUMN fundtadmissao DATE;
ALTER TABLE funcionario ADD COLUMN funsexo CHAR(1);

-- QUESTÃO 2
ALTER TABLE venda ADD COLUMN vendtcancelamento DATE;

-- QUESTÃO 3
CREATE TABLE formapagamento(
    fpgcodigo SMALLINT NOT NULL,
    fpgdescricao VARCHAR(80) NOT NULL,
    fpgativo BOOLEAN NOT NULL
);

-- QUESTÃO 4
ALTER TABLE venda ADD COLUMN vendformapagamento SMALLINT;

ALTER TABLE formapagamento ADD PRIMARY KEY (fpgcodigo);

ALTER TABLE venda ADD FOREIGN KEY (vendformapagamento)
REFERENCES formapagamento (fpgcodigo);
INSERT INTO formapagamento (fpgcodigo, fpgdescricao, fpgativo) VALUES 
('1', 'Dinheiro em especie', TRUE),
('2', 'Cartão de Credito', TRUE),
('3', 'Cartão de Debito', TRUE),
('4', 'Pix', TRUE);
-- QUESTÃO 5
update venda set vendformapagamento=1 where vendformapagamento is null;
ALTER TABLE venda MODIFY vendformapagamento SMALLINT NOT NULL;

-- QUESTÃO 6

alter table venda
add constraint foreign key(vendformapagamento)
references formapagamento(fpgcodigo);

SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS=0;
UPDATE venda SET vendformapagamento ='1' WHERE vendformapagamento IS NULL;

-- QUESTÃO 7
UPDATE funcionario SET funsexo = 'M' WHERE funcodigo = '1';
UPDATE funcionario SET funsexo = 'M' WHERE funcodigo = '2';
UPDATE funcionario SET funsexo = 'M' WHERE funcodigo = '3';
UPDATE funcionario SET funsexo = 'F' WHERE funcodigo = '4';
UPDATE funcionario SET funsexo = 'F' WHERE funcodigo = '5';
UPDATE funcionario SET funsexo = 'M' WHERE funcodigo = '6';
UPDATE funcionario SET funsexo = 'F' WHERE funcodigo = '7';
UPDATE funcionario SET funsexo = 'F' WHERE funcodigo = '8';
UPDATE funcionario SET funsexo = 'M' WHERE funcodigo = '9';
UPDATE funcionario SET funsexo = 'M' WHERE funcodigo = '10';

-- QUESTÃO 8
UPDATE funcionario SET fundtnascto = '1980-01-12' WHERE funcodigo = '1';
UPDATE funcionario SET fundtnascto = '1985-01-14' WHERE funcodigo = '2';
UPDATE funcionario SET fundtnascto = '1990-01-07' WHERE funcodigo = '3';
UPDATE funcionario SET fundtnascto = '1995-04-24' WHERE funcodigo = '4';
UPDATE funcionario SET fundtnascto = '2000-12-23' WHERE funcodigo = '5';
UPDATE funcionario SET fundtnascto = '1989-11-15' WHERE funcodigo = '6';
UPDATE funcionario SET fundtnascto = '1994-06-24' WHERE funcodigo = '7';
UPDATE funcionario SET fundtnascto = '1998-07-20' WHERE funcodigo = '8';
UPDATE funcionario SET fundtnascto = '1993-03-03' WHERE funcodigo = '9';
UPDATE funcionario SET fundtnascto = '1997-02-15' WHERE funcodigo = '10';


-- QUESTÃO 9
INSERT INTO funcionario(funcodigo, funnome, funsalario, funbaicodigo, funcodgerente, funestcodigo, fundtnascto, fundtadmissao, funsexo) VALUES
('31', 'Sannyer Carodos Carvalho Nery', '5450.00', '6', '2','1','1999-11-15','2024-02-09','M'),
('32', 'Irismar Ferreira de Carvalho', '7230.00', '6', '2','3','1970-03-12','2024-02-09','F');



-- QUESTÃO 10
UPDATE funcionario SET funsalario = funsalario + (funsalario*0.10) WHERE fundtdem IS NULL;

-- QUESTÃO 11
UPDATE funcionario SET fundtdem ='2023-10-27' WHERE funcodigo = '21';

-- QUESTÃO 12
/*SELECT DISTINCT pronome, procusto, prosaldo
FROM cliente INNER JOIN venda ON clicodigo = venclicodigo
INNER JOIN itemvenda ON vencodigo = itvvencodigo
INNER JOIN produto ON procodigo = itvprocodigo
WHERE prosaldo > '5' AND clisexo = 'M' AND cliestcodigo = '2';*/

-- QUESTÃO 13
/*SELECT clinome
FROM venda INNER JOIN cliente ON clicodigo = venclicodigo
INNER JOIN funcionario ON venfuncodigo = funcodigo
WHERE clisexo = 'F' AND clirendamensal > 1000 AND clirendamensal < 1500
AND fundtdem IS NOT NULL;*/

-- QUESTÃO 14
/*SELECT funnome, bainome, funsalario, zonnome
FROM funcionario INNER JOIN bairro
ON funbaicodigo = baicodigo
INNER JOIN zona ON baizoncodigo = zoncodigo
WHERE fundtdem IS NOT NULL;*/

-- QUESTÃO 15
/*SELECT funnome, bainome, funsalario, zonnome
FROM funcionario INNER JOIN bairro
ON funbaicodigo = baicodigo
INNER JOIN zona ON baizoncodigo = zoncodigo
WHERE fundtdem IS NULL AND funnome LIKE '%s';*/

-- QUESTÃO 16
/*SELECT DISTINCT clinome, zonnome, estdescricao
FROM cliente INNER JOIN venda
ON clicodigo = venclicodigo
INNER JOIN bairro ON clibaicodigo = baicodigo
INNER JOIN zona ON baizoncodigo = zoncodigo
INNER JOIN estadocivil ON cliestcodigo = estcodigo;*/

-- QUESTÃO 17
/*SELECT pronome, cidnome
FROM produto INNER JOIN fornecedor ON proforcnpj = forcnpj
INNER JOIN cidade ON forcidcodigo = cidcodigo
WHERE cidnome NOT IN ('manaus', 'porto velho', 'rio branco');*/

-- QUESTÃO 18
/*SELECT clinome, bainome, funnome, estdescricao, zonnome
FROM cliente INNER JOIN bairro ON clibaicodigo = baicodigo
INNER JOIN zona ON baizoncodigo = zoncodigo
INNER JOIN venda ON clicodigo = venclicodigo
INNER JOIN funcionario ON venfuncodigo = funcodigo
INNER JOIN estadocivil ON funestcodigo = estcodigo
WHERE bainome IN ('cidade nova', 'cachoeirinha', 'chapada','japiim','educandos')
AND estdescricao IN ('solteiro','divorciado');

-- QUESTÃO 19
SELECT grpdescricao, cidnome
FROM produto INNER JOIN grupoproduto ON progrpcodigo = grpcodigo
INNER JOIN itemvenda ON procodigo = itvprocodigo
INNER JOIN venda ON itvvencodigo = vencodigo
INNER JOIN cliente ON venclicodigo = clicodigo
INNER JOIN bairro ON clibaicodigo = baicodigo
INNER JOIN zona ON baizoncodigo = zoncodigo
INNER JOIN cidade ON zoncidcodigo = cidcodigo
WHERE cidnome = 'manaus' AND proativo = '0' ;

-- QUESTÃO 20
SELECT itvvencodigo, pronome, itvqtde
FROM produto INNER JOIN itemvenda ON procodigo = itvprocodigo
WHERE proativo = '0';

-- QUESTÃO 21
SELECT funnome, pronome
FROM funcionario INNER JOIN venda ON funcodigo = venfuncodigo
INNER JOIN itemvenda ON vencodigo = itvvencodigo
INNER JOIN produto ON itvprocodigo = procodigo
WHERE funnome LIKE '%f%' AND funnome LIKE '%u%'
ORDER BY funnome;

-- QUESTÃO 22
SELECT clinome, grpdescricao
FROM cliente INNER JOIN venda ON clicodigo = venclicodigo
INNER JOIN itemvenda ON vencodigo = itvvencodigo
INNER JOIN produto ON itvprocodigo = procodigo
INNER JOIN grupoproduto ON progrpcodigo = grpcodigo
WHERE grpdescricao = 'informatica' AND proativo = '1';

-- QUESTÃO 23
SELECT bainome, funcodigo FROM
funcionario RIGHT OUTER JOIN bairro ON funbaicodigo = baicodigo
WHERE funcodigo IS NULL;

-- QUESTÃO 24
SELECT fornome, procodigo FROM fornecedor RIGHT OUTER JOIN produto ON forcnpj = proforcnpj
WHERE procodigo IS NULL;

-- QUESTÃO 25
SELECT clinome, estdescricao, vencodigo
FROM cliente RIGHT OUTER JOIN venda ON clicodigo = venclicodigo
INNER JOIN estadocivil ON cliestcodigo = estcodigo
WHERE vencodigo IS NULL;

-- QUESTÃO 26
SELECT funnome, vencodigo
FROM funcionario RIGHT OUTER JOIN venda ON funcodigo = venfuncodigo
WHERE vencodigo IS NULL;

-- QUESTÃO 27
SELECT pronome, vencodigo
FROM venda RIGHT OUTER JOIN itemvenda ON vencodigo = itvvencodigo
INNER JOIN produto ON itvprocodigo= procodigo
WHERE vencodigo IS NULL;*/

-- QUESTÃO 28
CREATE TABLE vendedor(
    vedfuncodigo INT(11) PRIMARY KEY,
    FOREIGN KEY (vedfuncodigo) REFERENCES funcionario(funcodigo)
);
ALTER TABLE venda ADD COLUMN venvedcodigo INT(11) NOT NULL;
ALTER TABLE venda ADD FOREIGN KEY (venvedcodigo) REFERENCES vendedor(vedfuncodigo);

-- QUESTÃO 29
/*SELECT grpdescricao, SUM(itvqtde) AS Total
FROM itemvenda INNER JOIN produto ON itvprocodigo = procodigo
INNER JOIN grupoproduto ON progrpcodigo = grpcodigo
GROUP BY grpdescricao;

-- QUESTÃO 30
SELECT zonnome, AVG(funsalario) AS Media
FROM funcionario INNER JOIN bairro ON funbaicodigo = baicodigo
INNER JOIN zona ON baizoncodigo = zoncodigo
GROUP BY zonnome;

-- QUESTÃO 31
SELECT bainome, SUM(clirendamensal) AS 'Total Renda', clisexo, COUNT(*) Total
FROM cliente INNER JOIN bairro ON clibaicodigo = baicodigo
GROUP BY bainome, clisexo;

-- QUESTÃO 32
SELECT zonnome, SUM(clirendamensal) AS 'Total Renda', estdescricao, COUNT(*) Total
FROM cliente INNER JOIN bairro ON clibaicodigo = baicodigo
INNER JOIN zona ON baizoncodigo = zoncodigo
INNER JOIN estadocivil ON cliestcodigo = estcodigo
GROUP BY zonnome, estdescricao;*/
