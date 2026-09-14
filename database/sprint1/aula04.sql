CREATE DATABASE liga_pokemon;
use liga_pokemon;
	
CREATE TABLE treinador (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    idade TINYINT,
    telefone CHAR(11),
    dataCadastro DATETIME 
);

ALTER TABLE treinador AUTO_INCREMENT = 100;

-- Now == Current_TimeStamp
INSERT INTO treinador VALUES
(DEFAULT, 'Ash Ketchum', 12, '11956482366', NOW()),
(DEFAULT, 'Misty', 12, NULL, NOW()),
(DEFAULT, 'Brocky', 15, '11926482366', NOW()),
(DEFAULT, 'Lance', 60, NULL, NOW()),
(DEFAULT, 'Serena', 14, '11923487512', NOW());

SELECT * FROM treinador;

-- Formatando data e aplicando um alias
SELECT nome, 
DATE_FORMAT(dataCadastro, '%D/%m/%Y %H:%m:%s') AS data_cadastro
FROM treinador;

-- FILTRAGEM
-- Exibir telefone se estiver null
SELECT * FROM treinador
WHERE telefone IS NULL;

-- Exibir telefone se não estiver null
SELECT * FROM treinador
WHERE telefone IS NOT NULL;

-- VALIDAÇÃO
SELECT 
nome,
IFNULL(telefone, 'Telefone não encontrado') valida_telefone
FROM treinador;

-- VALIDAÇÃO
SELECT
nome, 
ISNULL(Telefone) valida_telefone
FROM treinador;

SELECT
nome,
NULLIF(idade, 12) valida_idade
FROM treinador;

-- ALTERAR MAIS DE UM CAMPO
ALTER TABLE treinador 
ADD COLUMN cidade VARCHAR(45),
DROP COLUMN telefone;

DESC treinador;

UPDATE treinador
SET nome = 'Ash', idade = 13, cidade = 'Pallet'
WHERE id = 100;

UPDATE treinador
SET cidade = 'Pallet'
WHERE id IN (100, 102);

SELECT * FROM treinador
WHERE id = 100;

SELECT * FROM treinador
WHERE cidade IS NULL;

UPDATE treinador
SET cidade = 'São Paulo'
WHERE cidade IS NULL;

CREATE TABLE pokemon (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    tipo VARCHAR(45) DEFAULT 'Água',
	nivel TINYINT,
    hp INT,
    atk INT
);

INSERT INTO pokemon (nome, nivel, hp, atk) VALUES
('Squirtle', 2, 30, 10),
('Greninja', 50, 120, 140),
('Lapras', 40, 90, 100);

SELECT * FROM pokemon;

INSERT INTO pokemon (nome, nivel, hp, atk, tipo) VALUES
('Pikachu', 100, 100, 70, 'Eletrico'),
('Zapdos', 70, 500, 300, 'Eletrico'),
('Alakazam', 25, 120, 70, 'Psiquico');

SELECT * FROM pokemon;

-- operações
SELECT 
nome, 
hp + atk AS poder_total
FROM pokemon;

SELECT 
nome, 
hp - atk AS total
FROM pokemon;

SELECT 
nome, 
hp * 2 AS dobra_de_vida,
atk / 2 AS ataque_reduzido 
FROM pokemon;

-- extração das datas
SELECT 
nome, 
NOW() data_hora_atual,
curdate() data_atual
FROM treinador;

SELECT 
nome,
YEAR(NOW()) ano_atual,
YEAR(dataCadastro) ano_cadastro,
MONTH(dataCadastro) mes_cadastro,
DAY(dataCadastro) dia_cadastro,
CURDATE() ano_atual 
FROM treinador;

-- Diferença entre datas

SELECT 
nome,
TIMESTAMPDIFF(DAY, dataCadastro, '2026-09-24') dias_cadastro
FROM treinador;

SELECT nome,
TIMESTAMPDIFF( MONTH, dataCadastro, '2027-02-25') meses_cadastro
FROM treinador;

SELECT nome,
TIMESTAMPDIFF (YEAR, dataCadastro, '2029-02-23') anos_cadastro
FROM treinador;

-- tb ve a diferença de horários
SELECT
TIMESTAMPDIFF(DAY, '2007-11-03',NOW()) idade;

SELECT
DATEDIFF( NOW(), '2006-11-28') idade_em_dias;