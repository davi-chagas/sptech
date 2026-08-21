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
    CONSTRAINT chCategoria CHECK(categoria IN('Individual', 'Coletivo')),
    num_jogadores INT,
    estreia DATE,
    pais_origem VARCHAR(30)
);

INSERT INTO esporte (nome, categoria, num_jogadores, estreia, pais_origem) VALUES
('Futebol', 'Coletivo', 11, '1930-06-20', 'Inglaterra'),
('Volei', 'Coletivo', 6, '1950-10-05', 'Russia'),
('UFC', 'Individual', 1, '1944-08-12', 'Argentina'),
('Formula 1', 'Individual', 1, '1932-02-14', 'França'),
('Basquete', 'Coletivo', 5, '1912-04-17', 'Estados Unidos');

-- Alterar a tabela para adicionar uma coluna popularidade que armazene a popularidade do esporte como um valor decimal entre 0 e 10 e exibir como ficou a estrutura da tabela.
ALTER TABLE esporte ADD COLUMN popularidade DECIMAL (2, 0) CONSTRAINT chPopularidade CHECK(popularidade >= 0 AND popularidade <=10 ); 


-- Atualizar os registros para definir a popularidade dos esportes inseridos anteriormente.
UPDATE esporte
SET popularidade = 8
WHERE id > 0 AND id <= 3;

UPDATE esporte
SET popularidade = 10
WHERE id > 3;

UPDATE esporte 
SET popularidade = 5
WHERE id = 3;

SELECT * FROM esporte;

-- Exibir os esportes ordenados por popularidade em ordem crescente
SELECT * from esporte
ORDER BY popularidade;

-- Exibir apenas os esportes que estrearam nas Olimpíadas a partir do ano 2000.
SELECT * FROM esporte
WHERE estreia > '2000-01-01';

-- Criar uma checagem para que não possa ser inserido valores dentro de estreia que seja menor que 06 de abril de 1896 e depois da data atual.
ALTER TABLE esporte 
MODIFY COLUMN estreia DATE 
CONSTRAINT chEstreia 
CHECK (estreia < '1986-04-06' or estreia > '2026-08-17');

-- Alterar a tabela para excluir a regra de inserção de categoria,
-- assim podendo colocar valores além de “Individual” ou “Coletivo”.
ALTER TABLE esporte DROP CHECK chEstreia;

-- Exibir apenas os esportes cujo nome do país de origem tenha “a” na segunda letra.
SELECT * FROM esporte
WHERE nome LIKE '_a%';

-- Exibir os dados onde o número de jogadores por equipe esteja entre 4 e 11.
SELECT * FROM esporte
WHERE num_jogadores BETWEEN 4 AND 11;

-- Remover os registros onde id seja 1, 3 e 5.
DELETE FROM esporte
WHERE id IN (1, 3,5);

SELECT * FROM esporte;

-- exercicio 3 --
CREATE DATABASE desenho;

use desenho;

CREATE TABLE desenho (
	id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(50),
    data_lancamento DATE,
    emissora_original VARCHAR(50),
    classificacao INT,
    status VARCHAR(15),
    nota int,
    CONSTRAINT chNota CHECK (nota BETWEEN 1 AND 5)
) AUTO_INCREMENT = 10;

INSERT INTO desenho 
(titulo, data_lancamento, emissora_original, classificacao, status, nota) 
VALUES
('Ben 10', '2005-12-27', 'Cartoon Network', 10, 'finalizado', 5),
('Hora de Aventura', '2010-04-05', 'Cartoon Network', 10, 'finalizado', 5),
('O Incrível Mundo de Gumball', '2011-05-02', 'Cartoon Network', 10, 'finalizado', 4),
('Os Padrinhos Mágicos', '2001-03-30', 'Nickelodeon', 10, 'finalizado', 5);


-- Exibir todos os dados da tabela
SELECT * FROM desenho;

-- Exibir todos os desenhos com a classificação menor ou igual a 14 anos.
SELECT * FROM desenho
WHERE classificacao <= 14;

-- Exibir todos os desenhos de uma mesma emissora original.
SELECT * FROM desenho
WHERE emissora_original = 'Cartoon Network';

ALTER TABLE desenho MODIFY COLUMN status VARCHAR(15) CONSTRAINT chStatus CHECK(status IN ('exibindo', 'finalizado', 'cancelado'));

INSERT INTO desenho 
(titulo, data_lancamento, emissora_original, classificacao, status, nota) 
VALUES
('Coragem o cão covarde', '2005-12-27', 'Cartoon Network', 10, 'exibindo', 5),
('Titio Avo', '2005-12-27', 'Cartoon Network', 10, 'exibindo', 5);

SELECT * FROM desenho;
-- Modificar o status ‘exibindo’ para ‘finalizado’ de 2 desenhos pelo ID.
UPDATE desenho
SET status = 'finalizado'
WHERE id = 18 OR id = 19;

DELETE FROM desenho
WHERE id = 12;

-- Exibir apenas os desenhos que comecem com uma determinada letra.
SELECT * FROM desenho
WHERE titulo LIKE 't%';

-- Renomear a coluna classificacao para classificacaoIndicativa.
ALTER TABLE desenho RENAME COLUMN classificacao to classificacaoIndicativa;

-- Atualizar a nota e data de lançamento do desenho de ID 11.
UPDATE desenho
SET nota = 2
WHERE id = 11;

UPDATE desenho
SET data_lancamento = '2005-12-27'
WHERE id = 11;

SELECT * FROM desenho;

-- Limpar todos os dados da tabela.
TRUNCATE desenho;

-- Remover a regra do status do desenho.
ALTER TABLE desenho DROP CHECK chStatus;

-- Exercicio 4 --
CREATE DATABASE estoque;
USE estoque;

CREATE TABLE misteriosSa(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    data_compra DATE,
    preco DECIMAL (4, 2),
    data_retirada DATE
);

INSERT INTO misteriosSa (nome, data_compra, preco) VALUES
('Arroz', '2026-08-01', 25.90),
('Feijão', '2026-08-03', 8.50),
('Macarrão', '2026-08-05', 6.99),
('Leite', '2026-08-07', 5.49),
('Biscoitos Scooby', '2026-08-10', 18.90);

-- Verificar se os valores foram inseridos corretamente.
SELECT * FROM misteriosSa;

-- Exibir os nomes, as datas de compra e retirada e o id dos alimentos ordenados a partir da data de compra mais antiga.
SELECT nome, data_compra, id FROM misteriosSa
ORDER BY data_compra DESC;

-- Alguém comeu uma caixa de biscoitos, atualizar a data de retirada da caixa de “Biscoitos Scooby” que foi comprada a mais tempo.
UPDATE misteriosSa
SET data_retirada = '2026-08-17'
WHERE id = 5;

-- Alterar o nome da coluna id para idComida.
ALTER TABLE misteriosSa RENAME COLUMN id TO idComida;

-- Alterar o tipo do check para que os alimentos só possam ser “Biscoitos Scooby” ou “Cachorro-quente”.
TRUNCATE misteriosSa;
ALTER TABLE misteriosSa MODIFY COLUMN nome VARCHAR(45) CONSTRAINT chNome CHECK(nome IN('Biscoitos Scooby', 'Cachorro-quente'));

-- Exibir os produtos onde o nome seja “Biscoitos Scooby” de forma que o nome das colunas dataCompra
-- apareça como “data da compra” e dataRetirada apareça como “data da retirada”.
INSERT INTO misteriosSa (nome, data_compra, preco) VALUES
('Biscoitos Scooby', '2026-08-10', 18.90);

SELECT nome,
  data_compra AS 'data da compra',
  data_retirada AS 'data da retirada'
  FROM misteriosSa
 WHERE nome = 'Biscoitos Scooby';
 
 -- Exibir os alimentos que foram comprados antes do dia 25 de julho de 2024.
SELECT * FROM misteriosSa
WHERE data_compra < '2024-07-25';

-- Exibir os alimentos que possuem um preço acima ou igual a 30.50.
SELECT * FROM misteriosSa
WHERE preco >= 30.50;

-- Limpar a tabela.
TRUNCATE misteriosSa;

-- Exercicios 5 --
CREATE DATABASE vingadores;

use vingadores;

CREATE TABLE herois(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    versao VARCHAR(45),
    habilidade VARCHAR(45),
    altura INT
);

INSERT INTO herois ( nome, versao, habilidade, altura) VALUES
('Homem-Aranha', 'Homem Aranha 3	', 'Soltar Teia', 172),
('Homem de Ferro', 'Homem de Ferro 2', 'Armadura', 176),
('Capitão América', 'Capitão América Guerra Civil', 'Super Soro', 172),
('Jean Gray', 'X-Men', 'Telecinese', 160),
('Wolverine', 'Logan', 'Super Regeneração', 158);

SELECT * FROM herois;

-- Adicionar um campo de regeneracao, onde ele aceitará apenas os valores booleanos de TRUE ou FALSE.
ALTER TABLE herois ADD COLUMN regeneracao TINYINT;

-- Modificar o campo versao para aceitar até 100 caracteres.
ALTER TABLE herois MODIFY COLUMN versao VARCHAR(100);

-- Remover o herói de id 3 pois ele se morreu em batalha.
DELETE FROM herois
WHERE id = 3;
DESC herois;
-- Chegou reforços, inserir um novo herói para a equipe.
INSERT INTO herois (nome, versao, habilidade, altura, regeneracao) VALUE
('Doutor Estranho', 'Vingadores Guerra Infinita', 'Magia', 175, 0);

-- Exibir todos os dados inseridos na tabela onde o nome do herói começa com “C” ou “H”.
SELECT * FROM herois
WHERE nome LIKE 'c%' OR nome LIKE 'H%';

-- Exibir todos os dados inseridos na tabela onde o nome do herói não contém a letra “A” no campo nome.
SELECT * FROM herois
WHERE nome NOT LIKE '%a%';


-- Exibir apenas o nome do herói onde a altura for maior que 190.
UPDATE herois
SET altura = 182
WHERE id = 6;

SELECT nome FROM herois
WHERE altura > 190;

-- Exibir todos os dados da tabela de forma decrescente pelo nome onde a altura do herói for maior que 180.
SELECT * FROM herois
WHERE altura > 180
ORDER BY nome DESC;

TRUNCATE TABLE herois;

-- Exercicio 6 --
use sprint1;

CREATE TABLE revista (
	idRevista INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(40),
    categoria VARCHAR(30)
) AUTO_INCREMENT = 1;	

INSERT INTO revista (nome, categoria) VALUES
('Variety', ''),
('Vogue', ''),
('Deadline', ''),
('Forbes', '');

-- Exibir todos os dados da tabela.
SELECT * FROM revista;

-- Atualizar os dados das categorias das 3 revistas inseridas. Exibir os dados da tabela novamente para verificar se atualizou corretamente.
UPDATE revista
SET categoria = 'Moda'
WHERE idRevista = 4;

UPDATE revista
SET categoria = 'Música'
WHERE idRevista = 1;

UPDATE revista
SET categoria = 'Filmes e Séries'
WHERE idRevista = 3;

INSERT INTO revista (nome, categoria) VALUES 
('Shounen Jump', 'Mangá'),
('Recreio', 'Jovem'),
('Veja', 'Noticias');

-- Exibir novamente os dados da tabela.
SELECT * FROM revista;

-- Exibir a descrição da estrutura da tabela.
DESC revista;

-- Alterar a tabela para que a coluna categoria possa ter no máximo 40 caracteres.
ALTER TABLE revista MODIFY COLUMN categoria VARCHAR(40);



-- Exibir novamente a descrição da estrutura da tabela, para verificar se alterou o tamanho da coluna categoria.
DESC revista;

-- Acrescentar a coluna periodicidade à tabela, que é varchar(15).
ALTER TABLE revista ADD COLUMN periodicidade VARCHAR(15);

-- Exibir os dados da tabela.
SELECT * FROM revista;

-- Excluir a coluna periodicidade da tabela.
ALTER TABLE revista DROP COLUMN periodicidade;

DESC revista;

CREATE TABLE carro (
	idCarro INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(40),
    placa CHAR(7)
) AUTO_INCREMENT = 1000;

INSERT INTO carro (nome, placa) VALUES 
('Gol quadrado', 'abcdefg'),
('Gol bolinha', 'abcdef1'),
('Ferrari', 'lsjfiwo'),
('Porsche', 'nchek13');

-- Exibir todos os dados da tabela.
SELECT * FROM carro;

-- Inserir mais 3 registros sem a placa dos carros.
INSERT INTO carro (nome) VALUES
('BMW'),
('Mercedes'),
('BYD');

-- Exibir novamente os dados da tabela.
SELECT * FROM carro;

-- Exibir a descrição da estrutura da tabela.
DESC carro;

-- Alterar a tabela para que a coluna nome possa ter no máximo 28 caracteres.
ALTER TABLE carro MODIFY COLUMN nome VARCHAR(28);

-- Exibir novamente a descrição da estrutura da tabela, para verificar se alterou o tamanho da coluna.
DESC carro;

-- Acrescentar a coluna ano à tabela, que é char(4).
ALTER TABLE carro ADD COLUMN ano CHAR(4);

-- Atualizar todos os dados nulos da tabela.
UPDATE carro
SET ano = 2001 
WHERE idCarro = 1000;

UPDATE carro
SET ano = 1999
WHERE idCarro = 1002;

UPDATE carro
SET ano = 2003, placa = '12g4d67'
WHERE idCarro = 1004;

UPDATE carro
SET ano = 2017, placa = '14683fb'
WHERE idCarro = 1006;

UPDATE carro
SET ano = 1993
WHERE idCarro = 1001;

UPDATE carro
SET ano = 2025, placa = 'kdnv82d'
WHERE idCarro = 1005;

UPDATE carro
SET ano = 2023
WHERE idCarro = 1003;

-- exibir dados novamente
SELECT * FROM carro;

