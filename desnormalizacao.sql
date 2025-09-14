-- Objetivo: otimizar o desempenho de consultas com redundância controlada.
-- Objetivo: reduzir a quantidade de junções para obter os dados.

-- Exemplo sem Desnormalização (Normalizado)
-- Imagine um sistema de e-commerce com as seguintes tabelas normalizadas:

-- Pedidos (id_pedido, data_pedido, id_cliente)
-- Clientes (id_cliente, nome_cliente, email)
-- Para obter o nome do cliente para cada pedido, você precisaria fazer uma junção entre as duas tabelas.

SELECT
  p.id_pedido,
  p.data_pedido,
  c.nome_cliente
FROM Pedidos AS p
JOIN Clientes AS c
  ON p.id_cliente = c.id_cliente;

-- Essa abordagem é ideal para evitar redundância e manter a integridade dos dados, mas pode se tornar lenta se a tabela Pedidos for muito grande e a consulta for executada com muita frequência.

-- Exemplo com Desnormalização
-- Para desnormalizar, podemos adicionar o campo nome_cliente diretamente à tabela Pedidos, eliminando a necessidade de uma junção para essa consulta específica
-- Tabela 'Pedidos_Desnormalizada'
CREATE TABLE Pedidos_Desnormalizada (
    id_pedido INT PRIMARY KEY,
    data_pedido DATE,
    id_cliente INT,
    nome_cliente VARCHAR(255) -- Este é o campo desnormalizado!
);

SELECT
  id_pedido,
  data_pedido,
  nome_cliente
FROM Pedidos_Desnormalizada;

-- Como a Redundância é Gerenciada?
-- O grande desafio da desnormalização é garantir que a redundância não cause inconsistências. Se o nome do cliente for alterado na tabela Clientes, a tabela Pedidos_Desnormalizada também precisa ser atualizada. É aqui que mecanismos como gatilhos (triggers) são essenciais.
-- Um gatilho é um bloco de código SQL que é executado automaticamente quando um evento específico (como INSERT, UPDATE ou DELETE) ocorre em uma tabela.
-- Veja como seria um gatilho para manter os dados sincronizados:
-- Este é um exemplo simplificado de como um gatilho funcionaria
-- Ele é executado após a atualização do nome de um cliente
-- e atualiza a tabela desnormalizada
CREATE TRIGGER trg_atualiza_nome_cliente
AFTER UPDATE OF nome_cliente ON Clientes
FOR EACH ROW
BEGIN
    UPDATE Pedidos_Desnormalizada
    SET nome_cliente = NEW.nome_cliente
    WHERE id_cliente = NEW.id_cliente;
END;
