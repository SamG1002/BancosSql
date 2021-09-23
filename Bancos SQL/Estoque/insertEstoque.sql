use bdEstoque	

	insert into tbCliente(nomeCliente, cpfCliente, emailCliente, sexoCliente, dataNascimentoCliente)
		values('Amando Jos� Santana', 12345678900, 'amandojsantana@outlook.com.br', 'm', '1961-02-23')
		,('Sheila Carvalho Leal', 45678909823, 'scarvalho@ig.com', 'f', '1978-09-13')
		,('Carlos Henrique Souza', 76598278299, 'chenrique@ig.com', 'm', '1981-09-08')
		,('Maria Aparecida Souza', 87365309899, 'mapdasouza@outlook.com.br', 'f', '1962-07-07')
		,('Adriana Nogueira Silva', 76354309388, 'drica1977@ig.com', 'f', '1977-04-09')
		,('Paulo Henrique Silva', 87390123111, 'phsilva80@hotmail.com', 'm', '1961-02-23')
		select * from tbCliente

	insert into tbFabricante(nomeFabricante)
		values('Unilever')
		,('P&G')
		,('Bunge')
		select * from tbFabricante

	insert into tbFornecedor(nomeFornecedor, contatoFornecedor)
		values('Atacad�o', 'Carlos Santos')
		,('Assa�', 'Maria Stella')
		,('Rold�o', 'Paulo C�sar')
		select * from tbFornecedor

	insert into tbProduto(descricaoProduto, valorProduto, quantidadeProduto, codFabricante, codFornecedor)
		values('Amaciante Downy', 5.76, 1500, 2, 1)
		,('Amaciante Comfort', 5.45, 2300, 1, 1)
		,('Sab�o em p� OMO', 5.99, 1280, 1, 2)
		,('Margarina Qualy', 4.76, 2500, 3, 1)
		,('Salsicha Hot Dog Sadia', 6.78, 2900, 3, 2)
		,('Mortadela Perdig�o', 2.50, 1200, 3, 3)
		,('Hamburguer Sadia', 9.89, 1600, 3, 1)
		,('Fralda Pampers', 36.00, 340, 2, 3)
		,('Xampu Seda', 5.89, 800, 1, 2)
		,('Condicionador Seda', 6.50, 700, 1, 3)
		select * from tbProduto

	insert into tbVenda(dataVenda, valorTotalVenda, codCliente)
		values('2014-02-01', 4500.00, 1)
		,('2014-02-03', 3400.00, 1)
		,('2014-02-10', 2100.00, 2)
		,('2014-02-15', 2700.00, 3)
		,('2014-03-17', 560.00, 3)
		,('2014-04-09', 1200.00, 4)
		,('2014-05-07', 3500.00, 5)
		,('2014-05-07', 3400.00, 1)
		,('2014-05-05', 4000.00, 2)
		select * from tbVenda

	insert into tbItensVenda(codVenda, codProduto, quantidadeItensVenda, subTotalItensVenda)
		values(1, 1, 200, 1500.00)
		,(1, 2, 300, 3000.00)
		,(2, 4, 120, 1400.00)
		,(2, 2, 200, 1000.00)
		,(2, 3, 130, 1000.00)
		,(3, 5, 200, 2100.00)
		,(4, 4, 120, 1000.00)
		,(4, 5, 450, 700.00)
		,(5, 5, 200, 560.00)
		,(6, 7, 200, 600.00)
		,(6, 6, 300, 600.00)
		,(8, 1, 300, 2500.00)
		,(8, 2, 200, 1000.00)
		,(9, 6, 250, 1700.00)
		,(9, 5, 200, 1700.00)
		,(9, 4, 1000, 4000.00)
		select * from tbItensVenda