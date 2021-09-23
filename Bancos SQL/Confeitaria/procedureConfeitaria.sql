--a

CREATE PROCEDURE InsereCategoria
@nomeCategoriaProduto VARCHAR (30)
AS 
BEGIN
	IF EXISTS (SELECT codCategoriaProduto FROM tbCategoriaProduto WHERE @nomeCategoriaProduto like nomeCategoriaProduto)
	BEGIN
		print('IMPOSSIVEL executar, Ja existe a categoria '+ CONVERT(VARCHAR,@nomeCategoriaProduto))
	END
	ELSE
	BEGIN
		INSERT INTO tbCategoriaProduto( nomeCategoriaProduto )
		VALUES (@nomeCategoriaProduto)
		SELECT * FROM tbCategoriaProduto
	END
END


EXEC InsereCategoria 'Bolo Festa' 
EXEC InsereCategoria 'Bolo Simples' 
EXEC InsereCategoria 'Torta' 
EXEC InsereCategoria 'Salgado' 



--b

CREATE PROCEDURE InsereProdutos
@nomeProduto VARCHAR(30), @precoProduto SMALLMONEY, @codCategoriaProduto INT
AS
BEGIN
	IF EXISTS (SELECT codProduto FROM tbProduto WHERE @nomeProduto like nomeProduto)
	BEGIN
		print('IMPOSSIVEL executar, Ja existe o Produto '+ CONVERT(VARCHAR,@nomeProduto))
	END
	ELSE
	BEGIN
		INSERT INTO tbProduto( nomeProduto, precoProduto, codCategoriaProduto )
		VALUES (@nomeProduto, @precoProduto, @codCategoriaProduto )
		SELECT * FROM tbProduto
	END
END

EXEC InsereProdutos 'Bolo Floresta Negra', 42.00, 1
EXEC InsereProdutos 'Bolo Prestigio', 43.00, 1
EXEC InsereProdutos 'Bolo Nutella', 44.00, 1
EXEC InsereProdutos 'Bolo Formigueiro', 17.00, 2
EXEC InsereProdutos 'Bolo de Cenoura', 19.00, 2
EXEC InsereProdutos 'Torta de Palmito', 45.00, 3
EXEC InsereProdutos 'Torta de Frango e Catupiry', 47.00, 3
EXEC InsereProdutos 'Torta de Escarola', 44.00, 3
EXEC InsereProdutos 'Coxinha Frango', 24.00, 4
EXEC InsereProdutos 'Esfiha de Carne', 27.00, 4
EXEC InsereProdutos 'Folhado de Queijo', 31.00, 4
EXEC InsereProdutos 'Risoles Misto', 29.00, 4


--c
CREATE PROCEDURE CadastrarClientes 
@nomeCliente VARCHAR(30), @cpfCliente VARCHAR(15), @dtNascCliente SMALLDATETIME, 
@sexoCliente CHAR(1), @ruaCliente VARCHAR(20), @cepCliente VARCHAR(9), @bairroCliente VARCHAR(20), 
@cidadeCliente VARCHAR(15), @estadoCliente VARCHAR(15)
AS
BEGIN
	IF EXISTS (SELECT codCLiente FROM tbCliente WHERE @cpfCliente like cpfCliente)
	BEGIN
		print('IMPOSSIVEL Cadastrar, Cliente de CPF '+ CONVERT(VARCHAR,@cpfCliente))
	END

	ELSE
	BEGIN
		IF @bairroCliente  not like 'Itaquera' and @bairroCliente not like 'Guaianases'
		BEGIN
			print('IMPOSSIVEL Cadastrar o Cliente de CPF '+ CONVERT(VARCHAR,@cpfCliente) +' Pois o Bairro '+ CONVERT(VARCHAR,@bairroCliente)+ ' Não é atendida pela Confeitaria')
		END
		ElSE
		BEGIN
		
			INSERT INTO tbCliente( nomeCliente, cpfCliente,dtNascCliente, sexoCliente,
			ruaCliente, cepCliente, bairroCliente, cidadeCliente, estadoCliente)
			VALUES (@nomeCliente, @cpfCliente, @dtNascCliente, @sexoCliente, 
			@ruaCliente, @cepCliente, @bairroCliente, @cidadeCliente, @estadoCliente)
			SELECT * FROM tbCliente
			
		END
	END
END


EXEC CadastrarClientes 'Samira Fatah', '123.456.789-02', '10/11/1997', 
'F', 'Rua Aguapeí', '8090000', 'Guaianases', 'São Paulo', 'SP'

EXEC CadastrarClientes 'Celia Nogueira', '234.567.890-12', '06/06/1992', 
'F', 'Rua Andes', '8456090', 'Guaianases', 'São Paulo', 'SP'

EXEC CadastrarClientes 'Paulo Cesar Siqueira', '345.678.901-23', '04/04/1994', 
'M', 'Rua Castelo de Piauí', '8109000', 'Itaquera', 'São Paulo', 'SP'

EXEC CadastrarClientes 'Rodrigo Favoroni', '456.789.012-34', '09/04/1991', 
'M', 'Rua Sansão Castelo Branco', '8431090', 'Guaianases', 'São Paulo', 'SP'

EXEC CadastrarClientes 'Flavia Regina Brito', '567.8900.123-45', '22/04/1992', 
'F', 'Rua Mariano Moro', '8200123', 'Itaquera', 'São Paulo', 'SP'




--d
CREATE PROCEDURE Encomendas 
@dtEncomenda SMALLDATETIME, @codCliente INT,
@valorTotal SMALLINT, @dtEntrega SMALLDATETIME  
AS
BEGIN
	
	IF NOT EXISTS (SELECT cpfCLiente FROM tbCliente WHERE @codCliente like codCliente)
	BEGIN
		PRINT('IMPOSSIVEL efetivar encomenda, o Cliente de Codigo ' + CONVERT(VARCHAR,@codCliente)+' Não esta cadastrado')
	END
	ELSE
	BEGIN
		DECLARE @codEncomenda INT
		DECLARE @nomeCLiente VARCHAR (30)
		SELECT @nomeCLiente = nomeCliente FROM tbCliente WHERE @codCliente like codCLiente
		INSERT INTO tbEncomenda(dtEncomenda, codCliente, valorTotal, dtEntregaEncomenda)
		VALUES (@dtEncomenda, @codCliente, @valorTotal, @dtEntrega)
		SELECT @codEncomenda =  codEncomenda FROM tbEncomenda WHERE @codCliente like codCLiente
		PRINT('Encomenda '+CONVERT(VARCHAR, @codEncomenda) + ' para  o cliente '+ @nomeCliente + ' efetuada com sucesso')
		SELECT * FROM tbEncomenda
	END
END

EXEC Encomendas'08/08/2015', 1, 450.00, '15/08/2015'
EXEC Encomendas'10/10/2015', 2, 200.00, '15/10/2015'
EXEC Encomendas'10/10/2015', 3, 150.00, '10/12/2015'
EXEC Encomendas'06/10/2015', 1, 250.00, '12/10/2015'
EXEC Encomendas'06/10/2015', 4, 150.00, '12/10/2015'

--e
CREATE PROCEDURE ItensEncomendas 
@codEncomenda INT, @codProduto INT,
@qtdKilos SMALLINT, @subTotal SMALLINT
AS
BEGIN
	IF NOT EXISTS (SELECT codEncomenda FROM tbEncomenda WHERE @codEncomenda like codEncomenda)
	AND NOT EXISTS (SELECT codProduto FROM tbProduto WHERE @codProduto like codProduto)
	BEGIN
		PRINT('IMPOSSIVEL efetivar Cadastro, O Codigo ' + CONVERT(VARCHAR,@codEncomenda)+' de Produto / Encomenda Não esta cadastrado')
	END
	ELSE
	BEGIN
		INSERT INTO tbItensEncomenda(codEncomenda, codProduto, qtdKilos, subTotal)
		VALUES (@codEncomenda, @codProduto, @qtdKilos, @subTotal)
		SELECT * FROM tbItensEncomenda
	END
END

EXEC ItensEncomendas 1, 1, 2.5, 105.00
EXEC ItensEncomendas 1, 10, 2.6, 70.00
EXEC ItensEncomendas 1, 9, 6, 150.00
EXEC ItensEncomendas 1, 12, 4.3, 125.00
EXEC ItensEncomendas 2, 9, 8, 200.00
EXEC ItensEncomendas 3, 11, 3.2, 100.00
EXEC ItensEncomendas 3, 9, 2, 50.00
EXEC ItensEncomendas 4, 2, 3.5, 150.00
EXEC ItensEncomendas 4, 3, 2.2, 100.00
EXEC ItensEncomendas 5, 6, 3.4, 150.00






--f
CREATE PROCEDURE Alteracao

AS
BEGIN
	DECLARE @i INT
	DECLARE @valorAtual SMALLINT
	DECLARE @resul FLOAT
	SET @i = 0

	--1
	--bolo festa +10%

	WHILE @i <= 3 
	BEGIN

		SELECT @valorAtual = precoProduto FROM tbProduto WHERE codCategoriaProduto like 1 and codProduto like @i
		SET @resul = @valorAtual * ( 1.1 )

		UPDATE tbProduto
		SET precoProduto = CONVERT(SMALLMONEY,@resul)
		WHERE codCategoriaProduto = 1 and codProduto like @i

		SELECT * FROM tbProduto WHERE codCategoriaProduto like 1

		SET @i += 1
	END
	
	
--2
--bolo simples -20%
	
	WHILE @i <= 5
	BEGIN	
		
		SELECT @valorAtual = precoProduto FROM tbProduto WHERE codCategoriaProduto like 2 and codProduto like @i
		SET @resul = @valorAtual * ( 0.8 )
		PRINT(@resul)

		UPDATE tbProduto
		SET precoProduto = CONVERT(SMALLMONEY,@resul)
		WHERE codCategoriaProduto = 2 and codProduto like @i

		SELECT * FROM tbProduto WHERE codCategoriaProduto like 2 
		SET @i += 1
	END
	SELECT * FROM tbProduto WHERE codCategoriaProduto like 2
	
--3
--torta +25%

	WHILE @i <= 8
	BEGIN 

		SELECT @valorAtual = precoProduto FROM tbProduto WHERE codCategoriaProduto like 3 and codProduto like @i
		SET @resul = @valorAtual * ( 1.25 )
	
		UPDATE tbProduto
		SET precoProduto = CONVERT(SMALLMONEY,@resul)
		WHERE codCategoriaProduto like 3 and codProduto like @i

		SET @i += 1 
	END
	SELECT * FROM tbProduto WHERE codCategoriaProduto like 3
	
--4
--salgado +20% excessao esfiha de carne

	WHILE @i <= 12
	BEGIN

		SELECT @valorAtual = precoProduto FROM tbProduto WHERE codCategoriaProduto like 4 and codProduto like @i
		SET @resul = @valorAtual * ( 1.2 )

		UPDATE tbProduto
		SET precoProduto = CONVERT(SMALLMONEY,@resul)
		WHERE codCategoriaProduto = 4 and codProduto like @i AND nomeProduto NOT LIKE 'esfiha de Carne'

		SET @i += 1
	END

	SELECT * FROM tbProduto WHERE codCategoriaProduto like 4
	

	SELECT * FROM tbProduto

END

EXEC Alteracao


--g
CREATE PROCEDURE ExcluirCliente
@cpf VARCHAR(15)
AS
BEGIN
	IF NOT EXISTS (SELECT codCliente FROM tbCliente WHERE @cpf like cpfCliente)
	BEGIN
		print('IMPOSSIVEL Excluir, Nao existe Cliente de CPF '+ CONVERT(VARCHAR,@cpf))
		SELECT * FROM tbCliente
	END
	ELSE
	BEGIN
		DECLARE @cod INT
		DECLARE @nome VARCHAR(30)
		SELECT @cod = codCliente, @nome = nomeCliente FROM tbCliente WHERE @cpf like cpfCliente
		IF EXISTS(SELECT codEncomenda FROM tbEncomenda WHERE @cod like codCliente)
		BEGIN
			PRINT('Impossivel remover esse cliente pois o cliente '+ @nome +' possui encomendas')
			SELECT * FROM tbEncomenda
		END
		ELSE
		BEGIN
			DELETE FROM tbCliente WHERE @cpf = cpfCliente
			SELECT * FROM tbCliente
		END
	END
END

EXEC ExcluirCliente '123.456.789-02'




--h
alter PROCEDURE ExcluirEncomenda
@codEncomenda INT, @codProduto INT, @dtAtual DATE
AS
BEGIN
	IF not EXISTS (SELECT codEncomenda FROM tbItensEncomenda WHERE @codEncomenda like codEncomenda)
	AND not EXISTS (SELECT codProduto FROM tbItensEncomenda WHERE @codProduto like codProduto)
	BEGIN
		PRINT('Algum dos codigos sao incompativeis')
	END
	ELSE
	BEGIN
		DECLARE @dtEntrega DATE
		SELECT @dtEntrega = dtEntregaEncomenda FROM tbEncomenda WHERE codEncomenda like @codEncomenda
		IF ( @dtAtual < @dtEntrega )
		BEGIN

			--PRECO DESCONTAR ENCOMENDA
			DECLARE @preco SMALLMONEY
			SELECT @preco = subTotal FROM tbItensEncomenda WHERE @codProduto like codProduto and @codEncomenda like codEncomenda
		
			UPDATE tbEncomenda
			SET valorTotal -= @preco
			WHERE @codEncomenda like codEncomenda

			--remover item
			DELETE FROM tbItensEncomenda WHERE @codProduto like codProduto and @codEncomenda like codEncomenda
			SELECT * FROM tbItensEncomenda
	
		END
		ELSE
		BEGIN
			PRINT('A data atual devera ser inferior a data de entrega, logicamente vc estaria excluindo uma entrega ja concluida ')
		END
	END
END

EXEC ExcluirEncomenda 1, 1, '09/09/2015'

SELECT * FROM tbProduto
SELECT * FROM tbEncomenda
SELECT * FROM tbItensEncomenda
















