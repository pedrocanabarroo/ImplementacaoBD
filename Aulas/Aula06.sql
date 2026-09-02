-- declare

-- @valor = nome da variável, int = tipo da variável

-- para colocar valor na variável usamos SET

-- SET @valor = 10;

-- SELECT @nome = d.nome
-- from dependente as d
-- where id = 2;


-- calcular a idade da jennifer

DECLARE @data_nasc DATE,
		@idade INT;

SELECT @data_nasc = F.Datanasc 
FROM FUNCIONARIO AS F
WHERE F.Pnome = 'Jennifer';

SET @idade = YEAR (GETDATE()) - YEAR(@data_nasc);
PRINT @idade;


-- O funcionário(a) Jennifer tem um salário de : R$ 43000.

-- CAST

SELECT 'O funcionario '
		+ Pnome
		+ ' tem o salario de: R$ '
		+ CAST (Salario AS VARCHAR(10)) AS 'Nome + Salário', 
		Cpf
FROM FUNCIONARIO;


-- CONVERT

SELECT 'O funcionario '
		+ Pnome
		+ ' tem o salario de: R$ '
		+ CONVERT(VARCHAR(10), Salario) AS 'Nome + Salário'
FROM FUNCIONARIO;

-- converta a data de nascimento da jennifer para o padrão brasileiro: dd/mm/aaaa

DECLARE @date DATE;

SELECT @date = Datanasc
FROM FUNCIONARIO
WHERE Pnome = 'Jennifer'

PRINT 'Formato padrão: '+ CAST(@date AS VARCHAR(10));
PRINT 'Formato francês: '+ CONVERT(VARCHAR(10), @date, 103);

-- IF ELSE

DECLARE @nome VARCHAR(50),
		@idade INT;

SET @nome = 'Herysson';
SET @idade = 16;

IF (@idade >= 18 AND @idade <= 150)
	PRINT 'O ' + @nome + ' é maior de idade';
ELSE IF (@idade < 0 OR @idade > 150)
	PRINT 'Valor incorreto';
ELSE
	PRINT 'O ' + @nome + ' é menor de idade';

-- Verificar se um Funcionário Recebe Abaixo da Média Salarial

DECLARE @media DECIMAL(10,2),
		@salario DECIMAL(10,2);

SELECT @media = AVG (F.Salario)
FROM FUNCIONARIO AS F;

SELECT @salario = F.Salario
FROM FUNCIONARIO AS F
WHERE F.Pnome = 'Ana';

PRINT @media;

IF (@salario < @media)
	PRINT 'Funcionario fudido';
ELSEl
	PRINT 'Tá no lucro';







DECLARE @nome VARCHAR(50),
        @salario DECIMAL(10,2),
        @media DECIMAL(10,2);

SET @nome = 'Jennifer';

SELECT @salario = Salario
FROM FUNCIONARIO
WHERE Pnome = @nome;

SELECT @media = AVG(Salario)
FROM FUNCIONARIO;

IF (@salario < @media)
    PRINT 'A funcionária ' + @nome + ' recebe abaixo da média salarial';
ELSE
    PRINT 'A funcionária ' + @nome + ' não recebe abaixo da média salarial';




DECLARE @nome VARCHAR(50),
        @bonus DECIMAL(10,2);

-- Jennifer
SET @nome = 'Jennifer';

SELECT @bonus = Bonus
FROM FUNCIONARIO
WHERE Pnome = @nome;

IF (@bonus > 0)
    PRINT 'A funcionária ' + @nome + ' já recebeu bônus este ano';
ELSE
    PRINT 'A funcionária ' + @nome + ' ainda não recebeu bônus este ano';


--Verificar se um Funcionário Já Recebeu Bônus Este Ano.

-- Jorge
SET @nome = 'Jorge';

SELECT @bonus = Bonus
FROM FUNCIONARIO
WHERE Pnome = @nome;

IF (@bonus > 0)
    PRINT 'O funcionário ' + @nome + ' já recebeu bônus este ano';
ELSE
    PRINT 'O funcionário ' + @nome + ' ainda não recebeu bônus este ano';


-- Paulo
SET @nome = 'Paulo';

SELECT @bonus = Bonus
FROM FUNCIONARIO
WHERE Pnome = @nome;

IF (@bonus > 0)
    PRINT 'O funcionário ' + @nome + ' já recebeu bônus este ano';
ELSE
    PRINT 'O funcionário ' + @nome + ' ainda não recebeu bônus este ano';
