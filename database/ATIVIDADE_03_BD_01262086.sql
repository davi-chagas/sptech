CREATE DATABASE game_store;

use game_store;

CREATE TABLE jogo (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30),
    diretor VARCHAR(30),
    genero VARCHAR(30),
    data_lancamento DATE,
    nota INT,
    CONSTRAINT chNota CHECK(nota >= 0 AND nota <= 10),
    quantidade INT
);

DROP TABLE jogo;
INSERT INTO jogo (nome, diretor, genero, data_lancamento, nota, quantidade) VALUES 
('Rainbow Six Siege', 'Alexander Karpazis', 'FPS', '2015-10-13', 7, 30),
('Minecraft', 'Agnes Larsson', 'Sandbox', '2009-05-07', 8, 350),
('Fortnite', 'Breno ', 'Battle Royale', '2017-09-20', 5, 205),
('Zelda Ocarina of time', 'Daniel', 'Fantasia', '1999-02-10', 6, 303),
('Free Fire', 'Loud Coringa', 'Battle Royale', '2018-05-10', 6, 30);

--  Alterar a tabela para inserir uma coluna que represente o tipo_midia, que deve armazenar o tipo de jogo apenas com os valores “física” ou “digital”.
ALTER TABLE jogo ADD COLUMN tipo_midia VARCHAR(50) CONSTRAINT chTipo_midia CHECK(tipo_midia = 'fisica' OR tipo_midia = 'digital');

-- 
UPDATE jogo
SET tipo_midia = 'digital'
WHERE id > 1 AND id <= 3;

UPDATE jogo
SET tipo_midia = 'fisica'
WHERE id > 3;

select* from jogo;

-- Exibir apenas os jogos com data de lançamento a partir de 2015
SELECT * FROM jogo
WHERE data_lancamento > '2015-01-01';

-- Exibir os jogos que tenham a letra A em seu nome e são de mídia física
SELECT * FROM jogo
WHERE nome LIKE '%a%' AND 
tipo_midia = 'fisica';

-- Exibir os jogos onde o nome do diretor não contenha a letra e
SELECT * FROM jogo 
WHERE diretor NOT LIKE '%e%';

-- Exibir os jogos de um determinado genero e que ainda esteja em estoque
SELECT * FROM jogo
WHERE genero = 'FPS'
AND quantidade > 0;

-- Excluir os jogos que não têm mais unidades disponíveis em estoque.
DELETE FROM jogo
WHERE quantidade < 1;

-- Renomear a coluna diretor para criador e exibir como ficou a estrutura da tabela.
ALTER TABLE jogo RENAME COLUMN diretor to criador;
DESC jogo;

-- Exercicio 2 -- 
CREATE DATABASE olimpiadas;

USE olimpiadas;

CREATE TABLE esporte (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(40),
    categoria VARCHAR(20),
    CONSTRAINT chCategoria CHECK(categoria 
    

);