USE bdEstoque

--01

CREATE TRIGGER tgRemoverUnidade ON tbItensVenda AFTER INSERT
AS
BEGIN
	DECLARE @qtdVendida INT, @codProduto INT

	SELECT @codProduto = codProduto, @qtdVendida = quantidadeItensVenda FROM inserted

	UPDATE tbProduto
	SET quantidadeProduto -= @qtdVendida
	WHERE @codProduto = codProduto

END

--02

CREATE TRIGGER tgAdicionarUnidade ON tbEntradaProduto AFTER INSERT
AS
BEGIN
	DECLARE @qtdEntrando INT, @codProduto INT

	SELECT @codProduto = codProduto, @qtdEntrando = quantidadeEntradaProduto FROM inserted

	UPDATE tbProduto
	SET quantidadeProduto += @qtdEntrando
	WHERE @codProduto = codProduto

END

--03

CREATE TRIGGER tgInsertSaida ON tbItensVenda AFTER INSERT
AS
BEGIN
	DECLARE @qtdVenda INT, @codProduto INT

	SELECT @codProduto = codProduto, @qtdVenda = quantidadeItensVenda FROM inserted

	INSERT INTO tbSaidaProduto (codProduto,quantidadeSaidaProduto,dataSaidaProduto)
	VALUES ( @codProduto, @qtdVenda, GETDATE() )

END
