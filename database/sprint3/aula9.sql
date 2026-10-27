CREATE DATABASE sprint3;
USE sprint3;

CREATE TABLE cliente(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45)
);

CREATE TABLE produto(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
preco DECIMAL(10,2)
);

CREATE TABLE pedido(
fk_cliente INT,
fk_produto INT,
data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY (fk_cliente) REFERENCES cliente(id),
FOREIGN KEY (fk_produto) REFERENCES produto(id),

PRIMARY KEY (fk_cliente, fk_produto, data_hora)
);

INSERT INTO cliente (nome) VALUES
('Ana Silva'),
('Carlos Souza'),
('Maria Oliveira'),
('João Santos'),
('Fernanda Lima'),
('Pedro Costa'),
('Juliana Almeida'),
('Rafael Rocha'),
('Vincenzo O\'Conquistador');

SELECT * FROM cliente;

INSERT INTO produto (nome, preco) VALUES
('Pão Francês', 0.75),
('Café Expresso', 5.50),
('Coxinha', 6.00),
('Pão de Queijo', 4.50),
('Suco Natural', 8.00),
('Bolo de Chocolate', 7.50),
('Empada', 5.00),
('Croissant', 6.50),
('Açaí', 12.00),
('Misto Quente', 9.00);

SELECT * FROM produto;

INSERT INTO pedido (fk_cliente, fk_produto, data_hora) VALUES
(1,1,'2024-03-10 07:15:00'),
(1,1,'2024-03-10 07:18:00'),
(1,2,'2024-03-10 07:20:00'),
(2,3,'2024-03-12 08:05:00'),
(2,3,'2024-03-12 08:10:00'),
(2,5,'2024-03-12 08:30:00'),
(3,4,'2024-03-15 09:00:00'),
(3,4,'2024-03-15 09:12:00'),
(3,6,'2024-03-15 09:30:00'),
(4,10,'2024-03-18 18:10:00'),
(4,2,'2024-03-18 18:20:00'),
(4,2,'2024-03-20 18:45:00'),
(5,9,'2024-03-20 15:15:00'),
(5,8,'2024-03-20 15:30:00'),
(5,8,'2024-03-20 15:40:00'),
(6,7,'2024-03-22 10:00:00'),
(6,7,'2024-03-22 10:05:00'),
(6,7,'2024-03-22 10:15:00'),
(6,2,'2024-03-22 10:25:00'),
(7,1,'2024-04-01 06:50:00'),
(7,1,'2024-04-01 07:00:00'),
(7,1,'2024-04-01 07:10:00'),
(7,1,'2024-04-01 07:20:00'),
(7,1,'2024-04-01 07:30:00'),
(8,9,'2024-04-05 16:00:00'),
(8,10,'2024-04-05 16:20:00'),
(9,6,'2024-04-08 14:10:00'),
(9,5,'2024-04-08 14:25:00'),
(1,3,'2024-04-10 11:00:00'),
(1,3,'2024-04-10 11:15:00'),
(2,1,'2024-04-12 08:00:00'),
(2,1,'2024-04-12 08:10:00');

SELECT * FROM pedido;

-- BLOCO 1: COUNT, SUM, AVG, MIN, MAX

-- 1) Quantos pedidos existem no total?
SELECT COUNT(*) AS qtd_pedidos
 FROM pedido;

-- 2) Quantos clientes estão cadastrados?
SELECT COUNT(*) AS qtd_clientes
FROM cliente;

-- 3) Quantos produtos estão cadastrados?
SELECT COUNT(*) AS qtd_produtos
FROM produto;

-- 4) Qual o preço do produto mais caro?
SELECT MAX(preco) AS produto_mais_caro
FROM produto;

-- 5) Qual o preço do produto mais barato?
SELECT MIN(preco) AS produto_mais_barato
FROM produto;

-- 6) Qual o preço médio dos produtos?
SELECT AVG(preco) AS preco_medio
FROM produto;

-- 7) Qual a soma dos preços de todos os produtos cadastrados?
SELECT SUM(preco) AS soma_produtos
FROM produto;

-- 8) Quantos pedidos foram realizados em março de 2024?
SELECT COUNT(*) AS qtd_pedidos
FROM pedido 
WHERE data_hora BETWEEN '2024-03-01' AND '2024-03-31';

-- 9) Quantos pedidos foram realizados em abril de 2024?
SELECT COUNT(*) AS qtd_pedidos
FROM pedido
WHERE data_hora BETWEEN '2024-04-01' AND '2024-04-30';

-- BLOCO 2: GROUP BY

-- 10) Quantos pedidos cada cliente fez?
-- Exiba fk_cliente e a quantidade de pedidos.
SELECT fk_cliente, 
COUNT(*) AS qtd_de_pedidos
FROM pedido 
GROUP BY fk_cliente;

-- 11) Quantas vezes cada produto foi pedido?
-- Exiba fk_produto e a quantidade.
SELECT fk_produto,
COUNT(*) AS qtd_pedido
FROM pedido
GROUP BY fk_produto;

-- 12) Quantos pedidos foram feitos em cada dia?
SELECT DAY(data_hora), 
COUNT(*) AS qtd_pedido
FROM pedido
GROUP BY DAY(data_hora);

-- 13) Quantos pedidos foram feitos em cada mês?
SELECT MONTH(data_hora), 
COUNT(*) AS qtd_pedido_mensal
FROM pedido
GROUP BY MONTH(data_hora);

-- 14) Quais clientes fizeram mais de 3 pedidos?
-- Exiba fk_cliente e a quantidade.
SELECT fk_cliente,
 COUNT(*) AS pedidos
FROM pedido
GROUP BY fk_cliente
HAVING COUNT(*) > 3.0;

-- 15) Quais produtos foram pedidos mais de 3 vezes?
-- Exiba fk_produto e a quantidade.
SELECT fk_produto,
COUNT(*) FROM pedido AS qtd_produtos
GROUP BY fk_produto
HAVING COUNT(*) > 3;

-- 16) Em quais dias houve mais de 3 pedidos?
SELECT 
DAY(data_hora) AS dias
FROM pedido
GROUP BY DAY (data_hora)
HAVING COUNT(*) > 3;

-- BLOCO 3: DATETIME

-- 17) Quantos pedidos foram realizados em cada hora do dia?
SELECT 
COUNT(*)  
FROM pedido
GROUP BY HOUR(data_hora);

-- 18) Em qual horário houve mais pedidos?
SELECT
COUNT(*)
FROM pedido
GROUP BY HOUR(data_hora)
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 19) Quantos pedidos foram realizados no período da manhã?
-- Considere até 11:59.
SELECT
COUNT(*) 
FROM pedido
WHERE HOUR (data_hora) < '11:59:00';


-- 20) Quantos pedidos foram realizados no período da tarde?
-- Considere de 12:00 até 17:59.
SELECT
COUNT(*)
FROM pedido
WHERE HOUR(data_hora) BETWEEN '12:00' AND '17:59';

-- 21) Quantos pedidos foram realizados no período da noite?
-- Considere a partir das 18:00.
SELECT 
COUNT(*)
FROM pedido
WHERE HOUR (data_hora) > '18:00'; 

-- BLOCO 4: JOIN + AGREGAÇÃO

-- 22) Exiba o nome do cliente e quantos pedidos ele fez.
SELECT 
c.nome AS nome_cliente,
COUNT(*) AS qtd_pedidos
FROM pedido AS p
JOIN cliente AS c
ON c.id = p.fk_cliente
GROUP BY fk_cliente;

-- 23) Exiba o nome do produto e quantas vezes foi pedido.
SELECT pr.nome,
COUNT(*) AS qtd_pedido
FROM pedido AS p
JOIN produto AS pr
ON pr.id = p.fk_produto
GROUP BY p.fk_produto;

-- 24) Exiba o nome do cliente e o total gasto por ele.
SELECT 
c.nome,
SUM(pr.preco)
FROM pedido AS p
JOIN cliente AS c
ON c.id = p.fk_cliente
JOIN produto AS pr
ON pr.id = p.fk_produto
GROUP BY fk_cliente;

-- 25) Exiba o nome do produto e o total arrecadado com ele.
SELECT 
pr.nome,
SUM(pr.preco) AS preco
FROM pedido p
JOIN produto AS pr
ON pr.id = p.fk_produto
GROUP BY fk_produto;

-- 26) Exiba o nome do cliente, o nome do produto
-- e quantas unidades daquele produto ele comprou.
SELECT
c.nome,
pr.nome,
COUNT(*)
FROM pedido AS p 
JOIN cliente AS c
ON c.id = p.fk_cliente
JOIN produto AS pr
ON pr.id = p.fk_cliente
GROUP BY fk_cliente;

-- 27) Exiba o nome do cliente e o valor médio gasto por pedido.
SELECT 
c.nome,


-- 28) Exiba o nome do cliente e o produto mais comprado por ele.


-- BLOCO 5: ROUND, TRUNCATE, CEIL, FLOOR

-- 29) Exiba o preço médio dos produtos arredondado para 2 casas decimais.

-- 30) Exiba o preço médio dos produtos truncado para 1 casa decimal.

-- 31) Exiba o preço médio dos produtos arredondado para cima (inteiro).

-- 32) Exiba o preço médio dos produtos arredondado para baixo (inteiro).

-- 33) Exiba o nome e o preço de cada produto
-- arredondado para o inteiro mais próximo.

-- 34) Exiba o valor arrecadado por cada produto
-- arredondado para 2 casas decimais.


-- BLOCO 6: SUBSTRING

-- 35) Exiba os 3 primeiros caracteres do nome de cada cliente.

-- 36) Exiba o nome do produto e as 5 primeiras letras do nome.

-- 37) Exiba os clientes que começam com a letra 'J'.

-- 38) Exiba a inicial do nome de cada cliente.

-- 39) Exiba a inicial do nome de cada cliente
-- e quantos pedidos ele realizou.


-- DESAFIO

-- 40) Qual cliente mais gastou?
-- Exiba o nome e o valor gasto.

-- 41) Qual produto foi o mais vendido?
-- Exiba o nome e a quantidade vendida.

-- 42) Para cada cliente, exiba:
-- nome,
-- total gasto arredondado para 2 casas decimais,
-- quantidade de pedidos realizados.

-- 43) Exiba os 3 clientes que mais gastaram.

-- 44) Exiba os 3 produtos mais vendidos.

-- 45) Qual foi o dia com maior quantidade de pedidos?

-- 46) Qual foi o faturamento total da padaria?

-- 47) Em qual mês a padaria vendeu mais produtos?

-- 48) Qual cliente comprou a maior variedade de produtos diferentes?

