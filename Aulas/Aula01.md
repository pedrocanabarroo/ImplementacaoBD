# implementação de banco de dados

- disciplina terá caráter extensionista na última unidade
- provas difíceis e podendo trazer cola (em uma folha A4) para poder consultar no dia

- Notas
  - Nota 1: trabalho (3,0) + prova (7,0)
  - Nota 2: trabalho (3,0) + prova (7,0)
  - Nota 3: trabalho final (10)


- museu treze de maio (trabalharemos nesse semestre)

- Diagrama Entidade Relacionamento Conceitual (representa um conceito e não o estado físico do banco)
- não cria-se atributo para chave estrangeira

  Exemplo:
    Funcionário (entidade):
      (atributos):
      ID (chave primária) ou também idFuncionário:
      Nome:
      CPF:
      Data_nasc:
      Endereço
        - rua
        - cep
        - numero
        - complemento

  EM SQL:

  /* Lógico_1: */

CREATE TABLE Funcionario (
    Nome VARCHAR(100),
    CPF INT PRIMARY KEY,
    cep CHAR(14),
    rua VARCHAR(100),
    numero INT,
    comp VARCHAR(50),
    data_nasc DATE,
    salario DECIMAL(10,2)
);

<img width="925" height="317" alt="{1A3DC34A-4835-4B72-A1A3-6AE4ECDC2F43}" src="https://github.com/user-attachments/assets/2a6c9e24-fb2e-4fc6-ad63-42fb542d5bf1" />




Exercício para continuar
<img width="876" height="456" alt="{C5279EFF-477A-4355-87D0-CA370B89662A}" src="https://github.com/user-attachments/assets/0d5a3135-5da5-4fb1-b647-42939a9eeec1" />

