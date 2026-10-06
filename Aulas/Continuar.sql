-- questão 7
SELECT A.Nome, HE.Nota, T.Semestre, T.Ano
FROM ALUNO AS A
JOIN HISTORICO_ESCOLAR AS HE
ON A.Numero_aluno = HE.Numero_aluno
JOIN TURMA AS T
ON HE.Identificacao_turma = T.Identificacao_turma
JOIN DISCIPLINA AS D
ON T.Numero_disciplina = D.Numero_disciplina
WHERE D.Nome_disciplina = 'Banco de Dados I';

-- questão 8
SELECT A.Nome, D.Nome_disciplina, T.Semestre, T.Ano, HE.Nota, HE.Frequencia 
FROM ALUNO AS A
JOIN HISTORICO_ESCOLAR AS HE
ON A.Numero_aluno = HE.Numero_aluno
JOIN TURMA AS T
ON T.Identificacao_turma = HE.Identificacao_turma
JOIN DISCIPLINA AS D
ON D.Numero_disciplina = T.Numero_disciplina
WHERE HE.Frequencia < 75.00 OR HE.Nota < 6.00;

-- questão 9
SELECT
	COUNT(A.Nome) as 'Qtd',
	T.Identificacao_turma,
	T.Semestre,
	D.Nome_disciplina
FROM ALUNO AS A
JOIN HISTORICO_ESCOLAR AS H
ON A.Numero_aluno = H.Numero_aluno
JOIN TURMA AS T
ON H.Identificacao_turma = T.Identificacao_turma
JOIN DISCIPLINA AS D
ON T.Numero_disciplina = D.Numero_disciplina
GROUP BY T.Identificacao_turma, D.Nome_disciplina, T.Semestre;

-- questão 10
GO;

CREATE OR ALTER FUNCTION fn_SituacaoAluno(
	@nota DECIMAL (4,2), 
	@freq DECIMAL (5,2))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @Situacao VARCHAR(50);
	IF @nota IS NULL OR @freq IS NULL
		SET @Situacao = 'Em Andamento';
	ELSE IF @freq < 75
		SET @Situacao = 'Reprovado por frequência';
	ELSE IF @nota >= 7
		SET @Situacao = 'Aprovado';
	ELSE IF @nota >= 5
		SET @Situacao = 'Em Recuperação';
	ELSE 
		SET @Situacao = 'Reprovado';
	RETURN @Situacao;
END;
GO

-- questão 11
CREATE FUNCTION dbo.fn_ConverterNotaConceito
(
    @Nota DECIMAL(4,2)
)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @Conceito VARCHAR(20);

    IF @Nota IS NULL
        SET @Conceito = 'Sem nota';
    ELSE IF @Nota >= 9.0 AND @Nota <= 10.0
        SET @Conceito = 'A';
    ELSE IF @Nota >= 7.0
        SET @Conceito = 'B';
    ELSE IF @Nota >= 5.0
        SET @Conceito = 'C';
    ELSE
        SET @Conceito = 'D';

    RETURN @Conceito;
END;
GO

SELECT dbo.fn_SituacaoAluno(7, 70);

-- questão 12
CREATE PROCEDURE dbo.usp_ListarAlunosPorCurso
(
    @SiglaCurso VARCHAR(10)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Numero,
        Nome
    FROM Aluno
    WHERE SiglaCurso = @SiglaCurso
    ORDER BY Nome;
END;
GO

-- questão 13
CREATE PROCEDURE dbo.usp_CadastrarDisciplina
(
    @Codigo       INT,
    @Nome         VARCHAR(100),
    @Creditos     INT,
    @Departamento VARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Verifica se já existe disciplina com o mesmo código
    IF EXISTS (
        SELECT 1
        FROM Disciplina
        WHERE Codigo = @Codigo
    )
    BEGIN
        PRINT 'Falha: já existe uma disciplina com este código.';
        RETURN;
    END;

    -- Verifica se já existe disciplina com o mesmo nome
    IF EXISTS (
        SELECT 1
        FROM Disciplina
        WHERE Nome = @Nome
    )
    BEGIN
        PRINT 'Falha: já existe uma disciplina com este nome.';
        RETURN;
    END;

    -- Verifica se a quantidade de créditos é maior que zero
    IF @Creditos <= 0
    BEGIN
        PRINT 'Falha: a quantidade de créditos deve ser maior que zero.';
        RETURN;
    END;

    -- Realiza o cadastro
    INSERT INTO Disciplina
    (
        Codigo,
        Nome,
        Creditos,
        Departamento
    )
    VALUES
    (
        @Codigo,
        @Nome,
        @Creditos,
        @Departamento
    );

    PRINT 'Disciplina cadastrada com sucesso.';
END;
GO
