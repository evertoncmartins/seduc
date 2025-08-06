--🔸PARTE 1: Revisão das propriedades ACID (teórica, não há código)
-- Esta parte exige uma explicação teórica, mas vamos traduzir para comentários no código para referência.
-- Atomicidade: Garante que uma transação seja tratada como uma única operação. Ou ela é totalmente executada (COMMIT) ou totalmente desfeita (ROLLBACK). Não há estado parcial.
-- Consistência: Garante que a transação leve o banco de dados de um estado válido para outro.
-- Isolamento: Garante que a execução de uma transação não seja visível para outras transações concorrentes até que ela seja concluída. É como se cada transação estivesse sendo executada sozinha.
-- Durabilidade: Garante que, uma vez que uma transação é confirmada (COMMIT), suas alterações persistem permanentemente, mesmo em caso de falha do sistema.
--
--🔸PARTE 2 - Implementação prática.
-- A primeira etapa é criar um banco de dados para a empresa FastTech e selecioná-lo.
-- Geralmente, o comando CREATE DATABASE não é parte de uma transação, pois ele define a estrutura básica.
CREATE DATABASE fasttech;

USE fasttech;

-- Segunda parte: Implementação de controle de transações
-- O próximo passo é criar a tabela `pedidos` conforme especificado no anexo.
-- Esta tabela armazenará os pedidos da plataforma de vendas online.
-- Note a definição de colunas, tipos de dados e a chave primária.
   CREATE TABLE pedidos (
          id INT AUTO_INCREMENT PRIMARY KEY,
          cliente VARCHAR(100),
          produto VARCHAR(100),
          quantidade INT,
          valor DECIMAL(10, 2),
          status VARCHAR(20) DEFAULT 'Pendente'
          );

-- Agora, vamos simular a inserção de um pedido e, em seguida, desfazê-lo com ROLLBACK.
-- Isso demonstra a propriedade de Atomicidade: ou a transação é completa, ou não acontece nada.
-- O comando START TRANSACTION inicia a transação.
-- A instrução INSERT insere os dados do pedido.
-- O comando ROLLBACK desfaz todas as alterações feitas desde o START TRANSACTION.
START TRANSACTION;

-- Inserimos um pedido para 'João Silva'
   INSERT INTO pedidos (cliente, produto, quantidade, valor)
   VALUES ('João Silva', 'Notebook', 1, 3500.00);

-- O ROLLBACK desfaz a inserção acima, como se ela nunca tivesse ocorrido.
-- Se você consultar a tabela agora, este pedido não estará lá.
ROLLBACK;

-- Vamos verificar se o pedido de 'João Silva' foi realmente desfeito.
-- A saída desta consulta deve ser vazia.
   SELECT *
     FROM pedidos;

-- Em seguida, vamos inserir um novo pedido com sucesso e confirmá-lo com COMMIT.
-- Isso garante que as alterações se tornem permanentes no banco de dados,
-- demonstrando a propriedade de Durabilidade.
-- A transação começa com START TRANSACTION.
START TRANSACTION;

-- Inserimos um pedido para 'Maria Souza'.
   INSERT INTO pedidos (cliente, produto, quantidade, valor)
   VALUES ('Maria Souza', 'Smartphone', 2, 2000.00);

-- O COMMIT confirma todas as alterações desde o START TRANSACTION, tornando-as
-- permanentes e visíveis para outras transações.
COMMIT;

-- Vamos verificar se o pedido de 'Maria Souza' foi persistido.
-- A saída desta consulta deve mostrar o pedido inserido.
   SELECT *
     FROM pedidos;

-- Parte 3: Simulação de falha e recuperação de dados
-- A seguir, simulamos uma falha no meio de uma transação para demonstrar
-- como o banco de dados reage e como o ROLLBACK é essencial para a recuperação.
-- A transação começa com START TRANSACTION.
START TRANSACTION;

-- Inserimos um pedido válido para 'Carlos Lima'.
-- A princípio, esta operação é bem-sucedida.
   INSERT INTO pedidos (cliente, produto, quantidade, valor)
   VALUES ('Carlos Lima', 'Tablet', 1, 1500.00);

-- Aqui, simulamos uma falha ao tentar inserir um pedido com dados inválidos.
-- Por exemplo, um cliente com valor NULL e uma quantidade negativa.
-- Isso representaria uma inconsistência ou erro de lógica.
-- O banco de dados pode ou não permitir essa inserção, mas em um sistema real,
-- a lógica de negócio impediria isso, levando a uma decisão de ROLLBACK.
   INSERT INTO pedidos (cliente, produto, quantidade, valor)
   VALUES (NULL, 'Smartwatch', -1, 500.00);

-- O ROLLBACK é executado, desfazendo tanto a inserção válida de 'Carlos Lima'
-- quanto a inserção inválida do 'Smartwatch'.
-- Isso garante que a integridade dos dados seja mantida,
-- pois nenhuma das operações parciais será salva.
ROLLBACK;

-- Agora, vamos verificar se os dados estão consistentes e se as alterações
-- foram de fato revertidas.
-- A saída desta consulta deve mostrar apenas o pedido de 'Maria Souza',
-- pois os pedidos de 'João Silva' e 'Carlos Lima' foram desfeitos.
   SELECT *
     FROM pedidos;

--🔸PARTE 3 - Respostas as questões
-- A partir daqui, as partes 4 e 5 são de discussão e reflexão, não requerem código.
-- A seguir estão as respostas para as perguntas propostas na Parte 4.
--
-- Descreva o impacto da utilização de transações e as propriedades ACID no contexto de sistemas transacionais, como o e-commerce.
-- Resposta: As transações e as propriedades ACID são fundamentais para garantir a integridade e a confiabilidade de sistemas transacionais. No e-commerce, por exemplo, uma transação de pedido envolve várias etapas (ex: debitar do estoque, processar o pagamento, inserir o pedido). Se uma dessas etapas falhar, as propriedades ACID garantem que todas as outras sejam desfeitas (Atomicidade), evitando inconsistências como um produto debitado do estoque, mas não cobrado do cliente.
--
-- Por que é importante garantir a integridade dos dados em todas as operações?
-- Resposta: A integridade dos dados é crucial para evitar erros financeiros e operacionais. No e-commerce, dados inconsistentes podem levar a cobranças duplicadas, produtos que não foram enviados, ou a um estoque que não reflete a realidade, causando prejuízos financeiros e insatisfação do cliente.
--
-- Como o ROLLBACK pode ajudar na recuperação de erros no ambiente de produção?
-- Resposta: O ROLLBACK é uma ferramenta vital para a recuperação de erros. Se um problema inesperado (como um erro de sistema, violação de regra de negócio ou falha de conexão) ocorrer no meio de uma transação, o ROLLBACK reverte todas as alterações incompletas, restaurando o banco de dados para seu estado original e consistente. Isso evita que dados corrompidos ou parciais sejam salvos, facilitando a recuperação e a estabilidade do sistema.
--
-- Explique a importância de COMMIT no controle de transações e na durabilidade dos dados.
-- Resposta: O COMMIT é o comando que confirma o sucesso de uma transação. Ele é essencial porque torna as alterações permanentes no banco de dados, garantindo que os dados não sejam perdidos mesmo em caso de falhas subsequentes do sistema. Isso está diretamente ligado à propriedade de Durabilidade, assegurando que o que foi salvo, permanece salvo. Sem o COMMIT, as alterações seriam temporárias e poderiam ser facilmente desfeitas.