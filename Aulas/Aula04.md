# Foram feitas consultas utilizando joins

-- Selecionar o primeiro nome, último nome, endereço dos funcionários que 
-- trabalham no departamento de “Pesquisa”
SELECT 
	F.Pnome AS 'Nome', 
	F.Unome AS 'Sobrenome', 
	F.Endereco AS 'Endereço', 
	D.Dnome AS 'Nome do Departamento'
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
WHERE D.Dnome = 'Pesquisa';
GO

-- Liste o nome dos funcionários que estão desenvolvendo o “ProdutoX”. 

SELECT F.Pnome, TE.Pnr, P.Projnome
FROM FUNCIONARIO AS F
INNER JOIN TRABALHA_EM AS TE
ON TE.Fcpf = F.Cpf
INNER JOIN PROJETO AS P
ON TE.Pnr = P.Projnumero
WHERE P.Projnome = 'ProdutoX';

-- Para cada projeto localizado em “Mauá”, liste o número do projeto, 
-- o número do departamento que o
-- controla e o sobrenome, endereço e data de nascimento do gerente do departamento.

SELECT *
FROM PROJETO;

SELECT 
	F.Unome, 
	F.Endereco, 
	F.Datanasc, 
	D.Dnumero, 
	P.Projnumero
FROM DEPARTAMENTO AS D
INNER JOIN PROJETO AS P
ON D.Dnumero = P.Dnum
INNER JOIN FUNCIONARIO AS F
ON D.Cpf_gerente = F.Cpf
WHERE P.Projlocal = 'Mauá';


-- Liste o último nome de TODOS os funcionários e o 
-- último nome dos respectivos gerentes, caso possuam
SELECT F.Unome, D.Cpf_gerente
FROM FUNCIONARIO AS F
LEFT JOIN DEPARTAMENTO AS D
ON D.Cpf_gerente = F.Cpf
WHERE D.Cpf_gerente IS NOT NULL;

-- para todos os funcionarios e respectivos supervisores

SELECT 
	FU.Unome AS 'Último nome dos supervisores', 
	F.Unome AS 'Último nome dos funcionários'
FROM FUNCIONARIO AS F
LEFT JOIN FUNCIONARIO AS FU
ON F.Cpf_supervisor = FU.Cpf;

-- Encontre os departamentos que não possuem funcionários a eles vinculados

SELECT *
FROM DEPARTAMENTO AS D
LEFT JOIN FUNCIONARIO AS F
ON F.Dnr = D.Dnumero

-- encontrar os funcionários que não possuem dependentes

SELECT *
FROM DEPENDENTE AS D
RIGHT JOIN FUNCIONARIO AS F
ON F.Cpf = D.Fcpf
WHERE D.Fcpf IS NOT NULL;

-- teste entre as relações entre funcionários e departamentos

SELECT *
FROM FUNCIONARIO AS F
FULL JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero;
