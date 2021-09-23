CREATE DATABASE bdConfeitaria
USE bdConfeitaria

--TABELAS
CREATE TABLE tbCliente (
	codCLiente INT PRIMARY KEY IDENTITY(1,1)
	,nomeCliente VARCHAR(30) NOT NULL
	,dtNascCliente SMALLDATETIME NOT NULL
	,ruaCliente VARCHAR(20) NOT NULL
	,cepCliente VARCHAR(9) NOT NULL
	,bairroCliente VARCHAR(20) NOT NULL
	,cidadeCliente VARCHAR(15) NOT NULL
	,estadoCliente VARCHAR(15) NOT NULL
	,cpfCliente VARCHAR(15) NOT NULL
	,sexoCliente CHAR(1) NOT NULL
)

CREATE TABLE tbEncomenda (
	codEncomenda INT PRIMARY KEY IDENTITY (1,1)
	,dtEncomenda DATE NOT NULL 
	,codCliente INT FOREIGN KEY REFERENCES tbCliente(codCliente)
	,valorTotal SMALLINT NOT NULL
	,dtEntregaEncomenda DATE NOT NULL
)

CREATE TABLE tbCategoriaProduto (
	codCategoriaProduto INT PRIMARY KEY IDENTITY (1,1)
	,nomeCategoriaProduto VARCHAR(30)  NOT NULL
)

CREATE TABLE tbProduto (
	codProduto INT PRIMARY KEY IDENTITY (1,1)
	,nomeProduto VARCHAR(30) NOT NULL
	,precoProduto SMALLMONEY NOT NULL
	,codCategoriaProduto INT FOREIGN KEY REFERENCES tbCategoriaProduto(codCategoriaProduto)
)

CREATE TABLE tbItensEncomenda (
	codItensEncomenda INT PRIMARY KEY IDENTITY (1,1)
	,codEncomenda INT FOREIGN KEY REFERENCES tbEncomenda (codEncomenda)
	,codProdutO INT FOREIGN KEY REFERENCES tbProduto (codProduto)
	,qtdKilos FLOAT NOT NULL
	,subTotal SMALLINT NOT NULL
)