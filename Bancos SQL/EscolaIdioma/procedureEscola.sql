

--01



CREATE PROCEDURE spBuscador_Aluno 
@rg VARCHAR(15) 
AS
	begin
		IF EXISTS(SELECT codAluno FROM tbAluno WHERE rgAluno != @rg)
		begin
			SELECT nomeAluno,dataNascAluno FROM tbAluno WHERE @rg like rgAluno
		end
		else
		begin
			print('Impossivel consultar. Aluno rg '+@rg+' invalido')
		end
	end


	
EXEC spBuscador_Aluno '23.533.211-9'


--02
CREATE PROCEDURE spInsereAluno
	@nome varchar(100), @dataN smalldatetime, @rgAluno varchar(15)
	,@naturalidade varchar(5)
AS
	begin
		IF EXISTS(SELECT codAluno FROM tbAluno WHERE @rgAluno like rgAluno)
		begin
			print('Impossivel cadastrar. Aluno cpf '+@rg+' já cadastrado')
		end
		else
		begin
			INSERT INTO tbAluno(nomeAluno, dataNascAluno, rgAluno,
			naturalidadeAluno)
				VALUES (@nome, @dataN, @rgAluno, @naturalidade)
				declare @codigo int
			set @codigo = (SELECT max(codAluno) from tbAluno)
			print ('Aluno '+@nome+' cadastrado com sucesso! com código '+ convert(varchar(6), @codigo) )
		end
	end



EXEC spInsereAluno 'Antonio Junior', '14/07/1990', '117788-x',
	'SP'
SELECT * FROM tbAluno



--03


CREATE PROCEDURE spAumenta_Preco
@nomeCurso VARCHAR(10), @valorPorc FLOAT
AS
	begin
	IF not EXISTS(SELECT codCurso FROM tbCurso WHERE @nomeCurso like nomeCurso)
		begin
			print('Impossivel alterar, Algo de certo nao esta errado')
		end
		else
		begin
			DECLARE @valorAtual FLOAT
			DECLARE @resul SMALLMONEY
			DECLARE @cod INT
			SELECT @valorAtual = valorCurso, @cod = codCurso FROM tbCurso 
			WHERE @nomeCurso like nomeCurso
			SET @resul = @valorAtual * (1 + @valorPorc / 100)
			PRINT(@resul)
			UPDATE tbCurso 
			SET valorCurso = CONVERT(SMALLMONEY,@resul)
			WHERE codCurso like @cod
			SELECT * FROM tbCurso

		END
	end
	
	EXEC spAumenta_Preco 'Espanhol', 50.0
	SELECT * FROM tbCurso




--04

CREATE PROCEDURE spExibe_AlunosdaTurma
@nomeTurma VARCHAR(5)
AS
	begin
	IF not EXISTS(SELECT codTurma FROM tbTurma WHERE @nomeTurma like nomeTurma)
		begin
			print('Impossivel alterar, Algo de certo nao esta errado')
		end
		else
		begin
			DECLARE @codTurma INT 
			SELECT @codTurma = codTurma FROM tbTurma WHERE @nomeTurma = nomeTurma
			SELECT nomeAluno FROM tbMatricula INNER JOIN tbAluno ON tbMatricula.codAluno = tbAluno.codAluno WHERE codTurma = @codTurma

		END
	end
	
	EXEC spExibe_AlunosdaTurma '1|C'










--05


CREATE PROCEDURE spMatriculaAluno
@nomeCurso VARCHAR(10), @rg VARCHAR (15)
AS
	begin
	IF not EXISTS(SELECT codAluno FROM tbAluno WHERE @rg like rgAluno) and NOT EXISTS( SELECT codCurso FROM tbCurso WHERE @nomeCurso like nomeCurso)
		begin
			print('Impossivel alterar, Algo de certo nao esta errado')
		end
		else
		begin
			DECLARE @codTurma INT  
			DECLARE @codAluno INT  
			SELECT @codTurma = codTurma FROM tbTurma INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso WHERE @nomeCurso like nomeCurso
			SELECT @codAluno = codAluno FROM tbAluno WHERE @rg like rgAluno
			INSERT tbMatricula(dataMatricula, codAluno, codTurma)
			VALUES('19/04/2012', @codAluno, @codTurma)
		END
		
	end
	
	EXEC spMatriculaAluno 'Inglês', '117788-x'
	SELECT * FROM tbMatricula
