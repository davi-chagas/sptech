USE sprint2;

CREATE TABLE jogoZelda (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nmJogo VARCHAR(45),
    anoLancamento INT,
    fkJogoAnterior INT,
    CONSTRAINT fkJogoAnteriorZelda FOREIGN KEY (fkJogoAnterior) REFERENCES jogoZelda(id)
);

INSERT INTO jogoZelda (nmJogo, anoLancamento, fkJogoAnterior) VALUES
('The Legend of Zelda', 1986, NULL),
('Zelda II: The Adventure of Link', 1987, 1),
('A Link to the Past', 1991, 2),
('Link''s Awakening', 1993, 3),
('Ocarina of Time', 1998, 4),
('Majora''s Mask', 2000, 5),
('The Wind Waker', 2002, 6),
('Twilight Princess', 2006, 7),
('Skyward Sword', 2011, 8),
('A Link Between Worlds', 2013, 9),
('Breath of the Wild', 2017, 10),
('Tears of the Kingdom', 2023, 11);

SELECT
s.nmJogo AS JOGO_SUCESSOR,
a.nmJogo AS JOGO_ANTERIOR
FROM jogoZelda AS s
JOIN jogoZelda AS a
ON s.fkJogoAnterior = a.id;

SELECT
nmJogo,
anoLancamento,
CASE 
	WHEN anoLancamento < 1995 THEN 'Era Classica'
    WHEN anoLancamento < 2010 THEN 'Era Moderna'
    ELSE 'Era Contemporânea'
END AS periodo
FROM jogoZelda;

ALTER TABLE jogoZelda ADD COLUMN nmConsole VARCHAR(45);

UPDATE jogoZelda
SET nmConsole = 'NES'
WHERE id IN (1, 2);

UPDATE jogoZelda
SET nmConsole = 'SNES'
WHERE id = 3;

UPDATE jogoZelda
SET nmConsole = 'Game Boy'
WHERE id = 4;

UPDATE jogoZelda
SET nmConsole = 'Nintendo 64'
WHERE id IN (5, 6);

UPDATE jogoZelda
SET nmConsole = 'GameCube'
WHERE id = 7;

UPDATE jogoZelda
SET nmConsole = 'Wii'
WHERE id IN (8, 9);

UPDATE jogoZelda
SET nmConsole = 'Nintendo 3DS'
WHERE id = 10;

UPDATE jogoZelda
SET nmConsole = 'Nintendo Switch'
WHERE id IN (11, 12);

SELECT * FROM jogoZelda;

-- Exiba o nome dos consoles e os jogos da série lançados em cada um deles, 7
-- ordenando os resultados pelo ano de lançamento dos jogos, do mais recente para o mais antigo.

SELECT
nmConsole,
nmJogo
FROM jogoZelda
ORDER BY anoLancamento DESC;

SELECT
CONCAT(s.nmJogo, ' é o sucessor de ', a.nmJogo) AS info
FROM jogoZelda AS s
JOIN jogoZelda AS a
ON s.fkJogoAnterior = a.id;

-- Exiba o título e o ano de lançamento dos jogos que não possuem antecessor registrado, 
-- ou seja, os jogos que iniciam a franquia sem partir de nenhum outro.
SELECT 
j.nmJogo,
j.anoLancamento
FROM jogoZelda AS j
WHERE j.fkJogoAnterior IS NULL;

DELETE FROM jogoZelda
WHERE id = 12;

SELECT * FROM jogoZelda;

-- INDICE 2

CREATE TABLE nacao (
	pkNacao INT PRIMARY KEY AUTO_INCREMENT,
    nmNacao VARCHAR(45),
    nmElemento VARCHAR(45)
);

CREATE TABLE avatar (
	pkAvatar INT PRIMARY KEY AUTO_INCREMENT,
    nmAvatar VARCHAR(45),
    fkNacao INT,
    fkAntecessor INT,
    CONSTRAINT fk_nacao_avatar FOREIGN KEY (fkNacao) REFERENCES nacao(pkNacao),
    CONSTRAINT fk_antecessor_avatar FOREIGN KEY (fkAntecessor) REFERENCES avatar(pkAvatar)
);
INSERT INTO nacao (nmNacao, nmElemento) VALUES
('Nômades do Ar', 'Ar'),
('Tribo da Água', 'Água'),
('Reino da Terra', 'Terra'),
('Nação do Fogo', 'Fogo');

INSERT INTO avatar (nmAvatar, fkNacao, fkAntecessor) VALUES
('Wan', 1, NULL),
('Szeto', 4, 1),
('Yangchen', 1, 2),
('Kuruk', 2, 3),
('Kyoshi', 3, 4),
('Roku', 4, 5),
('Aang', 1, 6),
('Korra', 2, 7);

SELECT
s.nmAvatar NOME_SUCESSOR,
n.nmNacao NOME_NACAO,
n.nmElemento NOME_ELEMENTO,
a.nmAvatar NOME_ANTECESSOR
FROM avatar AS s
JOIN nacao AS n
ON s.fkNacao = n.pkNacao
LEFT JOIN avatar AS a
ON a.fkAntecessor = s.pkAvatar
ORDER BY a.pkAvatar;

SELECT
CONCAT(s.nmAvatar, ' sucedeu ' , ifnull(a.nmAvatar, 'ninguém')) AS info
FROM avatar AS s
LEFT JOIN avatar AS a
ON a.fkAntecessor = s.pkAvatar
ORDER BY a.pkAvatar;

SELECT
s.nmAvatar NOME_SUCESSOR,
n.nmNacao NOME_NACAO,
n.nmElemento NOME_ELEMENTO,
a.nmAvatar NOME_ANTECESSOR,
na.nmElemento ELEMENTO_ANTECESSOR
FROM avatar AS s
JOIN nacao AS n
ON s.fkNacao = n.pkNacao
LEFT JOIN avatar AS a
ON a.fkAntecessor = s.pkAvatar
LEFT JOIN nacao AS na
ON a.fkNacao = na.pkNacao
ORDER BY a.pkAvatar;

SELECT
nmAvatar,
CASE
	WHEN pkAvatar IN (1, 2 ,3, 4 ) THEN 'Era antiga'
    WHEN pkAvatar IN (5, 6) THEN 'Era classica'
    ELSE 'Era moderna'
END AS epoca
FROM avatar
ORDER BY fkAntecessor;

-- Atualize o nome da nação Tribo da Água para Tribo da Água do Norte e do Sul.
UPDATE nacao
SET nmNacao = 'Tribo da Àgua do Norte e do Sul'
WHERE pkNacao = 2;

-- Remova da tabela o último avatar registrado no ciclo - aquele que nenhum outro avatar referência como antecessor. ____________________
DELETE FROM avatar
WHERE pkAvatar = 7;

SELECT * FROM avatar;

-- INDICE 3

CREATE TABLE tipo (
	pkTipo INT PRIMARY KEY AUTO_INCREMENT,
    nmTipo VARCHAR(45)
);

CREATE TABLE pokemon (
	pkPokemon INT PRIMARY KEY AUTO_INCREMENT,
    nmPokemon VARCHAR(45),
    nrPokedex INT,
    fkTipo INT,
    fkEvoluiDe INT,
    CONSTRAINT fk_tipo_pokemon FOREIGN KEY (fkTipo) REFERENCES tipo(pkTipo),
    CONSTRAINT fk_evolui_pokemon FOREIGN KEY (fkEvoluiDe) REFERENCES pokemon(pkPokemon)
);

INSERT INTO tipo (nmTipo) VALUES
('Grama'),
('Fogo'),
('Água'),
('Venenoso'),
('Psíquico'),
('Normal'),
('Voador'),
('Elétrico');

INSERT INTO pokemon (nmPokemon, nrPokedex, fkTipo, fkEvoluiDe) VALUES
('Bulbasaur', 1, 1, NULL),
('Charmander', 4, 2, NULL),
('Squirtle', 7, 3, NULL),
('Abra', 63, 5, NULL),
('Eevee', 133, 6, NULL);

INSERT INTO pokemon (nmPokemon, nrPokedex, fkTipo, fkEvoluiDe) VALUES
('Ivysaur', 2, 1, 1),
('Venusaur', 3, 1, 6),
('Charmeleon', 5, 2, 2),
('Charizard', 6, 2, 8),
('Wartortle', 8, 3, 3),
('Blastoise', 9, 3, 10),
('Kadabra', 64, 5, 4),
('Alakazam', 65, 5, 12);

-- Exiba o nome e o número da Pokédex de cada Pokémon junto ao nome do seu tipo principal. 
-- Relacione a tabela pokemon com a tabela tipo e ordene pelo número da Pokédex.
SELECT 
p.nmPokemon,
p.nrPokedex,
t.nmTipo
FROM pokemon AS p
JOIN tipo AS t
ON p.fkTipo = t.pkTipo;

-- Exiba todos os Pokémon, incluindo as formas base que não evoluem de nenhum outro.
-- Para cada um, mostre o nome, o número da Pokédex e o nome do Pokémon do qual ele evolui. 
-- Quando o Pokémon não evoluir de nenhum outro, 
-- exiba o texto Forma Base no lugar do antecessor. Ordene pelo número da Pokédex.

SELECT 
p.nmPokemon,
p.nrPokedex,
IFNULL(pa.nmPokemon, 'Forma base') AS ANTECESSOR
FROM pokemon AS p
LEFT JOIN pokemon AS pa
ON p.fkEvoluiDe = pa.pkPokemon
ORDER BY p.nrPokedex;

SELECT 
CONCAT(a.nmPokemon , ' evolui para ', s.nmPokemon) AS info
FROM pokemon AS a
JOIN pokemon AS s
ON s.fkEvoluiDe = a.pkPokemon
ORDER BY a.nrPokedex;

-- Adicione uma nova coluna chamada dsAtaqueEspecial à tabela pokemon para armazenar o nome do ataque especial de cada Pokémon.
ALTER TABLE pokemon ADD COLUMN dsAtaqueEspecial VARCHAR(45);

UPDATE pokemon
SET dsAtaqueEspecial = 'Frenesi Solar'
WHERE pkPokemon = 7;

UPDATE pokemon
SET dsAtaqueEspecial = 'Lança-Chamas'
WHERE pkPokemon = 9;

UPDATE pokemon
SET dsAtaqueEspecial = 'Hidro Bomba'
WHERE pkPokemon = 11;

UPDATE pokemon
SET dsAtaqueEspecial = 'Psíquico'
WHERE pkPokemon = 13;

SELECT * FROM pokemon;

SELECT
p.nmPokemon,
p.nrPokedex,
CASE
	WHEN p.fkEvoluiDe IS NULL THEN 'Forma Base'
    WHEN a.fkEvoluiDe = p.PkPokemon THEN 'Forma final'
	ELSE 'Forma Intermediaria'
END AS estagio
FROM pokemon AS p
LEFT JOIN pokemon  AS a
ON a.fkEvoluiDe = p.pkPokemon
ORDER BY p.nrPokedex;

SELECT
a.nmPokemon,
a.nrPokedex,
t.nmTipo
FROM pokemon AS p
JOIN pokemon  AS a
ON p.fkEvoluiDe = a.pkPokemon
JOIN tipo AS t
ON p.fkTipo = t.pkTipo
WHERE a.fkEvoluiDe IS NOT NULL
ORDER BY p.nrPokedex;

-- Remova da tabela o Pokémon de número 133 da Pokédex.
DELETE FROM pokemon
WHERE pkPokemon = 5;

SELECT * FROM pokemon;
