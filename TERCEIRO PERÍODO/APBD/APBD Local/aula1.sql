-- criar schema
/*CREATE DATABASE aula1

create TABLE empregado(
	empmatricula CHAR(8) NOT NULL,
	empnome varchar(80) NOT NULL,
	empdatainicio DATE NOT NULL,
	empendereco VARCHAR(50) NOT NULL,
	primary KEY (empmatricula)
);

CREATE TABLE gerente(
	germatricula CHAR(8) NOT NULL,
	PRIMARY KEY (germatricula),
	foreign KEY (germatricula) REFERENCES empregado(empmatricula)
);
*/
CREATE TABLE projeto(
	projsigla CHAR(5) NOT NULL,
	PRIMARY KEY (projsigla)
);

CREATE table empregadoprojeto(
	epprojeto CHAR(5) NOT NULL,
	epgerente CHAR(8) NOT NULL,
	PRIMARY KEY (epprojeto,epgerente),
	FOREIGN KEY (epprojeto) REFERENCES projeto(projsigla),
	FOREIGN KEY (epgerente) REFERENCES gerente(germatricula)
);

CREATE TABLE secretaria(
	secmatricula CHAR(8) NOT NULL,
	secvelocidadededigitacao INT NOT NULL,
	PRIMARY KEY(secmatricula),
	FOREIGN KEY (secmatricula) REFERENCES empregado(empmatricula)	
);

CREATE TABLE tecnico(
	tecmatricula CHAR(8) NOT NULL,
	teccategoria VARCHAR(60) NOT NULL,
	PRIMARY KEY(tecmatricula),
	FOREIGN KEY (tecmatricula) REFERENCES empregado(empmatricula)	
);

CREATE TABLE engenheiro(
	engmatricula CHAR(8) NOT NULL,
	engncrea CHAR(8) NOT NULL,
	PRIMARY KEY(engmatricula),
	FOREIGN KEY (engmatricula) REFERENCES empregado(empmatricula)	
);

CREATE TABLE empregadoassalariado(
	empassmatricula CHAR(8) NOT NULL,
	empassslaario DECIMAL(7,2) NOT NULL,
	PRIMARY KEY(empassmatricula),
	FOREIGN KEY (empassmatricula) REFERENCES empregado(empassmatricula)	
);

CREATE TABLE sindicato(
	sindcnpj CHAR(14) NOT NULL,
	PRIMARY KEY(sindcnpj)	
);

CREATE TABLE empregadohorista(
	emphmatricula CHAR(8) NOT NULL,
	emphvalorhora DECIMAL(7,2) NOT NULL,
	emphsindcnpj CHAR(14),
	PRIMARY KEY(emphmatricula),
	FOREIGN KEY (emphmatricula) REFERENCES empregado(emphmatricula),
	FOREIGN KEY (emphsindcnpj) REFERENCES sindicato(cnpj)
);

