create database bdEstoque
go
use bdEstoque

	create table tbCliente(
		codCliente int primary key identity(1,1) 
		,nomeCliente varchar(30) not null
		,cpfCliente varchar(15) not null
		,emailCliente varchar(30) not null
		,sexoCliente char(1) not null 
		,dataNascimentoCliente date not null
	)

	create table tbFabricante(
		codFabricante int primary key identity(1,1)
		,nomeFabricante varchar(30) not null
	)

	create table tbFornecedor(
		codFornecedor int primary key identity(1,1)
		,nomeFornecedor varchar(30) not null
		,contatoFornecedor varchar(30) not null
	)

	create table tbProduto(
		codProduto int primary key identity(1,1)
		,descricaoProduto varchar(50) not null
		,valorProduto smallmoney not null
		,quantidadeProduto int not null
		,codFornecedor int foreign key references tbFornecedor(codFornecedor)
		,codFabricante int foreign key references tbFabricante(codFabricante)
	)

	create table tbVenda(
		codVenda int primary key identity(1,1)
		,dataVenda date not null
		,codCliente int foreign key references tbCliente(codCliente)
		,valorTotalVenda money not null
	)

	create table tbItensVenda(
		codItensVenda int primary key identity(1,1)
		,codVenda int foreign key references tbVenda(codVenda)
		,codProduto int foreign key references tbProduto(codProduto)
		,quantidadeItensVenda int not null
		,subTotalItensVenda smallmoney not null
	)

	create table tbEntradaProduto(
		codEntradaProduto int primary key identity(1,1)
		,codProduto int foreign key references tbProduto(codProduto)
		,dataEntradaProduto date not null
		,quantidadeEntradaProduto int not null
	)

	create table tbSaidaProduto(
		codSaidaProduto int primary key identity(1,1)
		,codProduto int foreign key references tbProduto(codProduto)
		,dataSaidaProduto date not null
		,quantidadeSaidaProduto int not null
	)