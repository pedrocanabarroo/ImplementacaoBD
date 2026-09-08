DECLARE @contador INT = 1;

WHILE @contador <= 10

BEGIN
	PRINT 'Contador: ' + CAST(@contador AS VARCHAR);
	SET @contador = @contador + 1;
	IF @contador = 5
		BREAK;

END


-- cursores
DECLARE @nome VARCHAR(50);
DECLARE cursorFuncionario CURSOR FOR
SELECT Pnome FROM FUNCIONARIO;

OPEN cursorFuncionario;
FETCH NEXT FROM cursorFuncionario INTO @nome;

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @nome
	FETCH NEXT FROM cursorFuncionario INTO @nome;
END
CLOSE cursorFuncionario;
DEALLOCATE cursorFuncionario;


-- final do conteúdo da primeira parte.



-- função

CREATE OR ALTER FUNCTION fn_Dobro(@Numero INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
	RETURN @Numero * 2;
END;


CREATE FUNCTION fn_calc_idade(@data DATE)
RETURNS INT
AS
BEGIN
	DECLARE @idade INT;
	SET @idade = DATEDIFF(YEAR, @data, GETDATE());

	IF (MONTH(@data) > MONTH(GETDATE())
		OR (MONTH(@data) = MONTH(GETDATE()) 
			AND DAY(@data) > DAY(GETDATE())))
			SET @idade = @idade - 1;
	RETURN @idade;
END
GO


CREATE FUNCTION fn_func_dpt(@nome VARCHAR(30))
RETURNS TABLE
AS
RETURN(
	SELECT Pnome, Unome
	FROM FUNCIONARIO AS F
	JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
	WHERE D.Dnome = 'Pesquisa'
);

GO

SELECT dbo.fn_Dobro(10) AS Resultado;

SELECT 
	F.Pnome, 
	F.Unome,
	F.Salario AS 'S.Atual',
	dbo.fn_Dobro(F.Salario) AS 'Dobro'
FROM FUNCIONARIO AS F;
GO

SELECT
	F.Pnome,
	F.Unome,
	F.Datanasc,
	dbo.fn_calc_idade(F.Datanasc) AS 'Idade'
FROM FUNCIONARIO AS F;


