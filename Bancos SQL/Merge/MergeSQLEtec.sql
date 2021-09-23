CREATE DATABASE bdEtec
GO
USE bdEtec

CREATE TABLE tb2A(
	rmAluno int primary key not null
	,nomeAluno varchar(40) not null
	,statusAluno varchar(9) not null
)

CREATE TABLE tb2B(
	rmAluno int primary key not null
	,nomeAluno varchar(40) not null
	,statusAluno varchar(9) not null
)

CREATE TABLE tb3Ano(
	rmAluno int primary key not null
	,nomeAluno varchar(40) not null
	,statusAluno varchar(9) not null
)

INSERT INTO tb2A (rmALuno, nomeALuno, statusAluno)
VALUES 
	(20100, 'Vitória Gonçalves', 'APROVADO')
	,(200101, 'Gabriely Miranda', 'APROVADO')
	,(200103, 'Kauê Loviz', 'REPROVADO')
	,(200104, 'Mariana Santos', 'APROVADO')
	,(200105, 'Guilherme Delfino', 'APROVADO')
	,(200106, 'Paulo Moreira', 'APROVADO')
	,(200102, 'Camylly Ferreira', 'APROVADO')
	,(200107, 'Larissa Santos', 'REPROVADO')
	,(200108, 'David Alameda', 'REPROVADO')
	,(200109, 'Samuleu Guerra', 'APROVADO')
SELECT * FROM tb2A

INSERT INTO tb2b (rmALuno, nomeALuno, statusAluno)
VALUES (20100, 'Gabriel Hacker', 'REPROVADO')
	,(200110, 'Pedro Repelente de ...', 'APROVADO')
	,(200111, 'Amanda que Nojo', 'REPROVADO')
	,(200112, 'Melissa Dream', 'APROVADO')
	,(200113, 'Amiga da Melissa', 'APROVADO')
	,(200114, 'Gustavo Guitar Hero', 'APROVADO')
	,(200115, 'Menino Alto la', 'APROVADO')
	,(200116, 'Icaro God', 'REPROVADO')
	,(200117, 'Salermo', 'APROVADO')
	,(200118, 'Samuel q reprovou kk', 'REPROVADO')
SELECT * FROM tb2b

MERGE tb3Ano dest
	USING tb2a ori
	ON ori.rmAluno = dest.rmAluno
		WHEN NOT MATCHED AND ori.statusAluno like 'APROVADO' THEN 
			INSERT VALUES (ori.rmAluno, ori.nomeAluno, ori.statusAluno);
MERGE tb3Ano dest
	USING tb2b ori
	ON ori.rmAluno = dest.rmAluno
		WHEN NOT MATCHED AND ori.statusAluno like 'APROVADO' THEN 
			INSERT VALUES (ori.rmAluno, ori.nomeAluno, ori.statusAluno);
SELECT * FROM tb3Ano
	
