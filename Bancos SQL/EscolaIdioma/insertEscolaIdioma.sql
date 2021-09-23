go 
use bdEscolaIdiomas

INSERT INTO tbAluno(nomeAluno, dataNascAluno, rgAluno, naturalidadeAluno)
VALUES ('Paulo Santos', '10-03-2000', '82.282.122-0', 'SP')
	,('Maria da Gloria', '03-10-1999', '43.233.123-0', 'SP')
	,('Pedro Nogueira da Silva', '04-04-1998', '23.533.211-9', 'SP')
	,('Gilson Barros Silva', '09-09-1995', '34.221.111-x', 'PE')
	,('Mariana Barbosa Santos', '10-10-2001', '54.222.122-9', 'RJ')
	,('Alessandro Pereira', '11-10-2003', '24.402.454-9', 'ES')
	,('Aline Melo', '10-08-2001', '88.365.012-3', 'RJ')
SELECT * FROM tbAluno

INSERT INTO tbCurso (nomeCurso, caragaHorariaCurso, valorCurso)
VALUES ('Inglês', 2000, 356.00)
	,('Alemão', 3000, 487.00)
	,('Espanhol', 4000, 500.00)
SELECT * FROM tbCurso

INSERT INTO tbTurma(nomeTurma, codCurso, horarioTurma)
VALUES ('1|A', 1, '1900-01-01T12:00:00')
	,('1|C', 3, '1900-01-01T18:00:00')
	,('1|B', 1, '1900-01-01T18:00:00')
	,('1|AA', 2, '1900-01-01T19:00:00')
SELECT * FROM tbTurma

INSERT INTO tbMatricula(dataMatricula, codAluno, codTurma)
VALUES ('03-10-2015', 7, 1)
	,('04-05-2014', 2, 1)
	,('04-05-2014', 2, 4)
	,('03-05-2012', 3, 2)
	,('03-03-2016', 1, 3)
	,('07-05-2015', 4, 2)
	,('05-07-2015', 4, 3)
SELECT * FROM tbMatricula

