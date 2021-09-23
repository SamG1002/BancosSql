--USE bdLocadoraVeiculo
--Procedures com Inserts

CREATE PROCEDURE inserirFabricante
@nomeFabricante VARCHAR (30), @cnpjFabricante VARCHAR (20)
AS
BEGIN
	IF EXISTS (SELECT idFabricante FROM tbFabricante WHERE @nomeFabricante like nomeFabricante)
	BEGIN
		print('IMPOSSIVEL executar, Ja existe a Fabricante '+ CONVERT(VARCHAR, @nomeFabricante))
	END
	ELSE
	BEGIN
		INSERT INTO tbFabricante( nomeFabricante, cnpjFabricante )
		VALUES ( @nomeFabricante, @cnpjFabricante )
		SELECT * FROM tbFabricante
	END
END

CREATE PROCEDURE inserirTipoCombustivel
@descTipoCombustivel VARCHAR (50)
AS
BEGIN
	IF EXISTS (SELECT idTipoCombustivel FROM tbTipoCombustivel WHERE @descTipoCombustivel like descTipoCombustivel)
	BEGIN
		print('IMPOSSIVEL executar, Ja existe a Tipo de Combustivel '+ CONVERT(VARCHAR, @descTipoCombustivel))
	END
	ELSE
	BEGIN
		INSERT INTO tbTipoCombustivel( descTipoCombustivel )
		VALUES ( @descTipoCombustivel )
		SELECT * FROM tbTipoCombustivel
	END
END

CREATE PROCEDURE inserirCategoriaVeiculo
@descCategoriaVeiculo VARCHAR (50), @valorDiariaCategoria SMALLMONEY
AS
BEGIN
	IF EXISTS (SELECT idCategoriaVeiculo FROM tbCategoriaVeiculo WHERE @descCategoriaVeiculo like descCategoriaVeiculo)
	BEGIN
		print('IMPOSSIVEL executar, Ja existe a Categoria de Veiculo '+ CONVERT(VARCHAR, @descCategoriaVeiculo ))
	END
	ELSE
	BEGIN
		INSERT INTO tbCategoriaVeiculo ( descCategoriaVeiculo, valorDiariaCategoriaVeiculo)
		VALUES ( @descCategoriaVeiculo, @valorDiariaCategoria )
		SELECT * FROM tbCategoriaVeiculo
	END
END

CREATE PROCEDURE inserirCliente
@nomeCliente VARCHAR (50), @dtNascCliente DATE, @cpfCliente VARCHAR(11)
AS
BEGIN
	IF EXISTS (SELECT idCliente FROM tbCliente WHERE @nomeCliente like nomeCliente )
	BEGIN
		print('IMPOSSIVEL executar, Ja existe o Cliente '+ CONVERT(VARCHAR, @nomeCliente))
	END
	ELSE
	BEGIN
		INSERT INTO tbCliente ( nomeCliente, dtNascCliente, cpfCliente )
		VALUES ( @nomeCliente, @dtNascCliente, @cpfCliente )
		SELECT * FROM tbCliente
	END
END

CREATE PROCEDURE inserirVeiculo
@modeloVeiculo VARCHAR (20), @placaVeiculo VARCHAR(7) , @origemVeiculo	VARCHAR(2), @idFabricante INT, @idTipoCombustivel INT, @idCategoriaVeiculo INT, @kmVeiculo INT
AS
BEGIN
	IF EXISTS (SELECT idVeiculo FROM tbVeiculo WHERE @placaVeiculo like placaVeiculo)
	BEGIN
		print('IMPOSSIVEL executar, Ja existe o Veiculo '+ CONVERT(VARCHAR, @modeloVeiculo)+' de placa '+ CONVERT(VARCHAR, @placaVeiculo))
	END
	ELSE
	BEGIN
		INSERT INTO tbVeiculo ( modeloVeiculo, placaVeiculo, origemVeiculo, idFabricante, idTipoCombustivel, idCategoriaVeiculo, kmVeiculo )
		VALUES ( @modeloVeiculo, @placaVeiculo, @origemVeiculo, @idFabricante, @idTipoCombustivel, @idCategoriaVeiculo, @kmVeiculo)
		SELECT * FROM tbVeiculo 
	END
END

--Exercicio C
CREATE PROCEDURE inserirLocacao 
@dataDevolucao DATE, @cpfCliente VARCHAR (11), @placaVeiculo VARCHAR (7)
AS
BEGIN
	IF NOT EXISTS (SELECT idCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente) 
	OR NOT EXISTS (SELECT idvEICULO FROM tbVeiculo WHERE placaVeiculo LIKE @placaVeiculo)
	OR (DATEDIFF (DAY, GETDATE(), @dataDevolucao) < 0)
	BEGIN
		PRINT ('Algum dado fornecido não foi encontrado ou está incorreto, tente novamente')
	END
	ELSE
	BEGIN
		DECLARE @diarias INT, @valorTotal SMALLMONEY, @data DATE, @idCli INT, @idVeic INT, @valorCategoria SMALLMONEY

		SET @data = GETDATE()
		SET @diarias = DATEDIFF(day, @data, @dataDevolucao)
		SET @idCli = (SELECT idCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
		SET @idVeic = (SELECT idVeiculo FROM tbVeiculo WHERE placaVeiculo LIKE @placaVeiculo)
		SET @valorCategoria = (SELECT valorDiariaCategoriaVeiculo FROM tbCategoriaVeiculo WHERE idCategoriaVeiculo = 
		(SELECT idCategoriaVeiculo FROM tbVeiculo WHERE idVeiculo = @idVeic))
		SET @valorTotal = @diarias * @valorCategoria

		INSERT INTO tbLocacao (dataLocacao, dataDevolucao, numDiaria, valorTotal, idCliente, idVeiculo)
		VALUES(@data, @dataDevolucao, @diarias, @valorTotal, @idCli, @idVeic)

		SELECT * FROM tbLocacao
	END
END

--Executando Procedure Insercao

EXEC InserirFabricante 'Ford', '89434343000121' 
EXEC InserirFabricante 'GM', '33873233000122' 
EXEC InserirFabricante 'Honda', '73222323000192' 
EXEC InserirFabricante 'Hyundai', '83222323000109' 
EXEC InserirFabricante 'Toyota', '23234983000199' 

EXEC inserirTipoCombustivel 'Alcool'
EXEC inserirTipoCombustivel 'Diesel'
EXEC inserirTipoCombustivel 'Gasolina'
EXEC inserirTipoCombustivel 'GNV'
EXEC inserirTipoCombustivel 'Flex'

EXEC inserirCategoriaVeiculo 'Passeio Simples', 200.00
EXEC inserirCategoriaVeiculo 'Passeio Intermediario', 300.00
EXEC inserirCategoriaVeiculo 'Utilitario Pequeno', 300.00
EXEC inserirCategoriaVeiculo 'Utilitario Grande', 700.00
EXEC inserirCategoriaVeiculo 'SUV', 700.00

EXEC inserirCliente 'Vanessa Ferraz', '18/11/1984', '123456789000'
EXEC inserirCliente 'Rosangela Freire', '03/06/1984', '98309933399'
EXEC inserirCliente 'Erico Verissimo', '16/04/1990', '12243322222'
EXEC inserirCliente 'Junios Santos', '14/07/1985', '33322255593'

EXEC inserirVeiculo 'HRV', 'ABC1234', 'SP', 3, 5, 5, 10000
EXEC inserirVeiculo 'Prisma LTZ', 'FRG1222', 'SP', 2, 5, 1, 5000
EXEC inserirVeiculo 'Hilux', 'TRE1224', 'SP', 5, 2, 4, 1800
EXEC inserirVeiculo 'HB20 S ', 'WSA3220', 'RJ', 4, 5, 2, 2000
EXEC inserirVeiculo 'Ford Ka', 'RED3544', 'RJ', 1, 5, 1, 123000
EXEC inserirVeiculo 'Ford Edge', 'TPO9000', 'SP', 1, 2, 4, 1500
EXEC inserirVeiculo 'Creta', 'VCF3333', 'RJ', 4, 5, 2, 2000
EXEC inserirVeiculo 'Onix', 'BSE5444', 'SP', 2, 5, 1, 2300

--Questao D
EXEC inserirLocacao '10/12/2020', '12243322222', 'TRE1224'
EXEC inserirLocacao '05/12/2020', '12345678900', 'VCF3333'
EXEC inserirLocacao '10/12/2020', '98309933399', 'ABC1234'
EXEC inserirLocacao '10/12/2020', '12243322222', 'RED3544'
EXEC inserirLocacao '10/12/2020', '12345678900', 'WSA3220'
EXEC inserirLocacao '10/12/2020', '98309933399', 'RED3544'

SELECT * FROM tbCliente
SELECT * FROM tbVeiculo 
select * from tbCategoriaVeiculo
select * from tbLocacao