# Banco de Dados — EMPRESA

## Introdução

Este documento reúne os comandos SQL desenvolvidos em aula para criação, estruturação, preenchimento e consulta do banco de dados **EMPRESA**.

O banco foi utilizado para praticar conceitos como:

* Criação de banco de dados;
* Criação de tabelas;
* Chaves primárias;
* Chaves estrangeiras;
* Restrições de integridade;
* Relacionamentos entre tabelas;
* Inserção de registros;
* Atualização de registros;
* Alteração da estrutura de tabelas;
* Consultas com `SELECT`;
* Operadores relacionais;
* Operadores lógicos;
* `LIKE`;
* `NULL`;
* Ordenação com `ORDER BY`;
* `DISTINCT`;
* `TOP`;
* Funções de agregação;
* Subconsultas.

---

# 1. Estrutura do Banco de Dados

O banco de dados utilizado nas aulas possui o nome:

```text
EMPRESA
```

As principais tabelas são:

| Tabela            | Descrição                                       |
| ----------------- | ----------------------------------------------- |
| `FUNCIONARIO`     | Armazena os dados dos funcionários              |
| `DEPARTAMENTO`    | Armazena os departamentos da empresa            |
| `LOCALIZACAO_DEP` | Armazena as localizações dos departamentos      |
| `PROJETO`         | Armazena os projetos desenvolvidos pela empresa |
| `TRABALHA_EM`     | Relaciona funcionários aos projetos             |
| `DEPENDENTE`      | Armazena os dependentes dos funcionários        |

---

# 2. Relacionamentos

A estrutura possui os seguintes relacionamentos principais:

```text
FUNCIONARIO
   │
   ├── possui supervisor ────────> FUNCIONARIO
   │
   ├── pertence ────────────────> DEPARTAMENTO
   │
   ├── possui ──────────────────> DEPENDENTE
   │
   └── trabalha ────────────────> TRABALHA_EM
                                      │
                                      └── PROJETO
                                             │
                                             └── DEPARTAMENTO

DEPARTAMENTO
   │
   ├── possui gerente ──────────> FUNCIONARIO
   │
   ├── possui localização ─────> LOCALIZACAO_DEP
   │
   └── possui projetos ────────> PROJETO
```

---

# 3. Criação do Banco de Dados

Inicialmente foi criado o banco de dados `EMPRESA`.

```sql
CREATE DATABASE EMPRESA;
GO

USE EMPRESA;
GO
```

O comando:

```sql
CREATE DATABASE EMPRESA;
```

cria o banco de dados.

Já:

```sql
USE EMPRESA;
```

define o banco `EMPRESA` como o banco que será utilizado pelos próximos comandos.

---

# 4. Criação da Tabela FUNCIONARIO

A primeira tabela criada foi `FUNCIONARIO`.

```sql
CREATE TABLE FUNCIONARIO (
    Pnome VARCHAR(15) NOT NULL,
    Minicial CHAR,
    Unome VARCHAR(15) NOT NULL,
    Cpf CHAR(11),
    Datanasc DATE,
    Endereco VARCHAR(255),
    Sexo CHAR,
    Salario DECIMAL(10,2),
    Cpf_supervisor CHAR(11),
    Dnr INT,

    PRIMARY KEY (Cpf),

    FOREIGN KEY (Cpf_supervisor)
        REFERENCES FUNCIONARIO(Cpf)
);
GO
```

## Estrutura

| Campo            | Tipo            | Descrição               |
| ---------------- | --------------- | ----------------------- |
| `Pnome`          | `VARCHAR(15)`   | Primeiro nome           |
| `Minicial`       | `CHAR`          | Inicial do nome do meio |
| `Unome`          | `VARCHAR(15)`   | Último nome             |
| `Cpf`            | `CHAR(11)`      | CPF do funcionário      |
| `Datanasc`       | `DATE`          | Data de nascimento      |
| `Endereco`       | `VARCHAR(255)`  | Endereço                |
| `Sexo`           | `CHAR`          | Sexo                    |
| `Salario`        | `DECIMAL(10,2)` | Salário                 |
| `Cpf_supervisor` | `CHAR(11)`      | CPF do supervisor       |
| `Dnr`            | `INT`           | Número do departamento  |

A chave primária é:

```sql
PRIMARY KEY (Cpf)
```

Também existe um **autorrelacionamento**, pois um funcionário pode possuir outro funcionário como supervisor:

```sql
FOREIGN KEY (Cpf_supervisor)
REFERENCES FUNCIONARIO(Cpf)
```

---

# 5. Criação da Tabela DEPARTAMENTO

```sql
CREATE TABLE DEPARTAMENTO (
    Dnome VARCHAR(15) NOT NULL,
    Dnumero INT,
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE,

    PRIMARY KEY (Dnumero),

    UNIQUE (Dnome),

    FOREIGN KEY (Cpf_gerente)
        REFERENCES FUNCIONARIO(Cpf)
);
```

## Estrutura

| Campo                 | Tipo          | Descrição                      |
| --------------------- | ------------- | ------------------------------ |
| `Dnome`               | `VARCHAR(15)` | Nome do departamento           |
| `Dnumero`             | `INT`         | Número identificador           |
| `Cpf_gerente`         | `CHAR(11)`    | CPF do gerente                 |
| `Data_inicio_gerente` | `DATE`        | Data em que iniciou a gerência |

A chave primária é:

```sql
PRIMARY KEY (Dnumero)
```

O nome do departamento deve ser único:

```sql
UNIQUE (Dnome)
```

O gerente deve ser um funcionário cadastrado:

```sql
FOREIGN KEY (Cpf_gerente)
REFERENCES FUNCIONARIO(Cpf)
```

---

# 6. Relacionando FUNCIONARIO e DEPARTAMENTO

Após a criação das tabelas, foi adicionada uma chave estrangeira na tabela `FUNCIONARIO`.

```sql
ALTER TABLE FUNCIONARIO
ADD CONSTRAINT Dnr
FOREIGN KEY (Dnr)
REFERENCES DEPARTAMENTO(Dnumero);
```

Esse relacionamento determina que o campo:

```text
FUNCIONARIO.Dnr
```

deve corresponder a um:

```text
DEPARTAMENTO.Dnumero
```

Portanto, cada funcionário pode estar associado a um departamento.

---

# 7. Criação da Tabela LOCALIZACAO_DEP

```sql
CREATE TABLE LOCALIZACAO_DEP (
    Dnumero INT NOT NULL,
    Dlocal VARCHAR(15) NOT NULL,

    PRIMARY KEY (Dnumero, Dlocal),

    FOREIGN KEY (Dnumero)
        REFERENCES DEPARTAMENTO(Dnumero)
);
```

A tabela possui uma **chave primária composta**:

```sql
PRIMARY KEY (Dnumero, Dlocal)
```

Isso permite que um mesmo departamento possua mais de uma localização.

Exemplo:

```text
Departamento 5
├── Santo André
├── Itu
└── São Paulo
```

---

# 8. Criação da Tabela PROJETO

```sql
CREATE TABLE PROJETO (
    Projnome VARCHAR(15) NOT NULL,
    Projnumero INT NOT NULL,
    Projlocal VARCHAR(15),
    Dnum INT,

    PRIMARY KEY (Projnumero),

    UNIQUE (Projnome),

    FOREIGN KEY (Dnum)
        REFERENCES DEPARTAMENTO(Dnumero)
);
```

## Estrutura

| Campo        | Descrição                |
| ------------ | ------------------------ |
| `Projnome`   | Nome do projeto          |
| `Projnumero` | Número do projeto        |
| `Projlocal`  | Localização do projeto   |
| `Dnum`       | Departamento responsável |

Cada projeto pertence a um departamento.

---

# 9. Criação da Tabela TRABALHA_EM

A tabela `TRABALHA_EM` representa o relacionamento entre funcionários e projetos.

```sql
CREATE TABLE TRABALHA_EM (
    Fcpf CHAR(11) NOT NULL,
    Pnr INT NOT NULL,
    Horas DECIMAL(3,1) NOT NULL,

    PRIMARY KEY (Fcpf, Pnr),

    FOREIGN KEY (Fcpf)
        REFERENCES FUNCIONARIO(Cpf),

    FOREIGN KEY (Pnr)
        REFERENCES PROJETO(Projnumero)
);
```

A chave primária é composta por:

```text
Fcpf + Pnr
```

Isso permite identificar em qual projeto determinado funcionário trabalha.

O campo `Horas` representa a quantidade de horas trabalhadas naquele projeto.

---

# 10. Criação da Tabela DEPENDENTE

```sql
CREATE TABLE DEPENDENTE (
    Fcpf CHAR(11) NOT NULL,
    Nome_dependente VARCHAR(15) NOT NULL,
    Sexo CHAR,
    Datanasc DATE,
    Parentesco VARCHAR(8),

    PRIMARY KEY (Fcpf, Nome_dependente),

    FOREIGN KEY (Fcpf)
        REFERENCES FUNCIONARIO(Cpf)
);
```

A tabela possui uma chave primária composta:

```sql
PRIMARY KEY (Fcpf, Nome_dependente)
```

Assim, diferentes funcionários podem possuir dependentes com o mesmo nome.

---

# 11. Inserindo os Departamentos

```sql
INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Pesquisa', 5);

INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Administração', 4);

INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Matriz', 1);
```

Para visualizar os departamentos:

```sql
SELECT *
FROM DEPARTAMENTO;
```

---

# 12. Inserindo Funcionários

Foram cadastrados inicialmente os seguintes funcionários:

```sql
INSERT INTO FUNCIONARIO
VALUES (
    'Jorge',
    'E',
    'Brito',
    '88866555576',
    '1937-11-10',
    'Rua do Horto, 35, São Paulo, SP',
    'M',
    55000,
    NULL,
    1
);

INSERT INTO FUNCIONARIO
VALUES (
    'Jennifer',
    'S',
    'Souza',
    '98765432168',
    '1941-06-20',
    'Av Arthur de Lima, 54, Santo André, SP',
    'F',
    43000,
    '88866555576',
    4
);

INSERT INTO FUNCIONARIO
VALUES (
    'Fernando',
    'T',
    'Wong',
    '33344555587',
    '1955-12-08',
    'Rua da Lapa, 34, São Paulo, SP',
    'M',
    40000,
    '88866555576',
    5
);

INSERT INTO FUNCIONARIO
VALUES (
    'João',
    'B',
    'Silva',
    '12345678966',
    '1965-01-09',
    'Rua das Flores, 751, São Paulo, SP',
    'M',
    30000,
    '33344555587',
    5
);

INSERT INTO FUNCIONARIO
VALUES (
    'Alice',
    'J',
    'Zelaya',
    '99988777767',
    '1968-01-19',
    'Rua Souza Lima, 35, Curitiba, PR',
    'F',
    25000,
    '98765432168',
    4
);

INSERT INTO FUNCIONARIO
VALUES (
    'Ronaldo',
    'K',
    'Lima',
    '66688444476',
    '1962-09-15',
    'Rua Rebouças, 65, Piracicaba, SP',
    'M',
    38000,
    '33344555587',
    5
);

INSERT INTO FUNCIONARIO
VALUES (
    'Joice',
    'A',
    'Leite',
    '45345345376',
    '1972-07-31',
    'Av. Lucas Obes, 74, São Paulo, SP',
    'F',
    25000,
    '33344555587',
    5
);

INSERT INTO FUNCIONARIO
VALUES (
    'André',
    'E',
    'Brito',
    '98798798733',
    '1969-03-29',
    'Rua Timbira, 35, São Paulo, SP',
    'M',
    25000,
    '98765432168',
    4
);
```

---

# 13. Atualizando um Funcionário

Foi utilizada a instrução `UPDATE` para corrigir o endereço de um funcionário.

```sql
UPDATE FUNCIONARIO
SET Endereco = 'Rua Reboucas, 65, Piracicaba, SP'
WHERE Cpf = '66688444476';
```

O `WHERE` determina qual registro será alterado.

Para consultar todos os funcionários:

```sql
SELECT *
FROM FUNCIONARIO;
```

---

# 14. Definindo os Gerentes dos Departamentos

Após inserir os funcionários, foi possível associar os gerentes aos departamentos.

## Departamento de Pesquisa

```sql
UPDATE DEPARTAMENTO
SET
    Cpf_gerente = '33344555587',
    Data_inicio_gerente = '1988-05-22'
WHERE Dnumero = 5;
```

## Departamento de Administração

```sql
UPDATE DEPARTAMENTO
SET
    Cpf_gerente = '98765432168',
    Data_inicio_gerente = '1995-01-01'
WHERE Dnumero = 4;
```

## Matriz

```sql
UPDATE DEPARTAMENTO
SET
    Cpf_gerente = '88866555576',
    Data_inicio_gerente = '1981-06-19'
WHERE Dnumero = 1;
```

Consulta:

```sql
SELECT *
FROM DEPARTAMENTO;
```

---

# 15. Preenchendo LOCALIZACAO_DEP

```sql
INSERT INTO LOCALIZACAO_DEP
VALUES (1, 'São Paulo');

INSERT INTO LOCALIZACAO_DEP
VALUES (4, 'Mauá');

INSERT INTO LOCALIZACAO_DEP
VALUES (5, 'Santo André');

INSERT INTO LOCALIZACAO_DEP
VALUES (5, 'Itu');

INSERT INTO LOCALIZACAO_DEP
VALUES (5, 'São Paulo');
```

Consulta:

```sql
SELECT *
FROM LOCALIZACAO_DEP;
```

---

# 16. Preenchendo a Tabela PROJETO

```sql
INSERT INTO PROJETO
VALUES ('ProdutoX', 1, 'Santo André', 5);

INSERT INTO PROJETO
VALUES ('ProdutoY', 2, 'Itu', 5);

INSERT INTO PROJETO
VALUES ('ProdutoZ', 3, 'São Paulo', 5);

INSERT INTO PROJETO
VALUES ('Informatização', 10, 'Mauá', 4);

INSERT INTO PROJETO
VALUES ('Reorganização', 20, 'São Paulo', 1);

INSERT INTO PROJETO
VALUES ('Novosbenefícios', 30, 'Mauá', 4);
```

Consulta:

```sql
SELECT *
FROM PROJETO;
```

---

# 17. Preenchendo a Tabela TRABALHA_EM

```sql
INSERT INTO TRABALHA_EM VALUES ('12345678966', 1, 32.5);
INSERT INTO TRABALHA_EM VALUES ('12345678966', 2, 7.5);

INSERT INTO TRABALHA_EM VALUES ('66688444476', 3, 40);

INSERT INTO TRABALHA_EM VALUES ('45345345376', 1, 20);
INSERT INTO TRABALHA_EM VALUES ('45345345376', 2, 20);

INSERT INTO TRABALHA_EM VALUES ('33344555587', 2, 10);
INSERT INTO TRABALHA_EM VALUES ('33344555587', 3, 10);
INSERT INTO TRABALHA_EM VALUES ('33344555587', 10, 10);
INSERT INTO TRABALHA_EM VALUES ('33344555587', 20, 10);

INSERT INTO TRABALHA_EM VALUES ('99988777767', 10, 10);
INSERT INTO TRABALHA_EM VALUES ('99988777767', 30, 30);

INSERT INTO TRABALHA_EM VALUES ('98798798733', 10, 35);
INSERT INTO TRABALHA_EM VALUES ('98798798733', 30, 5);

INSERT INTO TRABALHA_EM VALUES ('98765432168', 30, 20);
INSERT INTO TRABALHA_EM VALUES ('98765432168', 20, 15);
```

---

# 18. Preenchendo a Tabela DEPENDENTE

```sql
INSERT INTO DEPENDENTE
VALUES ('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha');

INSERT INTO DEPENDENTE
VALUES ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filh0');

INSERT INTO DEPENDENTE
VALUES ('33344555587', 'Janaina', 'F', '1958-05-03', 'Eposa');

INSERT INTO DEPENDENTE
VALUES ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');

INSERT INTO DEPENDENTE
VALUES ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho');

INSERT INTO DEPENDENTE
VALUES ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha');

INSERT INTO DEPENDENTE
VALUES ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');
```

> **Observação:** os valores `Filh0` e `Eposa` foram mantidos como utilizados durante a aula.

---

# 19. Alteração da Tabela FUNCIONARIO

Para as aulas seguintes foram adicionados novos atributos à tabela `FUNCIONARIO`.

## Adicionando Bonus

```sql
ALTER TABLE FUNCIONARIO
ADD Bonus DECIMAL(10,2) NULL;
GO
```

## Adicionando Data de Admissão

```sql
ALTER TABLE FUNCIONARIO
ADD Data_Admissao DATE NULL;
GO
```

A tabela passou a possuir também:

| Campo           | Tipo            | Descrição                       |
| --------------- | --------------- | ------------------------------- |
| `Bonus`         | `DECIMAL(10,2)` | Bônus recebido pelo funcionário |
| `Data_Admissao` | `DATE`          | Data de admissão                |

---

# 20. Inserindo Novos Funcionários

Foram adicionados novos funcionários utilizando explicitamente os campos que receberiam valores.

```sql
INSERT INTO FUNCIONARIO (
    Pnome,
    Minicial,
    Unome,
    Cpf,
    Datanasc,
    Endereco,
    Sexo,
    Salario,
    Cpf_supervisor,
    Dnr,
    Data_Admissao,
    Bonus
)
VALUES
(
    'Carlos',
    'A',
    'Silva',
    '98765432100',
    '1985-04-12',
    'Rua A, 123',
    'M',
    4500.00,
    NULL,
    1,
    '2023-03-01',
    1000.00
),
(
    'Ana',
    'B',
    'Sousa',
    '98765432200',
    '1990-06-23',
    'Rua B, 456',
    'F',
    6500.00,
    '98765432100',
    1,
    '2022-01-15',
    0.00
),
(
    'Maria',
    'C',
    'Oliveira',
    '98765432300',
    '1978-09-17',
    'Rua C, 789',
    'F',
    7500.00,
    '98765432200',
    5,
    '2024-02-01',
    1500.00
),
(
    'Paulo',
    'D',
    'Silva',
    '98765432400',
    '1982-11-05',
    'Rua D, 101',
    'M',
    7000.00,
    '98765432300',
    4,
    '2024-05-15',
    500.00
);
GO
```

---

# 21. Novos Funcionários — Aula 03

Também foram inseridos novos funcionários sem departamento definido inicialmente.

```sql
INSERT INTO FUNCIONARIO (
    Pnome,
    Minicial,
    Unome,
    Cpf,
    Datanasc,
    Endereco,
    Sexo,
    Salario,
    Cpf_supervisor,
    Dnr
)
VALUES
(
    'Carlos',
    'M',
    'Ferreira',
    '12312312311',
    '1980-02-15',
    'Av. Paulista, 1000, São Paulo, SP',
    'M',
    45000,
    NULL,
    NULL
),
(
    'Mariana',
    'L',
    'Gomes',
    '32132132122',
    '1985-06-22',
    'Rua das Acácias, 500, Rio de Janeiro, RJ',
    'F',
    42000,
    NULL,
    NULL
),
(
    'Pedro',
    'A',
    'Silva',
    '65465465433',
    '1990-11-10',
    'Rua da Praia, 200, Salvador, BA',
    'M',
    47000,
    NULL,
    NULL
);
GO
```

---

# 22. Novos Departamentos — Aula 03

```sql
INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES
    ('Vendas', 6),
    ('RH', 7),
    ('TI', 8);
GO
```

A partir desse momento também existem os departamentos:

```text
1 - Matriz
4 - Administração
5 - Pesquisa
6 - Vendas
7 - RH
8 - TI
```

---

# Consultas SQL

# 23. Selecionando o Banco

Antes de executar as consultas:

```sql
USE EMPRESA;
GO
```

---

# 24. SELECT

O comando `SELECT` é utilizado para consultar informações armazenadas no banco de dados.

Estrutura básica:

```sql
SELECT coluna
FROM tabela;
```

Para retornar todas as colunas:

```sql
SELECT *
FROM FUNCIONARIO;
```

---

# 25. DISTINCT

## Listar os diferentes salários maiores ou iguais a R$ 30.000

```sql
SELECT DISTINCT F.Salario
FROM FUNCIONARIO AS F
WHERE F.Salario >= 30000;
```

O comando:

```sql
DISTINCT
```

remove valores duplicados do resultado.

Por exemplo, se vários funcionários possuírem salário de `40000`, o valor será exibido apenas uma vez.

---

# 26. Consultando um Funcionário pelo Nome

## Encontrar o funcionário João

```sql
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Pnome = 'João';
```

O operador:

```sql
=
```

é utilizado para comparar valores.

---

# 27. Operador AND

## Funcionários do sexo masculino com salário maior ou igual a R$ 30.000

```sql
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Salario >= 30000
  AND F.Sexo = 'M';
```

O `AND` determina que **todas as condições precisam ser verdadeiras**.

Neste exemplo:

```text
Salário >= 30000
        E
Sexo = Masculino
```

---

# 28. Operador OR

## Funcionários que moram em São Paulo ou Curitiba

```sql
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Endereco LIKE '%São Paulo%'
   OR F.Endereco LIKE '%Curitiba%';
```

O `OR` determina que **pelo menos uma das condições precisa ser verdadeira**.

---

# 29. LIKE

O operador `LIKE` permite realizar pesquisas dentro de textos.

Exemplo:

```sql
F.Endereco LIKE '%São Paulo%'
```

Os símbolos `%` representam qualquer quantidade de caracteres.

Assim:

```text
%São Paulo%
```

significa:

> Retorne registros que possuam "São Paulo" em qualquer posição do texto.

---

# 30. Operador NOT

## Funcionários que não moram em São Paulo

```sql
SELECT *
FROM FUNCIONARIO AS F
WHERE NOT F.Endereco LIKE '%São Paulo%';
```

O `NOT` inverte uma condição.

Nesse caso:

```text
NÃO possuir "São Paulo" no endereço.
```

---

# 31. ORDER BY

## Funcionários em ordem decrescente de salário

Situação proposta:

> É necessário analisar a folha de pagamento para um possível corte de orçamento.

```sql
SELECT *
FROM FUNCIONARIO AS F
ORDER BY F.Salario DESC;
```

O comando:

```sql
DESC
```

representa **ordem decrescente**.

Resultado conceitual:

```text
Maior salário
     ↓
     ↓
     ↓
Menor salário
```

Para ordem crescente poderia ser utilizado:

```sql
ASC
```

---

# 32. IS NULL

## Funcionários que não possuem supervisor

```sql
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Cpf_supervisor IS NULL;
```

`NULL` representa ausência de valor.

Para procurar campos sem valor deve-se utilizar:

```sql
IS NULL
```

e não:

```sql
= NULL
```

---

# 33. IS NOT NULL

## Funcionários que possuem supervisor

```sql
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Cpf_supervisor IS NOT NULL;
```

`IS NOT NULL` seleciona registros em que existe um valor armazenado.

---

# 34. TOP

## Recuperar os três funcionários com maiores salários

```sql
SELECT TOP 3 *
FROM FUNCIONARIO AS F
ORDER BY F.Salario DESC;
```

Primeiro os funcionários são ordenados do maior salário para o menor:

```sql
ORDER BY F.Salario DESC
```

Depois apenas os três primeiros são retornados:

```sql
TOP 3
```

---

# 35. Função MIN

## Encontrar o menor salário

```sql
SELECT MIN(F.Salario)
FROM FUNCIONARIO AS F
WHERE F.Salario > 0;
```

A função:

```sql
MIN()
```

retorna o menor valor encontrado.

Porém, essa consulta retorna apenas **o valor do salário**, não todos os dados do funcionário.

---

# 36. Subconsulta — Funcionário com Menor Salário

Para recuperar todos os dados do funcionário com menor salário foi utilizada uma consulta aninhada.

```sql
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Salario = (
    SELECT MIN(Salario)
    FROM FUNCIONARIO
    WHERE Salario > 0
);
```

Funcionamento:

```text
Consulta externa
        │
        ▼
SELECT * FROM FUNCIONARIO
        │
        ▼
Onde Salario seja igual
        │
        ▼
┌──────────────────────────────┐
│      Subconsulta             │
│                              │
│ SELECT MIN(Salario)          │
│ FROM FUNCIONARIO             │
│ WHERE Salario > 0            │
└──────────────────────────────┘
```

Primeiro é descoberto o menor salário.

Depois são buscados os funcionários que possuem aquele salário.

---

# 37. Função COUNT

## Quantidade de funcionários cadastrados

```sql
SELECT COUNT(F.Pnome)
FROM FUNCIONARIO AS F;
```

A função:

```sql
COUNT()
```

é utilizada para contar registros.

Outra forma utilizada:

```sql
SELECT COUNT(F.Cpf) AS 'Num Func'
FROM FUNCIONARIO AS F;
```

O resultado recebe o nome:

```text
Num Func
```

---

# 38. Função AVG

## Média salarial dos funcionários

```sql
SELECT AVG(F.Salario) AS 'Média Salarial'
FROM FUNCIONARIO AS F;
```

A função:

```sql
AVG()
```

calcula a média dos valores.

Conceitualmente:

```text
Soma dos salários
──────────────────
Nº de funcionários
```

---

# 39. Função SUM

## Custo mensal da folha de pagamento

```sql
SELECT SUM(F.Salario) AS 'Custo Mensal'
FROM FUNCIONARIO AS F;
```

A função:

```sql
SUM()
```

soma todos os valores de uma determinada coluna.

Nesse caso:

```text
Salário funcionário 1
+ Salário funcionário 2
+ Salário funcionário 3
+ ...
────────────────────────
Custo mensal
```

---

# 40. Quantidade de Dependentes

```sql
SELECT COUNT(D.Nome_dependente) AS 'Num Depen'
FROM DEPENDENTE AS D;
```

Essa consulta conta quantos dependentes estão cadastrados.

---

# 41. Total de Pessoas no Banco

O objetivo foi somar:

```text
Funcionários + Dependentes
```

Consulta:

```sql
SELECT
    (SELECT COUNT(Cpf)
     FROM FUNCIONARIO)
    +
    (SELECT COUNT(Nome_dependente)
     FROM DEPENDENTE)
    AS 'Total';
```

Essa consulta utiliza duas subconsultas.

Primeira:

```sql
SELECT COUNT(Cpf)
FROM FUNCIONARIO
```

Segunda:

```sql
SELECT COUNT(Nome_dependente)
FROM DEPENDENTE
```

Depois os dois resultados são somados.

---

# 42. Funcionários Nascidos em 1972

A consulta utilizada em aula foi:

```sql
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Datanasc LIKE '%1972%';
```

O objetivo é recuperar funcionários cuja data de nascimento esteja no ano de `1972`.

No banco utilizado em aula, por exemplo:

```text
Joice A. Leite
Data de nascimento: 1972-07-31
```

---

# 43. Resumo dos Principais Comandos

| Comando           | Função                                         |
| ----------------- | ---------------------------------------------- |
| `CREATE DATABASE` | Cria um banco                                  |
| `USE`             | Seleciona o banco                              |
| `CREATE TABLE`    | Cria uma tabela                                |
| `ALTER TABLE`     | Altera uma tabela                              |
| `INSERT INTO`     | Insere registros                               |
| `UPDATE`          | Atualiza registros                             |
| `SELECT`          | Consulta dados                                 |
| `WHERE`           | Define condições                               |
| `DISTINCT`        | Remove valores duplicados                      |
| `AND`             | Exige que todas as condições sejam verdadeiras |
| `OR`              | Exige que uma das condições seja verdadeira    |
| `NOT`             | Nega uma condição                              |
| `LIKE`            | Pesquisa padrões em textos                     |
| `IS NULL`         | Procura ausência de valor                      |
| `IS NOT NULL`     | Procura valores não nulos                      |
| `ORDER BY`        | Ordena registros                               |
| `ASC`             | Ordem crescente                                |
| `DESC`            | Ordem decrescente                              |
| `TOP`             | Limita a quantidade de resultados              |
| `MIN()`           | Retorna o menor valor                          |
| `MAX()`           | Retorna o maior valor                          |
| `COUNT()`         | Conta registros                                |
| `AVG()`           | Calcula a média                                |
| `SUM()`           | Soma valores                                   |

---

# 44. Resumo das Funções de Agregação

## COUNT

Conta registros:

```sql
SELECT COUNT(Cpf)
FROM FUNCIONARIO;
```

---

## SUM

Soma valores:

```sql
SELECT SUM(Salario)
FROM FUNCIONARIO;
```

---

## AVG

Calcula a média:

```sql
SELECT AVG(Salario)
FROM FUNCIONARIO;
```

---

## MIN

Retorna o menor valor:

```sql
SELECT MIN(Salario)
FROM FUNCIONARIO;
```

---

## MAX

Retorna o maior valor:

```sql
SELECT MAX(Salario)
FROM FUNCIONARIO;
```

---

# 45. Resumo dos Operadores

## Operadores relacionais

| Operador     | Significado    |
| ------------ | -------------- |
| `=`          | Igual          |
| `<>` ou `!=` | Diferente      |
| `>`          | Maior          |
| `<`          | Menor          |
| `>=`         | Maior ou igual |
| `<=`         | Menor ou igual |

---

## Operadores lógicos

| Operador | Significado |
| -------- | ----------- |
| `AND`    | E           |
| `OR`     | OU          |
| `NOT`    | NÃO         |

Exemplo:

```sql
SELECT *
FROM FUNCIONARIO
WHERE Salario >= 30000
  AND Sexo = 'M';
```

---

# 46. Estrutura Final Simplificada

```text
EMPRESA
│
├── FUNCIONARIO
│   ├── Cpf (PK)
│   ├── Pnome
│   ├── Minicial
│   ├── Unome
│   ├── Datanasc
│   ├── Endereco
│   ├── Sexo
│   ├── Salario
│   ├── Cpf_supervisor (FK → FUNCIONARIO)
│   ├── Dnr (FK → DEPARTAMENTO)
│   ├── Bonus
│   └── Data_Admissao
│
├── DEPARTAMENTO
│   ├── Dnumero (PK)
│   ├── Dnome
│   ├── Cpf_gerente (FK → FUNCIONARIO)
│   └── Data_inicio_gerente
│
├── LOCALIZACAO_DEP
│   ├── Dnumero (PK/FK → DEPARTAMENTO)
│   └── Dlocal (PK)
│
├── PROJETO
│   ├── Projnumero (PK)
│   ├── Projnome
│   ├── Projlocal
│   └── Dnum (FK → DEPARTAMENTO)
│
├── TRABALHA_EM
│   ├── Fcpf (PK/FK → FUNCIONARIO)
│   ├── Pnr (PK/FK → PROJETO)
│   └── Horas
│
└── DEPENDENTE
    ├── Fcpf (PK/FK → FUNCIONARIO)
    ├── Nome_dependente (PK)
    ├── Sexo
    ├── Datanasc
    └── Parentesco
```

---

# 47. Conceitos Trabalhados

Durante a construção e utilização deste banco foram praticados conceitos importantes de **Banco de Dados Relacional**.

### Chave Primária

Identifica unicamente um registro.

Exemplo:

```sql
PRIMARY KEY (Cpf)
```

---

### Chave Estrangeira

Cria um relacionamento entre duas tabelas.

Exemplo:

```sql
FOREIGN KEY (Dnr)
REFERENCES DEPARTAMENTO(Dnumero)
```

---

### Chave Primária Composta

Utiliza mais de uma coluna para identificar um registro.

Exemplo:

```sql
PRIMARY KEY (Fcpf, Pnr)
```

Utilizada na tabela:

```text
TRABALHA_EM
```

---

### Restrição UNIQUE

Impede valores repetidos.

Exemplo:

```sql
UNIQUE (Dnome)
```

Assim, dois departamentos não podem possuir exatamente o mesmo nome.

---

### Restrição NOT NULL

Determina que determinado campo deve obrigatoriamente receber um valor.

Exemplo:

```sql
Pnome VARCHAR(15) NOT NULL
```

---

### Subconsulta

Uma consulta pode utilizar o resultado de outra consulta.

Exemplo:

```sql
SELECT *
FROM FUNCIONARIO
WHERE Salario = (
    SELECT MIN(Salario)
    FROM FUNCIONARIO
);
```

---

# 48. Conclusão

O banco de dados `EMPRESA` permitiu trabalhar desde os conceitos básicos de criação e modelagem de um banco relacional até consultas envolvendo filtros, ordenação, funções de agregação e subconsultas.

A estrutura possui relacionamentos entre funcionários, departamentos, projetos e dependentes, permitindo compreender na prática conceitos como:

```text
Banco de Dados
      │
      ├── Tabelas
      │
      ├── Registros
      │
      ├── Chaves Primárias
      │
      ├── Chaves Estrangeiras
      │
      ├── Integridade Referencial
      │
      ├── Relacionamentos
      │
      └── Consultas SQL
             │
             ├── Filtros
             ├── Ordenações
             ├── Agregações
             └── Subconsultas
```

Esse banco servirá como base para o estudo de consultas SQL mais avançadas nas próximas aulas.
