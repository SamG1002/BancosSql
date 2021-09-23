--Criando Banco

CREATE DATABASE bdLocadoraVeiculo

--Criando Tabelas

USE bdLocadoraVeiculo
go
CREATE TABLE tbFabricante(
	idFabricante INT PRIMARY KEY IDENTITY(1,1)
	,nomeFabricante VARCHAR (30) NOT NULL
	,cnpjFabricante VARCHAR (20) NOT NULL
)

CREATE TABLE tbTipoCombustivel(
	idTipoCombustivel INT PRIMARY KEY IDENTITY(1,1)
	,descTipoCombustivel VARCHAR (50) NOT NULL
)

CREATE TABLE tbCategoriaVeiculo(
	idCategoriaVeiculo INT PRIMARY KEY IDENTITY(1,1)
	,descCategoriaVeiculo VARCHAR (30) NOT NULL
	,valorDiariaCategoriaVeiculo SMALLMONEY NOT NULL
)

CREATE TABLE tbCliente(
	idCliente INT PRIMARY KEY IDENTITY(1,1)
	,nomeCliente VARCHAR (50)
	,dtNascCliente DATE NOT NULL
	,cpfCliente VARCHAR (11) NOT NULL
)


CREATE TABLE tbVeiculo(
	idVeiculo INT PRIMARY KEY IDENTITY(1,1)
	,modeloVeiculo VARCHAR (20) NOT NULL
	,placaVeiculo VARCHAR (7) NOT NULL
	,origemVeiculo VARCHAR (2) NOT NULL
	,idFabricante INT FOREIGN KEY REFERENCES tbFabricante(idFabricante)
	,idTipoCombustivel INT FOREIGN KEY REFERENCES tbTipoCombustivel(idTipoCombustivel)
	,idCategoriaVeiculo INT FOREIGN KEY REFERENCES tbCategoriaVeiculo(idCategoriaVeiculo)
	,kmVeiculo INT NOT NULL
)

CREATE TABLE tbLocacao(
	idLocacao INT PRIMARY KEY IDENTITY (1,1)
	,dataLocacao DATE NOT NULL
	,dataDevolucao DATE NOT NULL
	,numDiaria INT NOT NULL
	,valorTotal SMALLMONEY NOT NULL
	,idCliente INT FOREIGN KEY REFERENCES tbCliente(idCliente)
	,idVeiculo INT FOREIGN KEY REFERENCES tbVeiculo(idVeiculo)
)