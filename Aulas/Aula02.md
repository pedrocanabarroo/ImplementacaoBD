2ª aula de revisão de implementação de banco de dados

# entidade dependente de outra entidade = entidade fraca 

  DML (Data Manipulation Language)
  Comandos usados para manipular os dados armazenados nas tabelas.

    SELECT: Consulta e retorna dados de uma ou mais tabelas.
    INSERT: Insere novos registros em uma tabela.
    UPDATE: Atualiza os dados de registros existentes.
    DELETE: Remove registros de uma tabela.
  
  DDL (Data Definition Language)
  Comandos utilizados para criar e modificar a estrutura do banco de dados.

    CREATE: Cria objetos no banco de dados, como tabelas, bancos, índices e views.
    ALTER: Altera a estrutura de um objeto existente (adicionar, remover ou modificar colunas, por exemplo).
    DROP: Exclui permanentemente um objeto do banco de dados.
    TRUNCATE: Remove todos os registros de uma tabela de forma rápida, mantendo sua estrutura.

  DCL (Data Control Language)
  Comandos relacionados ao controle de permissões e segurança.

    GRANT: Concede permissões de acesso ou execução para usuários ou grupos.
    REVOKE: Remove permissões previamente concedidas.
  
  TCL (Transaction Control Language)
  Comandos utilizados para controlar transações no banco de dados.

    SAVEPOINT: Cria um ponto de restauração dentro de uma transação.
    ROLLBACK: Desfaz alterações de uma transação, retornando ao último SAVEPOINT ou ao início da transação.
    COMMIT: Confirma as alterações realizadas na transação, tornando-as permanentes no banco de dados.
