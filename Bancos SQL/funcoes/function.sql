--bdEscola
--01
CREATE FUNCTION fc_DiaMatricula (@dtMatricula DATE)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @diaSemana VARCHAR(20)
	DECLARE @dia INT SET @dia = DATEPART(dw, @dtMatricula)
	IF(@dia like 1)
		SET @diaSemana = 'Domingo'
	IF(@dia like 2)
		SET @diaSemana = 'Segunda'
	IF(@dia like 3)
		SET @diaSemana = 'Ter�a'
	IF(@dia like 4)
		SET @diaSemana = 'Quarta'
	IF(@dia like 5)
		SET @diaSemana = 'Quinta'
	IF(@dia like 6)
		SET @diaSemana = 'Sexta'
	IF(@dia like 7)
		SET @diaSemana = 'Sabado'
	RETURN @diaSemana
END

SELECT dia_que_Matriculei = dbo.fc_DiaMatricula('28/09/2020')

--02
CREATE FUNCTION fc_tempoCurso (@codCurso INT)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @hora INT, @tempo VARCHAR(10)
	SELECT @hora = caragaHorariaCurso FROM tbCurso WHERE codCurso like @codCurso
	IF(1000 >= @hora)
	BEGIN
		SET @tempo = 'Rapido'
	END
	ELSE
	BEGIN
		SET @tempo = 'Extenso'	
	END
	RETURN @tempo
END


SELECT Tempo_do_Curso = dbo.fc_tempoCurso(codCurso) FROM tbCurso

--03
CREATE FUNCTION fc_valorCurso (@codCurso INT)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @valor INT, @custo VARCHAR(10)
	SELECT @valor = valorCurso FROM tbCurso WHERE codCurso like @codCurso
	IF(@valor >= 400)
	BEGIN
		SET @custo = 'Caro'
	END
	ELSE
	BEGIN
		SET @custo = 'Barato'	
	END
	RETURN @custo
END


SELECT Valor_do_Curso = dbo.fc_valorCurso(codCurso) FROM tbCurso

--04
CREATE FUNCTION fc_Formatando (@data DATE)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @diaSemana VARCHAR(20)
	SELECT @diaSemana = FORMAT(@data,'d', 'pt-br')
	RETURN @diaSemana
END

SELECT dia_que_Matriculei = dbo.fc_Formatando('2018/02/24')

--bdEstoque
--01
CREATE FUNCTION fc_DiaVenda (@dtVenda DATE)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @diaSemana VARCHAR(20)
	DECLARE @dia INT SET @dia = DATEPART(dw, @dtVenda)
	IF(@dia like 1)
		SET @diaSemana = 'Domingo'
	IF(@dia like 2)
		SET @diaSemana = 'Segunda'
	IF(@dia like 3)
		SET @diaSemana = 'Ter�a'
	IF(@dia like 4)
		SET @diaSemana = 'Quarta'
	IF(@dia like 5)
		SET @diaSemana = 'Quinta'
	IF(@dia like 6)
		SET @diaSemana = 'Sexta'
	IF(@dia like 7)
		SET @diaSemana = 'Sabado'
	RETURN @diaSemana
END

SELECT DiaSemanaVenda = dbo.fc_DiaVenda(dataVenda), Codigo = codVenda, Total = valorTotalVenda, DataVenda = dataVenda  FROM tbVenda

--02
CREATE FUNCTION fc_ComprasCliente (@codCliente INT) 
RETURNS INT 
AS
BEGIN
	DECLARE @contador INT
	SELECT @contador = count(codCliente) FROM tbVenda WHERE @codCliente like codCliente
	RETURN @contador

END

select Compras do Cliente = dbo.fc_ComprasCliente(1) 

--03
CREATE FUNCTION fc_VendedornoMes (@codVendedor INT, @mes INT) 
RETURNS INT 
AS
BEGIN
	DECLARE @contador INT
	SELECT @contador = count(codCliente) FROM tbVenda WHERE @codVendedor like codVendedor and @mes like DATEPART(m,dataVenda)
	RETURN @contador

END

select Vendas_no_Mes = dbo.fc_VendedornoMes(1, 2) 

--04
CREATE FUNCTION fc_cpf (@CPF VARCHAR)
RETURNS CHAR(1)
AS
BEGIN
	DECLARE @i INT, @soma INT, @primeiroD INT, @segundoD INT,
	 @cpfT VARCHAR(11), @digIguais CHAR(1), @r CHAR(1)

	SET @r = 'N'

	SET @cpfT = SUBSTRING(@CPF, 1, 1)

	SET @i = 1
	SET @digIguais = '5'

	WHILE(@i <= 11)
		IF(SUBSTRING(@CPF, @i, 1) <> @cpfT)
			SET @digIguais = 'N'
		SET @i += 1

	IF(@digIguais LIKE 'N')
		SET @soma = 0
		SET @i = 1
		WHILE(@i <= 9)
			SET @soma = @soma + CONVERT(INT,SUBSTRING(@CPF, @i, 1) * (11 - @i))
			SET @i += 1

		SET @primeiroD = 11 - (@soma % 11)

	IF(@primeiroD > 9)
		SET @primeiroD = 0


	SET @soma = 0
	SET @i = 1
	WHILE(@i <= 10)
		SET @soma = @soma + CONVERT(INT,SUBSTRING(@CPF, @i, 1) * (12 - @i))
		SET @i += 1
	SET @segundoD = 11 - (@soma % 11)

	IF(@segundoD > 9)
		SET @primeiroD = 0


	IF(@primeiroD LIKE SUBSTRING(@CPF, LEN(@CPF)-1, 1)) AND (@segundoD LIKE SUBSTRING(@CPF, LEN(@CPF), 1))
		SET @r = 'S'
	ELSE
		SET @r = 'N'
	RETURN @r


END

SELECT valido = dbo.fc_cpf('171.426.641-93') 
